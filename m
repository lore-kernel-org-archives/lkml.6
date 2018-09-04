Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227BC20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xw6j/hCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227BC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeIDT3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:29:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36830 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbeIDT3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:29:15 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84F3fV2056619;
        Tue, 4 Sep 2018 10:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536073421;
        bh=plaojBKuralsXwh3QIwdyvTkSzWrZTTEvZ3Ua00RSog=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xw6j/hCOGB43b+GJJrJ64JJeDKxkbyzg1flFpo11RzCqQ2awEwg7nmF1Gzu6qWJNJ
         v2M3FTZ4F/NeZ35439hakNW/4kt027Mq/lX7Dd73kISUFcTqsSaF+WQKEQp15/9d1W
         PvF2CKp3o3ljleCHWpgth6YoOWWCGuJRdI8FBRP8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84F3fXR005441;
        Tue, 4 Sep 2018 10:03:41 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 10:03:40 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 10:03:40 -0500
Received: from [172.22.184.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84F3emJ029409;
        Tue, 4 Sep 2018 10:03:40 -0500
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
 <20180904145740.GE12993@sirena.org.uk>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
Date:   Tue, 4 Sep 2018 10:03:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904145740.GE12993@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 09:57 AM, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 09:50:50AM -0500, Andrew F. Davis wrote:
>> On 09/03/2018 06:30 AM, Mark Brown wrote:
>>> On Fri, Aug 31, 2018 at 01:17:37PM -0500, Andrew F. Davis wrote:
>>>> The notification handler sets the reset line but never re-enables it
>>>> as no one is listening for an enable event, this is certainly broken
>>>> and was most likely just copied from other CODECs, remove this code.
> 
>>> Why not fix it?  The usual pattern would be to take the CODEC out of
>>> reset when bringing the bias back to standby.
> 
>> The only time this code gets called outside of the normal power on/off
>> path is regulator_force_disable(). And the enable event is only called
>> inside regulator_enable() which would already be part of the normal
>> power up path.
> 
> It's there to save us having to rewrite the register cache if we asked
> for the device to be powered down but that didn't actually happen due to
> other constraints, we know all the registers are still as we left them.
> 

I don't see that happening for any other user of this, we will still
have to re-write the cache when the device goes from OFF->STANDBY, and
if it stays in standby and never went off, then we are still broken as
we switched to using the register cache only, but never turned on real
writes again.
