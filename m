Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE5CC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4322E20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emQqRC0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4322E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbeKHDUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:20:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42931 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeKHDUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:20:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so8186827plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PIFLZL5b1Tl6mFxyEsZDWQUuh+4alBjnBASE2IvM76o=;
        b=emQqRC0VR2fJIspzzrRyU7XiRfQNG9X0jYb7yZzkgGRiBU7JGlErcSHbTtT6L5hFpH
         Eo4rlA6jvAEu7B6nXgwqmPmvObZ6gV/w1608/H3kMQkELHadOP7ilu254LtFzRX1rNkk
         EmoZbeK51nl9fFfI39d50N9cAI0UgpPMISkR2Q20sQfyLC1KmYS5Op3ia2w2AOaumfXt
         zFQ67mmEc7fjZvQcmZ1diiG/7HK2GvAsM/0Xo4DJeoKOvbsOAWlIJG/jBX3rMTIU0DAj
         QrtKibbV2xjrRQWu+Nm9ZkAR/Qn4bIdfgwoDq4IUATiRZe58b1xhmcNIQVUfHZUSEey6
         ZJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIFLZL5b1Tl6mFxyEsZDWQUuh+4alBjnBASE2IvM76o=;
        b=J3rR12nu4dlYTZ6USyWfASeifmqXbGwsscmISiIs4800QHwWhKaT3DF8pn/7ZoHbxI
         dciw+yuTz5mHzYf0HbT/BHvCt2k9feE0SqzYIBqhVRRQ8GbJe0XaGP/65RvMpEoz0MBq
         Dx6CxrJxxk3sbsKJmPSzw2kqzsb4dXzT2dTG0Pot5cK8M10AfPMPXzYqz64hhvnCGnUQ
         eOnj152SDneVWCb3OAupiMGjd9hDcaRxWTEZZnEgWCGlFoG41/jaxme1yu86q+Da6Pcf
         o9T9k5fyRXQiDjwehuYoStUlkUoWvkoRu9AhNixnPFteb0ROIKOCzc2KobdfVT5/cpUR
         QknA==
X-Gm-Message-State: AGRZ1gJTMNPmnNKKmt0KHeZekDTMlBQFRRZtrSwdzPJxMlDG/3OTXNvd
        H381KOac86JMSoz2I7AyKH5dyzXPHmm47CqX4cuwIA==
X-Google-Smtp-Source: AJdET5e34u46pjaEg5njAUM6ykqa6mTSjH2BrhhLX0Is5ZI9OxtONPQK1LioQW69XRBYOTgpalEHq2/4l+ylOLEVwdA=
X-Received: by 2002:a17:902:1347:: with SMTP id r7-v6mr1149358ple.238.1541612946112;
 Wed, 07 Nov 2018 09:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com> <20181107085503.GA31517@flashbox>
 <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
In-Reply-To: <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Nov 2018 09:48:54 -0800
Message-ID: <CAKwvOdmkC1LqMokhQUebpEZRoWWWwtQnbm8xGwiwdBy9UOMT5Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for PIN_CONFIG_IO_STANDARD
To:     michal.simek@xilinx.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 07. 11. 18 9:55, Nathan Chancellor wrote:
> > On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
> >> On 01. 11. 18 1:57, Nathan Chancellor wrote:
> >>> Clang warns when one enumerated type is implicitly converted to another:
> >>>
> >>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> >>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> >>>         ~               ^~~~~~~~~~~~~~~~~~~~~
> >>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> >>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
> >>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> >>> macro 'PCONFDUMP'
> >>>         .param = a, .display = b, .format = c, .has_arg = d     \
> >>>                  ^
> >>> 2 warnings generated.
> >>
> >> This is interesting. I have never tried to use llvm for building the
> >> kernel. Do you have any description how this can be done?
> >>
> >
> > Depending on what version of Clang you have access to, it is usually just as
> > simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
> >
> > Clang 7.0+ is recommended but 6.0 might work too.
>
> TBH I would expect to download container and run this there to make sure
> that I don't break anything else.

This is the first request we've had for a container in order to test a
patch.  If it comes up again from other folks, I think it makes sense
to create one.  Until then, its nice to have.  It's definitely
overkill for this patch.

-- 
Thanks,
~Nick Desaulniers
