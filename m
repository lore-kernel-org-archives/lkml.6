Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE020869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wOs9mSpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDE020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeIDHcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:32:05 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:25632
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbeIDHcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POTYRI7SeQ2lZ0ZPRBI1+i3YD31PP/NuZp0lLPTjVG4=;
 b=wOs9mSpNWpkhv8NffD/ygGgAo9ZD6n5fq3K5ozOwCXQTN4xEbOfHu1LLF/mBWei6C2cMP2uWnKgLlhUZsJijZiXqmJafbGflVYeymNQdrtCqQ+AhqYBNhEef5U/t4kZsCJNMyIOXRXzxmjzvkdX4Mo3sZal7DH17g5yRdm+Qtrs=
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com (10.166.173.8) by
 DB5PR0401MB2197.eurprd04.prod.outlook.com (10.166.172.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Tue, 4 Sep 2018 03:08:58 +0000
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::f9e1:eda0:e2ec:6b1]) by DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::f9e1:eda0:e2ec:6b1%7]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 03:08:58 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
CC:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>
Subject: RE: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUOLbm4rl14SxWF0C6ww3h4NBV1KTV6koAgAIMswCAAKh1AIAAANOAgADNfJCAAPM9AIADb+mAgAFIboCAAGwIAA==
Date:   Tue, 4 Sep 2018 03:08:57 +0000
Message-ID: <DB5PR0401MB221372E7A7DA3ED53BA721B2F3030@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
 <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
 <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
 <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <f6707cb54c3e6da1b50f45f915c996dfccfeacda.camel@buserror.net>
 <DB5PR0401MB221332A5ED14C8E14C8D18A1F30C0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <3a4274af2200923875ff05f945888a34d6dccee3.camel@buserror.net>
In-Reply-To: <3a4274af2200923875ff05f945888a34d6dccee3.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR0401MB2197;6:byzcZL4++jABn40RP1gCrXNsoPQQu4kl8zHg6hy4I8Kdm2SxZFmnTB0G79Uzh0IaSQfj0ENpm6hC1HXpdJdzXsSLuffmZDCXQaBBEWMnn2qIaFQFCv5qiolO7vDNQCO0F5HSSWq7beUmons3kp8iAd5lBlupI3FQewQcB+Qi/iHC2O7aF2YLB+TV6FpkQAda0ZZLLTupRZJpTUcO9A18u+kerLFRE0ZRWnkXWJMQj5V810EfYxEtdXqxTUTLVCimh5rY6npKovX+dsJbIgkjPyavOvPRVZC+nhszxzbu1IVWqkwiKNEIFqZGxUw0ffm39g83aW/cAuit56NHKsZ/vGeVToq4Gh4gNSevPI+hpDIfWg2z3NRc7TPLGEm84ghmRe05XCiZPZvrti1oAWCYfGNLuDRiTRlNIl2y+pvTDbBECEqQgN1fmVgG/mghZmd2SN6lCe2pCLno4GgA8i+LvA==;5:bT/XoNWPJNrUTa0NfpMcPVDnylSWUF1JTcVd4uD/23LbSzBb1UQauocNBGkhEinI+DX+O8+w1klgmmjQzmcRcL5WhktL9/O74BEE1BYg9YJ4bl0mWQJRUaH/u/UelRvyL9pkMH03Mb+1T1hBnbE1sjcYJlfUizNEMTunkRX0/Xw=;7:lP+ue6ZIE9y02TiGH0QiXrOXLkqyEd1j9+oxjRpwxQxWzje3QJreqOnKrewGq83TkQ/fKz9gkT6Ip6yjjk1uJo2BpgUJx79/7RUwQH89WP8zQ25/0J0XGTreW5Xf5+IiMochooZ5q8npsSutlkNzUWR5Dyokg+1qc5SqXWL3QCy8WZpweDMuI7w3H+2s2Gtr+EW0BveFZWqiOEHmh1o5Hm0koXhDZNP+TWYgTLUeLLHpspm7QAVZVDNj4uh4ObhB
x-ms-office365-filtering-correlation-id: 6f95bbbe-d8ca-4a35-49bd-08d61213c1a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR0401MB2197;
x-ms-traffictypediagnostic: DB5PR0401MB2197:
x-microsoft-antispam-prvs: <DB5PR0401MB2197D12B499025DEF094FB4FF3030@DB5PR0401MB2197.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(65623756079841)(185117386973197)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DB5PR0401MB2197;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB2197;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(13464003)(199004)(189003)(4326008)(106356001)(33656002)(105586002)(229853002)(446003)(186003)(93886005)(11346002)(7696005)(99286004)(5660300001)(25786009)(26005)(76176011)(7416002)(7736002)(305945005)(316002)(110136005)(54906003)(2906002)(74316002)(102836004)(3846002)(97736004)(6116002)(6506007)(8676002)(53546011)(6246003)(256004)(8936002)(45080400002)(6306002)(2201001)(86362001)(14444005)(5250100002)(9686003)(44832011)(2501003)(486006)(68736007)(14454004)(478600001)(2900100001)(966005)(53936002)(81166006)(476003)(81156014)(6436002)(55016002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0401MB2197;H:DB5PR0401MB2213.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uRmTp7h32h3lCd01tlkOo5Mry0UdcmZrN1EsuEbinZlYP1m4PVqiM1STSSQYUSoU3w5tE4Hfl+pDnu7DbqBnwOVLIs1cNy1aGGqJF29XYdY8klmqxgjDzhV+fk0je0+wcUMX1yffybU9jUn9zTwQectuXj5Z2XVHdX7mdsNANJyAU8Yue3atmA4wu8XvRwdehuk80JUmPSL4y4GhM/VUr7GqvaWXhGSic9AdXIk87rjW1UD5XTVUC2hd9MO/c+b+er3tkNw28+hqj6nppbnYHJY94e9aN+5j3JvDbspQjCX1qL5QxSvt5gc+PF0a4hwU4epJemSltMQhd3P8J+H2BPbmGR11HTthKCIdoYQGBtU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f95bbbe-d8ca-4a35-49bd-08d61213c1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 03:08:57.9948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0401MB2197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2NvdHQsDQoNClBsZWFzZSBzZWUgbXkgcmVwbGF5IGlubGluZS4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2Vy
bmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gT24gQmVoYWxmIE9mIFNjb3R0IFdv
b2QNCj4gU2VudDogMjAxOOW5tDnmnIg05pelIDQ6MzQNCj4gVG86IEFuZHkgVGFuZyA8YW5keS50
YW5nQG54cC5jb20+OyBWYWJoYXYgU2hhcm1hDQo+IDx2YWJoYXYuc2hhcm1hQG54cC5jb20+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXhwcGMt
ZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGtlcm5lbC5vcmc7IHJqd0By
and5c29ja2kubmV0OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsNCj4gbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWwtb3du
ZXJAdmdlci5rZXJuZWwub3JnOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsNCj4gd2lsbC5kZWFj
b25AYXJtLmNvbTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGFybmRAYXJuZGIuZGU7DQo+
IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IHlhbWFkYS5tYXNhaGlyb0Bzb2Npb25leHQu
Y29tDQo+IENjOiBZb2dlc2ggTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNv
bT47DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNv
bT47IFVkaXQgS3VtYXINCj4gPHVkaXQua3VtYXJAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAzLzVdIGRyaXZlcnM6IGNsay1xb3JpcTogQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9yDQo+
IGx4MjE2MGENCj4gDQo+IE9uIE1vbiwgMjAxOC0wOS0wMyBhdCAwMToxNyArMDAwMCwgQW5keSBU
YW5nIHdyb3RlOg0KPiA+IEhpIFNjb3R0LA0KPiA+DQo+ID4gUGxlYXNlIHNlZSBteSByZXBsYXkg
aW4gbGluZS4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IExpbnV4cHBjLWRldg0KPiA+ID4gPGxpbnV4cHBjLWRldi1ib3VuY2VzK2IyOTk4Mz1mcmVl
c2NhbGUuY29tQGxpc3RzLm96bGFicy5vcmc+IE9uDQo+ID4gPiBCZWhhbGYgT2YgU2NvdHQgV29v
ZA0KPiA+ID4gU2VudDogMjAxOOW5tDnmnIgx5pelIDQ6MjkNCj4gPiA+IFRvOiBBbmR5IFRhbmcg
PGFuZHkudGFuZ0BueHAuY29tPjsgVmFiaGF2IFNoYXJtYQ0KPiA+ID4gPHZhYmhhdi5zaGFybWFA
bnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+ID4gbWFyay5ydXRsYW5k
QGFybS5jb207IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOw0KPiA+ID4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4g
PiA+IHNib3lkQGtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyB2aXJlc2gua3VtYXJAbGlu
YXJvLm9yZzsNCj4gPiA+IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIu
a2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmc7IGNh
dGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiA+ID4gd2lsbC5kZWFjb25AYXJtLmNvbTsgZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGFybmRAYXJuZGIuZGU7DQo+ID4gPiBrc3Rld2FydEBsaW51
eGZvdW5kYXRpb24ub3JnOyB5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbQ0KPiA+ID4gQ2M6
IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsNCj4gPiA+
IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgVWRpdCBLdW1hciA8dWRpdC5rdW1hckBueHAuY29tPjsg
VmFydW4NCj4gU2V0aGkNCj4gPiA+IDxWLlNldGhpQG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDMvNV0gZHJpdmVyczogY2xrLXFvcmlxOiBBZGQgY2xvY2tnZW4gc3VwcG9ydA0K
PiA+ID4gZm9yIGx4MjE2MGENCj4gPiA+DQo+ID4gPiBPbiBGcmksIDIwMTgtMDgtMzEgYXQgMDY6
MTIgKzAwMDAsIEFuZHkgVGFuZyB3cm90ZToNCj4gPiA+ID4gV2UgZG9uJ3Qgd2FudCB0byBpbmNy
ZWFzZSBOVU1fQ01VWCBlYWNoIHRpbWUgbmV3IHNvYyB3aXRoDQo+IG1vcmUNCj4gPiA+DQo+ID4g
PiBjbXV4ZXMgYWRkZWQuDQo+ID4gPg0KPiA+ID4gWW91IGRvbid0IHdhbnQgdG8gaGF2ZSB0byBt
YWtlIGEgdHJpdmlhbCBjaGFuZ2UgZWFjaCB0aW1lIHlvdSBleGNlZWQNCj4gPiA+IGEgbGltaXQg
dGhhdCBoYXMgeWV0IHRvIGJlIGV4Y2VlZGVkIG9uY2Ugc2luY2UgTlVNX0NNVVggd2FzIGFkZGVk
Pw0KPiA+ID4gVGhpcyBpc24ndCBBQkkgb3IgaW4gYW55IG90aGVyIHdheSBoYXJkIHRvIGNoYW5n
ZS4gIEl0J3MgcmlnaHQgaW4NCj4gPiA+IHRoZSBzYW1lIGZpbGUgYXMgdGhlIGNoaXAgZGVzY3Jp
cHRpb24geW91J2QgYmUgYWRkaW5nLg0KPiA+ID4NCj4gPiA+IEFuZCBldmVuIGlmIGEgY2hpcCBk
aWQgY29tZSBhbG9uZyB3aXRoIDE2IGNtdXhlcywgeW91J2QgdGhlbiBuZWVkIHRvDQo+ID4gPiBp
bmNyZWFzZSB0aGUgYXJyYXkgdG8gMTcgdG8gaG9sZCB0aGUgLTEgaWYgeW91IGRvbid0IHdhbnQg
dG8gbGVhdmUgYQ0KPiA+ID4gc2l0dWF0aW9uIGxpa2UgdGhlDQo+ID4gPiBwNDA4MCBpcyBpbiBu
b3csIHdoZXJlIGEgY2hpcCdzIGNtdXggYXJyYXkgY291bGQgYmUgYnJva2VuIGJ5DQo+ID4gPiBp
bmNyZWFzaW5nIE5VTV9DTVVYIGZ1cnRoZXIuDQo+ID4gPg0KPiA+DQo+ID4gW0FuZHldIEFkZGlu
ZyBidWZmZXIgdG8gYSBsaW1pdGF0aW9uIG51bWJlciBpcyBhbHdheXMgYSBnb29kIGhhYml0DQo+
ID4gd2hlbiBjb2RpbmcuIFdlIG9mdGVuIGZvcmdldCB0byBpbmNyZWFzZSB0aGlzIHZhbHVlIHdo
ZW4gYSBuZXcgY2hpcA0KPiA+IHdpdGggbW9yZSBjbXV4ZXMgYWRkZWQuDQo+IA0KPiAib2Z0ZW4i
PyAgVGhlcmUgaGFzIG5ldmVyIGJlZW4gYSBuZXcgY2hpcCBhZGRlZCB3aXRoIG1vcmUgY211eGVz
DQo+IHRoYW4gcDQwODAncyA4LCBhbmQgaWYgb25lIGRvZXMgY29tZSBhbG9uZyBhbmQgeW91IGZv
cmdldCwgdGhlIGNvbXBpbGVyDQo+IHNob3VsZCBjb21wbGFpbiBhYm91dCBleGNlZWRpbmcgdGhl
IGFycmF5IGxlbmd0aCB3aXRoIGEgc3RhdGljIGluaXRpYWxpemVyLg0KPiBUaGlzIGlzbid0IGxp
a2UgYW4gYXJyYXkgdGhhdCBpcyBmaWxsZWQgd2l0aCBhIHJ1bnRpbWUtZGV0ZXJtaW5lZCBsZW5n
dGguDQo+IA0KPiA+IExpa2UgdGhpcyBwYXRjaCwgd2UgZGlkbid0IGluY3JlYXNlIHRoaXMgdmFs
dWUgYXQgZmlyc3QuIFdlIHNwZW50IGENCj4gPiBsb3Qgb2YgdGltZSBmaW5kaW5nIG91dCB0aGF0
IE5VTV9DTVVYIG5lZWRzIHRvIGJlIGluY3JlYXNlZCB0b28uDQo+IA0KPiBBcmUgeW91IHRhbGtp
bmcgYWJvdXQgc29tZSBvdGhlciBjaGlwIHRoYXQgeW91IGhhdmVuJ3Qgc2VudCBhIHBhdGNoIGZv
cg0KPiB5ZXQ/DQo+IE9yIGlzIHRoZSBjbXV4IGFycmF5IGZvciB0aGlzIGNoaXAgd3Jvbmc/ICBX
aGF0IHNwZWNpZmljYWxseSBkaWQgeW91IHNlZQ0KPiBoYXBwZW4gImF0IGZpcnN0Ij8NCj4gDQpb
QW5keV0gU29ycnksICJPZnRlbiIgaXMgbm90IGEgcmlnaHQgd29yZC4gSSBtZWFudCB3ZSB0ZW5k
IHRvIGFkZCBuZXcgc29jIHdpdGhvdXQgdXBkYXRpbmcgTlVNX0NNVVguDQogDQo+ID4gSXQgaXMg
YSBwZXJzb25hbCBwcmVmZXJlbmNlIGhvdyB0byBzZXQgdGhpcyB2YWx1ZS4gSSB0aGluayBpdCBp
cw0KPiA+IGJldHRlciB0byBpbmNyZWFzZSBpdCB0byAxNiwgbm90IE5VTV9DTVVYKzEgYXMgbG9u
ZyBhcyB3ZSBmaXggdGhlDQo+ID4gUDQwODAgaXNzdWUgZXZlbiB0aG91Z2ggaXQgaXMgYSB0cml2
aWFsIGNoYW5nZS4gQW5kIEkgYWdyZWUgdGhlDQo+ID4gZGVzY3JpcHRpb24gbmVlZHMgdG8gYmUg
dXBkYXRlZC4NCj4gDQo+IEknbSBub3QgdGhlIGNsb2NrIG1haW50YWluZXIsIHNvIGl0J3Mgbm90
IHVwIHRvIG1lLCBidXQgSSBkb24ndCBzZWUgdGhlIHBvaW50DQo+IGluIHNldHRpbmcgaXQgdG8g
YW4gYXJiaXRyYXJ5IG51bWJlciwgYW5kIEkgZG8gbm90IGFncmVlIHRoYXQgaW5jcmVhc2luZw0K
PiBOVU1fQ01VWCBpcyBhIHN1aXRhYmxlIHJlcGxhY2VtZW50IGZvciBOVU1fQ01VWCsxIGluDQo+
IGNtdXhfdG9fZ3JvdXBbXSwgYXMgdGhhdCBhcnJheSBzaG91bGQgYmUgb25lIGxhcmdlciB0aGFu
IGNtdXhbXSBpbiBvcmRlcg0KPiB0byBhbGxvdyBldmVyeSBjaGlwIHRvIGhhdmUgYQ0KPiAtMSB0
ZXJtaW5hdG9yLiAgSW4gYW55IGNhc2UsIGFueSBjaGFuZ2UgdG8gTlVNX0NNVVggc2hvdWxkIGJl
IGENCj4gc2VwYXJhdGUgcGF0Y2ggYmVjYXVzZSBpdCdzIG5vdCByZXF1aXJlZCBmb3IgbHgyMTYw
YSBzdXBwb3J0IChhc3N1bWluZw0KPiBseDIxNjBhIHdhcyBjb3JyZWN0bHkgZGVzY3JpYmVkIGJ5
IHRoaXMgcGF0Y2gpLg0KW0FuZHldIEkgZG9uJ3Qgc2VlIGFueSBpbXByb3ByaWF0ZSBhYm91dCB5
b3VyIHN1Z2dlc3Rpb24uIHNvIHdlIGFyZSBnb2luZyB0byBkbyBpbiB5b3VyIHdheS4NCg0KVGhh
bmtzLA0KQW5keQ0KPiANCj4gLVNjb3R0DQo+IA0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwczov
L2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYl
MkZsaXN0DQo+IHMuaW5mcmFkZWFkLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmxpbnV4LWFy
bS1rZXJuZWwmYW1wO2RhdGE9MDINCj4gJTdDMDElN0NhbmR5LnRhbmclNDBueHAuY29tJTdDZGJj
ODI0ZmMzOTY3NDcxMTMxNjIwOGQ2MTFkY2YNCj4gNjFiJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjcxNjAzDQo+IDgwNjA3OTcxMTMmYW1wO3NkYXRhPWlD
TEtHTUV6UlgyZHBINSUyQmY0TldJaVBEYzVMNU5wVGNwWjdYDQo+IHVzZWhkSXclM0QmYW1wO3Jl
c2VydmVkPTANCg==
