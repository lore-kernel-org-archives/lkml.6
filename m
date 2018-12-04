Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D548C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A282082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="KtPt1LVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A282082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLDPEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:04:00 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:2400
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbeLDPD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW0TL8oViga6LgLmrj/1ZxAhqVTiZdgv5iUCUDPMEXo=;
 b=KtPt1LVhRDjpss53fpldlZeHl1FmwSFrM9ltNzE3RiAP+OWD+OjJCX5LluSiLmR3d/aYzvAI9y8S9u+U+5aYte//Fc89aKP7ILhMf1nA1mo4UO3D14jBCr2DZhQfYWV6YzDjdEgRrhJT3D5Dc7YIfdhLhXehgMpGxf4izK5OBZw=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5963.eurprd04.prod.outlook.com (20.178.107.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 15:03:40 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 15:03:40 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: =?utf-8?B?W1BBVENIIDQvNF0gQVJNOiBteHM6IGNmYTEwMDM2OiBGaXh1cCBPTEVEwqBk?=
 =?utf-8?Q?isplay_reset_polarity?=
Thread-Topic: =?utf-8?B?W1BBVENIIDQvNF0gQVJNOiBteHM6IGNmYTEwMDM2OiBGaXh1cCBPTEVEwqBk?=
 =?utf-8?Q?isplay_reset_polarity?=
Thread-Index: AQHUi+KKthGpJEQVZU6UA2M3No4/WA==
Date:   Tue, 4 Dec 2018 15:03:40 +0000
Message-ID: <1543935806-94880-5-git-send-email-michal.vokac@ysoft.com>
References: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:203:90::21) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5963;6:8Jf4LwWMkTeYdKmvFEEhEN4ikRMT2Rrjjz6f/N0dBkb0Wymmh/8IcsUcgAT/n90aM7RviEtamXrn36LfbgdZZ3SMShdI4eJUCk0AdfxxarT8BhANO8scLcmGj6d8RKRtIWXx4V1GkoN/+Tm2mtuxKcwbLQjarqzQT0zGehXsRKphBZ3zcIsPSHTXt3lLagmeNdgk/QbyYQdEnvdaKOjYUkWViqljhmqTLEO/22c6Fup+bGSoB0tRlUvZ5qrtpM/0vof27kGSzahX0siJUoj8dZVHFj3Bk2bgnfHtmuwq5budcAHAJEmway6it+82vwTHXJ+YW5ThH1DAfH0F5TVzl7Wp/PXXoJd+snT1v0ttRbxWdndAHXt1lq83gcorQBhPvtduTT8kBB+fw9UHvnvOGl6wnnUJ8nmifF5pQD5ucE0JXZ7rqbY2n4UOnZ3/eUh9yjV9/xJIIgLEdhBCV1b+8w==;5:uIzqHWrMz8JvPwyCOEVlnaUuQF1ieSzudFx8UFb5J1HHa9PtbkMBAFCZIh/0nNn/W7Vb3nnfkV9aWQyJ0zfl8L5ZfHAUnb+HY7XMow3aGJOoOtY699onBi2E9so+7eaI/7vrNkpGP/wZoeukTZ0Goed90UoeirwvT+yKYuELWkg=;7:sIs6dERQhNa0ZwEcFtb+R0VrTr8MjAC4uqFvyHPhYc98+8GJO6vmItXd9m/0yegpExNJzodH6b0iNjC57m9iE0yjOSQQu/sPPXGBgkKfAZxnWlw/k+3sygAuX5tMWM4Tw070wQrWezf+v3NHEWFHUw==
x-ms-office365-filtering-correlation-id: ea8ba808-b6f6-4722-50e8-08d659f9ace9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5963;
x-ms-traffictypediagnostic: DB7PR04MB5963:
x-microsoft-antispam-prvs: <DB7PR04MB59631E89DB4D04F1D357B1319EAF0@DB7PR04MB5963.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5963;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5963;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(136003)(396003)(346002)(376002)(199004)(189003)(72206003)(53936002)(478600001)(76176011)(6512007)(26005)(386003)(305945005)(186003)(4326008)(107886003)(7736002)(256004)(81156014)(14444005)(66066001)(8936002)(71200400001)(14454004)(71190400001)(6506007)(81166006)(6486002)(5660300001)(11346002)(25786009)(99286004)(36756003)(2616005)(6436002)(446003)(316002)(68736007)(102836004)(105586002)(2906002)(110136005)(106356001)(54906003)(486006)(52116002)(6116002)(86362001)(3846002)(476003)(85182001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5963;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oXc0pktuujK0Dy7zuTSZdNU0IdmxWiZWsHZysuJ6N+DREI1sDOlWGDIanc8+fK89vnbkbDQVViMIpgAFw7NcBGsHUH7gDKxj0gWVSJ7SgtugXADjAE4by2vZ+bn5QOJcqpcbibGj4BSdKNTDzO0JkDb5EELDNAacLEVPqeHZ4hGRBvAVGXHBWPFKRNK+H3hNU03tKRXKBMRnBA7MBxc6QUXWahKYxmEH10Rwij1nRS60VnfFwms6c1UBeMCqhkrB8XmIOz3udyIiaQ+9pOUlff3jUsfThehiYy65oqJrj6xEvjX0XrP0AhTueA8Cm6ENc14lT1MbiqUjEWbf6WbwPmjqc8EOIuGWNpdn2ka2yuo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <738447F86299104B827666F04D0CB600@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8ba808-b6f6-4722-50e8-08d659f9ace9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 15:03:40.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5963
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgd2FzIGEgYnVnIGluIHJlc2V0IHNpZ25hbCBnZW5lcmF0aW9uIGluIHNzZDEzMDdmYiBP
TEVEIGRyaXZlci4NClRoZSBkaXNwbGF5IG5lZWRzIGFuIGFjdGl2ZS1sb3cgcmVzZXQgc2lnbmFs
IGJ1dCB0aGUgZHJpdmVyIHByb2R1Y2VkDQp0aGUgY29ycmVjdCBzZXF1ZW5jZSBvbmx5IGlmIHRo
ZSBHUElPIHVzZWQgZm9yIHJlc2V0IHdhcyBzcGVjaWZpZWQgYXMNCkdQSU9fQUNUSVZFX0hJR0gu
DQoNCk5vdyBhcyB0aGUgT0xFRCBkcml2ZXIgaXMgZml4ZWQgaXQgaXMgYWxzbyBuZWNlc3NhcnJ5
IHRvIGltcGxlbWVudA0KYSBmaXh1cCBmb3IgYWxsIGN1cnJlbnQgdXNlcnMgb2YgdGhlIG9sZCBE
VCBBQkkuIFRoZXJlIGlzIG9ubHkgb25lDQppbi10cmVlIHVzZXIgYW5kIHRoYXQgaXMgdGhlIENy
eXN0YWxmb250eiBDRkEtMTAwMzYgYm9hcmQuIEluIGNhc2UNCnRoaXMgYm9hcmQgaXMgYm9vdGlu
ZyBhbmQgR1BJT19BQ1RJVkVfSElHSCBpcyB1c2VkIGZvciByZXNldCB3ZQ0Kb3ZlcnJpZGUgaXQg
dG8gR1BJT19BQ1RJVkVfTE9XLg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWlj
aGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0tLQ0KIGFyY2gvYXJtL21hY2gtbXhzL21hY2gtbXhzLmMg
fCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNo
LW14cy9tYWNoLW14cy5jIGIvYXJjaC9hcm0vbWFjaC1teHMvbWFjaC1teHMuYw0KaW5kZXggMWM2
MDYyZC4uMjNjMjYwYyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL21hY2gtbXhzL21hY2gtbXhzLmMN
CisrKyBiL2FyY2gvYXJtL21hY2gtbXhzL21hY2gtbXhzLmMNCkBAIC0yMSw2ICsyMSw3IEBADQog
I2luY2x1ZGUgPGxpbnV4L3JlYm9vdC5oPg0KICNpbmNsdWRlIDxsaW51eC9taWNyZWxfcGh5Lmg+
DQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCisjaW5jbHVkZSA8bGludXgvb2ZfZ3Bp
by5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KICNpbmNsdWRlIDxsaW51eC9w
aHkuaD4NCiAjaW5jbHVkZSA8bGludXgvcGluY3RybC9jb25zdW1lci5oPg0KQEAgLTI2OCw5ICsy
NjksNTMgQEAgc3RhdGljIHZvaWQgX19pbml0IGFweDRkZXZraXRfaW5pdCh2b2lkKQ0KIAkJCQkJ
ICAgYXB4NGRldmtpdF9waHlfZml4dXApOw0KIH0NCiANCisjZGVmaW5lIE9MRURfUkVTRVRfR1BJ
T19MRU4JMw0KKyNkZWZpbmUgT0xFRF9SRVNFVF9HUElPX1NJWkUJKE9MRURfUkVTRVRfR1BJT19M
RU4gKiBzaXplb2YodTMyKSkNCisNCitzdGF0aWMgdm9pZCBfX2luaXQgY3J5c3RhbGZvbnR6X29s
ZWRfcmVzZXRfZml4dXAodm9pZCkNCit7DQorCXN0cnVjdCBwcm9wZXJ0eSAqbmV3Z3BpbzsNCisJ
c3RydWN0IGRldmljZV9ub2RlICpucDsNCisJdTMyICpncGlvc3BlYzsNCisJaW50IGksIHJldDsN
CisNCisJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAic29sb21vbixz
c2QxMzA2ZmItaTJjIik7DQorCWlmICghbnApDQorCQlyZXR1cm47DQorDQorCW5ld2dwaW8gPSBr
emFsbG9jKHNpemVvZigqbmV3Z3BpbykgKyBPTEVEX1JFU0VUX0dQSU9fU0laRSwgR0ZQX0tFUk5F
TCk7DQorCWlmICghbmV3Z3BpbykNCisJCXJldHVybjsNCisNCisJbmV3Z3Bpby0+dmFsdWUgPSBu
ZXdncGlvICsgMTsNCisJbmV3Z3Bpby0+bGVuZ3RoID0gT0xFRF9SRVNFVF9HUElPX1NJWkU7DQor
CW5ld2dwaW8tPm5hbWUgPSBrc3RyZHVwKCJyZXNldC1ncGlvcyIsIEdGUF9LRVJORUwpOw0KKwlp
ZiAoIW5ld2dwaW8tPm5hbWUpIHsNCisJCWtmcmVlKG5ld2dwaW8pOw0KKwkJcmV0dXJuOw0KKwl9
DQorDQorCWdwaW9zcGVjID0gbmV3Z3Bpby0+dmFsdWU7DQorCWZvciAoaSA9IDA7IGkgPCBPTEVE
X1JFU0VUX0dQSU9fTEVOOyBpKyspIHsNCisJCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2lu
ZGV4KG5wLCAicmVzZXQtZ3Bpb3MiLCBpLA0KKwkJCQkJCSAmZ3Bpb3NwZWNbaV0pOw0KKwkJaWYg
KHJldCkgew0KKwkJCWtmcmVlKG5ld2dwaW8pOw0KKwkJCXJldHVybjsNCisJCX0NCisJfQ0KKw0K
KwlpZiAoIShncGlvc3BlY1syXSAmIE9GX0dQSU9fQUNUSVZFX0xPVykpIHsNCisJCWdwaW9zcGVj
WzJdIHw9IE9GX0dQSU9fQUNUSVZFX0xPVzsNCisJCWNwdV90b19iZTMyX2FycmF5KGdwaW9zcGVj
LCBncGlvc3BlYywgT0xFRF9SRVNFVF9HUElPX0xFTik7DQorCQlvZl91cGRhdGVfcHJvcGVydHko
bnAsIG5ld2dwaW8pOw0KKwl9DQorfQ0KKw0KIHN0YXRpYyB2b2lkIF9faW5pdCBjcnlzdGFsZm9u
dHpfaW5pdCh2b2lkKQ0KIHsNCiAJdXBkYXRlX2ZlY19tYWNfcHJvcChPVUlfQ1JZU1RBTEZPTlRa
KTsNCisJY3J5c3RhbGZvbnR6X29sZWRfcmVzZXRfZml4dXAoKTsNCiB9DQogDQogc3RhdGljIHZv
aWQgX19pbml0IGR1Y2tiaWxsX2luaXQodm9pZCkNCi0tIA0KMi4xLjQNCg0K
