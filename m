Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7259820657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="nm5BJa7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7259820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeKCAD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:03:59 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:28981
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeKCAD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqUCYAXI6tNpi0pOG8fUMtHqXiqsWhnuOYbMFftS4aY=;
 b=nm5BJa7pRpcuWbfDMnomTfmEcagXzdUeWobxnejv4edos1HG7Pc7b7w11ONYxy99DWOh+mNQftxILpf11vFupAC+oIY/muzrfXVbef3L4LXFeP5Iyw3GXDNvexAy8lxjh7p6yPCuSG3gs1Fl/8kHxvH7VVPSlblwWBLzP4chF3o=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4987.eurprd04.prod.outlook.com (20.176.234.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 2 Nov 2018 14:56:32 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 14:56:32 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH fbdev-for-next 1/2] dt-bindings: display: ssd1307fb: Add
 reset-active-low property
Thread-Topic: [PATCH fbdev-for-next 1/2] dt-bindings: display: ssd1307fb: Add
 reset-active-low property
Thread-Index: AQHUcrw+i/ut91AHCkuAoUzkq/OHRQ==
Date:   Fri, 2 Nov 2018 14:56:32 +0000
Message-ID: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0086.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::27) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4987;6:t0IAdz5Q/FZGzgImE2Hq+P2NUKmaxf0bmsEsW7dX3DYuk8z7WereNnWSGUw+jwcON1QW5THiZQsHbVTCaqj7rIZW2+IPfdLFy1KZW2IP/8DPRAWBKTu5WcVrFU4ZqM5pehBT5QC6OHN5Ky0hf+hY5Ei7fzPZybbJOLPuGhfp3dahu2ALR33czIrH0uY56wjPdoqAlyBynSaDSg+hlYMXBlLmIpp4Y3NXlUPkk8yqssV0EMP8LJYdoq3OK20P6lB6mau2vltpRc418S4/UB0nBsWF+QQiIIJwBEvLXzWUvIJD0Lkpud2o4BbVT94ZKV8GSlnmvsj7pFU/4MeiQSnu2pNEJcxlVaYOPTwYoqks8TexF/l8cZVCqJaBAuytogY2E0JBpTvjHcKX51E5pUedZb2lSlpBtzOK+HB+9d11am4ABjhUUzrsSLzEvJEp4FJ444zfVv8sg3Kor9IF/53hxg==;5:K17n+yVqL8poO6mCkm31Vq6QjO8ps+yyZnDpa0mReRcKWeMQse5owajPfjcVZCb6bC7SxNPGrQEiAUBhn5XyO/XROqvcG2kQUoarxQV9GfvIcCeoc1zdtyTgLRp5B5q5BrOO2SHOKRCt80XVPDiqSFoAJeoxYBhf9DKmX8m4nwA=;7:/DUyjev/zQx9NBYq0wM0xnzSmBMVbs1qISPjHD44BwUsIKMKQLsQqdbB7es0CvomiWa/6Pefywb0inwcv+nAqSLrNlJLyROdH5ronrkh3GY7aJxckZgWC+MKF9B5TuGQU289WQXEsutp4r1XVNDHvg==
x-ms-office365-filtering-correlation-id: 437bc04f-6e28-44ba-3f1f-08d640d3609d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4987;
x-ms-traffictypediagnostic: DB7PR04MB4987:
x-microsoft-antispam-prvs: <DB7PR04MB4987117A1D74F1F1E7E548909ECF0@DB7PR04MB4987.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4987;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4987;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(366004)(376002)(346002)(396003)(189003)(199004)(6512007)(52116002)(54906003)(110136005)(386003)(53936002)(6116002)(2906002)(3846002)(6506007)(476003)(486006)(2900100001)(186003)(8676002)(575784001)(86362001)(26005)(6436002)(316002)(102836004)(66066001)(99286004)(85182001)(81166006)(81156014)(7736002)(8936002)(305945005)(25786009)(68736007)(36756003)(14454004)(5660300001)(107886003)(6486002)(97736004)(478600001)(71200400001)(4326008)(2616005)(106356001)(105586002)(72206003)(256004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4987;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 41ySgJHwbaZskK7/6QF6LPhOCyAoPQBrqF4VE7s7eh8rp9+gzF1WTOvB9RpHUF0xQ5hXF/7gNC8kIw07/o6DRj61fZbInV/wH3nR8hA9j68zfZYUESbe3Y24/XGtcsCnJt4Y62DqHIN1bwUzrZKP/KIPCSx0UcZXa++nO5lqGxHlkXvsksu8yc4KkejAhyPmptb1vh3AvJ46T96CnS9++z4r2xl/wduXOy6KpSYupsDFQkNOH35S2D2wRPnP8myRK9gEt0fjtweKLrHVQoAqO9iJsY1Vbr9X20qi7KeSamONRb8cISPwyn1rCogkjh3fIuVfDXemBVTiejpxvGQPQ8s6ZU1mFqXvT5nuZaGyZM8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <180BA1B53F1D93458920604DE1CA8E09@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437bc04f-6e28-44ba-3f1f-08d640d3609d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 14:56:32.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCA1MTliNGRiYTU4NjE5OGVlZDhmNzJiYTA3YmM3MTgwOGFmMmUw
ZTMyLg0KSXQgaXMgdHJ1ZSB0aGF0IHRoZSBhY3R1YWwgaW1wbGVtZW50YXRpb24gaGFzIG5ldmVy
IGJlZW4gdGhlcmUuIEJ1dA0KY29udHJhcnkgdG8gd2hhdCB0aGUgcmV2ZXJ0ZWQgY29tbWl0IG1l
c3NhZ2Ugc2F5cyBpdCBkb2VzIG1ha2Ugc2Vuc2UNCnRvIGFkZCBpdC4NCg0KQ3VycmVudCBpbXBs
ZW1lbnRhdGlvbiBvZiB0aGUgcmVzZXQgc2lnbmFsIGlzIGhhcmQtY29kZWQgdG8gYWN0aXZlIGxv
dw0Kd2l0aCB0aGUgYXNzdW1wdGlvbiB0aGF0IHJlc2V0LWdwaW9zIGlzIHNwZWNpZmllZCBhcyBH
UElPX0FDVElWRV9ISUdILg0KVGhhdCBpcyB0ZWNobmljYWxseSB3cm9uZyBhcyB0aGUgRFRTIGF1
dGhvcnMgc2hvdWxkIGtub3cgdGhhdCBTU0QxMzB4DQpkaXNwbGF5cyBuZWVkIGFjdGl2ZSBsb3cg
cmVzZXQgYW5kIGhlbmNlIHRoZXkgYXJlIHRlbXBlZCB0byB1c2UNCkdQSU9fQUNUSVZFX0xPVy4g
QnV0IHdpdGggdGhhdCB0aGUgcmVzZXQgaXMgYnJva2VuLiBTbyByZXNldC1hY2l2ZS1sb3cNCnBy
b3BlcnR5IGNhbiBiZSB1c2VkIHRvIGludmVydCB0aGUgc2lnbmFsIG9uY2UgYWdhaW4gdG8gZml4
IHRoaXMuDQoNClNpZ25lZC1vZmYtYnk6IE1pY2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNAeXNv
ZnQuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
c3NkMTMwN2ZiLnR4dCB8IDYgKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L3NzZDEzMDdmYi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9zc2QxMzA3ZmIudHh0DQppbmRleCAyMDlkOTMxLi5hNWVhZDEw
IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
c3NkMTMwN2ZiLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvc3NkMTMwN2ZiLnR4dA0KQEAgLTE2LDYgKzE2LDggQEAgUmVxdWlyZWQgcHJvcGVydGll
czoNCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KICAgLSByZXNldC1ncGlvczogVGhlIEdQSU8gdXNl
ZCB0byByZXNldCB0aGUgT0xFRCBkaXNwbGF5LCBpZiBhdmFpbGFibGUuIFNlZQ0KICAgICAgICAg
ICAgICAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vZ3Bpby50eHQg
Zm9yIGRldGFpbHMuDQorICAtIHJlc2V0LWFjdGl2ZS1sb3c6IEJvb2wgZmxhZyB0byBpbmRpY2F0
ZSB0aGUgR1BJTyBzcGVjaWZpZWQgaW4gInJlc2V0LWdwaW9zIg0KKyAgICAgICAgICAgICAgICAg
ICAgICBwcm9wZXJ0eSBpcyBhY3RpdmUgbG93Lg0KICAgLSB2YmF0LXN1cHBseTogVGhlIHN1cHBs
eSBmb3IgVkJBVA0KICAgLSBzb2xvbW9uLHNlZ21lbnQtbm8tcmVtYXA6IERpc3BsYXkgbmVlZHMg
bm9ybWFsIChub24taW52ZXJ0ZWQpIGRhdGEgY29sdW1uDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdG8gc2VnbWVudCBtYXBwaW5nDQpAQCAtMzUsNyArMzcsNyBAQCBzc2QxMzA3OiBv
bGVkQDNjIHsNCiAgICAgICAgIGNvbXBhdGlibGUgPSAic29sb21vbixzc2QxMzA3ZmItaTJjIjsN
CiAgICAgICAgIHJlZyA9IDwweDNjPjsNCiAgICAgICAgIHB3bXMgPSA8JnB3bSA0IDMwMDA+Ow0K
LSAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW8yIDc+Ow0KKyAgICAgICAgcmVzZXQtZ3Bpb3Mg
PSA8JmdwaW8yIDcgR1BJT19BQ1RJVkVfTE9XPjsNCiAgICAgICAgIHJlc2V0LWFjdGl2ZS1sb3c7
DQogfTsNCiANCkBAIC00Myw3ICs0NSw3IEBAIHNzZDEzMDY6IG9sZWRAM2Mgew0KICAgICAgICAg
Y29tcGF0aWJsZSA9ICJzb2xvbW9uLHNzZDEzMDZmYi1pMmMiOw0KICAgICAgICAgcmVnID0gPDB4
M2M+Ow0KICAgICAgICAgcHdtcyA9IDwmcHdtIDQgMzAwMD47DQotICAgICAgICByZXNldC1ncGlv
cyA9IDwmZ3BpbzIgNz47DQorICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbzIgNyBHUElPX0FD
VElWRV9MT1c+Ow0KICAgICAgICAgcmVzZXQtYWN0aXZlLWxvdzsNCiAgICAgICAgIHNvbG9tb24s
Y29tLWxycmVtYXA7DQogICAgICAgICBzb2xvbW9uLGNvbS1pbnZkaXI7DQotLSANCjIuMS40DQoN
Cg==
