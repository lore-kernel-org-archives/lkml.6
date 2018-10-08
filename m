Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFDEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1211420858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s6wJvOys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1211420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJHTft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:35:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50244 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:35:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98COGbw099124;
        Mon, 8 Oct 2018 07:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539001456;
        bh=MuNm4IqRvhdO/q4yOX9w3v2zMba2YwFob1i/uiI1mg8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s6wJvOysUjkBr14MpPhhx1Eb7/0T88z1sBvkXSJD2SOO7bajoXaQBuj76+l909+dI
         MVeSgAWJQJW1Yfys/Zs8C8LUJd/Pj4Om4tCrHcTN6S8Ct0alfkG4fUjqn9GKfUUOBf
         SqhBZTua12v1Y9f1Z/0R9+ShNKXBuYJa8bDTRCZ4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98COG20030991;
        Mon, 8 Oct 2018 07:24:16 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 07:24:16 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 07:24:16 -0500
Received: from [172.22.168.12] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98COF5j027463;
        Mon, 8 Oct 2018 07:24:15 -0500
Subject: Re: [RFC PATCH 9/9] leds: lm3632: Introduce the TI LM3632 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-10-dmurphy@ti.com> <20181007134630.GA19323@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b323e344-f8e5-1a29-9ea3-56499d41ba89@ti.com>
Date:   Mon, 8 Oct 2018 07:23:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007134630.GA19323@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 10/07/2018 08:46 AM, Pavel Machek wrote:
> On Wed 2018-09-26 08:09:21, Dan Murphy wrote:
>> Add the dedicated TI LM3632 LED driver.  This
>> LED device is capable of driving a backlight display.
>>
>> In addition to the backlight the device has control
>> of a strobe and torch output.
> 
> Is this in some way similar to 3639? That also seems to include flash
> and torch.
> 
> drivers/video/backlight/lm3639_bl.c
> 	

NICE!  

Yes this driver looks to be good enough to use for the 3632 as well.

We would have to extend that driver to support the 3632, add firmware support,
convert the led class registration to the flash LED registration and add the regulator support.

I can abandon the dedicated LED driver and update this one for the 3632.
No reason to have duplicate code.

Dan

							Pavel
> 


-- 
------------------
Dan Murphy
