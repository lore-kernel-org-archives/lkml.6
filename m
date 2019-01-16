Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF16CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05D20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEhs92PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbfAPGxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:53:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46308 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbfAPGxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:53:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so5537978wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BzuEQaPSgabeNpQJFFJ07endqin36st+YkoKatpZoxU=;
        b=KEhs92PUKIQVhL/05d+i1z9MaWrl/fAqpm3TIobpjI7tcHQuFqUDHLBAIbIc5b140G
         WE98Az3ubbtgKRGMaOMYd0FBIDQaQwm84DvzETdy+/qxwTp8ja74Umhnt2IWBOQhTkCh
         rVOWPF+Ewa2UQneqPrhJYqojxdMD8B8TzKaVPnHr6TXFfkY7HEu5pPEySG309oXCsIYF
         Dbk59EuMdbk+UNsF3g5lW8oA9cC0ZQmIjChEoIMth0+V+g6ajJS0ylAC9qhAeNs5jO0m
         mgvaoMqA90+/tkCwSRDF/agmF9Ih5R2JEMx9N9zS3KPlNt7FHkFrfDWem+dktxydBuaI
         jvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BzuEQaPSgabeNpQJFFJ07endqin36st+YkoKatpZoxU=;
        b=QXeRhVMDJt2UaqDqPZc35HXTezrEaiKR3V1qNGJUFs0+TAMxqXT2laQOeLZJUjb+PT
         cxJ77Ss0y4ckaOJoRvQ/73f/NBysbssqt66BgzHsnamjSBGPpTCPkZUlTf6mZJoYiVhh
         sZqU4cjKw3QFa7uH1fiakqjBfy5NOGkQaV7lQ7xu2yi8Ts/hfVsRO7xo10aUIhjD8g2t
         wqj898qiMZ957ixU2IxV5MTauzV97VkNeQR6PRrPPn8Fq0SUWenewqAqnJdTFDL3hYD7
         Mi6OIrlu4Ia4GObO3I9Pd0U3t1qZuCPFl4kVd9fVXPHrRfVS+WyikHG2YRFyr2mNWAkX
         z0hg==
X-Gm-Message-State: AJcUukdUIbaNLCOzntHVqukhIcYNtu4BNao5yNIMy83lZcA9Z90tkOQh
        pl61nzZJLbqxMIUFhDCssfo=
X-Google-Smtp-Source: ALg8bN4UgT5qK3Ocl41tdlCx6GiiUnmEXx2m3bWIeOC4KAd66xcBTzYpiKmdSjr9WYji9VF9REsSRA==
X-Received: by 2002:adf:e9d1:: with SMTP id l17mr5722314wrn.73.1547621623219;
        Tue, 15 Jan 2019 22:53:43 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a12sm85482946wro.18.2019.01.15.22.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 22:53:42 -0800 (PST)
Date:   Tue, 15 Jan 2019 23:53:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix build error with Clang when
 inlining is disabled
Message-ID: <20190116065340.GA5336@flashbox>
References: <20190116060302.8882-1-natechancellor@gmail.com>
 <20190116064202.GA25498@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116064202.GA25498@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 07:42:02AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 11:03:02PM -0700, Nathan Chancellor wrote:
> > When CONFIG_NO_AUTO_INLINE was present in linux-next (which added
> > '-fno-inline-functions' to KBUILD_CFLAGS), an allyesconfig build with
> > Clang failed at the modpost stage:
> > 
> > ERROR: "is_broadcast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> > ERROR: "is_zero_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> > ERROR: "is_multicast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> > 
> > These functions were marked as extern inline, meaning that if inlining
> > doesn't happen, the function will be undefined, as it is above.
> > 
> > This happens to work with GCC because the '-fno-inline-functions' option
> > respects the __inline attribute so all instances of these functions are
> > inlined as expected and the definition doesn't actually matter. However,
> > with Clang and '-fno-inline-functions', a function has to be marked with
> > the __always_inline attribute to be considered for inlining, which none
> > of these functions are. Clang tries to find the symbol definition
> > elsewhere as it was told and fails, which trickles down to modpost.
> > 
> > To make sure that this code compiles regardless of compiler and make the
> > intention of the code clearer, use 'static __always_inline' to ensure
> > that these functions are always inlined. Some alternative solutions
> > included 'extern __always_inline' or converting these functions to
> > macros (so the preprocessor deals with them) but I would argue this is
> > the more "standard" solution.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/include/ieee80211.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
> > index bcc8dfa8e672..959e822315b5 100644
> > --- a/drivers/staging/rtl8723bs/include/ieee80211.h
> > +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
> > @@ -850,18 +850,18 @@ enum ieee80211_state {
> >  #define IP_FMT "%pI4"
> >  #define IP_ARG(x) (x)
> >  
> > -extern __inline int is_multicast_mac_addr(const u8 *addr)
> > +static __always_inline int is_multicast_mac_addr(const u8 *addr)
> 
> Ick, really?  This is in a .h file, the .c file sees this, so why isn't
> clang picking it up?  Worst case it just makes it a "normal" function
> and doesn't inline it, right?
> 

As I understand it, the meaning of 'extern inline' is basically use this
defintion when inlining, otherwise use one from a different file or
translation unit. See commit d0a8d9378d16 ("x86/paravirt: Make
native_save_fl() extern inline"). These functions don't have any other
declaration/definition so when they aren't inlined, they don't exist.

> How about just replacing "extern" with "static", that should solve this,
> adding "__always_inline" everywhere is not going to be fun and doesn't
> make any sense.
> 

Yes, that would work (and what I originally tested). My assumption with
the code is that it was intended for this function to always be inlined
but if you'd rather it just be 'static', I am happy to send a v2!

> thanks,
> 
> greg k-h

Thanks for the quick reply and review,
Nathan
