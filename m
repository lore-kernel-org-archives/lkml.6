Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A5AECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC41A20C0A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK2vUUq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC41A20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeIVVvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:51:10 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43190 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbeIVVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:51:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id k66-v6so805730ywa.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KSWvz7fkRN9QxJVwkVIk0KF+dxr4n2K8gDRW4om4zM=;
        b=ZK2vUUq/TLJNo0Z6kPHfpQuhSKO9uKoyZpP9LTHpK3sKJHFdjHAf4eUtfIzHkAnU/o
         PYK1S2vnE4q2bmvhVoT0kP2ackmT6hqvU521I6PFteCDrwSgTd1N2Jv9tX4fbVarmi/3
         k3iQwhXFYqORna2aBkG+cENU25OGXEi/+/SfhJYJy/8bt17pViYerTQgHiana3fSruWP
         gLnJwIS5k4oLbxIXQz5dPQBQIesSEvc513R6qdMdJNcl84lPR88k50wxqohfdc+9rrsd
         0bxX4AL7MzoBfQgxcQJZnmwxW6VE26pcujjBmeGdZ37oOHarqJ6mHjmWWB2YgWG8L5nu
         pv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KSWvz7fkRN9QxJVwkVIk0KF+dxr4n2K8gDRW4om4zM=;
        b=eMhS6j3lBHDPW6qc0dKKn7aES+0M4Iwpe+tfL93qSdHPpwnG4ZkQ23GFE3BKpvz1Md
         9RpwLg4USGDr06YJ9nNYOYB08wrtkjyhhoDXuoowL0aqnkKtDrN7JKw7apbRkI1jWium
         RB+RDDClTcU5y4P6wrQvKErk1UqYvbaEIG6JsT/brrwFi/LU45Aqjhw3/ClccMWVWKag
         04G73LmDueHDNfMHKSFEKpoZ8QH39Xmf28UK1BYw2mzxydnW2EkzuEvtvxr1RdboqsCt
         GfAlcV2LFYL97WS6DiGBrvtLdAYaMI8gDkKAwuoyNmK28+cELd4dDr8H4otM6zOP7Mcr
         HNTQ==
X-Gm-Message-State: APzg51C+mY0GT5C1XW1aJCdpGQVvWaIr4fGePPn4OxFYOVcfRsBqn9Ih
        5JU1fziKUrJNltZIHM7YL5Nh8xaUmVk91TLPGHU=
X-Google-Smtp-Source: ANB0VdaQ1KC2rCzdoz3y6p9bvWOxkSfJsCZxj/DO7XIMkMTy+YJgX0rApdyXIU/SYAWiTqSX+JSD4E2qTP6um+u2BXE=
X-Received: by 2002:a81:ee0c:: with SMTP id l12-v6mr1293041ywm.480.1537631827098;
 Sat, 22 Sep 2018 08:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180912035352.11191-1-diego.viola@gmail.com>
In-Reply-To: <20180912035352.11191-1-diego.viola@gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Sat, 22 Sep 2018 12:56:55 -0300
Message-ID: <CA+ToGPGSOsLpbOvjjb22B510qkNefdsUSiFTYON7c=oh0s8vcA@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] Punctuation fixes
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:54 AM Diego Viola <diego.viola@gmail.com> wrote:
>
> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> ---
>  CREDITS     | 2 +-
>  MAINTAINERS | 2 +-
>  Makefile    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index 5befd2d71..b82efb36d 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1473,7 +1473,7 @@ W: http://www.linux-ide.org/
>  W: http://www.linuxdiskcert.org/
>  D: Random SMP kernel hacker...
>  D: Uniform Multi-Platform E-IDE driver
> -D: Active-ATA-Chipset maddness..........
> +D: Active-ATA-Chipset maddness...
>  D: Ultra DMA 133/100/66/33 w/48-bit Addressing
>  D: ATA-Disconnect, ATA-TCQ
>  D: ATA-Smart Kernel Daemon
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d870cb57c..6567bf245 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -93,7 +93,7 @@ Descriptions of section entries:
>            Supported:   Someone is actually paid to look after this.
>            Maintained:  Someone actually looks after it.
>            Odd Fixes:   It has a maintainer but they don't have time to do
> -                       much other than throw the odd patch in. See below..
> +                       much other than throw the odd patch in. See below.
>            Orphan:      No current maintainer [but maybe you could take the
>                         role as you write your new code].
>            Obsolete:    Old code. Something tagged obsolete generally means
> diff --git a/Makefile b/Makefile
> index 4d5c883a9..7b5c5d634 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1109,7 +1109,7 @@ archprepare: archheaders archscripts prepare1 scripts_basic
>  prepare0: archprepare gcc-plugins
>         $(Q)$(MAKE) $(build)=.
>
> -# All the preparing..
> +# All the preparing...
>  prepare: prepare0 prepare-objtool
>
>  # Support for using generic headers in asm-generic
> --
> 2.19.0
>

Jonathan,

can you please merge my patch? After you merge this one, I'll go
through the rest of the documentation to make it more consistent.

Diego
