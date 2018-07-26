Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E504C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BC220844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BC220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeGZOEk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:04:40 -0400
Received: from hermes.aosc.io ([199.195.250.187]:49748 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbeGZOEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:04:40 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 71B359FA44;
        Thu, 26 Jul 2018 12:47:49 +0000 (UTC)
Date:   Thu, 26 Jul 2018 20:47:34 +0800
In-Reply-To: <20180726124119.dwne2sncws2p3sdi@flea>
References: <20180724163655.61365-1-icenowy@aosc.io> <20180726124119.dwne2sncws2p3sdi@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to rebase on M2 Ultra
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <BA51039A-02DD-42C2-A7A9-E1B866074CA6@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月26日 GMT+08:00 下午8:41:19, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
>> Banana Pi designs the BPi M2 Berry board to be software compatible
>with
>> BPi M2 Ultra,
>
>Do you have a reference for this?

See [1], it says "BPI-M2U and BPI-M2 Berry share the same image".

[1] http://www.banana-pi.org/download.html

>
>> so it's based on M2 Ultra with some function cuts, including:
>> 
>> - 2048MiB DRAM -> 1024MiB (this should be proceed by the bootloader);
>> - dropped a LED;
>> - dropped eMMC;
>> - dropped USB2 and connect USB1 to a 4-port HUB.
>
>Is it the exhaustive list?

Sorry, but I forgot one thing -- LiPo battery connector.

The list can be examined with [2], except LED difference.

[2] https://bananapi.gitbooks.io/bpi-m2-ultra-open-source-single-board-computer/content/

>
>I'm a bit reluctant to merge that kind of patches usually, since that
>would also imply that each time someone will commit something to the
>M2-Ultra, it would automatically apply to the M2-Berry, without any
>easy way to tell and / or test.
>
>Maxime
