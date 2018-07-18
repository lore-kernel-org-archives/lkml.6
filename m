Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35130ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DD42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="fUZK/zD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DD42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeGRHGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:06:53 -0400
Received: from mail-eopbgr20122.outbound.protection.outlook.com ([40.107.2.122]:45082
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbeGRHGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Scsr0KLtWQKAuO+5HIT1x6M6BmDtfzSbNmTGhH2kLso=;
 b=fUZK/zD6pWPyg9GpaPLpOE7Zk2hlxcTi5beyesEh688ffcQLxErWox9QNcpSSoViN+kOvoFzfQwBrfTsCDbLr5XiItpmOlUTnvIKZbaaC4HRqSzHesCGWiZ529Q2fAlHYl5Z53wwM24LTlRKTp/VBj58+C3tvoTOoUhFStAxSb0=
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com (10.168.74.23) by
 DB6PR0501MB2791.eurprd05.prod.outlook.com (10.172.226.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Wed, 18 Jul 2018 06:30:32 +0000
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9]) by DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9%9]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 06:30:32 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "clabbe@baylibre.com" <clabbe@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] Revert "ata: ahci_platform: convert kcalloc to
 devm_kcalloc"
Thread-Topic: [PATCH] Revert "ata: ahci_platform: convert kcalloc to
 devm_kcalloc"
Thread-Index: AQHUHmDTzLJJLOBtfkisOswFPeaazg==
Date:   Wed, 18 Jul 2018 06:30:32 +0000
Message-ID: <1531895430.16896.2.camel@toradex.com>
References: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
         <c8a963fa-70c8-ea79-3c30-69bf723fb764@nvidia.com>
In-Reply-To: <c8a963fa-70c8-ea79-3c30-69bf723fb764@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2791;7:dabOQt46EQWIhsj473zlWd8994vfhjLpv2qiLKlMKD6VA2UVokjXxWIQPFR5CzWct3XmmUhUZBmvgvDv+dRy5eF27uLVGVNxpqvoXOTZY3qeGgQWafAJgpOegpVCwfVjqUekwVgCpw6/W7awN9P9EjFP7puh0zgBNIxgQSsOmbq+reilSZmlxdDXC8vmovVGMSAmuiGjFW0UNEMzjli7vyvMedwplwZqSC3ZV/05IjFaaci2eAYsJ298FzIsQI83
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dc1d8d36-0694-434c-2af3-08d5ec77f6ab
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2791;
x-ms-traffictypediagnostic: DB6PR0501MB2791:
x-microsoft-antispam-prvs: <DB6PR0501MB27915FA369624D4D234E7A30FB530@DB6PR0501MB2791.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0501MB2791;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2791;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39850400004)(199004)(189003)(256004)(2201001)(68736007)(476003)(25786009)(486006)(105586002)(6116002)(86362001)(3846002)(6512007)(478600001)(446003)(2616005)(26005)(4326008)(44832011)(14454004)(11346002)(2501003)(5250100002)(106356001)(14444005)(186003)(2906002)(6486002)(103116003)(102836004)(66066001)(97736004)(110136005)(316002)(229853002)(54906003)(99286004)(36756003)(2900100001)(8676002)(81166006)(81156014)(8936002)(6246003)(76176011)(305945005)(5660300001)(53546011)(53936002)(6506007)(6436002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0501MB2791;H:DB6PR0501MB2583.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x6W4szyxjSSURoH5L8ofrgX6M6VhMpjj571pfA5VmbBfai8xBhpTk7ZoJuf+zORz97yXfhc+rE/YqesmOGelvA6YMGsK1ru3/rmayd0kUdep0E1z6iTZ7zx1pSkr6MzcIzST1KefgzvEp83C9We5j0eruMfxrt7lgndQ4rjEUQAd7vnjbTyz83mKZKTTQPMsb4e/pRVuHk6aet+jz0K4Yby3uASMp3fh0vsVtgjmtVK6h86+AihI4GMDkDoNX7sh9Nlp15TylilH4Blqfl9z0UpKqEsUTeIGVqFKKc0qIQjmFIkL1OMDq2BTQU3SQKEPQC+izzsMJL0YtahTADDRyZLPUDefA6osAdiWjzfdwL0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <513E891F603AD547A6C70A1347175549@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1d8d36-0694-434c-2af3-08d5ec77f6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 06:30:32.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTE3IGF0IDEzOjU3ICswMzAwLCBNaWtrbyBQZXJ0dHVuZW4gd3JvdGU6
DQo+IFRoYW5rcyENCg0KWWVzLCB0aGF0IGZpeGVzIEFwYWxpcyBUSzEgY3Jhc2hpbmcgYXMgb2Yg
bGF0ZSBhcyB3ZWxsLg0KDQo+IFJldmlld2VkLWJ5OiBNaWtrbyBQZXJ0dHVuZW4gPG1wZXJ0dHVu
ZW5AbnZpZGlhLmNvbT4NCg0KVGVzdGVkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3
aWxlckB0b3JhZGV4LmNvbT4NCg0KPiBPbiAxNy4wNy4yMDE4IDEzOjQ5LCBDb3JlbnRpbiBMYWJi
ZSB3cm90ZToNCj4gPiBTaW5jZSBhaGNpX3BsYXRmb3JtX3B1dF9yZXNvdXJjZXMoKSB1c2UgdGFy
Z2V0X3B3cnMgYWZ0ZXIgImRldm1fIg0KPiA+IGZyZWVkDQo+ID4gaXQsIHdlIGNhbm5vdCB1c2Ug
ZGV2bV9rY2FsbG9jIGZvciBhbGxvY2F0aW5nIHRhcmdldF9wd3JzLg0KPiA+IA0KPiA+IFRoaXMg
cmV2ZXJ0cyBjb21taXQgYmQwMDM4YjFiNGY0OTlkODE0ZDhmMzNhNTViMWRmNWVhNmNmM2I4NS4N
Cj4gPiANCj4gPiBSZXBvcnRlZC1ieTogTWlra28gUGVydHR1bmVuIDxtcGVydHR1bmVuQG52aWRp
YS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ29yZW50aW4gTGFiYmUgPGNsYWJiZUBiYXlsaWJy
ZS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2F0YS9saWJhaGNpX3BsYXRmb3JtLmMgfCA4
ICsrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZv
cm0uYw0KPiA+IGIvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jDQo+ID4gaW5kZXggZmU4
OTM5ZTE2MWVhLi4yY2VlYmFmMmVkNTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hdGEvbGli
YWhjaV9wbGF0Zm9ybS5jDQo+ID4gKysrIGIvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5j
DQo+ID4gQEAgLTI3MSw2ICsyNzEsOCBAQCBzdGF0aWMgdm9pZCBhaGNpX3BsYXRmb3JtX3B1dF9y
ZXNvdXJjZXMoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYsIHZvaWQgKnJlcykNCj4gPiAgIAlmb3Ig
KGMgPSAwOyBjIDwgaHByaXYtPm5wb3J0czsgYysrKQ0KPiA+ICAgCQlpZiAoaHByaXYtPnRhcmdl
dF9wd3JzICYmIGhwcml2LT50YXJnZXRfcHdyc1tjXSkNCj4gPiAgIAkJCXJlZ3VsYXRvcl9wdXQo
aHByaXYtPnRhcmdldF9wd3JzW2NdKTsNCj4gPiArDQo+ID4gKwlrZnJlZShocHJpdi0+dGFyZ2V0
X3B3cnMpOw0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gICBzdGF0aWMgaW50IGFoY2lfcGxhdGZvcm1f
Z2V0X3BoeShzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYgKmhwcml2LA0KPiA+IHUzMiBwb3J0LA0KPiA+
IEBAIC00MDYsNyArNDA4LDExIEBAIHN0cnVjdCBhaGNpX2hvc3RfcHJpdg0KPiA+ICphaGNpX3Bs
YXRmb3JtX2dldF9yZXNvdXJjZXMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
IAkJcmMgPSAtRU5PTUVNOw0KPiA+ICAgCQlnb3RvIGVycl9vdXQ7DQo+ID4gICAJfQ0KPiA+IC0J
aHByaXYtPnRhcmdldF9wd3JzID0gZGV2bV9rY2FsbG9jKGRldiwgaHByaXYtPm5wb3J0cywNCj4g
PiBzaXplb2YoKmhwcml2LT50YXJnZXRfcHdycyksIEdGUF9LRVJORUwpOw0KPiA+ICsJLyoNCj4g
PiArCSAqIFdlIGNhbm5vdCB1c2UgZGV2bV8gaGVyZSwgc2luY2UNCj4gPiBhaGNpX3BsYXRmb3Jt
X3B1dF9yZXNvdXJjZXMoKSB1c2VzDQo+ID4gKwkgKiB0YXJnZXRfcHdycyBhZnRlciBkZXZtXyBo
YXZlIGZyZWVkIG1lbW9yeQ0KPiA+ICsJICovDQo+ID4gKwlocHJpdi0+dGFyZ2V0X3B3cnMgPSBr
Y2FsbG9jKGhwcml2LT5ucG9ydHMsIHNpemVvZigqaHByaXYtDQo+ID4gPnRhcmdldF9wd3JzKSwg
R0ZQX0tFUk5FTCk7DQo+ID4gICAJaWYgKCFocHJpdi0+dGFyZ2V0X3B3cnMpIHsNCj4gPiAgIAkJ
cmMgPSAtRU5PTUVNOw0KPiA+ICAgCQlnb3RvIGVycl9vdXQ7
