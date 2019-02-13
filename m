Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0227CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C557C206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoJ2oHrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbfBMHUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:20:13 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:33955 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfBMHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:20:13 -0500
Received: by mail-yw1-f48.google.com with SMTP id u205so540328ywe.1;
        Tue, 12 Feb 2019 23:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPF6yD5DAHgXAIV1vACWZVe+d25mUGRVf9xdp5LPo8k=;
        b=uoJ2oHrRafAF2oawLWlkR94ApOG7ku3/Hk7q8vAm3KyB9xX++HqFxIVbIJBZ2uTg/X
         3xIStkJM1W3MdnLrLiAX4iG80Uz/0btaLWU+K6wVZseHrtIUnqBX9vWtEpyTCqoHCGPQ
         5rJedKO28I8QcHgLUUrXWZfBZuA488uG74Xm6hbZvOcAmNXHaK3OpN91EkS2LiQhTePm
         zJm9SOTKRwDDac5wE2tyKbc4vTfTCVXbJ4TTnaB3iijrlbKzU64SwXFIsshL6BJG5DsB
         7OX7AJwkQFLDTreCFdzuzNv49ZXP3+/OgA7/7jcGqTwXUUcLh5Jvhht+NkTMwHuLHx4U
         wmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPF6yD5DAHgXAIV1vACWZVe+d25mUGRVf9xdp5LPo8k=;
        b=Reg9lWR3BwAUDLizA8hajwXry0rScTzsUvrvU8xg63YG3SzQRviaMwcdE7Y/7roSNA
         XgDv8PEnFcMERNQ8QNXwEkNTWteRUrehXVqzgkqIfbhCZv2oft7kGmkBJ3VquDOZqdMk
         /6gWSqQwATI0fYe3fbRwdemIcBnY+jcXvCMcKAzSQqkUVmZv54wjiAVkr5CSHUBrSErH
         zbA9YzuWzCC/CLH6QBPi3r1lO5n0Q8omyLJ3JMRSG6jHyoG1QH3aGqtETgURVEYQ+YKa
         uiciyy8ZULejPavdlfbwtmfGBRJBQfg1XGHXGwX9I2wZlcGfg+x16HF/KlGHsMzDCoXk
         BtcA==
X-Gm-Message-State: AHQUAuaMMb5jPwcji9BjFVWaoUfAbbks28uGIUqSnwXjswEuWGGNVSTi
        vRUmseYJZq/X+ndMhgsXqkuJ7vD2o/M/V9wiv5U=
X-Google-Smtp-Source: AHgI3IaJMefOiPRX8qJbKpqxucMftsRQkATfIl4/rAYG5CpcV+s7zQHKVAd7geiWTdd4nQWe2SX289IwneJ7XMcCwdU=
X-Received: by 2002:a81:5509:: with SMTP id j9mr3478611ywb.409.1550042412166;
 Tue, 12 Feb 2019 23:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
In-Reply-To: <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Feb 2019 09:20:00 +0200
Message-ID: <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     Steve French <smfrench@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:56 PM Steve French <smfrench@gmail.com> wrote:
>
> Makes sense - e.g. I would like to have a process to make automation
> of the xfstests for proposed patches for stable for cifs.ko easier and
> part of the process (as we already do for cifs/smb3 related checkins
> to for-next ie linux next before sending to mainline for cifs.ko).
> Each filesystem has a different set of xfstests (and perhaps other
> mechanisms) to run so might be very specific to each file system, but
> would be helpful to discuss
>

Agreed.

Perhaps it is just a matter of communicating the stable tree workflow.
I currently only see notice emails from Greg about patches being queued
for stable.

I never saw an email from you or Greg saying, the branch "stable-xxx" is
in review. Please run your tests.

I have seen reports from LTP about stable kernels, so I know it is
being run regularly and I recently saw the set of xfstests configurations
that Sasha and Luis posted.

Is there any publicly available information about which tests are being run
on stable candidate branches?

Thanks,
Amir.
