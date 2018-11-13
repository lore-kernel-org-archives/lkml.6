Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D004C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD74E22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A1A/TUYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD74E22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbeKMUD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:03:29 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42566 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbeKMUD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:03:29 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181113100606euoutp02e15c84df3147cf57352a7c7d74bb4d6d~mpwYPb9CF3175931759euoutp02p
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:06:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181113100606euoutp02e15c84df3147cf57352a7c7d74bb4d6d~mpwYPb9CF3175931759euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542103566;
        bh=96Z5bOcipw0i03FXoX4jR3ap9q/LtIOU3sBn4KveVLY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=A1A/TUYRFwV0w+44V7RznQmcI52291tNlmuoepVSutN9N9MZNai47QBv2ARgqJ1j2
         MqMuOQNohdcShkE4b/TOGWtM85WlCP1EIxcZptlOZVHZhc8kbp5KYPE4u+pSDwx+8K
         h/zfQRDrZTJMp6GDclPUdfXnEPBB/+89gqH+xV4I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113100606eucas1p1b05487a56bb7400798576bcb8d288c2e~mpwXb6txq0163001630eucas1p13;
        Tue, 13 Nov 2018 10:06:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.04.04441.D02AAEB5; Tue, 13
        Nov 2018 10:06:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181113100605eucas1p25f18ba09acd59377c9bb62ca7196c2c7~mpwWrGSwH1709017090eucas1p2e;
        Tue, 13 Nov 2018 10:06:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181113100604eusmtrp1e4a921ed3d2e23575b3114af87629f34~mpwWcH60I2610726107eusmtrp1g;
        Tue, 13 Nov 2018 10:06:04 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-c3-5beaa20d6026
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.79.04128.C02AAEB5; Tue, 13
        Nov 2018 10:06:04 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181113100604eusmtip24ef56f1f83f4cfaa57df0eca4e5cc6b3~mpwV4dbro0669806698eusmtip2c;
        Tue, 13 Nov 2018 10:06:04 +0000 (GMT)
Subject: Re: [PATCH v2 05/11] Doc: DT: thermal: new irq-mode for trip point
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <99e23b0a-ebe7-5c6b-05a7-14d49965b1e1@partner.samsung.com>
Date:   Tue, 13 Nov 2018 11:06:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPedw6OD1fWWVkYozgR03AWKz5t_-vWw0MV1jVGVR_UGTA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe/5cc/dPHxd0Wf5td1mS6NE2rNpxmb2jD8If0R/8NCzarrK
        PRXFRqYfkpRacVK4iKtcEnI7TWnOrXTlV60f0jqmaNRllSFdT6b/Xp/P5/3Z5/3ePgyh6aC8
        maiYeFEfI0RraTX58PmEYzV7YzBsTatzFXfvkpninE/TEVfsWsqVNLZQXMmbdxTncFQpuer+
        KbqeVkpyry1FNOc634i4m+1tCi71SaOSc/Zl05tYvqK4AvGPDT1K3mgdUPDVprM03/3OSvP3
        S0/yxuw8is+uMSHeVb1sp2qfOjhcjI5KFPX+Gw+oI42pLVRc1vxjFUPep5B5biZSMYAD4WpX
        P52J1IwG30bQeG4UycUogs4COykXLgTmyjL630puqYOSB2UIhr+9J+RiCEFay2uFW+WBt0N9
        ym/KzZ54JbT/HpveIPCwAnoq7cpMxDA09oNa0xE3sngrGOuQW07iFdCdU0+4eSEOhYze8unD
        LF4A9stO0s0qHAItn3uVbiawF3Q6SxQyL4dHQ0XTfgBPKOGLJYeUXW+BkWb7TAIPGLTVKGVe
        Ak15WTMaCV5mmGY0JyDdXjuj2QDPbG2U2ycxlcVs8Zfbm8H+4Nd0G/A86BhaIFuYBxcfFhJy
        m4WMNI2s9oGarFaFzIugrKJAmYO0hlnBDLPCGGaFMfy/ew2RJuQlJki6CFEKiBGP+kmCTkqI
        ifA7FKurRlP/1vTHNlKLfrw62IAwg7Rz2ReFA2EaSkiUknQNCBhC68k+DhwM07DhQlKyqI/d
        r0+IFqUGtJghtV7s8TkfwjQ4QogXD4tinKj/N1UwqqmnCVj/7U7XW7VHIXt3cg5dH+ldYAvd
        HazLT8jPtaVv25MX1GxJVF0Ye9Z9hhk3CyUfrfnbHzQZK2919rU3YfMZ3x0X0BXPquGDic9t
        /t5McsGwT3hukWutKqT9UqbltJhKFu5989Pve5B1l1WYrKz76lHumBw33B8Jbv7ktS5FNaIl
        pUghwJfQS8JfNfVvBmsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xe7o8i15FGzw4YGqxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLc6f38BusekxkLWwbQmLxeVdc9gsPvceYbRYev0ik0Xr3iPsFk8e
        9rE58HqsmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7LO6bzOrRt2UVo8fnTXIBnFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GYtbz7EW
        9PBXrHkr1cC4nqeLkZNDQsBEYuKS86xdjFwcQgJLGSXe3F7ACJEQk5i0bzs7hC0s8edaFxtE
        0WtGibevZ4AlhAW8JQ42/mUFsUUENCWu//0ONolZ4COTxLLt+9ghOpYxSTz838rSxcjBwSag
        J7FjVSGIySvgJrF4H9gyFgFViTsTDjKD2KICERJnX64Di/MKCEqcnPmEBcTmFAiUOPfiPthe
        ZgEziXmbHzJD2OISt57MZ4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9Nxi
        I73ixNzi0rx0veT83E2MwJjeduznlh2MXe+CDzEKcDAq8fCemP4yWog1say4MvcQowQHs5II
        706TV9FCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MN3kl8YamhuYWlobmxubGZhZK4rzn
        DSqjhATSE0tSs1NTC1KLYPqYODiBkRTjHv1ug2H2yccd365NSrm+J71Ln0Vw7luGV7Prnm2v
        /t3cVDBH7Gel+5m9bhs1UmQUZm1q8btyKuKMyMsVkqZW9x6zRgQf93AXNjr6Ku8SExdPibtA
        Geunl5ECs4J84xbbh7Ly/FySfjzbNuRZ18Nb8mp3rY7mGFiWLar4n6V/+OPqio6yaUosxRmJ
        hlrMRcWJACi98Ir/AgAA
X-CMS-MailID: 20181113100605eucas1p25f18ba09acd59377c9bb62ca7196c2c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b
References: <CGME20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b@eucas1p2.samsung.com>
        <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPedw6OD1fWWVkYozgR03AWKz5t_-vWw0MV1jVGVR_UGTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the comments.

On 11/12/18 9:51 AM, Krzysztof Kozlowski wrote:
> On Wed, 7 Nov 2018 at 18:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
> 
> Subject prefix:
> dt-bindings: thermal:
> 
>> Thermal trip point gets new flag in DT: irq-mode.
>> Trip point may have a new explicit flag which indicate
>> IRQ support when the temperature is met (so the thermal framework
>> deos not need to set polling for it).
>> It is useful for 'passive' cooling trip point,
>> which now will not register for polling the temperature.
> 
> You wrap lines in weird way making it more difficult to read.
> I already asked about this while reviewing v1. Please fix it.
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L633
>
I will fix it in v3.
>>
>> Update documentation about irq-mode for trip points.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index ca14ba9..bee21e3 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -90,6 +90,10 @@ Required properties:
>>          "critical":     Hardware not reliable.
>>     Type: string
>>
>> +- irq-mode:            A flag indicating that trip rises irq, so there is no
> 
> "rises IRQ" (it is an abbreviation).
ACK
> 
> Best regards,
> Krzysztof
> 


Regards,
Lukasz
