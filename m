Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB03C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3063A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWQRlx0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3063A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936981AbeFRWwd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:52:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38963 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755329AbeFRWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:52:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so8901978pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+0KhMZy+jqAxchpr9dpEkSZ4D5Ja6NnxrpbdNtLkw7E=;
        b=JWQRlx0DP0sAtDUqjqxeLRYX6U26nAsyrFBNyYMTR8YNQymZ/N6hSrEXEvj2LPefit
         igq215SlmVnk9Q4O4EdeNaJ+UJr7SfpWbyPaCzz5CBADzK910ltuJXuxzRCkdTCn9cOj
         TvOAyDiOVymMsRQk1VH3QzHxWcoj2tG42HTBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+0KhMZy+jqAxchpr9dpEkSZ4D5Ja6NnxrpbdNtLkw7E=;
        b=U/hdtcVFqbRoeedju5faAeCwLX/3dEaJbHFvult1bIe2iIhsD6mBALY+hewkFflPlf
         e05ukOxxnyz+8dCSylFrSdYfIOFjWoEHVck3IRQ+A1/bgInpSliqbrrqn9KZGC7MRcQg
         YodaM75flYWg/dGFIERPMbgC9ZUI4K0sOjOFMQuWnxdcE3wXR7v+FpU+yidWClqubZq/
         0Si/U+0xPlX24q9bJ0WV4PZWGyF9T7XGrkh9aOjWuvtDjXOodMj7VE9QLnjrMtU67rQX
         wq6KMep+iX3YpdS1+DvPbMaaguWMJrD+ccQBKJIkpVZttEIWin5NWYnwiU1y+e3z0hl4
         VWJw==
X-Gm-Message-State: APt69E1KJzu1SUyR9TvSV9+BUQv87yPQBFX0LJndZvpmMaLRm5Vno8Rc
        P2TVeEWOXCkNM6EiQ4tmI3rOXA==
X-Google-Smtp-Source: ADUXVKKAZQ9LTUlT4lFqQbwR0GShoPxbkJ/tWsD03Z1+TnaDjfCVuT2LDLrawd/0xolBR6Vhe1X3KA==
X-Received: by 2002:a65:62d9:: with SMTP id m25-v6mr12382424pgv.371.1529362351311;
        Mon, 18 Jun 2018 15:52:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id i4-v6sm24360796pfk.133.2018.06.18.15.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 15:52:30 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:52:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang: objtool: native_machine_emergency_restart() falls through
 to next function
Message-ID: <20180618225230.GW88063@google.com>
References: <20180615211441.GO88063@google.com>
 <20180618221716.3qizmt3mph377ovi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618221716.3qizmt3mph377ovi@treble>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:17:16PM -0500, Josh Poimboeuf wrote:
> On Fri, Jun 15, 2018 at 02:14:41PM -0700, Matthias Kaehlcke wrote:
> > Hi Josh,
> > 
> > with your work on objtool and the upcoming implementation of
> > -fno-delete-null-pointer-checks (https://reviews.llvm.org/D47894,
> > https://reviews.llvm.org/D47895) in clang most objtool warnings
> > for clang builds will be fixed.
> > 
> > However even with -fno-delete-null-pointer-checks we currently still
> > get a warning about native_machine_emergency_restart():
> > 
> > arch/x86/kernel/reboot.o: warning: objtool:
> >   native_machine_emergency_restart()
> >   falls through to next function machine_power_off()
> > 
> > This only occurs when building with -Oz.
> > 
> > One of our compiler engineers looked into this, LLVM optimizes the
> > return statement away since the function has an endless loop, and
> > actually never returns.
> > 
> > Is there a way to tell objtool that the function is not expected to
> > return (I tried the attribute __noreturn, but it doesn't make a
> > difference), or do we have to tell clang to restrain from optimizing
> > returns out?
> > 
> > To repro:
> > 
> > git checkout v4.16
> > make CC=clang defconfig
> > echo "CONFIG_CC_OPTIMIZE_FOR_SIZE=y" >> .config
> > make CC=clang arch/x86/kernel/reboot.o
> 
> Hi Matthias,
> 
> Objtool can't detect 'noreturn' functions, so unfortunately we have to
> keep a manual list.  Does this fix it?
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5409f6f6c48d..ace3f85701c8 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -139,6 +139,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"lbug_with_loc",
>  		"fortify_panic",
>  		"usercopy_abort",
> +		"machine_real_restart",
>  	};
>  
>  	if (func->bind == STB_WEAK)

Yes this helps, thanks for having a look!

Could you send this as an official patch or should I do it (crediting
you)?

Thanks

Matthias
