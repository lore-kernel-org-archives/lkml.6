Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F3AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF05D21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfBOFky convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:40:54 -0500
Received: from mail-oln040092072064.outbound.protection.outlook.com ([40.92.72.64]:14867
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbfBOFkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:40:53 -0500
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (10.152.16.53) by AM5EUR03HT071.eop-EUR03.prod.protection.outlook.com
 (10.152.17.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Fri, 15 Feb
 2019 05:40:51 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.16.54) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17 via Frontend Transport; Fri, 15 Feb 2019 05:40:51 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%4]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 05:40:51 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: Make /dev/random wait for crng_ready
Thread-Topic: [PATCH] random: Make /dev/random wait for crng_ready
Thread-Index: AQHUxNBhCboXjY4dck65d31dWPtwSKXgWGKA
Date:   Fri, 15 Feb 2019 05:40:51 +0000
Message-ID: <VI1PR0702MB384026744E79BE0E82EABBDEE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:206:2::35) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:FDF81FB8BFF011941FCD3E85B20C30FF03C5B8144A989D0C32A1F923F10426A1;UpperCasedChecksum:9EC02F588E9E32B90283D1C7A0E8DC6E11E2FDB8A1021232DAB59BDF245924E3;SizeAsReceived:8567;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HG/7fpGTsFjv6Yj/QUgcTPTgBrV7vBwv]
x-microsoft-original-message-id: <067ee6d3-1cb2-50f2-0d3a-2edc76ae1040@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-exchange-diagnostics: 1;AM5EUR03HT071;6:F+EM5fiqvohi1TKuklVEXtazklikGCbZLmupGhuQHo3umEIAemaKLunplaqcZIPMOuBFnpPwRYOrQqFt4bWMS77AID3f4ZY2OP5XJa4WyKz23Aisb1nI6m2aJ8vtIBdjA91zxIKVRcqbLXO7lieuQKHq7f8jylJacZonyYiCyYaBXwQ1Idw7xZehDK4lQV7XOds3+Y1RjXiZoPkDeSyS+WgtFJcZ0Nd1sHW7tvEFXoQQmrYWZr6LokRop79H+evzzlLuhHDCV4r+0OxJMAQ+ByXoI8tSeidUvcTbDoOS+qCEDp8sSZHFVrk4Yd9wO7tnwgwTAkTKEElvFLVg12oeQshJ/lOGRWhsIi3unIPypw1Kw8x6KgTRHu4fwyQA4Kp34evCBICf75oVo1AkKQyMKan45ZRPtYViExR4QH1Puxm3lZ7DZuNk6vhoO+yhhZFCRLG7zwxZzhDMr3/WShxyng==;5:Nw+wAQEogwXVI512S2ejn/8KMQeiK3gMxkfUIFWn5TWGHLge4thCGJiB+IwHpNyxEhBLZbO63jKkZ9mlVA4yZPz98f05M7wn6ex6hWrEvWdTkqfK/ho+6niwxoAuV88nd4wzWlMX6d2Vo2DcpoM5ZPdNg75Mt1B1Vh34zIbBkT/Hqhox7pbJpOanR/rvVLihuwhUGzRhazbicWxdXtM0fA==;7:a+hOUjW76ry9zIA3JNowzZauIKEPM1WPshWmSAztXoCsXeNOkgYyGnvceKl9rSDSArMo6VE2k1s/wgb5LIhKdzP6rr/N39Jjr0NM3q8KFM4IeNj0AwC8ukcvOYwUqMg2oBewBUBuVcM+FxRGqCMARg==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT071;
x-ms-traffictypediagnostic: AM5EUR03HT071:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:AM5EUR03HT071;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR03HT071;
x-microsoft-antispam-message-info: cDzh1Daulq8cyhUAbP+dZIo3MOhuEwyoTjfWtR1qMofKqRiMj4fcSLtvhZnbwOtB
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2AF8CC9EDA797B41B2E3CC0FD64BA5D0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a761ce-68a4-4ee8-6425-08d6930824ae
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 05:40:50.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 2:47 AM, Bernd Edlinger wrote:
>  	while (1) {
> -		n = extract_entropy_user(&blocking_pool, buf, nbytes);
> +		n = crng_ready()
> +			?  extract_entropy_user(&blocking_pool, buf, nbytes)
> +			: 0;

Aehm, the whitespace after ? does not align with :, didn't see that before.

I wonder if it would be better style to use
 if (crng_ready())
      n = extract...;
 else
      n = 0;


Bernd.

