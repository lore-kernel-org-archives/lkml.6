Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5224FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F2520779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F2520779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJVPJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:09:12 -0400
Received: from mout01.posteo.de ([185.67.36.141]:45007 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeJVPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:09:12 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 92DC821255
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 08:51:57 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 42dnHw1c12z6tmF;
        Mon, 22 Oct 2018 08:51:56 +0200 (CEST)
Subject: Re: CRC errors between mvneta and macb
To:     linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org
References: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
 <20181019154439.GC24045@1wt.eu>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <c24489f6-3b9a-f26b-bc7f-b564d5567294@sorico.fr>
Date:   Mon, 22 Oct 2018 08:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181019154439.GC24045@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/10/2018 à 17:44, Willy Tarreau a écrit :
> On Fri, Oct 19, 2018 at 05:15:03PM +0200, Richard Genoud wrote:
>> When there's a CRC error, the TXCLK has its polarity inverted...
>> That's a clue !
>>
>> But this TXCLK (25MHz) is not used on the g35-ek.
>> Only the REFCLK/XT2 (50MHz) is used to synchronise the PHY and the macb.
>> So I guess that the TXCLK has a role to play to generate TX+/TX-
> 
> Well, just a stupid idea, maybe when this signal is inverted, the TX+/TX-
> are desynchronized by half a clock and are not always properly interpreted
> on the other side ?
> 
> Willy
> 

I must admit that I'm not familiar with the PHY internals, I'll have to
dig into that.

Richard.
