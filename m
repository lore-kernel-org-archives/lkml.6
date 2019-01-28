Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFB6C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001E3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WQHUHSZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfA1UsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:48:24 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:45032 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfA1UsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548708500; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtFF1XuTGe1bbx2x5U4Z7q4HHOW6EENS8+arBA44m9g=;
        b=WQHUHSZlO3uCVhCQJIo7HTWAhR5NN5kpfqNN5VlZQxTSogpdAO8dP8ZlgtaiG8KN4k8o0O
        HXO1Jdm5qr7uDc3bLydPsarwzfbe+VQAVyMV3/fz2wVrQi0uOOesRm7eoBuFL1gvjuyyfg
        idVaK96uXjDG+Ho+ekYeJk4l44sEgCs=
Date:   Mon, 28 Jan 2019 17:48:04 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Add Ingenic X1000 RTC support.
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Zhou Yanjie <zhouyanjie@zoho.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        a.zummo@towertech.it, robh+dt@kernel.org, paul.burton@mips.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Message-Id: <1548708484.7511.3@crapouillou.net>
In-Reply-To: <20190128201014.GB18309@piout.net>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
        <20190128201014.GB18309@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hello,
> 
> This seems like a useless renaming to me, can you elaborate a bit 
> more?
> 
> I'd also like to have Paul and Lars-Peter comment.

According to the patchset, the RTC in the X1000 does not behave any 
different
than the one in the JZ4780 SoC. Therefore patches 1/2 should be dropped.
In your devicetree bindings, just use the "ingenic,jz4780-rtc" 
compatible
string instead. The same goes for all the drivers (e.g. the uart one).

I don't really mind the renaming, maybe replace "Ingenic JZ47xx SoCs" 
with
just "Ingenic SoCs" since XBurst is just the name of the CPU inside 
these
SoCs.

Regards,
-Paul

