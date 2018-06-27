Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22441C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4BD2637C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sLkjjX7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4BD2637C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeF0K1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:27:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53808 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeF0K1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:27:21 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RAQHLp035368;
        Wed, 27 Jun 2018 05:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530095177;
        bh=pQPoY6VHrRq3SNzSUke2dzRht24ttf15O4AHxL1Qkso=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sLkjjX7lUyQV2KqXd5k5K3zSTb0KaoPBNfjA6D/OjrVotqTlcJtDnsb2fzvhRZa8k
         e916kTrouS5q5xaUZItNTHQuPlCHXUwhqW+IZR5oD9ibuygcdCX809KzZkjgbdxHVQ
         4EqZ4GA9W9+Em4woDzyIwMl5EAAza7dzGOUGuWNA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RAQHGo022474;
        Wed, 27 Jun 2018 05:26:17 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 05:26:16 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 05:26:16 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RAQCYm003872;
        Wed, 27 Jun 2018 05:26:13 -0500
Subject: Re: [PATCH v2 04/13] clk: davinci: psc-dm646x: use two lookup entries
 for the aemif clock
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-5-brgl@bgdev.pl>
 <1da88059-2d5b-f035-1d4c-9e21ae141017@ti.com>
 <CAMpxmJXpAECkA7FTLx-nR_w0ZEBUw_A7qpu2P6e_mS6k=pTsUQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <28c47ca0-60ca-beb2-cd78-63ef6595fcd5@ti.com>
Date:   Wed, 27 Jun 2018 15:56:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJXpAECkA7FTLx-nR_w0ZEBUw_A7qpu2P6e_mS6k=pTsUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 June 2018 03:33 PM, Bartosz Golaszewski wrote:
> 2018-06-27 12:01 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>> On Tuesday 26 June 2018 02:55 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> We want to be able to get the clock both from the board file by its
>>> con_id and from the aemif driver by dev_id.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I see the DM365 and DM644x EVM board files getting reference to aemif
>> clock using just the con_id, but don't see that for DM646x. Am I
>> overlooking something?
>>
>> Thanks,
>> Sekhar
> 
> It's being done indirectly from mach-davinci/aemif.c. I guess we can
> remove it again after last patch.

I see. One way to avoid that would be to merge this into 11/13. I prefer
that, but it prevents clean separation of clock and machine patches. So
okay with current way too.

Thanks,
Sekhar
