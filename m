Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9893920818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkNAGIRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfBFQpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:45:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41835 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfBFQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:45:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id p15so2174755edy.8;
        Wed, 06 Feb 2019 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAU85EYQJ6l4fWMlQm2CUY98GCgNPPtQyqS/hsYaj6o=;
        b=NkNAGIRgmFrJ6I4H898ThVv7zKesRjEcal1f0u+sOmjQLV3RYQELnZHn4S1tonfQ+7
         ESL0Mh+7qGaxTmG8FCKPQVH9NWazBhtM34oqjg3UjCbguYb09Pfzkeqc8tQ7f/dFYMim
         RQCq7HneFfFIbFC0VvdfptCbD3Fj9uE71M1WXvmES16RgrEwcZdZ0ppSSo76yZgOK2hw
         lCarAxPgqHQiLuc4mbY/uyxSbxpEzQkxcRR+S9jPTY3IWAEG7C/DkT7DbkMnlAbTyde/
         PSmK6ZcgV2Yo3uUHDbkuCUDMHe4fmqlA5P8sD2zvlLyjnc/HNUnbTu5YuB94I/KqyN2T
         M45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAU85EYQJ6l4fWMlQm2CUY98GCgNPPtQyqS/hsYaj6o=;
        b=ouaJ0wvp1b0sJqdmmN9dH/NXf9bXamDjzD3AXg7Opd3IeMRh+PkaDSF06JgqlFUGEt
         m4LoYMP0tGBYBiwhb5MmVmQ5DAaGpinoO66KZ+3+Sb8PsJ45al8UxaLzCl9yDo9w4nRa
         nmtUdOrF2dSQ5H+ZCPK+3etbZ8TZ7DwY0e4c8s5H+lvOHzPx4nHo6DyObnINRy0YjwCL
         M+JlPBZAV+I73OUZRxN8fXeNJvnn/34GfFMDXXbHpoGehxru3skuzXfCKf1zCg+zE4JR
         VPtsTMl7JE8KXJwQ5SH+9A39MI4ZkfvtTYYByME91RSmhC85QDFWj+gIerMIj9xHFdZ1
         /owQ==
X-Gm-Message-State: AHQUAuaoRLw+Rfz7sSvW7le+iNmf/F+anVELYnd9mNO0L3bZvtD88E1y
        N6U7E+AzJanLuYCLsmoF3Hc=
X-Google-Smtp-Source: AHgI3IZx6OWUmfxfwULuH5bf371NjdjPctFQmK43Sv90IF02wKQ8YW5b3GfLLFasboUh1vFvYy0uzw==
X-Received: by 2002:a17:906:1f06:: with SMTP id w6mr8215594ejj.132.1549471531229;
        Wed, 06 Feb 2019 08:45:31 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b46sm6095436edc.57.2019.02.06.08.45.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 06 Feb 2019 08:45:30 -0800 (PST)
Date:   Wed, 6 Feb 2019 09:45:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     jflat@chromium.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
Message-ID: <20190206164528.GA8925@archlinux-ryzen>
References: <20190201210853.244043-1-jflat@chromium.org>
 <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 05:26:05PM +0900, Masahiro Yamada wrote:
> On Sat, Feb 2, 2019 at 6:10 AM <jflat@chromium.org> wrote:
> >
> > From: Jon Flatley <jflat@chromium.org>
> >
> > gcc produces format warnings that clang suppresses. To keep behavior
> > consistent between gcc and clang, don't suppress format warnings in
> > clang.
> >
> > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > ---
> 
> Applied to linux-kbuild.
> Thanks.
> 
> 

Hi Jon and Masahiro,

Just as a heads up, this introduces a ton of warnings (duh). Isn't the
typical plan behind turning on warnings that were disabled to build with
'W=', fix them all, then turn them on so as not to pollute the build?

Log file: https://gist.github.com/443db156e56cd3c0f6b21d9d77728d80

Note a big chunk of them come from one scnprintf call in
include/linux/usb/wusb.h but still, there are many other warnings that
make quite a bit of noise. Some seem relatively easy to fix, which I
suppose I will try to tackle soon.

Thanks,
Nathan

> 
> 
> >  scripts/Makefile.extrawarn | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index 768306add591..94daf4e1fc73 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -68,7 +68,6 @@ else
> >  ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, format)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
> > --
> > 2.20.1.611.gfbb209baf1-goog
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
