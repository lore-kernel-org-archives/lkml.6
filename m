Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9172084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="V8c84loz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9172084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeH2SyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:54:25 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:10880
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbeH2SyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TRo0ggTyXZYm6/oKKAL34Bl9xrsckiEs7VA3y84kFc=;
 b=V8c84lozXcBTdoOFe5T2cOUKUbHArbNgKVk3LfJ2CI4XbKDUnZu0quP35GHG3qiTUKzs/EkFq0+iwPcfXspMP0rsGH9bHMZJTxPnFOJNQeiYl07b1u/FerrZwQk7mJcZxbQjyXdotNjxjtrtBxUAVLQrPvaFqivFv5tnGVzMauE=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2351.eurprd05.prod.outlook.com (10.169.135.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 14:56:59 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::79d0:3e0b:20af:4bb]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::79d0:3e0b:20af:4bb%8]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 14:56:59 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-tegra-owner@vger.kernel.org" 
        <linux-tegra-owner@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 13/26] ARM: tegra: colibri_t30: use proper irq-gpio for
 stmpe811
Thread-Topic: [PATCH 13/26] ARM: tegra: colibri_t30: use proper irq-gpio for
 stmpe811
Thread-Index: AQHUIoHxGMnTL6bjkUKaz5G1N0IFMqShKkiAgDXhxIA=
Date:   Wed, 29 Aug 2018 14:56:59 +0000
Message-ID: <1535554617.14664.30.camel@toradex.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
         <20180723123658.980-14-marcel@ziswiler.com>
         <844bac7c4e00a014f5e5b857e38a47bf@agner.ch>
In-Reply-To: <844bac7c4e00a014f5e5b857e38a47bf@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2351;6:8O1zUF746oRjdRY71YBQt63BZH7Hl9gTVeRclUowKHd4MND9b7QAAIjWcsiCPuqvsN2j9A5GYt202ykGDb+2Xwx9qySQuNj42voJvQvZL+n+3OGyifm0srrXjQNBB4gi+79YKu6q5WCWQEY8R4i0pvLH+prkLzrzSBxEZ7fbXNKjrcJq1/SjAYAH8hXY+cIdzA+HCw9n578o7pUISdhup7Huzd2edAPPMXk3Orsri2VnANBFGvUcHNT59FYT0eCgXHQ2ipbMV7f6Q+PABgiQdpW6PfcGiGa9HIbJoOB/fNFv3muSWRxX7NgTtn9YZK3KvMgg2e4HP6dxRc9IlyvT/lHL1nDnhC80utxIN4Q2f7Wus3XNAbNOEdpXdIBilCBCfZwztW8vFA0qnx1VmapjoBaBmB+7RPIEQxDzw02P0s1ukY7GOZFYgCkUyHwTf4KIcEKW0TtjZdvRaiE6/2v25Q==;5:f/Wru07nhjUDScoBN/GZNaLZ/9O9krWi+A4oc2lLsKgAppgaEL836QZv2aWGD6+hxw4WhpODSPKab+VEfjLtI42dhAdQ982ByWMZjS4qJFF2O2F8dhDuVjQqtcoQMuV0DYqvFPeV6HO1R9dnZsolyzysWSttUUvCXsl5qK1hcCo=;7:SGOi4J+Z3rNS8AZzNbtAn+ZKD70Piy03k298+R0/vyqVg0IMW5UMoZPeqEqexfX+UzFEL4dBvPslyIvNjtjF/xGxAov4rQDD0tZkwCMixSTSkai9ETRs/RSuCtK5BkWYfMpChdP2E//TkX2vvF/46TFLMIl0iROjELx5ttjjYZjfhiPVxVStDcHnaJpQOHL4klj0z6p5XdHDxG+7bgZZFCA9MN50bMPm5CM91T8/aTZGqiSVOnWWivTFjbOlnt9i
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a299a8d-7aee-4fbc-e2cc-08d60dbfac2c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2351;
x-ms-traffictypediagnostic: VI1PR0501MB2351:
x-microsoft-antispam-prvs: <VI1PR0501MB2351F10856DC9B1266BAD34DFB090@VI1PR0501MB2351.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR0501MB2351;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2351;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(366004)(396003)(346002)(376002)(199004)(189003)(36756003)(5660300001)(6246003)(106356001)(305945005)(105586002)(229853002)(26005)(2351001)(39060400002)(4326008)(6436002)(2900100001)(14454004)(446003)(11346002)(476003)(25786009)(81156014)(81166006)(186003)(3846002)(1730700003)(2616005)(486006)(6486002)(8676002)(66066001)(7736002)(478600001)(316002)(14444005)(6116002)(256004)(76176011)(53546011)(54906003)(6506007)(103116003)(2906002)(8936002)(6512007)(5640700003)(6916009)(5250100002)(102836004)(68736007)(99286004)(44832011)(53936002)(2501003)(86362001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2351;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KdN6V454f+7gFoSYziTj2b6ZCAzXNNkMg5TwAk5oHzMqAiqso6BcDgMv+tfv1+/jjY5ytMTNhTGwrBvaTp2n4Y+Pk3UVMfbnRpmx6VGLnk7vOZjq7UJnQ8Ru+EoITa46CKhMC1npoLLjI+y90Qq79mr6AtVdkJOZGd8BbU+QJoSb9zOYHbNK7fldSbtdxjiOAxs6AbKveA9psI+EBXWePXOBfvyiCaCFRm2xhTpKqQ2JObIPcXAxUIl6xY0bzFgbb6MVETq3QYJ+Aw+pvBEbvhchVhCw0Yc59jC11T+FQrKMuxUR7Qt8Zys1gmzTOQkTj3n8oD7dJJ4UmatPoTu5FbrjEU7A80URqdn4qIpXveQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D45AECD8DCABB548B2590B692D3CAE5E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a299a8d-7aee-4fbc-e2cc-08d60dbfac2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 14:56:59.6322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTI2IGF0IDEwOjA3ICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDIzLjA3LjIwMTggMTQ6MzYsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gPiBGcm9tOiBN
YXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiBV
c2UgcHJvcGVyIGlycS1ncGlvIGZvciBzdG1wZTgxMSB0b3VjaCBjb250cm9sbGVyLg0KPiANCj4g
SSBkb24ndCB0aGluayB0aGlzIGNoYW5nZSBpcyBuZWNlc3NhcnksIGludGVycnVwdHMvaW50ZXJy
dXB0LXBhcmVudA0KPiBzcGVjaWZpY2F0aW9uIHNlZW1zIHRvIGJlIHN1cHBvcnRlZCBieSB0aGUg
ZHJpdmVyIGFzIHdlbGwuDQoNClllcywgaG93ZXZlciwgc2hvdWxkIHlvdSBsb29rIGF0IHRoZSBk
cml2ZXIgbW9yZSBjbG9zZWx5IHlvdSBtYXkgbm90aWNlDQp0aGF0IG9ubHkgaWYgdXNpbmcgaXJx
LWdwaW8gdGhlIEdQSU8gaW4gcXVlc3Rpb24gYWxzbyBkb2VzIGdldCBwcm9wZXJseQ0KcmVxdWVz
dGVkIGJ5IGRldm1fZ3Bpb19yZXF1ZXN0X29uZSgpIHdpdGggYW4gInN0bXBlIiBsYWJlbC4gU28g
SSByZWFsbHkNCmRvIHRoaW5rIGRvaW5nIGl0IHRoaXMgd2F5IGlzIGFkdmFudGFnZW91cy4gSSBk
aWQgbm90aWNlIHRoaXMNCmRpZmZlcmVuY2UgYnkgY2hhbmNlIHdoZW4gZmlnaHRpbmcgc29tZSBw
cm9iZSBkZWZlciBpc3N1ZXMgZWFybGllci4NCg0KPiAtLQ0KPiBTdGVmYW4NCj4gDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3Jh
MzAtY29saWJyaS5kdHNpIHwgMyArLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy90ZWdyYTMwLWNvbGlicmkuZHRzaQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEz
MC1jb2xpYnJpLmR0c2kNCj4gPiBpbmRleCBjODBiOWJmNDQ3NTIuLmFjZTcyYTUzMTg2YSAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWNvbGlicmkuZHRzaQ0KPiA+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtY29saWJyaS5kdHNpDQo+ID4gQEAgLTgz
Niw4ICs4MzYsNyBAQA0KPiA+ICAJCXN0bXBlODExQDQxIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9
ICJzdCxzdG1wZTgxMSI7DQo+ID4gIAkJCXJlZyA9IDwweDQxPjsNCj4gPiAtCQkJaW50ZXJydXB0
cyA9IDxURUdSQV9HUElPKFYsIDApDQo+ID4gSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gPiAtCQkJ
aW50ZXJydXB0LXBhcmVudCA9IDwmZ3Bpbz47DQo+ID4gKwkJCWlycS1ncGlvID0gPCZncGlvIFRF
R1JBX0dQSU8oViwgMCkNCj4gPiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICAJCQlpbnRlcnJ1
cHQtY29udHJvbGxlcjsNCj4gPiAgCQkJaWQgPSA8MD47DQo+ID4gIAkJCWJsb2NrcyA9IDwweDU+
Ow==
