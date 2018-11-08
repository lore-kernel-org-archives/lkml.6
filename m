Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9314ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C8420827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWrWN162"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C8420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeKIAhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:37:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40069 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKIAhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:37:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so1498965wme.5;
        Thu, 08 Nov 2018 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1sKunXkCnbt4d4DCRYomB2Du9d0WmVfFrUlP7zNSSxs=;
        b=uWrWN162PhEPlt5U65i3uibUivtA1eXT3I//Nl3cSLJGYL13g5k28vV3Xbb9JUc+cP
         FJLiDa+7nP2jzJ3Zd5/axo6jpch+sQdOzZHdusuBE8djTxNowWZ/Jb9AOogua1U+DtL5
         tCh6OZduV+FntrAiYIWWA3s4nWLJIpFLTsyZVY7mYm23upQzRZS1ihRlw7/WLV4DW83M
         8wq9ZBCaDlEgsSNeizq0xaJ5PA30IOz+QCnxYBBa4iq0PPas/37CQ+71H2+HXSU2ikyV
         Yh7nkBOsF8x3Dg5Zy+wtVwyiNEC3ayvLdRsd1I/ySFykv3hi8Mh0GgXEROp8egSSEcOc
         asiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1sKunXkCnbt4d4DCRYomB2Du9d0WmVfFrUlP7zNSSxs=;
        b=QelZz2Zn+nKavkID1uNqkv5UtqaTA9v7IlUuJwYUThAjdFr0hF0ZBX5NWkf5BkRjHa
         Z9J+PDI7jHz6VsWGm4PDnHXjqMf3dmcBmPnEys3HVYndlyrTpcTgVHLqREn5yLIu8ZBd
         oAFfx3X+q5pcmqJ1IJscQ0HCOqrazLPhSY/jtbOCcey9UZpJU8ihWIM6cck9p8EZSpSv
         JlNVFHBpOfuwdpU1A3BwKVacH4C1j2yRJKEIa2/Rgw6i04Ly1tjdknTq3aIfcrUJtGPX
         IdSp8LTuz0EkVRASW8zw+1xfdBhFP6827NOB40QKRIDSM/ZjWaExSWQQnno6iP9Uk0nT
         7Zng==
X-Gm-Message-State: AGRZ1gJSqAdUZcjhbQOP4HZtKWKZkjXDSVu/nbODzvQVCSUeHK2sEw80
        6nCRf6WVAoHcLoFdOHku3p5vi8lpwCo=
X-Google-Smtp-Source: AJdET5fPsjSL4r7o8hdiqWT9k2lcGL76RMQPyN6FD+KVg93cn34WJc7DCK81qry2WKEcETpk1osINQ==
X-Received: by 2002:a1c:61d6:: with SMTP id v205-v6mr1605273wmb.10.1541689281171;
        Thu, 08 Nov 2018 07:01:21 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z6-v6sm5354027wrs.19.2018.11.08.07.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 07:01:18 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:01:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
Message-ID: <20181108150116.GA2830@flashbox>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
 <20181107085503.GA31517@flashbox>
 <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
 <CAKwvOdmkC1LqMokhQUebpEZRoWWWwtQnbm8xGwiwdBy9UOMT5Q@mail.gmail.com>
 <af717713-9e51-139d-1206-1682b83ae434@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af717713-9e51-139d-1206-1682b83ae434@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:45:42AM +0100, Michal Simek wrote:
> On 07. 11. 18 18:48, Nick Desaulniers wrote:
> > On Wed, Nov 7, 2018 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >>
> >> On 07. 11. 18 9:55, Nathan Chancellor wrote:
> >>> On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
> >>>> On 01. 11. 18 1:57, Nathan Chancellor wrote:
> >>>>> Clang warns when one enumerated type is implicitly converted to another:
> >>>>>
> >>>>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> >>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>>>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> >>>>>         ~               ^~~~~~~~~~~~~~~~~~~~~
> >>>>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> >>>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>>>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
> >>>>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> >>>>> macro 'PCONFDUMP'
> >>>>>         .param = a, .display = b, .format = c, .has_arg = d     \
> >>>>>                  ^
> >>>>> 2 warnings generated.
> >>>>
> >>>> This is interesting. I have never tried to use llvm for building the
> >>>> kernel. Do you have any description how this can be done?
> >>>>
> >>>
> >>> Depending on what version of Clang you have access to, it is usually just as
> >>> simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
> >>>
> >>> Clang 7.0+ is recommended but 6.0 might work too.
> >>
> >> TBH I would expect to download container and run this there to make sure
> >> that I don't break anything else.
> > 
> > This is the first request we've had for a container in order to test a
> > patch.  If it comes up again from other folks, I think it makes sense
> > to create one.  Until then, its nice to have.  It's definitely
> > overkill for this patch.
> 
> I have played with it to see that error and here are some steps I did.
> 
> docker run --name test-clang -it --rm debian:latest bash
> apt-get update
> apt-get install gcc-arm-linux-gnueabi gcc-aarch64-linux-gnu clang git bc
> build-essential bison flex make llvm vim libssl-dev sparse
> 
> git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth 1
> cd linux
> 
> export ARCH=arm64
> export CROSS_COMPILE=aarch64-linux-gnu-
> 
> make defconfig

This should also have 'CC=clang' because compiler detection happens in
Kconfig now so compiler flags get properly set. Other than that, looks
good and I was able to build pinctrl-zynq.o without any issues with
those commands.

Cheers!
Nathan

> make CC=clang drivers/pinctrl/pinctrl-zynq.o C=1 V=1
> 
> There was not a problem to run it for arm64 but I had issues to run this
> for arm32.
> Do you see any problem with above steps?
> 
> Thanks,
> Michal
> 
