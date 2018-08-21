Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB3FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4276B2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UTUnOnob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4276B2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeHVACN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:02:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44993 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVACN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:02:13 -0400
Received: by mail-io0-f194.google.com with SMTP id 75-v6so1083807iou.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bAEIPXhZeZ5s8Vdq9wmByEaIYk9PMAXCxmyYuHROTI=;
        b=UTUnOnob9I5tUCMlokM8mObrZWlskKrrI6mjHVbWkuQGxnQne+irdnj4czlz3wxmSJ
         6AAMfW1jJecKbzzHnZnH5YYoIzhMq2lKkvECVqSgKkzEnPN59ATYNLPCFKOyL+4XNpRA
         G2614oOswrgmivBwM9becQRV1Wqw8sSdcpvdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bAEIPXhZeZ5s8Vdq9wmByEaIYk9PMAXCxmyYuHROTI=;
        b=eEN4TbbVF25bLy4rhhi26vaPSdqh6ZozqIk0HOZP8o78Z1kE1dwOAHbtwc2OAGhYPB
         jZiIT9x+eYEtNlL3jxe7+fSr/2OymvszZzHss0vIoJlFv7OCx3mUWwFWIXGQOkYWfiWs
         cTxUbrQGvW5iC4AEyuStTlzbl3yzpDSsU+2Vkq1KxZU9eAcxKX8qFzCIfnA+xqFt1vgf
         BMpASYGWIyUPFwg540r5Sn0JAZ90o/Zz+jfkiHx0TCJAFJmvwIdz0hWSjRCeayLgMIlK
         MMfI0MIkTBbzEzGG4AkaZhOOSU97kSWEh6RBD5o+gnDUtQfrHaDIcBWd6AFCY5+cIJRm
         MnUQ==
X-Gm-Message-State: APzg51A5xk/Twxleq6Y0ftrT911mnngkR8tGXe+Fd20pz5th0IjLycC7
        aMK4hElK4nBiRjWMF69pQ9F5kAHPzNHDeRwIOT4=
X-Google-Smtp-Source: ANB0VdZVpRRJIqw5r0R56ItNMLazkfahegSRY2h/50gODFMspzMp5adelYJyXQhAeF477M95Y5QgNGCpBFG/PgeR3/E=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr2206429iop.238.1534884032567;
 Tue, 21 Aug 2018 13:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180821185413.GA40305@decatoncale.mtv.corp.google.com>
In-Reply-To: <20180821185413.GA40305@decatoncale.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Aug 2018 13:40:21 -0700
Message-ID: <CA+55aFz3HpWHezTKtN2LswehY8=nEaofczPFzPiKram+7DHbfQ@mail.gmail.com>
Subject: Re: [GIT PULL] chrome-platform updates for v4.19
To:     Benson Leung <bleung@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 11:54 AM Benson Leung <bleung@google.com> wrote:
>
> Minor changes this time around for 4.19.
>
> cros_ec_i2c and cros_ec_spi drivers moved from mfd
> to chrome platform.

Actually, these all came through the mfd branch. Was that not
expected? If Lee Jones is randomly pulling stuff from you that you
don't expect him to upstream, that's a communication problem.

So the only actual new-to-me patch there is the SPDX identifier fix.

                Linus
