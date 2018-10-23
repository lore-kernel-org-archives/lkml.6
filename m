Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926D7C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785D5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785D5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJWPUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:20:19 -0400
Received: from mout01.posteo.de ([185.67.36.141]:53854 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbeJWPUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:20:19 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 59EC0211AD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:58:13 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 42fPNg20KKz6tmM;
        Tue, 23 Oct 2018 08:58:11 +0200 (CEST)
Subject: Re: CRC errors between mvneta and macb
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org
References: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
 <20181019154439.GC24045@1wt.eu>
 <c24489f6-3b9a-f26b-bc7f-b564d5567294@sorico.fr>
 <31385a3b-2196-94d0-7f4f-52e37ee07a28@sorico.fr>
 <20181022181918.GF24112@lunn.ch>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <3d967432-b526-0cee-ed45-beb27bebd031@sorico.fr>
Date:   Tue, 23 Oct 2018 08:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181022181918.GF24112@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/10/2018 à 20:19, Andrew Lunn a écrit :
>> I dug more on the subject, and I think I found what Marvell's PHY/MAC
>> doesn't like.
> 
> Hi Richard
> 
> What PHY is being used?
> 
88E1512-NNP2

>> After analyzing the ethernet frame on the Davicom PHY's output (pin
>> TX+), I find out that the FCS errors occurs when the ethernet preamble
>> is longer than 56bits. (something like 58 or 60 bits)
> 
> Some Marvell PHYs have a register bit which might be of interest: Page
> 2, register 16, bit 6.
> 
> 0 = Pad odd nibble preambles in copper receive packets.
> 1 = Pass as is and do not pad odd nibble preambles in
> 
>   Andrew
> 

Thanks, I'll look into that.

Richard
