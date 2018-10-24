Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE84C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6402520833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6402520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJXVXP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:23:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44713 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727177AbeJXVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:23:15 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9OCmovq030620;
        Wed, 24 Oct 2018 14:54:48 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nan9y23q4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Oct 2018 14:54:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6169F3A;
        Wed, 24 Oct 2018 12:54:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 314F64713;
        Wed, 24 Oct 2018 12:54:47 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Oct
 2018 14:54:46 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Wed, 24 Oct 2018 14:54:46 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Thread-Topic: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Thread-Index: AQHUZsFCff0rP/nvtUWEQ9H/MMA/OQ==
Date:   Wed, 24 Oct 2018 12:54:46 +0000
Message-ID: <5BD06B96.3080809@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
 <20181019115015.GC5895@sirena.org.uk>
In-Reply-To: <20181019115015.GC5895@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <25C03AB68B403D46ADF5E95C06741A59@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Le 10/19/2018 01:50 PM, Mark Brown a écrit :
> On Thu, Oct 18, 2018 at 09:02:12AM +0000, Pascal PAILLET-LME wrote:
>
>> +	for (i = 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
>> +		/* Parse DT & find regulators to register */
>> +		init_data = stpmic1_regulators_matches[i].init_data;
>> +		if (init_data)
>> +			init_data->regulator_init = &stpmic1_regulator_parse_dt;
>> +
>> +		rdev = stpmic1_regulator_register(pdev, i, init_data, regul);
>> +		if (IS_ERR(rdev))
>> +			return PTR_ERR(rdev);
> This looks mostly good, the only big thing is this - the default is to
> just unconditionally register all the regulators that exist rather than
> only those that are configured on that particular platform.  This is a
> bit simpler and means that all the readback of the configuration for the
> unconfigured regulators is available for diagnostics.  Is there a reason
> not to do that?
I'm sorry, I'm not sure to understand. Would you prefer to not register 
regulators that
are not described in the device-tree ?

In that case I could add:
     if (!init_data)
         continue;

This would permit to keep some regulators unmodified by the kernel. This 
can be useful
because we have some regulators configured by boot loaders (for the DDR 
at least) and
it would be more simple to not handle them in the kernel.

best regards,
pascal
