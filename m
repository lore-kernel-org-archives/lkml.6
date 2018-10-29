Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE14C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0562082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="lIeLWo9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0562082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJ3ApI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:45:08 -0400
Received: from mail-ve1eur01on0046.outbound.protection.outlook.com ([104.47.1.46]:48192
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbeJ3ApH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9oBioZd8AtfbGt/V/uwDsC9gMX3Ph0G0uiyHyu/uUs=;
 b=lIeLWo9yJShRJCYs2K+yxw6phfKE8CEOTxl/Ff4tpQVpFIhOn4RU3KWzaRzINhc6oMTLxkCADc1IMphJxBd/VFPg06sRWNt/rsXHEK8ZXRhKh1RZAmcBlASFSI3u92lvJlW7scgT/sQBp0ZuTgRsLIImeTlfxesq/nKlv1Ax0pc=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5034.eurprd04.prod.outlook.com (20.176.234.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Mon, 29 Oct 2018 15:55:12 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 15:55:12 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Subject: =?utf-8?B?UmU6IFtSQ0bCoFBBVENILHYyLDIvMl0gcHdtOiBpbXg6IENvbmZpZ3VyZSBv?=
 =?utf-8?Q?utput_to_GPIO_in_disabled_state?=
Thread-Topic: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8yXSBwd206IGlteDogQ29uZmlndXJlIG91dHB1?=
 =?utf-8?Q?t_to_GPIO_in_disabled_state?=
Thread-Index: AQHUYgmcdqbPphssxk6nsYPZEg3OjqUb10cA///wZACAA2w0gIAAzsqAgBZ4zgA=
Date:   Mon, 29 Oct 2018 15:55:12 +0000
Message-ID: <05f8c6b8-1952-6869-f659-535f04e99b2a@ysoft.com>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <20181014202457.dohwgz3frgcpdpy6@pengutronix.de>
 <20181015084505.GA12357@ulmo>
In-Reply-To: <20181015084505.GA12357@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0036.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::49) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5034;6:Ulz9pua8jfSX9Y3kZiJAe2sUEa6QK0K7QGXI1E8qxjvmrZ0iVzLKSGYHZu2CbCxUHzQKyGWhAJAvs25tsHUqjxqJZg4O88VoUeyLnkIog2nzvSwdYr5GM5J33pTdwv6L3YwZzGnlGe8xo1VsYmqz2W58WkbvmTQ62UtSoRW7lqqYcMiRXDDkRDV0M4qG5i+nAD5nZkcaN/kYCVWn7RiNC1haFm6Pum0Xzk0BA7j3zlLOoPuTFC4B957W2R8uzAGp2UkMB0afAVTteYzWtrmD8NDiYuf8W0Z+P3+4lWazBflGIpYkM6nkQkhk3Q6A/5ei4zDjFKKvQl38ETqiT23XNxqn7k+BEO39w/Lg8mSgzKwHdGtEePOtlklA/sJt4Kipf3biA99bG6sT3cZKXJ+qym2JzDHWRXqVuyHgps2W22CSUU2k4eO5h7QPBCa2BbFe+mLPgezVxEU7mH0h409i2g==;5:tYt1YkNrYQU9M3sZQULpxts/M7SSPPahOE9/lzIodSV9ivgGIifxflhblzMrjfsNCOiFK/uWbaj4gADkYP4rLVatdOXR3s3GaHBO6MB/z2EfMQ9cYRmyTL54bxQ6sWTf6DjUoIfmSYwIfnPf8afv9dZbdS9IAtGPrspkErxskuo=;7:qawPfMnSrNZFdzMPE53IF9NrGHpaWseKt8yZqj36zB56poHd27z7yWuO0Y7nqswQ3EaJxUUpbyGkl+RA7fmtCxCvnlEpZKe9xC8op5judMJiOpmffOoloBHdjpiNdxhBIk2YMotCMuyEhAHkuJhSzw==
x-ms-office365-filtering-correlation-id: be6ce25a-f39f-49db-588b-08d63db6e8c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5034;
x-ms-traffictypediagnostic: DB7PR04MB5034:
x-microsoft-antispam-prvs: <DB7PR04MB503440A50D03383132A28CE19EF30@DB7PR04MB5034.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5034;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5034;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39850400004)(396003)(366004)(376002)(189003)(199004)(256004)(2900100001)(99286004)(31696002)(66574009)(53936002)(52116002)(102836004)(2906002)(6436002)(71200400001)(71190400001)(36756003)(66066001)(86362001)(6306002)(5660300001)(229853002)(85182001)(97736004)(6512007)(6486002)(345774005)(6246003)(3846002)(110136005)(93886005)(54906003)(39060400002)(4326008)(486006)(68736007)(305945005)(5250100002)(476003)(2616005)(7416002)(11346002)(446003)(7736002)(81166006)(8936002)(6116002)(186003)(106356001)(26005)(478600001)(14454004)(25786009)(105586002)(316002)(76176011)(966005)(386003)(6506007)(31686004)(53546011)(81156014)(72206003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5034;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VXv4w2ave1dW8u8ngnDlAz9nIQCG5YFpJjBDjhJVlQMDKwm+Fx+R5mEQKSn5uFjy58RoVTW0BxwXYeUStwfJYk5Sf7vDiOH6ovKhIHBOQfv52VFhKss+GTCW/jiN7wKxfqqnmsnHB8CC6isoaVCplSMgKD6RAZBR4VUM3gfBXBjp2Y/0drasqQ/EvB2zYyZ5A3btiEjnzjpd9jMu/eNcGX8wol5elKwr9wUYMx0F8Z5uJEpFi3q1Kg2ZoIzCwhtRtSJChhfKNDN0CmCoNFysegqrov9mflOUjgwn+OE/N/tFeSnl14rCihgwdTUx7T4FkZKgCWU2I9kPqDBeqeCof5RANMbUCrQsjXGlRm06YKU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BB8DD6F3C77CE408C8901D63F1794D7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6ce25a-f39f-49db-588b-08d63db6e8c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 15:55:12.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMTAuMjAxOCAxMDo0NSwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6DQo+IE9uIFN1biwgT2N0
IDE0LCAyMDE4IGF0IDEwOjI0OjU3UE0gKzAyMDAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0K
Pj4gSGVsbG8sDQo+Pg0KPj4gT24gRnJpLCBPY3QgMTIsIDIwMTggYXQgMDY6MDg6NTRQTSArMDIw
MCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+Pj4+Pj4gKwlpZiAoUFRSX0VSUihpbXhfY2hp
cC0+cHdtX2dwaW9kKSA9PSAtRVBST0JFX0RFRkVSKSB7DQo+Pj4+Pg0KPj4+Pj4gWW91IG11c3Qg
bm90IHVzZSBQVFJfRVJSIG9uIGEgdmFsdWUgdGhhdCBtaWdodCBub3QgY29udGFpbiBhbiBlcnJv
cg0KPj4+Pj4gcG9pbnRlci4NCj4+Pj4NCj4+Pj4gT0ssIHRoYW5rIHlvdSBmb3IgdmFsdWFibGUg
aW5mby4NCj4+Pj4gU28gaXQgc2VlbXMgbGlrZSB0aGUgSTJDIGZvbGtzIGFyZSBpbiB0cm91Ymxl
cyBhcyB3ZWxsOg0KPj4+Pg0KPj4+PiAJaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
bGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jI0w5OTYNCj4+Pg0KPj4+
IGNvcnJlY3QuIEkgY2Fubm90IGZpbmQgdGhpcyBkb2N1bWVudGVkIHRob3VnaC4NCj4+DQo+PiBJ
IGZvdW5kIGluIExERDNbMV0sIGNoYXB0ZXIgMTEgb24gcGFnZSAyOTU6DQo+Pg0KPj4gCUlmIHlv
dSBuZWVkIHRoZSBhY3R1YWwgZXJyb3IgY29kZSwgaXQgY2FuIGJlIGV4dHJhY3RlZCB3aXRoOg0K
Pj4NCj4+IAkJbG9uZyBQVFJfRVJSKGNvbnN0IHZvaWQgKnB0cik7DQo+Pg0KPj4gCVlvdSBzaG91
bGQgdXNlIFBUUl9FUlIgb25seSBvbiBhIHZhbHVlIGZvciB3aGljaCBJU19FUlIgcmV0dXJucyBh
IHRydWUNCj4+IAl2YWx1ZTsgYW55IG90aGVyIHZhbHVlIGlzIGEgdmFsaWQgcG9pbnRlci4NCj4+
DQo+PiBUaGF0IGlzIHByb2JhYmx5IHdoZXJlIEkgaGF2ZSBteSBjbGFpbSBmcm9tLiBUaGVyZSBp
cyBubyBmdXJ0aGVyDQo+PiBleHBsYW5hdGlvbiB0aG91Z2gsIHNvIEknbGwgcG9zdCBhIHBhdGNo
IGFkZGluZyBhIGNvbW1lbnQgdG8gdGhlDQo+PiBkZWZpbml0aW9uIG9mIFBUUl9FUlIgdG8gZmlu
ZCBvdXQgaWYgdGhlcmUgaXMgYSByZWxldmFudCByZWFzb24uDQoNClRoYW5rcyBmb3IgbWVudGlv
bmluZyB0aGUgTEREMyBVd2UuIEkgYWxtb3N0IGZvcmdvdCBpdCBleGlzdC4NCkkgd2lsbCBkdXN0
LW9mZiBteSBlbGVjdHJvbmljIGNvcHkgOykNCg0KPiBNaWNoYWwncyBjb2RlIGFib3ZlIGRvZXMg
YW4gaW1wbGljaXQgSVNfRVJSKCkgYnkgY29tcGFyaW5nIHRvIGFuIGFjdHVhbA0KPiBlcnJvciBj
b2RlLiBJdCdzIGNlcnRhaW5seSB0cnVlIHRoYXQgUFRSX0VSUigpIG9uIGFueSBwb2ludGVyIGFu
ZCB0aGVuDQo+IHVzaW5nIHRoYXQgdmFsdWUgY2FuIGJlIHJpc2t5IGJlY2F1c2UgaXQgbWF5IG5v
dCBhY3R1YWxseSBiZSBhbiBlcnJvci4NCj4gU28gaWYgeW91IGdvIGFuZCB1bmNvbmRpdGlvbmFs
bHkgcHJpbnQgdGhhdCBlcnJvciBjb2RlIGV2ZW4gaWYgaXQgaXNuJ3QNCj4gYW4gZXJyb3IgYnV0
IGEgdmFsaWQgcG9pbnRlciwgeW91J3ZlIGxlYWtlZCBhIGtlcm5lbCBhZGRyZXNzLg0KPiANCj4g
SG93ZXZlciwgaXQncyBwZXJmZWN0bHkgc2FmZSB0byB1c2UgUFRSX0VSUihwdHIpID09IC1FUFJP
QkVfREVGRVIgKG9yDQo+IGZvciBhbnkgb3RoZXIgZXJyb3IgY29kZSBmb3IgdGhhdCBtYXR0ZXIp
Lg0KDQpPSywgSSB3aWxsIGxlYXZlIHRoYXQgYXMgaXMuIEFuZCB0aGFua3MgZm9yIGFsbCB0aGUg
ZGV0YWlscy4NCkkgYWx3YXlzIGxlYXJuIHNvbWV0aGluZyBuZXcgZnJvbSB0aGUgY29tbWVudHMh
DQoNCk1pY2hhbA0K
