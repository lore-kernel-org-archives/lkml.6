Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576032082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C0jQ4Ceb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576032082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeIDSUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:20:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55450 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:20:34 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84Dt7p9014396;
        Tue, 4 Sep 2018 08:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536069307;
        bh=7OyTJEpEZdpEP2aw1bvM99B06xIBi/L5ma8brHxd0Z8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C0jQ4CebbFBKJxwXjqQNg+GrusEMjSHuzFO8YDhxl+1gBOqud6vcQ0WWA8ZSPTXkI
         yf1ITJT7y9+Yh2cayIcT4Ka2uWTAzu3ds7HVkm/a9JEbPEpGYuJojyveFlvjRXGp6u
         nL4blqRgTBpgMLOUarBe6TsvLwYlCrTgHZc8A/uc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84Dt70F030069;
        Tue, 4 Sep 2018 08:55:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 08:55:07 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 08:55:07 -0500
Received: from [172.22.184.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84Dt6p7001372;
        Tue, 4 Sep 2018 08:55:07 -0500
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
Date:   Tue, 4 Sep 2018 08:55:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903112656.GF10302@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 06:26 AM, Mark Brown wrote:
> On Fri, Aug 31, 2018 at 01:05:07PM -0500, Andrew F. Davis wrote:
>> Leaving microphone bias off is a valid setting and even used in the DT
>> binding document example. Add this setting here and document the same.
>> Although it may not make much sense to enable a microphone here without
>> any bias, it is a valid setting that can be chosen by DT and may be
>> needed for some boards.
> 
> If we really want to pay attention to something setting this up we'd
> need to completely remove the widget - what the code is doing at the
> minute is setting the voltage that the bias will go to when enabled,
> there's still a widget for turning it on and off.  There's some chance
> that this will break existing boards.
> 

Turning on bias is controlled separately, automatically in user-space in
many cases, not based on the board. The DT needs to have a way to state
that 0v is the needed bias on this board, without this you can not set
0v bias and 2v is chosen by default (which is IMHO should be 0v but that
would change existing behavior so I won't touch that).
