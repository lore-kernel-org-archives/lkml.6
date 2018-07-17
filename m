Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4449FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E2F20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="IJCk/qpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E2F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeGQIOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:14:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39282 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeGQIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:14:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id w14-v6so379833eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ej2Ufx0ybRTJe/K/OEcrhZg10FQmkkO1sPMGn5WWSMA=;
        b=IJCk/qpa0Eyrd/upxZIOodqPR1tazSA4aqr3g91OSMWOR7j+aor4dmfrpeE7czbF+G
         VECX/gy4gR6fiSkIr1rsyF3P8KvkRcrae1f2dtbucBNca3cJ70BhgvYvgkKI9wqIyv7I
         VBt+3ZNVzaIPhsxetRU52+8knxiC0Mp224yT5UMlmI9OvC4JvBLICXmzbtNd53dZEJgA
         +UrmQ+gngUqExLZZhVgwUVUZT2PV45FArOLfv2y13Kon1dg82x3zcAEcJFjUc7M4cx2Q
         E2y+ILtB2aLSDd7IDxjitD5bCMzlE8Lhabzuc4nFXIkcZVgfyuYMWMG6vYNA+AwHWJ5e
         8V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ej2Ufx0ybRTJe/K/OEcrhZg10FQmkkO1sPMGn5WWSMA=;
        b=uV46eRfUhKBAp/nJMtr8/Tvl+Oj8z329hoxjGlFsoDbtI0vACPbsXZoT0FDQ+/lj5E
         BrL0nrN4KpJofnZ1M/inOiCeHQMkpcfDEV+yWhws/wZpZcAqg+jEgR21miC9Yf4K0PEU
         L3lT5744+zpy9HXSglhFkoQwv/BZINbw+jhQlBYALhH9Yldsb3SWhbziESuWkjjUl/he
         3PYK3pbA4L3vSqH3JsBH0WOaHh7ocW4v86P4hqnmQYhgB2dCIO0W+j/1f7qOMWo6hO12
         auCh+/R0H0vSxCUyUh/8D5KKfeqNmHE/RnGFyFIdQw2LB72ggQLwLwd5ra8kpe1OSmWA
         ZPEQ==
X-Gm-Message-State: AOUpUlFfBh0EwqwqIpQcHSKGgel3SuSrNlHHulCMR/hjjqZqF7r7K7Y0
        0Uq8maY5tgTz4QnNZdf/ZkJUeg==
X-Google-Smtp-Source: AAOMgpdbFD8ojGA8bNkXr98+2f16+YtxmAm/8MIGO4S8bvaOn+61tvIKKzE8xVKKyWGfl7so/kcLZA==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr1211639edm.40.1531813386665;
        Tue, 17 Jul 2018 00:43:06 -0700 (PDT)
Received: from [172.20.0.13] ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id j7-v6sm231912edh.76.2018.07.17.00.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 00:43:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Subject: Re: [PATCH v5 1/2] dt-bindings: Add vendor prefix for Sancloud
From:   Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <20180717073659.GB3100@piout.net>
Date:   Tue, 17 Jul 2018 09:43:05 +0200
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>, SZ Lin <sz.lin@moxa.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EB8A3A1-EF76-42F8-A7C2-5A4A595C92B8@dominion.thruhere.net>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
 <20180717072028.GA3100@piout.net>
 <D3049450-5391-40CB-ADD1-E1330BFE0525@dominion.thruhere.net>
 <20180717073659.GB3100@piout.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: Apple Mail (2.3445.100.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Op 17 jul. 2018, om 09:36 heeft Alexandre Belloni =
<alexandre.belloni@bootlin.com> het volgende geschreven:
>=20
> On 17/07/2018 09:31:15+0200, Koen Kooi wrote:
>>=20
>>=20
>>> Op 17 jul. 2018, om 09:20 heeft Alexandre Belloni =
<alexandre.belloni@bootlin.com> het volgende geschreven:
>>>=20
>>> Hi Koen,
>>>=20
>>> I'm not sure how you expect that to be merged but you should =
probably
>>> send this patch to the TI maintainers along 2/2 because probably no =
one
>>> in copy of this patch will apply it.
>>=20
>> Is that the linux-omap list and Tony? scripts/get_maintainer.pl =
didn=E2=80=99t pick them up, which is why they are missing.
>>=20
>=20
> Yes, basically the same people that will apply the DT making use of =
this
> vendor prefix so both patches go in at the same time.

Thanks for the explanation! I resent 0001 with linux-omap and Tony =
explicitly adding using -cc in git-send-email.

regards,

Koen

>=20
>> regards,
>>=20
>> Koen
>>=20
>>>=20
>>> On 17/07/2018 08:24:45+0200, Koen Kooi wrote:
>>>> Add vendor prefix for Sancloud Ltd.
>>>>=20
>>>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>=20
>>>> v5: No changes
>>>> v4: Add Acked-by
>>>> v3: No changes
>>>> v2: No changes
>>>> v1: Initial submission
>>>>=20
>>>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt =
b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> index 7cad066..c7aaa1f 100644
>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> @@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
>>>> roofull	Shenzhen Roofull Technology Co, Ltd
>>>> samsung	Samsung Semiconductor
>>>> samtec	Samtec/Softing company
>>>> +sancloud	Sancloud Ltd
>>>> sandisk	Sandisk Corporation
>>>> sbs	Smart Battery System
>>>> schindler	Schindler
>>>> --=20
>>>> 2.0.1
>>>>=20
>>>=20
>>> --=20
>>> Alexandre Belloni, Bootlin (formerly Free Electrons)
>>> Embedded Linux and Kernel engineering
>>> https://bootlin.com
>>=20
>=20
> --=20
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

