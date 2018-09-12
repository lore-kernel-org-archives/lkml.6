Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AFCC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2027320854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLYpIv+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2027320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeILWgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:36:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42264 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeILWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:36:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so1403133pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MERpxOpdCsOgqacxyyeAFT9eqGH+ovxu2828DygTTbQ=;
        b=aLYpIv+xbuPS/JN9dZEnpc0IxoJ6oSUF5tYnVeWqdBvsVXVIQGooZh+0u9rH0VKe7p
         SV54JOUpjbB4nGFLOWJ3lhI9P3DSlMRC5kbVUv5xZHc1j5eN7E/Qb5FGi8qFr/TPQu0+
         I2zLetS2cE63FjX3yyqN+8v4yzPvdeuRJhPHK2Xn02fcSEopZOXvMf51F1vZScltqejC
         nWGvMbzol7sWMeoymhpwDzF1qWEUf9j+WcUqDCUtaesr//8esyvEIcwWyBiXlVaOzR/+
         P5v6yPp+8fsiKVUsBMnUJz5YdNBA8BB6EOQ8RW721h4XjoB+XC1hT/iBnRDJHuDGTnKH
         6pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MERpxOpdCsOgqacxyyeAFT9eqGH+ovxu2828DygTTbQ=;
        b=iwT9ACxJb7f7zcmJEP5RHIhOV9mOUBGjfRCL4a3m00KsCWK/YnBE1WYWCgWBtPgoiy
         /rk5hHHUpS8n8JSjK/yIaLLdr0XFW/DnStYjcBrPPdGed47JSgf2vV+qulND+O8EACfF
         KwG8v2ZEhYrQx1tIbSbgKeeXGZ3wFDE/3GDeKu2wsR9nTQLh+3Xa/ZF/jtFaR9K4P9rq
         42IZQwR3oxasInK/1gZSHPHpB7qBw3U/Et1/lGfARZ4pYXeD16fvquF6UhMZXMuR0zT+
         gBu1Qo2k6lB5iabgGao6fightWO2SnaIu/UTeu5dMhRC1Bc5mR7txesW7/Fi7hTJrflh
         moww==
X-Gm-Message-State: APzg51DaZ1N92g3LS31oh7Fp3/fsCWnAN5T3BdPgY9FwX6HdjOGkFrFI
        h4xVFBetJxa7TQaPaxAAKmk=
X-Google-Smtp-Source: ANB0VdZ70mMntOzVaGLDgZszWwWrz1we+uy2U4gQgEyJ0SFZyjiJvWcE3kJ1n8eOZPU7Bp1iDSJKQw==
X-Received: by 2002:a63:1125:: with SMTP id g37-v6mr3454126pgl.187.1536773439763;
        Wed, 12 Sep 2018 10:30:39 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u195-v6sm8153155pgb.21.2018.09.12.10.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 10:30:38 -0700 (PDT)
Date:   Wed, 12 Sep 2018 10:30:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
Message-ID: <20180912173037.GA6386@roeck-us.net>
References: <20180912165817.GA5118@roeck-us.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B0949BC@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0949BC@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:06:25PM +0000, Vineet Gupta wrote:
> 
> Hmm I have a prebuilt 2017.03 release of tools (gcc 7.1.1 based) and I don't see
> the issue above when building net/core/dev.o
> I presume your toolchain was built off of upstream gcc sources.

Yes, using buildroot.

> Can you please post the output of your arc-linux*gcc -v
> 

Here you are:

Using built-in specs.
COLLECT_GCC=/opt/kernel/arcv2/gcc-7.3.0/bin/arc-linux-gcc.br_real
COLLECT_LTO_WRAPPER=/opt/kernel/arcv2/gcc-7.3.0/bin/../libexec/gcc/arc-buildroot-linux-uclibc/7.3.0/lto-wrapper
Target: arc-buildroot-linux-uclibc
Configured with: ./configure --prefix=/opt/buildbot/buildroot/output/host
--sysconfdir=/opt/buildbot/buildroot/output/host/etc --enable-static
--target=arc-buildroot-linux-uclibc
--with-sysroot=/opt/buildbot/buildroot/output/host/arc-buildroot-linux-uclibc/sysroot
--disable-__cxa_atexit --with-gnu-ld --disable-libssp --disable-multilib
--with-gmp=/opt/buildbot/buildroot/output/host
--with-mpc=/opt/buildbot/buildroot/output/host
--with-mpfr=/opt/buildbot/buildroot/output/host --with-pkgversion='Buildroot
2018.02.2-00017-gea0e6fa-dirty' --with-bugurl=http://bugs.buildroot.net/
--disable-libquadmath --disable-libsanitizer --enable-tls --disable-libmudflap
--enable-threads --without-isl --without-cloog --disable-decimal-float
--with-cpu=archs --enable-languages=c
--with-build-time-tools=/opt/buildbot/buildroot/output/host/arc-buildroot-linux-uclibc/bin
--enable-shared --disable-libgomp
Thread model: posix
gcc version 7.3.0 (Buildroot 2018.02.2-00017-gea0e6fa-dirty) 

Guenter
