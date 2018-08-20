Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02669C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B7920C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B7920C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeHTPWY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:22:24 -0400
Received: from hermes.aosc.io ([199.195.250.187]:39734 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbeHTPWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:22:24 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0C737E0E6D;
        Mon, 20 Aug 2018 12:06:42 +0000 (UTC)
Date:   Mon, 20 Aug 2018 20:06:21 +0800
In-Reply-To: <20180820120046.7tonxtb52q43ocfq@flea>
References: <20180724163655.61365-1-icenowy@aosc.io> <20180726124119.dwne2sncws2p3sdi@flea> <dc8a28bcfbe082158bac5b097badb3ddf0f51ce8.camel@aosc.io> <20180820120046.7tonxtb52q43ocfq@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to rebase on M2 Ultra
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <2782CDF6-C36F-49EF-97AE-75382C416489@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年8月20日 GMT+08:00 下午8:00:46, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>Hi!
>
>On Wed, Aug 08, 2018 at 06:36:56PM +0800, Icenowy Zheng wrote:
>> 在 2018-07-26四的 14:41 +0200，Maxime Ripard写道：
>> > On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
>> > > Banana Pi designs the BPi M2 Berry board to be software
>compatible
>> > > with
>> > > BPi M2 Ultra,
>> > 
>> > Do you have a reference for this?
>> > 
>> > > so it's based on M2 Ultra with some function cuts, including:
>> > > 
>> > > - 2048MiB DRAM -> 1024MiB (this should be proceed by the
>> > > bootloader);
>> > > - dropped a LED;
>> > > - dropped eMMC;
>> > > - dropped USB2 and connect USB1 to a 4-port HUB.
>> > 
>> > Is it the exhaustive list?
>> 
>> I have asked Mikey from Sinovoip, and he has agreed this.
>> 
>> Here's a list provided by him, which covers some things I forgot:
>> - 2GiB -> 1GiB
>> - no eMMC
>> - no onboard microphone
>> - no IR
>> - no charging (and power jack to USB)
>> - USB change
>> - one less LED
>> 
>> Should I add this to the device tree's comment?
>
>Not really, because...
>
>> > 
>> > I'm a bit reluctant to merge that kind of patches usually, since
>that
>> > would also imply that each time someone will commit something to
>the
>> > M2-Ultra, it would automatically apply to the M2-Berry, without any
>> > easy way to tell and / or test.
>
>... this still applies.

But I think few developers will have both boards at the same time.

>
>Maxime
