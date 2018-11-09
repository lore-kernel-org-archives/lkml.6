Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A774520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDGE7fQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A774520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKJBRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:17:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42423 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbeKJBRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:17:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so2335415wru.9;
        Fri, 09 Nov 2018 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+fkUspOL3VZewTi0QyvsHpyL6yNBIZaP09UJQVYLJo=;
        b=sDGE7fQALVrc+a0xSF4UQPiLfAeaQ0jnEp+sGxHg7aTiMj4GpF7Q1ArXMixNzYM+oL
         QZlhsvO//OFXAs0aDXWYHDXeUoSDy6S4WJNpg/4L4eJQ/3jhrIvP/jHMzEVflLC7Ijzc
         A+LPwZCd0xPCEz27K0vkk9z8kI/5ISPYpSrzQ/ZS9Qmv60DhEpNgIkj1siBWje7jW4/C
         E3MzXFyfgEqa0dtgOpgA6UiHWHNYDdv5TsL/c2MYV8aed29KFzhJFZHu1oJ+k78TvKfk
         7WEPhMXxZXtxXidzh+DzEmddW+C1mmf3O3UBN26QxZj723QtY3VARW8vqIXxb/p3TqnT
         5z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+fkUspOL3VZewTi0QyvsHpyL6yNBIZaP09UJQVYLJo=;
        b=q96a0RtJ/YO+r2DdjfOfC3+qJaNgoroC82Ur+NRnl/fHqxIT1fP8gVbnCs6dqff37N
         W4ivoI5BJo2biVcnOvuZkQJmFs9agV4aen8uvxpEIb51inDD0lqdBedIbXfp6kgmv/3K
         +W0tyAp2mKyyHMIQxFj4ItQVQFpPCd6Z73NdPnHSLo4PI/Lf2zogdr8A+8kfLgUM+mWk
         jFGBU67nZ+zsjKaK4N6eatPCTD0rgfMJ8YHbeURbIM6O+KknslDla/H8A4llfF/LfEe2
         nHJZb6dDls8CFKWyCI7Bib/UHpc+rOkhpt+WLgyOLvyUeGjRT/cuM7erOl5dCGLsb0u9
         4ORA==
X-Gm-Message-State: AGRZ1gKJCxPMGQPlSkI01588Xf5lpo4i4WHj9GD3+HE/re/8NNsn0/mY
        NZYXngaeI7ApAnMvBZvf3FM=
X-Google-Smtp-Source: AJdET5fBqu0t4uCsTg+CKov5VrNSFIhbF2Vs2Hpl6wzTHYgCKw36io6czlfL3Lj4rPe/Si5STXRfhA==
X-Received: by 2002:adf:fb12:: with SMTP id c18-v6mr8623725wrr.200.1541777789234;
        Fri, 09 Nov 2018 07:36:29 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p7-v6sm7692540wrs.23.2018.11.09.07.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 07:36:28 -0800 (PST)
Date:   Fri, 9 Nov 2018 08:36:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
Message-ID: <20181109153626.GA6494@flashbox>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
 <20181107085503.GA31517@flashbox>
 <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
 <CAKwvOdmkC1LqMokhQUebpEZRoWWWwtQnbm8xGwiwdBy9UOMT5Q@mail.gmail.com>
 <af717713-9e51-139d-1206-1682b83ae434@xilinx.com>
 <20181108150116.GA2830@flashbox>
 <40a17c3e-6c81-6f59-cff6-003a91e10b29@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a17c3e-6c81-6f59-cff6-003a91e10b29@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:33:00AM +0100, Michal Simek wrote:
> On 08. 11. 18 16:01, Nathan Chancellor wrote:
> > On Thu, Nov 08, 2018 at 07:45:42AM +0100, Michal Simek wrote:
> >> On 07. 11. 18 18:48, Nick Desaulniers wrote:
> >>> On Wed, Nov 7, 2018 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>>>
> >>>> On 07. 11. 18 9:55, Nathan Chancellor wrote:
> >>>>> On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
> >>>>>> On 01. 11. 18 1:57, Nathan Chancellor wrote:
> >>>>>>> Clang warns when one enumerated type is implicitly converted to another:
> >>>>>>>
> >>>>>>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> >>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>>>>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> >>>>>>>         ~               ^~~~~~~~~~~~~~~~~~~~~
> >>>>>>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> >>>>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>>>>>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>>>>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
> >>>>>>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> >>>>>>> macro 'PCONFDUMP'
> >>>>>>>         .param = a, .display = b, .format = c, .has_arg = d     \
> >>>>>>>                  ^
> >>>>>>> 2 warnings generated.
> >>>>>>
> >>>>>> This is interesting. I have never tried to use llvm for building the
> >>>>>> kernel. Do you have any description how this can be done?
> >>>>>>
> >>>>>
> >>>>> Depending on what version of Clang you have access to, it is usually just as
> >>>>> simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
> >>>>>
> >>>>> Clang 7.0+ is recommended but 6.0 might work too.
> >>>>
> >>>> TBH I would expect to download container and run this there to make sure
> >>>> that I don't break anything else.
> >>>
> >>> This is the first request we've had for a container in order to test a
> >>> patch.  If it comes up again from other folks, I think it makes sense
> >>> to create one.  Until then, its nice to have.  It's definitely
> >>> overkill for this patch.
> >>
> >> I have played with it to see that error and here are some steps I did.
> >>
> >> docker run --name test-clang -it --rm debian:latest bash
> >> apt-get update
> >> apt-get install gcc-arm-linux-gnueabi gcc-aarch64-linux-gnu clang git bc
> >> build-essential bison flex make llvm vim libssl-dev sparse
> >>
> >> git clone
> >> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth 1
> >> cd linux
> >>
> >> export ARCH=arm64
> >> export CROSS_COMPILE=aarch64-linux-gnu-
> >>
> >> make defconfig
> > 
> > This should also have 'CC=clang' because compiler detection happens in
> > Kconfig now so compiler flags get properly set. Other than that, looks
> > good and I was able to build pinctrl-zynq.o without any issues with
> > those commands.
> 
> For arm32 I am still getting compilation issue (arm64 is fine)
> Below are my steps and version I use. Do you know what could be the
> problem?
> 
> Thanks,
> Michal
> 
> root@1e15921e6d15:~/linux# arm-linux-gnueabi-gcc --version
> arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516
> Copyright (C) 2016 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> root@1e15921e6d15:~/linux# clang --version
> clang version 3.8.1-24 (tags/RELEASE_381/final)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> 
> 
> export ARCH=arm
> export CROSS_COMPILE=arm-linux-gnuaebi-
> make CC=clang defconfig
> make CC=clang drivers/pinctrl/pinctrl-zynq.o
> 
> and I get
> clang: error: unsupported argument '-W' to option 'Wa,'
> scripts/Makefile.build:305: recipe for target 'scripts/mod/empty.o' failed
> make[2]: *** [scripts/mod/empty.o] Error 1
> scripts/Makefile.build:546: recipe for target 'scripts/mod' failed
> 

Ah because Debian's regular Clang is ancient.

For testing, we use the builds from apt.llvm.org. Commands assuming
you're using the normal Debian image:

curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch main" | tee -a /etc/apt/sources.list
apt-get update -qq && apt-get install -y clang-8

Then use `CC=clang-8' instead of 'CC=clang' for all make invocations.

Let me know if there are any more issues!
Nathan
