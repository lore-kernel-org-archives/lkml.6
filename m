Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E0BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CDA20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tskQvZ85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404250AbfAPNTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:19:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38016 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbfAPNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:19:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so1973895wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8EingedLiRZuvNwCxRf1rtVqht8S3zXdlcb+HElk5HA=;
        b=tskQvZ85qAOJTFozU4t/tas5i+aIfkFflpUuCpSRCMqRji+2RxtNOrp0qC+nlPAHnI
         DPZ6hZPOJMvLtelAAKyVL+XEXMRmJ/UNpzD+JNrz6oQJ5Shs2PznbXGAgz7SRQr428EG
         mw0hbvmDunT3GuLk3+EBBRGgUTTCy5nh+3LXKbNoLlxfcnnicPytWng6OcyE28T7z6hH
         /m0iR7N8kkxtgHjeExaa3B5/o/y/jTdNd0F0bf18dnyQ4iH+GMOk8hANSelqr0T5s288
         pj4eX1HegGql9lXAn7YJpSlCGG1U9tf9q6d+Ukj2JrE0ELdphU7SOh5QdKBXxrWH3ICS
         YpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8EingedLiRZuvNwCxRf1rtVqht8S3zXdlcb+HElk5HA=;
        b=lFdOUIr2emm7bPgewCT7mn+gPoeGHs+ZMc5OQMhl2PmEbeCrctQ1lw8ClGaSU+gNdk
         8FdGeYCOZnfuTQTEfw/CZ7SVdVhXbAW0pPGyhqfuYu0b3yGCq+93ev0ESIzoJHoq6Ky7
         Aowls5hGn8ZvJXu2V5961uOH6lOA5e2uOJ9FHCF+MCnkGV3RPm/Fqpe98wp7/pWtfzok
         mC6kOITKjF/6GkB4HuKtndXZjQlD52TP2DaspdMZTOKFxpB+UfnC8rEkOsRQFFEsthR/
         MDOeZFLwtrEd6pCZd3elA0AfmnthP/YcsKz1oW/xKSmRYE+8yRgfwkQEhx4loPKZFhwk
         ME6Q==
X-Gm-Message-State: AJcUukeBOl7kws2ZtAd4Kb64cE/uxqTdcDLbVYaCXQUC5MM9fNbRLAwl
        lxNuTeaIs/Wh/Cfj0p60sck=
X-Google-Smtp-Source: ALg8bN6JyIwR94xnnQGdSAvpoLXfyDwumMf+7vQhQPqoI1+3lFPyEnJPOt1fBg0n2JSZaEBfsBfNAQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr7484637wmi.61.1547644779207;
        Wed, 16 Jan 2019 05:19:39 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z17sm62804202wrv.2.2019.01.16.05.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 05:19:38 -0800 (PST)
Date:   Wed, 16 Jan 2019 06:19:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix build error with Clang when
 inlining is disabled
Message-ID: <20190116131937.GA31131@flashbox>
References: <20190116060302.8882-1-natechancellor@gmail.com>
 <20190116064202.GA25498@kroah.com>
 <20190116065340.GA5336@flashbox>
 <20190116084658.GA28112@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116084658.GA28112@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:46:58AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 11:53:40PM -0700, Nathan Chancellor wrote:
> > On Wed, Jan 16, 2019 at 07:42:02AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 15, 2019 at 11:03:02PM -0700, Nathan Chancellor wrote:
> > > > When CONFIG_NO_AUTO_INLINE was present in linux-next (which added
> > > > '-fno-inline-functions' to KBUILD_CFLAGS), an allyesconfig build with
> > > > Clang failed at the modpost stage:
> > > > 
> > > > ERROR: "is_broadcast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> > > > ERROR: "is_zero_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> > > > ERROR: "is_multicast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> > > > 
> > > > These functions were marked as extern inline, meaning that if inlining
> > > > doesn't happen, the function will be undefined, as it is above.
> > > > 
> > > > This happens to work with GCC because the '-fno-inline-functions' option
> > > > respects the __inline attribute so all instances of these functions are
> > > > inlined as expected and the definition doesn't actually matter. However,
> > > > with Clang and '-fno-inline-functions', a function has to be marked with
> > > > the __always_inline attribute to be considered for inlining, which none
> > > > of these functions are. Clang tries to find the symbol definition
> > > > elsewhere as it was told and fails, which trickles down to modpost.
> > > > 
> > > > To make sure that this code compiles regardless of compiler and make the
> > > > intention of the code clearer, use 'static __always_inline' to ensure
> > > > that these functions are always inlined. Some alternative solutions
> > > > included 'extern __always_inline' or converting these functions to
> > > > macros (so the preprocessor deals with them) but I would argue this is
> > > > the more "standard" solution.
> > > > 
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/include/ieee80211.h | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
> > > > index bcc8dfa8e672..959e822315b5 100644
> > > > --- a/drivers/staging/rtl8723bs/include/ieee80211.h
> > > > +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
> > > > @@ -850,18 +850,18 @@ enum ieee80211_state {
> > > >  #define IP_FMT "%pI4"
> > > >  #define IP_ARG(x) (x)
> > > >  
> > > > -extern __inline int is_multicast_mac_addr(const u8 *addr)
> > > > +static __always_inline int is_multicast_mac_addr(const u8 *addr)
> > > 
> > > Ick, really?  This is in a .h file, the .c file sees this, so why isn't
> > > clang picking it up?  Worst case it just makes it a "normal" function
> > > and doesn't inline it, right?
> > > 
> > 
> > As I understand it, the meaning of 'extern inline' is basically use this
> > defintion when inlining, otherwise use one from a different file or
> > translation unit. See commit d0a8d9378d16 ("x86/paravirt: Make
> > native_save_fl() extern inline"). These functions don't have any other
> > declaration/definition so when they aren't inlined, they don't exist.
> > 
> > > How about just replacing "extern" with "static", that should solve this,
> > > adding "__always_inline" everywhere is not going to be fun and doesn't
> > > make any sense.
> > > 
> > 
> > Yes, that would work (and what I originally tested). My assumption with
> > the code is that it was intended for this function to always be inlined
> > but if you'd rather it just be 'static', I am happy to send a v2!
> 
> This code is not trying to be that smart, someone just put the extern in
> there without realizing it.  So making it static is the correct fix, so
> a v2 would be great.
> 

Done!

> Odds are, almost all other places in the kernel that you hit with this
> also needs the same fixup, no need to be fancy here :)
> 

Thankfully, with arm, arm64, and x86_64, there was only one other place
that where that config caused an error:

https://lore.kernel.org/lkml/20181210234538.5405-1-natechancellor@gmail.com/

> thanks,
> 
> greg k-h

Thanks,
Nathan
