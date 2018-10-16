Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546FFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4DD2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vgKyAD2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4DD2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJPVQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:16:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44612 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeJPVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:16:18 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9GDPgwY019792;
        Tue, 16 Oct 2018 08:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539696342;
        bh=trZjiQQAJhueUbaTek0D6x1pWdJ66wmy0Gp59ZxtHKQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vgKyAD2CEd6KSSB9RsasfuV7VdTaN/Te8uPtDseXS/pWpnrEsO5P3KCFE1TJIW8ye
         O9LtTgzO2B0+XDdN9rpWobMMtAxqj47CSC+iEFdTvRAZcTIHb9UDwOsChOTMyMKPEM
         B1o0jnhKZfwpTnBIqN6aVvQreEtGXEdutBOM3mYE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9GDPfNV017024;
        Tue, 16 Oct 2018 08:25:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 16
 Oct 2018 08:25:41 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 16 Oct 2018 08:25:41 -0500
Received: from [172.22.180.47] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9GDPf7B007170;
        Tue, 16 Oct 2018 08:25:41 -0500
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20181011165123.32198-3-dmurphy@ti.com>
 <20181011182734.GA7973@amd> <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus> <20181012180312.GB5565@amd>
 <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
 <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
 <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
 <5c7f03cc-4d45-6010-523d-46721c218731@ti.com> <20181015214512.GA2001@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <aa401333-9650-c925-2085-6e6d17b576bd@ti.com>
Date:   Tue, 16 Oct 2018 08:25:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015214512.GA2001@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

On 10/15/2018 04:45 PM, Pavel Machek wrote:
> Hi!
> 
>>>> Given this one seems to have not really been finished, it's probably
>>>> okay to make changes in this case. Still, it would be good to see
>>>> patches structured so that it's obvious we're breaking things. But how
>>>> the patches are structured doesn't matter until there's some agreement
>>>> on the end result.
>>>
>>> OK, so if I'm getting it right, the correct patch structure in this case
>>> means that changes removing bindings from MFD and moving them along
>>> with the modifications to the LED subsystem should be placed in a single
>>> patch.
>>>
>>> Dan, could you please arrange the next patch set version accordingly?
>>
>> Yes I can squash the DT bindings patches and call it a "move and modify"
> 
> You can do move without problems. But if you plan to modify them,
> please try to change as little as possible, make it separate patch and
> explain why new version is better than old one.
> 

I have been thinking of how to do this.  Since the 2 devices are part of the current
binding there really is not a way to move them.  Since there are still MFD capable
devices available.

I would still need to remove the current active binding and create a new binding in the LED
bindings directory.

I would have to remove and create in the same patch.

Dan

> Thanks,
> 									Pavel
> 


-- 
------------------
Dan Murphy
