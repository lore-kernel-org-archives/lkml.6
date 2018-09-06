Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD948C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761C02075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761C02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIFKxg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:53:36 -0400
Received: from hermes.aosc.io ([199.195.250.187]:33938 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeIFKxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:53:36 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 4DA3911C1AF;
        Thu,  6 Sep 2018 06:19:37 +0000 (UTC)
Date:   Thu, 06 Sep 2018 14:19:17 +0800
In-Reply-To: <CAMty3ZDn=uj3buvJx93R1J7Swr3CyfjJJ=MgQTGvRZ01izbAAA@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180904044053.15425-9-icenowy@aosc.io> <CAMty3ZDn=uj3buvJx93R1J7Swr3CyfjJJ=MgQTGvRZ01izbAAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH v4 08/11] arm64: dts: allwinner: a64: Add display pipeline
To:     jagan@amarulasolutions.com, Jagan Teki <jagan@amarulasolutions.com>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <73ADC796-D8CE-417C-82E3-0CDAF710A2F3@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年9月6日 GMT+08:00 下午2:18:13, Jagan Teki <jagan@amarulasolutions.com> 写到:
>On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> From: Jagan Teki <jagan@amarulasolutions.com>
>>
>> Allwinner A64 have a display pipeline with 2 mixers/TCONs, the first
>> TCON is connected to LCD and the second is to HDMI.
>>
>> The HDMI controller/PHY pair is similar to the one on H3/H5.
>>
>> Add all required device tree nodes of the display pipeline, including
>> the TCON0 LCD one and the TCON1 HDMI one.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> [Icenowy: refactor commit message and add 1st pipeline]
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes for v4:
>> - Misc fixes
>> - Dropped second PLL from HDMI PHY clock
>
>Why? it was there in previous versions.

Based on my experiments, the bit has no effect on A64, and the parent
is always PLL-VIDEO0.

