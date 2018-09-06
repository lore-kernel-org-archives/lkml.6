Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6517C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EF820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EF820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbeIFW2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:28:47 -0400
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:57568
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727815AbeIFW2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3YdfQzLPAb8tQFuZq/GO35/DmsJA10gP1QOw6du0Oc=;
 b=CLI6FEK4FvlKWLdBFuh/bDxGyLtOU7QoEMG30avmOStrIN9A9QEpKLNLauCMZ6RjRe1Ie4yajgOtLa3iY00ByGSIY8iseD3fek0ujgrpHnJAP5z7cBqolTem0RIqYCHcJr0AjsAOLuNW0XxsL+tse50MuC59kirb9JkOkWozTQc=
Received: from VI1PR0801MB1759.eurprd08.prod.outlook.com (10.168.67.136) by
 VI1PR0801MB1950.eurprd08.prod.outlook.com (10.173.74.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 17:52:06 +0000
Received: from VI1PR0801MB1759.eurprd08.prod.outlook.com
 ([fe80::bcb5:596d:b59d:384f]) by VI1PR0801MB1759.eurprd08.prod.outlook.com
 ([fe80::bcb5:596d:b59d:384f%7]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 17:52:06 +0000
From:   Grant Likely <Grant.Likely@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "leif.lindholm@linaro.org" <leif.lindholm@linaro.org>,
        "agraf@suse.de" <agraf@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, nd <nd@arm.com>
Subject: Re: [PATCH] efi_stub: update documentation on dtb= parameter
Thread-Topic: [PATCH] efi_stub: update documentation on dtb= parameter
Thread-Index: AQHURUvRsWehPar4IUqaviTd7gIWP6TjaEaAgAAhyP8=
Date:   Thu, 6 Sep 2018 17:52:06 +0000
Message-ID: <BFA61ADA-2AD9-4383-ADAA-9D660881865B@arm.com>
References: <20180905190750.4566-1-grant.likely@arm.com>,<20180906095111.1a74dfcd@lwn.net>
In-Reply-To: <20180906095111.1a74dfcd@lwn.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
x-originating-ip: [217.43.126.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0801MB1950;6:NbUHllUDmutdxO3cEQe7k5vAtAzWZ3oEyaZhhTBYZQGyy0C2vqhZ2TPXY9TD9y4mqRJI9kZjAIJ0eJ+7jbj8J/L+LrVEp5RRDtmn9vXyYf4ju+MsP1BIlqIm37gG3qn70rw6PZ5wbk+MENdZ9r7lJb0Qmu+mV5uXtNCC5GmwE/H49cgLawSxikN3HrF8jMMTuBljP8IAuVhP6UW2FRtbN+3Tg4Dxd1NEwooZCtJ/b7S3QCevVI0zchKEn44Q9nqj19TNkwDq3EZdOTfU3lOxvxyUq/7hN/1FYpbo4Mr9tz3CSUcGscYBuxoYFHIWP/r89azIgpjpnw6P8KB/vQ1mlCoSk4YwJe+T3ZV5eYQx4uT1Rv1ezrEKHOEIvPvmwADNGUBi5biLhE380FrDAY3NfIRZiIMtA675CiX4R36amNQElDIBDhWoF2G5TLAVYcfS6eojaNkMv4tu18jQMgbIOQ==;5:rcjqBuMqrRvOVRmXyltDCQUPGuK8O4PE30a4I57Y17d3nj5lCfGJOWpy7eHP7dAeY/7jLcbHia0D3BGxgmssCNzkaOCtXzaso+2nG2+d9r0iUG3DA8bAOyElrxcQJV7uV7eHB4tps9R5/y3Vx4rG+1OyZI1PTBZwS96mitqak0A=;7:XZZpfldN8Wrn6PLKcIhVLETsec1fP3JKjXkAkTdR0sUHiTW257E0uMiMm0Ncdc/EYliTE/ARnaVmiie6n7viF0aql2XkRtvetf56e8EGUFGRCyboEWyX4kTM1K6n3Y6kipchWwd15Rtz1uNxL8sEvi9gGVA9rJCbX8wnMSJ+FRThtjTUXEUo+KCeJCmq2EaMkK/CMF/t+Of/OWYs17PftGNzNqndVPDrmL8A6pADV15OfgbxlQCT9fyEz21Ut0O/
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c3c60263-c98d-459b-03ad-08d6142175f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1950;
x-ms-traffictypediagnostic: VI1PR0801MB1950:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB1950785855F0A3120C2E003395010@VI1PR0801MB1950.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(103651359005742);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR0801MB1950;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1950;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(97736004)(6116002)(6512007)(305945005)(53936002)(36756003)(68736007)(25786009)(5660300001)(6246003)(33656002)(4326008)(81166006)(81156014)(2906002)(6916009)(8676002)(7736002)(8936002)(14454004)(478600001)(83716003)(82746002)(72206003)(3846002)(66066001)(26005)(6486002)(105586002)(106356001)(2900100001)(6436002)(486006)(229853002)(5024004)(14444005)(86362001)(54906003)(15650500001)(76176011)(6506007)(53546011)(99286004)(5250100002)(476003)(256004)(102836004)(7416002)(316002)(186003)(11346002)(2616005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1950;H:VI1PR0801MB1759.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sgWf9jksXAZmVutK/9DwuK/Ahk46UF+Qa+dmkyuZeHxI89RKD+eS97PSAqhdmnP5Xm1hQzrI+h8R1G7MAONuyTNc+PejYGa3RV/K6/4ZH6cuGGvWEG0nDG4JPnstkZ/RBW8hByq0bwBxqskyCmeefy19vc5aHdie/+lBWSSKmw+EGJ26+b5hRoFi+pRXHTxKZOdesvJE2xeDIyPlJd9W2Vg8CJaGw5DAvt/RhUZYoJKOc8wP0rf7w72RCyUtJ13z0bfFCeRZ8bnP5CupTt9k50nIbgdLaEtJ5Nbj0xse2gMannZiERMvv0W5XlPGn0g/hcTxHRqtOKI8lYpzief0KN60dziCA2y/bWvu+cpeROI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c60263-c98d-459b-03ad-08d6142175f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 17:52:06.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gNiBTZXAgMjAxOCwgYXQgMTY6NTEsIEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3
bi5uZXQ+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAgNSBTZXAgMjAxOCAyMDowNzo1MCArMDEwMA0K
PiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBhcm0uY29tPiB3cm90ZToNCj4gDQo+PiBUaGUg
ZHRiPSBwYXJhbWV0ZXIgaXMgbm8gbG9uZ2VyIHRoZSBwcmltYXJ5IG1lY2hhbmlzbSBmb3IgcHJv
dmlkaW5nIGENCj4+IGRldmljZXRyZWUgdG8gdGhlIGtlcm5lbC4gTm93IGVpdGhlciBmaXJtd2Fy
ZSBvciB0aGUgYm9vdCBzZWxlY3RvciAoZXguDQo+PiBHcnViKSBzaG91bGQgcHJvdmlkZSB0aGUg
ZGV2aWNldHJlZSBhbmQgZHRiPSBzaG91bGQgb25seSBiZSB1c2VkIGZvcg0KPj4gZGVidWcgb3Ig
d2hlbiB1c2luZyBmaXJtd2FyZSB0aGF0IGRvZXNuJ3QgdW5kZXJzdGFuZCBEVC4NCj4+IFVwZGF0
ZSB0aGUgRUZJIHN0dWIgZG9jdW1lbnRhdGlvbiB0byByZWZsZWN0IHRoZSBjdXJyZW50IHVzYWdl
Lg0KPiANCj4gU28gSSBoYXRlIHRvIGJlIG9ibm94aW91cywgYnV0Li4uDQo+IA0KPj4gSU1QT1JU
QU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50
cyBhcmUNCj4+IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkDQo+PiByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNl
bmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZQ0KPj4gY29udGVudHMgdG8g
YW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29w
eQ0KPj4gdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCj4gDQo+IENh
biBJIGdldCBhIHZlcnNpb24gb2YgdGhlIHBhdGNoIHdpdGhvdXQgdGhpcyBsYW5ndWFnZT8gIFRo
ZW4gSSdsbCBiZSBnbGFkDQo+IHRvIGFwcGx5IGl0Lg0KDQpVZ2guIFdlbGwgdGhhdCB3YXMgZHVt
Yi4gVGhlcmUgaXMgYSBtYWdpYyB0cmljayBJIGhhdmUgdG8gcGVyZm9ybSB0byBnZXQgcmlkIG9m
IHRoZSBkaXNjbGFpbWVyLCBidXQgaXQgZGlkbuKAmXQgd29yayB0aGlzIHRpbWUuIEnigJlsbCBm
aXggYW5kIGdldCBhIG5ldyBvbmUgb3V0Lg0KDQpnLg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBq
b24NCg==
