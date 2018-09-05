Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAF5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD9B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD9B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIEMPu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:15:50 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56664 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbeIEMPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:15:49 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id B5EA9FFAF3;
        Wed,  5 Sep 2018 07:46:48 +0000 (UTC)
Date:   Wed, 05 Sep 2018 15:46:41 +0800
In-Reply-To: <20180905071435.lgsogpzmh5nw6bcy@flea>
References: <20180903133434.58188-1-icenowy@aosc.io> <20180903133434.58188-2-icenowy@aosc.io> <20180905071435.lgsogpzmh5nw6bcy@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <3D28A45F-D67D-4388-9FB7-2A2763955398@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年9月5日 GMT+08:00 下午3:14:35, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Mon, Sep 03, 2018 at 09:34:32PM +0800, Icenowy Zheng wrote:
>> By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
>> introduced in R40, although it has two PLL-VIDEOs.
>> 
>> Change the A64 HDMI PHY binding to R40 one.
>> 
>> This binding is introduced in v4.19, which is still in RC stage, so
>we
>> have change to fix it.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>That doesn't make much sense. The A64 doesn't have any particular
>reason to behave like the R40, and the R40 can definitely use a
>different compatible if it has a different behaviour. But I don't see
>*why* the A64 not behaving like the R40 is a justification to remove
>the A64 compatible. Especially when the R40 was released later.
>
>Add a new compatible, and leave the A64 compatible alone.

But the behavior of A64 compatible will change from double
PLL to single PLL, because the A64 HDMI PHY is proven
to have no double PLL.

Should I then change the A64 compatible behavior and import R40 compatible at the same time?

In addition maybe I can just drop A64 compatible, and let A64
use H3 one. Then I will add a R40 compatible to catch
dual PLL behavior.

>
>Maxime
