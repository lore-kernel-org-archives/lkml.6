Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBA1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7792146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu8aan8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfBGUwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:52:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37816 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfBGUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:52:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so526818plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKTL/VUO2v+cmiF0gtxjbJiV47KA6awqYyKIrFSUDqc=;
        b=Nu8aan8qIfY42IqTNRslSjIE3HNHTa1HXz5Ii/eUGTQiwta1KIwOchyhIa+ylL6AFf
         px2rYcK4Dit+DWHb0PjEgSD3SFiFoL+kAR6DMc9thZq85MMCAeJz8NRyaV+HGufOlXLu
         xRwZqCMghe9/MRtydm3N4jfKK5hxTpp4+curaxffw+YfsRqTMx73ADEvsFM8Z2kULRZN
         Ad4IfzQicG9qXthFT9ssPDfi84hoLP7kbW6K2Y4qS/pFD6H8K0zrvCR+ES051wSom0Ti
         LuiijfqPy1pbOL6GhPs5HCtmq7OvEJGFeKRFKgiZ50xs7zBzjg8nEgTd8aoK/3dZ4MUW
         +3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKTL/VUO2v+cmiF0gtxjbJiV47KA6awqYyKIrFSUDqc=;
        b=LNjAZq6BdppHlSjaaOU9lOb+76iq8nP7QBrfAfjR/9LOxqPB1Sy/6cMP2iQOWB5cp7
         MQDAF0rZEkXbYrmOTCB/A19k8KzuucHVl4cDXCk/wJUh/rM7aIlxc9Q/tJqltZYGcdrI
         B8oWJ+rYnLPpB3IwjCOG9B0SNCblDsmEOVs1iIkcl6f4Zfxq6M8U3RuNxEIOYLjRRh9S
         ytl2A0XuVrcPmsF24rXEtcxRIf+594s1/QUPb9+19cIkfNN/vSxFCIhBrjtex5gl8gL4
         y7r/C0VCMder1S/qb7p5WUGr0pOiP2zL8ZD+UOQKhypmY0k0ovM1byXKPR48ulCGOg7J
         B8xA==
X-Gm-Message-State: AHQUAubRGZgH7r0aP4WhDJrb/fLqo/N1mOG382Tauy0qt7Ae9i/D+D+Q
        gQG/ZPR3cs602JYNzXTVpsqKRea+gPseQHMm6y4fSg==
X-Google-Smtp-Source: AHgI3IZKwz8iogrrII4x6WBjKdp9oBL6psLrJYaoA3GW7KKugenPXAsega03xFSIOdTn5h1oq1iBrNlnM1L4cMSPj5A=
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr18808462pld.13.1549572740234;
 Thu, 07 Feb 2019 12:52:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549532513.git.stefan@agner.ch> <c44f25a2d9e2f64fe41d910b09868c0f6ec3a3c9.1549532513.git.stefan@agner.ch>
In-Reply-To: <c44f25a2d9e2f64fe41d910b09868c0f6ec3a3c9.1549532513.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Feb 2019 12:52:09 -0800
Message-ID: <CAKwvOd=j_xA-dTm098un2qRnzir-9FZNv3K=5vpNT7prgMpvbQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: warn if divided syntax assembler is used
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 1:46 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Remove the -mno-warn-deprecated assembler flag to make sure the GNU
> assembler warns in case non-unified syntax is used.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Good idea, thanks for unifying the syntax.

> ---
>  arch/arm/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index a0d08a3c9d33..811498e16673 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -112,9 +112,6 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>  CFLAGS_ABI     +=-funwind-tables
>  endif
>
> -# Accept old syntax despite ".syntax unified"
> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> -

Shouldn't you also remove the references to the now gone AFLAGS_NOWARN
on lines 120 AND 127?

>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>  AFLAGS_AUTOIT  :=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
>  CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
