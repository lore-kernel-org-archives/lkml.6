Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDE2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954BF20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj6zsBwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954BF20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeLAEpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:45:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43699 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLAEpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:45:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so3612742qkr.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VVp5EP7Xn7RjCY3aOJkp022x4j4r3XEpvqg5+EvwaTI=;
        b=aj6zsBwFrRG16pxDWq5O6T1B1O3K0dyTxAz3mARYRie4rxHh9oEBn4RBSAdX0t2LIU
         2hD8CKDVlWQYb+AKyiyYoUUuFgF4I5nLETkLQpU6YA+8U9LORTXBnWUjiXVLyjD1XXWS
         +o/pp8QLfXh9oSZA9prYKHb1AaPi5lgQ6NvEq+kXDem+6ZetzwT9IZ/oQreAGd5PtJ45
         xU/XZE07YMA/RmfpJfAOZ3yFHh+5mvkj07gArNRr9Eo4xM/M+oh0lr/UAlSj7WP+aD6G
         Y+5FTCr7AUFmKz8oyclBpubFaXMS+dgJ46cy+ong9Qm632Wi8OzTVpYmyExzre1T++U5
         qALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVp5EP7Xn7RjCY3aOJkp022x4j4r3XEpvqg5+EvwaTI=;
        b=UTq/YDebJ4Se+/Uh3Xfz2llTxnKN/dR0kCi9/VcbUrRgF+TEyASzQXF2RTeocNUty3
         fJFsB1pCheOxoK8i8bIbEZ34RRU9AVNxZ6GvxZCazW7cae/Jn8s7HA40yUU9eQlucMA8
         goTTAbkkaE/3GQs7Wg4Ya/JWGPBdxGa0jh5Yoq0lwJZKinEAcWZRgmMGMIbGKejVYlok
         SSOfO1h9gZgy8hV9SaOExcDSMgDPd8dEL7J/nobkyvB3SczU8C0g7T2KcA59syiSZEV6
         JZt1lUA1aCLICvlWdsogJFM3GUB81nap4gf33BXu20pw/UhHA0pDcE4yyBrvC1I4G5nU
         XnAw==
X-Gm-Message-State: AA+aEWZ9aUvHim5RBm8C21Of492WGwqoNkv0ZzWfgVca6tOJppweyFPT
        6Z38CYsbzLNZyf5FsNIgbw==
X-Google-Smtp-Source: AFSGD/W8UUKTVbcTwgM1Sr1HIuMA8zAdNczY2o1yyHptlHGyGJDaHfw2xAv1j4wguCOMBr0qBDsqyw==
X-Received: by 2002:a37:4c41:: with SMTP id z62mr6037139qka.206.1543599319793;
        Fri, 30 Nov 2018 09:35:19 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x57sm3701322qtx.96.2018.11.30.09.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:35:19 -0800 (PST)
Date:   Fri, 30 Nov 2018 12:35:16 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181130173515.6zx5wvs52s5aqnge@gabell>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
 <20181130024346.GB30941@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130024346.GB30941@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:43:47AM +0800, Chao Fan wrote:
...
> >]$ make arch/x86/boot/compressed/misc.o
> >  CALL    scripts/checksyscalls.sh
> >  DESCEND  objtool
> >  CC      arch/x86/boot/compressed/misc.o
> >ld: -r and -pie may not be used together
> >make[1]: *** [scripts/Makefile.build:294: arch/x86/boot/compressed/misc.o] Error 1
> >make: *** [Makefile:1715: arch/x86/boot/compressed/misc.o] Error 2
> >]$
> 
> Hi Masa,
> 
> So many thanks for your test.
> 
> Could you give me more details about this error? More error message.
> Just on the first commit or the whole PATCHSET?
> Cause I didn't get error both on this commit and on the whole PATCHSET.

I built your whole patchset and got the error.
The error depends on CONFIG_MODVERSIONS.
If CONFIG_MODVERSIONS=y, you will get the build error.

Thanks,
Masa
