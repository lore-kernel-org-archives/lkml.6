Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F38C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2CF2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2CF2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeGJNPw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:15:52 -0400
Received: from hermes.aosc.io ([199.195.250.187]:35223 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754265AbeGJNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:15:51 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id A664E64915;
        Tue, 10 Jul 2018 13:15:36 +0000 (UTC)
Date:   Tue, 10 Jul 2018 21:15:05 +0800
In-Reply-To: <20180710130517.GA27236@Red>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com> <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io> <20180710130517.GA27236@Red>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
To:     linux-arm-kernel@lists.infradead.org,
        LABBE Corentin <clabbe@baylibre.com>
CC:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        wens@csie.org, robh+dt@kernel.org, tj@kernel.org,
        maxime.ripard@free-electrons.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <A588EEB5-5305-4EFC-8DDD-369F0751E382@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月10日 GMT+08:00 下午9:05:17, LABBE Corentin <clabbe@baylibre.com> 写到:
>On Mon, Jul 09, 2018 at 11:44:20PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> 于 2018年7月9日 GMT+08:00 下午11:20:54, Corentin Labbe
><clabbe@baylibre.com> 写到:
>> >Hello
>> >
>> >With Moeicenowy's agreement, I have take leadership ot this
>patchset.
>> >
>> >There are no really changes appart renaming struct quirck to
>variant.
>> >
>> >Since the last serie is really old, I will answer comment here.
>> >The two regulator (1.2 and 2.5V) are not for the PHY since:
>> >- nothing in the schematic said that they are for the PHY, they
>seems
>> >  only for controller
>> >- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>> >  cannot be used for target)
>> 
>> Target is not equal to PHY. Target means the supply
>> of the disk, which can be usually 5v (for 2.5" HDD) or
>> 12v (3.5" HDD).
>> 
>> By reading Wikipedia articles  about SATA and LVDS, I assume
>> 2.5V is for PHY and 1.2V is for internal digital logic (VDD-SYS
>> is commonly 1.2V on 40nm Allwinner SoCs; 2.5V VDD can be
>> used to efficiently deliver ~1.2V LVDS.)
>> 
>> P.S. VDD-SATA and VDD25-SATA also exist on A20, and by checking
>> Banana Pi M1 (the original Banana Pi) schematics, VDD-SATA
>> is connected to common VDD-SYS (called INTVDD on the
>> schematics) and VDD25-SATA is connected to an always-on
>> fixed LDO, maybe due to the lack of power outputs on AXP209.
>> 
>
>So we still need to add a regulator on the controller and add an
>optionnal "phy" regulator for AHCI port.

No, phy is not a part of the port. From the perspective of
the users, phy is part of the controller.

I still suggest generic multiple regulator support, to
reduce sunxi-specified code.

>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
