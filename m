Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560852687A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560852687A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeF1EMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:12:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44329 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeF1EMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:12:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so3300002ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FlRX4rS4p0IRVrMh8fVyivQZmVxEA/5sry7SF1qCv0w=;
        b=eL0pROPKz101Ocn7jHnn1Ut22nnOnWohQ8BkupxFe1b1d+4tw4TBsab5FBWVizumso
         AD9UAz6SnPVViZp/hK6bCfM6YwguzOFGCtzwBGWx7U6USucMVkdiirIcLWTWftFBL076
         sjiTtVCzi+ia8Sig3GVBF/pb5+7WZTPuKfaTjEReL4p5PZzHwQ+jiG5WnX/HelR39+BS
         gTyKosOkxVzlr0ZCQViuFS2hOczld9tTNKxo4XYtUxYdAHgZIviNE/l6B5d7awNATiHZ
         KR/vZKA7diamctGjTyV4yGOsHzS6KvPFfZuMIp/E8AGjR3M4IxGSyhgrcy8eeH1gRIX1
         oSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FlRX4rS4p0IRVrMh8fVyivQZmVxEA/5sry7SF1qCv0w=;
        b=VibzMluWe2Jy9EenSgM04mZvSqup+CuQFfhao3bzQ5Z6rJNwo5nHovCupUSoCGU0wF
         PiysbT+6NexeqVQsgz1OphL06l5GB8yoJ0xKz+SeYF4gOff/awR7zz5Y1RBtwPO+R26V
         mC99PX2VaWssq2FhXsAh7YbXIKGDF9Igy8Uz22MV9we0yP0Fqx2Y4BKdkM24Uu6djOk6
         SxKMBRuX7o0WRq2K6wlgBcKU1QUk4iP0+b5XxAneS2SwJ7vyM0j+SQviGMohY01SieMc
         RSecNnElHi1qpomGuDQ3bxIphnmEPIS+q3epoxwUlDkhu/gbNDRTEoMD8QPmys9LDWoH
         AJlw==
X-Gm-Message-State: APt69E3Sie4vQpgrbp+zaZSsfBDDiVJT3ooWpzOReGuov1squ6V04fcX
        e0xL9PzuBcjcI52B/GDKBKo=
X-Google-Smtp-Source: AAOMgpdhOW+7O/Z33qMDUm9a5yXvsBUUoBTUaQotQWSHgzOmiWCxVJGaG0cCbv3PI6BJief1nzfNmg==
X-Received: by 2002:a2e:5bc8:: with SMTP id m69-v6mr6129471lje.115.1530159140087;
        Wed, 27 Jun 2018 21:12:20 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
        by smtp.gmail.com with ESMTPSA id g5-v6sm952861lje.21.2018.06.27.21.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:12:18 -0700 (PDT)
Date:   Thu, 28 Jun 2018 06:12:18 +0200
From:   "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
        Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
        KONRAD Frederic <frederic.konrad@adacore.com>
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
Message-ID: <20180628041217.qxlspqzqfm4gszxd@toto>
References: <20180627185248.GA19743@roeck-us.net>
 <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
 <20180627205915.GA22693@roeck-us.net>
 <20180627224718.ewamlt42kvyirhjw@toto>
 <ae120580-01f2-672d-edc0-440c2dd3f248@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae120580-01f2-672d-edc0-440c2dd3f248@roeck-us.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:34:15PM -0700, Guenter Roeck wrote:
> Hi Edgar,
> 
> On 06/27/2018 03:47 PM, Edgar E. Iglesias wrote:
> 
> > 
> > Hi Guenter,
> > 
> > Re: ml605
> > The thing to watch out for with kernel configs for microblaze systems is the
> > physmem address setting. Unfortunately the kernel does not auto-detect this.
> > 
> > I'm attaching a kernelconfig for the ml605 that works for me and a qemu commandline.
> > 
> > qemu-system-microblazeel -M petalogix-ml605 -m 256 -serial mon:stdio -dtb petalogix-ml605.dtb -kernel arch/microblaze/boot/linux.bin -append rdinit=/bin/sh
> > 
> 
> Can you also send me the dtb file or even better its source ? I don't think
> the one in qemu is correct. It lists the serial port at 0x83e00000, but qemu
> instantiates it at 0x83e01000.

I used the one from QEMU. IIRC, there's some offsetting going on there
that differs between the Xilinx version and the PC version of these
UARTs...

Can you try again and see how it goes?
If it doesn't work, I can share my kernel Image and we can compare from there.

Cheers,
Edgar

> 
> > Re: pmu
> > The PMU board does not run Linux, it runs baremetal power-management related firmware.
> > 
> 
> Ah, good to know.
> 
> Thanks!
> Guenter
> 
