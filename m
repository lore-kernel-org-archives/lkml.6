Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463F5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A512075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A512075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeIFQkC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:40:02 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42831 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:40:01 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 7ADA211C1AF;
        Thu,  6 Sep 2018 12:04:38 +0000 (UTC)
Date:   Thu, 06 Sep 2018 20:04:11 +0800
In-Reply-To: <20180906115114.inc6dhqhy47obo25@flea>
References: <20180830154518.29507-1-embed3d@gmail.com> <20180830154518.29507-28-embed3d@gmail.com> <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com> <55579dd6-625d-e71b-1482-4592dccac665@gmail.com> <20180906115114.inc6dhqhy47obo25@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
To:     maxime.ripard@bootlin.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philipp Rossak <embed3d@gmail.com>
CC:     Emmanuel Vadot <manu@bidouilliste.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <BEA89263-1186-432A-B274-228FAC21A798@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年9月6日 GMT+08:00 下午7:51:15, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
>> On 04.09.2018 18:46, Emmanuel Vadot wrote:
>> > > +			/* Data cells */
>> > > +			thermal_calibration: calib@234 {
>> > > +				reg = <0x234 0x8>;
>> > > +			};
>> >   You are declaring 8 bytes of calibration data but to my knowledge
>it's
>> > only 2 bytes per sensor, so 2 bytes for H3.
>> >   Am I missing something ?
>> > 
>> >   Thanks,
>> 
>> Emmanuel you are right, it is 2 bytes per Sensor and should be 2
>bytes for
>> H3, but the thermal calibration data field is on all chips 64 bit
>wide - so
>> 8 bytes. So I'm reading here the complete calibration data field.
>
>Having one cell per channel would make more sense I guess.

I have mentioned that this is impossible because of wrong
addressing caused by LE2BE in SID driver.

>
>Maxime
