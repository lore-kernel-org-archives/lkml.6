Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC9BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF3B20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fhNJgPa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfAQUM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:12:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38815 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfAQUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:12:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so2416575wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4uG8rTQ+z04nwT9w7QR/uF5MC1nQ18tGXhygYKcakPE=;
        b=fhNJgPa210vg0R22Xc4oG4gLupBwuJzRnYqWHxAys1Q4fDJLoRQEVQmkuDk5cd0wf0
         Idmu8ZlK0DmxgMCvbkmyzLfnwMANjC3ROZWDYrabG89sqoJpHf4vNGwuQaJTzPb72JiV
         m2KJQLNQ/na2w34P/GF4Dfuk/mOelmJlRXmJaZQ9G9gKnkfg2X/SgmkL+g76sQ0LTp4T
         ODQEaOA3Ev9Ck27u15yFMnMjLIoZ3QlwaKuP/RmPG5Ps3GM49MUGc0joL8Pjjzv4tZ4A
         xDMbMer82xA5lcv1mmzGlAMB80OUkm9H/qcK/tpomaQaNH6btMw3Bkp1+awNIbVt9iQl
         uZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4uG8rTQ+z04nwT9w7QR/uF5MC1nQ18tGXhygYKcakPE=;
        b=umbgTH3ZwFRJtE8Uizyj/ee+uTQJ0fYBS22lA8dO/cK8H97ixvcPdj9oqmISWoELmZ
         nizCCbe5SY9a4EFVTTR1LX88Ds+IrLB2JiwHbn31wNlvm0Bw66LXvYI8kF9ZeMCm+sox
         1fRHq3xS+Ij6Ihr3Mjx2ZGVY4J9LuSP1sc7QFReZ68idWTVXK5PNyra/7Lk4iWbtJaEP
         6rf7A7Zgwcyx/M8Wz5Yl5x5Wt1sJeZUB2xDSjIhpu1UnojhxmHH3/ZKnzJa92xjk0s32
         SdSgdaNg06lV4kBi4L2wOTcCTYpn5KTz17CQ9v33s0TL0295lI7zPQpfmRqO9RSMimgz
         JC9w==
X-Gm-Message-State: AJcUukfT2FTjgGsDiYA4C5+nsI7hb20X9bQAzwxT7PnWWGzHeyecKfMI
        rEm9w55r+pPhmKxu4RkdR6kAkg==
X-Google-Smtp-Source: ALg8bN7IvkGWx/OA1yQPOpoCWMIc2j/U+zlQc1EzWP4ydgibgCcR6CAsMERKQYUZoJPKQ+UFSG+JXQ==
X-Received: by 2002:a1c:60c3:: with SMTP id u186mr14070746wmb.66.1547755943138;
        Thu, 17 Jan 2019 12:12:23 -0800 (PST)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id t199sm24951671wmt.1.2019.01.17.12.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:12:22 -0800 (PST)
Message-ID: <f7289814e316ad5879848fb8c379db396f615828.camel@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 21:12:20 +0100
In-Reply-To: <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
References: <20190116165236.8330-1-jbrunet@baylibre.com>
         <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2019-01-17 at 21:03 +0100, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Wed, Jan 16, 2019 at 5:52 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
> > -               aobus: bus@ff800000 {
> > -                       compatible = "simple-bus";
> > -                       reg = <0x0 0xff800000 0x0 0x100000>;
> are you sure about removing aobus?
> in your patch "arm64: dts: meson: g12a: add pinctrl support
> controllers" from [0] you're adding back an "rti" bus at the same
> memory address, except that it's size is 0x1000 instead of 0x100000

Yes, I'm sure. The fact that the aobus region size is completly made up, for
all I know, is the reason 

> 
> I don't have any G12A datasheet so it's hard for me to ACK / NACK this
> patch, here are some clues why I'm asking:
> - GXM's public datasheet lists the "RTI" region at 0xC8100000 -
> 0xC81FFFFF, we call it "aobus" in our .dtsi

... RTI region which will appear once i submit the clock controller

Yes GXM (and GXBB, GXL or AXG) has the same made up region with nothing
matching in the datasheet, but it is bit late fix that now.

> - buildroot_openlinux_kernel_4.9_fbdev_20180706/kernel/aml-
> 4.9/arch/arm64/boot/dts/amlogic/mesong12a.dtsi
> also uses an aobus node as well as an io_aobus_base sub-node for the
> codec_io node (the latter is obviously not upstream)

I know, but again, it does not map to anything in the doc, and it has been the
case for several SoC.

> 
> Regards
> Martin
> 
> 
> [0] https://lore.kernel.org/patchwork/patch/1032981/


