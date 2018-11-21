Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A324FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E01321479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E01321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rwth-aachen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeKVC56 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:57:58 -0500
Received: from mail-out-3.itc.rwth-aachen.de ([134.130.5.48]:61561 "EHLO
        mail-out-3.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730072AbeKVC56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:57:58 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 21:57:57 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AFDQB5g/Vb/5oagoZiHgEGBwaBZQKBL?=
 =?us-ascii?q?1OBaDGYBoINmTIMASyBS4J1AoQKIjgSAQMBAQIBAQJtKEIBEAEEAYRjAQEBAQI?=
 =?us-ascii?q?BJ0UKAwULAgEIDgoJJQ8BIiUCBA6FIAgBA6xqM4oljAWBWD6EI4RiEQuFWwKLE?=
 =?us-ascii?q?IRJj09VBwKBEZAziVuHK4dTkDECAgICCQIUgV0hgVVNJIM8kFlBgVmEQ4RCgl4?=
 =?us-ascii?q?BgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2AFDQB5g/Vb/5oagoZiHgEGBwaBZQKBL1OBaDGYBoINmTI?=
 =?us-ascii?q?MASyBS4J1AoQKIjgSAQMBAQIBAQJtKEIBEAEEAYRjAQEBAQIBJ0UKAwULAgEID?=
 =?us-ascii?q?goJJQ8BIiUCBA6FIAgBA6xqM4oljAWBWD6EI4RiEQuFWwKLEIRJj09VBwKBEZA?=
 =?us-ascii?q?ziVuHK4dTkDECAgICCQIUgV0hgVVNJIM8kFlBgVmEQ4RCgl4BgR4BAQ?=
X-IronPort-AV: E=Sophos;i="5.56,261,1539640800"; 
   d="scan'208";a="24956557"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-3.itc.rwth-aachen.de with ESMTP; 21 Nov 2018 17:13:01 +0100
Received: from rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158) by
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 21 Nov 2018 17:13:01 +0100
Received: from rwthex-w2-a.rwth-ad.de ([fe80::18f3:313d:3e:42ff]) by
 rwthex-w2-a.rwth-ad.de ([fe80::18f3:313d:3e:42ff%21]) with mapi id
 15.01.1531.007; Wed, 21 Nov 2018 17:13:01 +0100
From:   =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "m.purski@samsung.com" <m.purski@samsung.com>
Subject: Re: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Thread-Topic: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Thread-Index: AQHUgTlMOgH+/TcWJ0m0L3+ib8kVa6VaVu4A
Date:   Wed, 21 Nov 2018 16:13:01 +0000
Message-ID: <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
In-Reply-To: <20181121012629.5432-1-nicoleotsuka@gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.153.130.132]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BCA2704DE6A397439FA7D327DA2C9E4F@rwth-ad.de>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 21. November 2018 02:26:29 CET Nicolin Chen wrote:
> === Background ===
[...]
> 
> === Problem ===
> Both methods simplify software routine by fixing one factor, which
> sacrifices the precision of the hardware measurement results.
> 
> Using ina226 for example, with method A, the current scale was 1mA
> and the power scale was 25mA.
> 
> With method B, calibration value is fixed at 2048 so the precision
> is decided by shunt resistor value. It sounds reasonable since the
> hardware engineers can use a larger shunt resistor when they need
> higher resolution. However, they often concern power burning across
> the resistor as well, so the resistor usually won't be so large: a
> typical value 1000 micro-ohms, which results in a current scale at
> 2.5 mA and a power sacle at 62.5 mW.

Power loss surely is a concern, but figures should be kept reasonable.

1. You mention 1.8V bus voltage, and currents in the 30mA range. Using the 
1mOhm current shunt:

U_S = R_S * I_S 1e-3 Ohm * 30e-3 A = 30e-6 V  (30uV)
P_S = U_S * I_S = 30e-6V * 30e-3 A = 900e-9W = 0.9 uW

INA219 Power Supply (Datasheet)
Min operating Voltage: 3V
Quiescent Current: 0.7mA
-> Min power: 2.1mW

So the INA219 alone uses 2.1mW, 1000 times more than the shunt.

Another concern may be voltage drop over the shunt, but for this case you have 
a nominal voltage of 1.8V, so 30uV are 0.001%.
 
> When measuring a 1.8v voltage running a small current (e.g. 33 mA),
> the power value (that's supposed to be 59.4 mW) becomes inaccurate
> due to the larger scale (25mA for method A; 62.5 mA for method B).

Another look into the datasheet reveals, even at full gain (PGA=1), the LSB is
40mV / 2^12 = 40mV / 4096 ~ 10uV. So when the current ADC reads out as 3*LSB, 
this anything between 25mA and 35mA. This is the best case figure.

On top of quantisation error, you have the ADC offset voltage (V_OS), which is 
given as (for PGA=1, best case): (+-) 10uV typical, (+-) 100uV max.


So, if you want to have meaningful readouts adjust your shunt to a reasonable 
value. Even 100 times the current value will have no measurable effect on you 
system (power loss: 90uW, voltage drop: 3mV).

Kind regards,

Stefan
