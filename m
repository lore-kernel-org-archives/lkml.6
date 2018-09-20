Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5589EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1474721523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgEtHDfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1474721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbeIUA65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:58:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35812 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeIUA64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:58:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so689961wmc.0;
        Thu, 20 Sep 2018 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=7UZffiZbIMv5K7TvvhuvQ/1USYMYxFet6EpiUX4mTJ0=;
        b=MgEtHDfHBZSxOy/uZGxIyCzrws1+NCNVIgZaS5+44s//UBWBLAzvYeCZV53I02J+Li
         uc8XLGeNz8oAJys1Lrr5vqrsNZdtFmU5iXIGNKF9tVSKwZeUnPYDJbrAMlMYXwCE9GI8
         x0RXfeRovzpg/zv4j65dPfjWOKQMjypbVkG5A6D7Lxaocuy7F1ckE0K8X7fWLmQsaGxP
         HjHk7Nm4Jkt/HnsWZpJZR8a+Xso+sqW7oe1T1aBq6T09Bfw4T4V1K/lA5A0mVugff5eP
         Tvnylv0cKck+rrpdqeDUEMUWnYXlT8CtHd1/h/wLgtG074haSE02SQyNt2Yox2itgBHe
         BxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=7UZffiZbIMv5K7TvvhuvQ/1USYMYxFet6EpiUX4mTJ0=;
        b=av9R1RewBxLJ9av45gWzC+f7xaUFfkHSLWOTY3+IWtqKih5NNwlv5DRwaX1IKKD1uh
         3F1KzmVcJZjSCkZd+3d0eyM2Tpy4slCG1SwCFxtbGV5pBBGYJHZBulSA9zHhSlRfZ6bU
         xCdVbGJtJPSwuC0j8s+NTI0yMYwqvZvFoa1ynexgpzbrna83kS/wJPTXTHVa/AQFKL3L
         wNDkB1khjET/CKq9CIAdAR33QxZVMX/Fhz/XpaHLOf10xGktz+VkypU3ZzJGcEWLhhc+
         gZKlAJpqfcfgB+BNvJQPK1k1NO7yHb5bvmY+3c310YjohLX+0vjpxy8YrKKy6fHmp0j3
         GPRg==
X-Gm-Message-State: APzg51DaSHbHcPSUIE+v2y8eGMXRpcbRxiANSQH4G4mLQcbZjFa7Bxxn
        YrSrNRngCVbdqy03WuXA2A==
X-Google-Smtp-Source: ANB0VdZ9MZlj4oiqayfkgWiENJt6hipq/72dHXCit6r4hT/BIu2HG6kzYkn0ox/Xp4PAnPuPhoy7Hg==
X-Received: by 2002:a1c:9b91:: with SMTP id d139-v6mr4312891wme.50.1537470836933;
        Thu, 20 Sep 2018 12:13:56 -0700 (PDT)
Received: from android-dhcp-8-1-0-d4-38-9c-a2-1f-05.home (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.gmail.com with ESMTPSA id j133-v6sm3671386wmd.12.2018.09.20.12.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:13:56 -0700 (PDT)
Date:   Thu, 20 Sep 2018 20:13:52 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180920165847.6xqzeoqzqkyotshx@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com> <20180614151435.6471-3-ctatlor97@gmail.com> <20180916121045.aptj6nciwskfg4st@earth.universe> <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com> <20180920165847.6xqzeoqzqkyotshx@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Craig <ctatlor97@gmail.com>
Message-ID: <5039A15E-E604-4D03-AFEF-4B139EB18A30@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 September 2018 17:58:47 BST, Sebastian Reichel <sebastian=2Ereichel@=
collabora=2Ecom> wrote:
>[Dropped a couple of people from CC, added Baolin]
>
>Hi Craig, Baolin and Rob,
>
>On Thu, Sep 20, 2018 at 03:32:29PM +0100, Craig wrote:
>> On 16 September 2018 13:10:45 BST, Sebastian Reichel
><sebastian=2Ereichel@collabora=2Ecom> wrote:
>> >Sorry for my long delay in reviewing this=2E I like the binding,
>> >but the "qcom," specific properties should become common properties
>> >in
>> >
>> >Documentation/devicetree/bindings/power/supply/battery=2Etxt
>> >and referenced via monitored-battery=2E
>
>> Thanks for the review, what bindings for ocv would you prefer? The
>> spreadtrum ones or mine?
>
>Most importantly I want to see only one generic binding supporting
>both use cases=2E As far as I can see there are two major differences:
>
>1=2E Qcom uses legend properties and SC27XX embedds this into data
>2=2E Qcom supports temperature based mapping
>
>The second point is easy: Not having temperature information can
>be a subset of the data with temperature info=2E The main thing to
>discuss are the legend properties=2E I suppose we have these
>proposals:
>
>Proposal A (from Qcom BMS binding):
>
>ocv-capacity-legend =3D /bits/ 8 <100 95 90 85 80 75 70 65 60 55 50 45
>=2E=2E=2E>;
>ocv-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
>ocv-lut-microvolt =3D <43050000 43050000 43030000 42990000
>
>Proposal B (from SC27XX binding):
>
>ocv-cap-table =3D <4185 100>, <4113 95>, <4066 90>, <4022 85> =2E=2E=2E;
>
>I prefer the second binding (with mV -> uV), but I think it becomes
>messy when temperature is added=2E What do you think about the
>following proposal (derived from pinctrl style):
>
>Proposal C:
>
>ocv-capacity-table-temperatures =3D <(-10) 0 10>;
>ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, =2E=
=2E=2E;
>ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, =2E=
=2E=2E;
>ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, =2E=
=2E=2E;
>
>-- Sebastian

C looks good to me however I do kinda think it should be millivolts as I d=
on't think any hardware reads in microvolts and the zeroes make it look qui=
te ugly
