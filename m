Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129BECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D742320858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sd6Pv76P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D742320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeISJoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:44:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55142 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeISJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:44:12 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8J48Crb039338;
        Tue, 18 Sep 2018 23:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537330092;
        bh=z+iHwZb5hKNzKe1+8mrGdH1LFkUcP9Wfos4VItSCduY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Sd6Pv76P7OY9L9EQKXBtNdZ4jj9YrCcJCpLLnwm9HBMAk26W/Xstx7NWf3kdbiNt9
         3y1HyiNMQHCD7OR84OOR4Az15ex0tSa9LHtx+bhQYLGz1hb3U7v0M10hhwBaGCXEIt
         fWFW1vTz2SJTYZhYOsG4U62YabUWSxTFYbPw+mSc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J48Bvb001944;
        Tue, 18 Sep 2018 23:08:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 18
 Sep 2018 23:08:11 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 18 Sep 2018 23:08:12 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J488eM021462;
        Tue, 18 Sep 2018 23:08:09 -0500
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>
CC:     "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-2-afd@ti.com>
 <CACRpkdYmYHL1vrRFeyuO6immh9ZtVPeiOo+=ZB9T=CHe1yGTxg@mail.gmail.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <1b1199c7-2e3a-4f65-0da4-1cbdae219537@ti.com>
Date:   Wed, 19 Sep 2018 09:38:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYmYHL1vrRFeyuO6immh9ZtVPeiOo+=ZB9T=CHe1yGTxg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 19 September 2018 12:56 AM, Linus Walleij wrote:
> On Fri, Aug 31, 2018 at 12:13 PM Andrew F. Davis <afd@ti.com> wrote:
> 
>> Use dev_name to get a unique label and use -1 for a base to get our
>> selection automatically. We pull in all GPIOs per chip now so this
>> does not have the effect of out of order labels like before.
>>
>> We do these both together so we can drop all the static data in one
>> patch. This also lets us normalize the return paths as we don't need
>> any cleanup after this change.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> 
> I have tentatively applied this patch set as we seem to have rough
> consensus that it will be OK.
> 
> We can always pull it out or revert it if things break.

Okay. If that is the case then i have already tested the entire series.

Apart from gpio numbering different, i have tested toggling and
interrupts with k2g-evm and omapl138.

> 
> Yours,
> Linus Walleij
> 
