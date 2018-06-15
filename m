Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADE8FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712B2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8L5xvRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5712B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755883AbeFOGbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:31:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52996 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755592AbeFOGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:31:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so1696604wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mhoSv1fkbgnA29nKQp638lsbXYLmnY+vafNcrLJ2UU0=;
        b=R8L5xvRlfs8HSBfYVpuhov6EtuQGCOckVS+BcyOgQ2u5/J2m0kTGxYvtRL9nMoRxTU
         0pdo1P2NptXJqEnpj7j0/sOD9W7FzaZPoCqMX9rNPg5TyYIv3DB6zldjv5chUnQ9RDZJ
         i7L9ivuI2N86GDZCNV3dyX0qMQTUGaZi3jVc2rt9y5zvMEBb2vXo766YsprvOSPK2/6n
         MsvOLeKRew6pgiiS2xBfg5aUzJQmU43hc7PUamqYec0rIVCRIMpx2yqUDQACmP4sAEWo
         jPjdqiiQxN+P2xTBXod7JxAYBjE52EqBd9IBmB6UJOWTZkx7EVtzTL34J24wbwigNOiU
         rohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mhoSv1fkbgnA29nKQp638lsbXYLmnY+vafNcrLJ2UU0=;
        b=SjfVqjidEQo0UEYg4HB2edEmsVAcffiejUFC54RQm8cZRZCkpADFf6dW5BNJ04lzan
         +x6ghs6x1ihG/QPP8Z78/N8Qj2l8KlJ7PadUU9NOn2nMZZ3VqKO+nIYvcBufxJ309cRu
         /hI7uJseYJ1hxomLXX/RTAKwC7fDObLtMp/sr+7Ji0C3MI1EKW0E49KostjSqiXkgstX
         QLkYhsoIHI7/jwKjWnoBPIvPDXmrRwxpEgDFSuYbGPF6EXcTKWc1LKYjPpf9sZsd0+M2
         VB/524agRSfyU9ltU/XFBFgHkEeWodW46t67Uh2Mm7E9SL5mByLiZniaoz+VLx/mUqov
         ZAYQ==
X-Gm-Message-State: APt69E0qS0epFlJdABwwaGBrcWC0lL4NP7qg7NTmiD6YxXk28KAhFSpv
        Q+L8fXV9/CYCxvq4jQUuRW8TlRlTl6M00/7oXT0=
X-Google-Smtp-Source: ADUXVKIF67tdZU6hYBZhvtfl2esWnwd5rsRMCRotZWgN7GgqrXOyn2N7AXiX9+B/wGjtpGZxRYo1ozMx62NYltqPhtg=
X-Received: by 2002:a1c:7d94:: with SMTP id y142-v6mr139667wmc.107.1529044301110;
 Thu, 14 Jun 2018 23:31:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8271:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 23:31:40
 -0700 (PDT)
In-Reply-To: <1763075.mOQZ1Y9R1k@blindfold>
References: <1763075.mOQZ1Y9R1k@blindfold>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 15 Jun 2018 08:31:40 +0200
Message-ID: <CAFLxGvzO_qXNbCp1K_DNiKYzhVcNk5UJytQPk4K1pN65vG4uEw@mail.gmail.com>
Subject: Re: [GIT PULL] UML updates for 4.18-rc1
To:     Richard Weinberger <richard@nod.at>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Wed, Jun 13, 2018 at 9:31 PM, Richard Weinberger <richard@nod.at> wrote:
> Linus,
>
> The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:
>
>   Linux 4.17 (2018-06-03 14:15:21 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.18-rc1
>
> for you to fetch changes up to 5ec9121195a4f1cecd0fa592636c5f81eb03dc8c:
>
>   um: Fix raw interface options (2018-06-10 22:54:47 +0200)

Kind ping to make sure my mail didn't get lost in your gmail spam folder. :-)

-- 
Thanks,
//richard
