Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740B2C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C24B20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C24B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeILUmp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:42:45 -0400
Received: from hermes.aosc.io ([199.195.250.187]:55269 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILUmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:42:45 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F309F619CD;
        Wed, 12 Sep 2018 15:37:31 +0000 (UTC)
Date:   Wed, 12 Sep 2018 23:37:24 +0800
In-Reply-To: <CAGb2v64t40yTbrnkg33N2=jBdnvV45H1XSCF8U230LGAyuVySw@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-3-jernej.skrabec@siol.net> <CAGb2v65y1W=52SAFFqyCOnHd80nx+oPHUDeysHWBy7o8_g=eeQ@mail.gmail.com> <9915D9F1-1C60-4AEF-9074-CE040FCD7BF0@aosc.io> <CAGb2v64t40yTbrnkg33N2=jBdnvV45H1XSCF8U230LGAyuVySw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH 02/27] arm64: allwinner: h6: add system controller device tree node
To:     linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <B9D0F336-B0C0-453C-AD56-325DAA9883A0@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年9月12日 GMT+08:00 下午10:49:12, Chen-Yu Tsai <wens@csie.org> 写到:
>On Tue, Sep 4, 2018 at 4:44 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>>
>>
>>
>> 于 2018年9月4日 GMT+08:00 下午4:40:56, Chen-Yu Tsai <wens@csie.org> 写到:
>> >On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec
><jernej.skrabec@siol.net>
>> >wrote:
>> >>
>> >> From: Icenowy Zheng <icenowy@aosc.io>
>> >>
>> >> As we have already binding for the H6 system controller, add its
>node
>> >> to the device tree.
>> >>
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> [fixed compatible string]
>> >> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> >
>> >Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>>
>> By the way can these patches be applied first? (patches
>> related to syscon).
>>
>> They're also needed for EMAC.
>
>Applied.
>
>BTW, the H6 system control EMAC register also has the internal PHY
>related controls seen on H3/H5. IIRC you previously mentioned that
>they have no effect?

Yes, because the "internal PHY" on H6 is on AC200.

The internal/external mux bit has effect (although it will mux
to a non-existent PHY when switching to "internal", render
EMAC not usable), but it also has effect on A64 (same effect
with H6), on which it's not documented.

>
>ChenYu
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
