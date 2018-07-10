Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB5320883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB5320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeGJMc7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:32:59 -0400
Received: from hermes.aosc.io ([199.195.250.187]:59155 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932752AbeGJMc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:32:57 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 017AA6490A;
        Tue, 10 Jul 2018 12:32:45 +0000 (UTC)
Date:   Tue, 10 Jul 2018 20:32:27 +0800
In-Reply-To: <20180710122922.6sgmgfislqwhn3tt@flea>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com> <20180710122922.6sgmgfislqwhn3tt@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>
CC:     linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <3F7BD4FD-D8D8-4900-BC53-E2C1928616A4@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月10日 GMT+08:00 下午8:29:22, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Mon, Jul 09, 2018 at 03:20:54PM +0000, Corentin Labbe wrote:
>> Hello
>> 
>> With Moeicenowy's agreement, I have take leadership ot this patchset.
>> 
>> There are no really changes appart renaming struct quirck to variant.
>> 
>> Since the last serie is really old, I will answer comment here.
>> The two regulator (1.2 and 2.5V) are not for the PHY since:
>> - nothing in the schematic said that they are for the PHY, they seems
>>   only for controller
>> - all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>>   cannot be used for target)
>
>That's a pretty bad thing to do, especially for old series. You just
>dropped all the context that you reply to, and there's no way for any
>reviewer to tell if your answers make any kind of sense, or addresses
>any question one might have had.
>
>> Furthermore, the AHCI binding support only one regulator per PHY, so
>> using the "target" regulator is out of question for registring this
>two
>> non-phy regulator.
>
>Nothing is "out of question", we have the source code and can change
>it if needed.

The main problem is that he misunderstood the meaning
of target regulator -- it's not for PHY but for disk. And if a
device is designed to accept both 2.5" and 3.5" HDD at
the same port multiple target regulator might really
be useful -- one 5v and one 12v.

>
>Maxime
