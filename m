Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF5FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA53206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="JOZ6pwe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA53206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437831AbeKWCWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:22:13 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:19265
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437817AbeKWCWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmQOPdL09+vD+VZIDNx3PJ58ZmQC1UHuy0t01AaF/aM=;
 b=JOZ6pwe7Q1J9+8lSg7vhqG1LSwO1wdyEOPOw3s3J4selOBqhnUJVgIBIQ2NqLYy7W5mYTEvGyt0W+oYXV0Ciob4Kjrm83562MDe5HX5glIf7awMmP9uFYv6vdPqlWwJ5n3SzryoCtnT8lOOBhMaOzF7GkR/hMgHQbuZgsyA1lUU=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4697.eurprd04.prod.outlook.com (20.176.233.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 22 Nov 2018 15:42:14 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Thu, 22 Nov 2018
 15:42:14 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in disabled
 state
Thread-Topic: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Thread-Index: AQHUfX7SCRu1RfBnYE+mazOHv61qtqVSEQGAgAnn4AA=
Date:   Thu, 22 Nov 2018 15:42:14 +0000
Message-ID: <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
References: <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de> <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de> <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
In-Reply-To: <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0033.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::46) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4697;6:8W8qDQrfN5mmFy1VxmxNcu9Z24Qp3RLYqH5eQcfefMNhplk7yGwPlgoL9WaqoqWZieCJBYS4DkMTe22C/PXeVKQHJ2VKwabicHnHC0n0uK4V0YLltSljjqeGGSJOTXZQegMcrUDEsQw8xgjz/snC3gjPpG3dpr+yt/AA7+Do7vWTtBNr0YfNqecqD8I5dYtCaVsvIDnSrJBkWnIjuUryWMKq00ZaBRNMntJqJHcPTHcEv2zBO9TZN8RZ7flDrKFck1nd/Q2eI4kHpVJ2I4Bgswqu2H08q7B/6+KXqEj3j16ytGYLaSeWRJiFfcXL2JDkuNSHDlIVxD0TqWa+shHyu3rv6OIioyQbq+L1Tgw9BpCl/GU8i6PvaWIk3OiGyrghOG3Tl837zK+A0TQbvpMv4kd235g9yZOQ+MEo7C1BClK34HSwGC0LzsvwD7VA41tWWyBoSqUO3adVKDX2iUuVVQ==;5:qixSgryY4y5g48yLO4FDeiIw9gyvMjbH5idgQHjLbf1M/VXjJyZR7O7DGGi+vFDJcekpepo3dh4PHPnVZ+UDNf/22TwEaE0GOa+jfebmrtql4iPUoSF6TpfFBqkPKv1M4apWYB7huJg26zSzHp+lqZ1QreHwBf8V850XuPU9kfE=;7:kCIJrQo77laBXYH69xmcnMciNElWnI7ukp+aknDmqzv5tksvsrFuB0XmeAEra6NdF83xTp5CtCJ8Ng21yWmWqpNCB61yERBgNT0+6v1AGQl653I8Dmly+aX2ecSW2TXdThdzD+LnoGO1gKAfWX3Khg==
x-ms-office365-filtering-correlation-id: 5e796cf4-ed74-4943-20a0-08d650911319
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4697;
x-ms-traffictypediagnostic: DB7PR04MB4697:
x-microsoft-antispam-prvs: <DB7PR04MB4697B829F8A1E82521D98F6C9EDB0@DB7PR04MB4697.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4697;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4697;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(346002)(366004)(376002)(396003)(199004)(189003)(561944003)(6486002)(256004)(14454004)(14444005)(36756003)(6436002)(6512007)(39060400002)(66066001)(446003)(53936002)(478600001)(93886005)(68736007)(11346002)(476003)(2906002)(72206003)(229853002)(8936002)(6246003)(71190400001)(99286004)(2616005)(486006)(31686004)(86362001)(102836004)(52116002)(76176011)(97736004)(110136005)(7416002)(31696002)(316002)(186003)(7736002)(105586002)(5660300001)(25786009)(54906003)(85182001)(81166006)(26005)(2900100001)(4326008)(66574009)(106356001)(3846002)(305945005)(53546011)(71200400001)(6116002)(81156014)(386003)(6506007)(8676002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4697;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zJDEMdqBXenNV5geRWxo1Bz/2shJ/yBxX0OUN0cCMHc8KuMM/9iLoYLkwUBgUIuMHjfQgXkYJU/Y5plU87FJqkfN+nHKnc9jLG1mfVRkGfJ/hIW6mMbhxIBhq7/DslDuAj64RbfwuSqKY6wg5qny7aD9uqCYJok5zovYpX2yqe2FRM+yX602liPGu8LIgJWzVWrG7oQGpCjsZdH7A64wDDRoVUfKzRm/V9grGwlB93075FJ0pL3GWz0yzLDNR70aBnjt81Dj7uaXdA2jbCJMIcSOFRxEL3bWxguKKSYOOIOrrQsRn2EX1G97998KeYRHmMx320MmTfzgYqrqlsvVuYTh8y3aMa7oEyck4xLTaro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D2D7D36DFD5A41A8A8480CEEFC4355@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e796cf4-ed74-4943-20a0-08d650911319
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 15:42:14.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4697
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMTEuMjAxOCAwOToyNSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IE9uIEZyaSwg
Tm92IDE2LCAyMDE4IGF0IDA4OjM0OjMwQU0gKzAxMDAsIExvdGhhciBXYcOfbWFubiB3cm90ZToN
Cj4+IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdy
b3RlOg0KPj4+IE9uIFRodSwgTm92IDE1LCAyMDE4IGF0IDA0OjI1OjQ1UE0gKzAxMDAsIFRoaWVy
cnkgUmVkaW5nIHdyb3RlOg0KPj4+PiBPbiBXZWQsIE5vdiAxNCwgMjAxOCBhdCAxMDo1MToyMFBN
ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4+Pj4+IE9uIFdlZCwgTm92IDE0LCAy
MDE4IGF0IDEyOjM0OjQ5UE0gKzAxMDAsIFRoaWVycnkgUmVkaW5nIHdyb3RlOg0KPj4gWy4uLl0N
Cj4+Pj4+IEFsc28gZHRzIHdyaXRlcyBkb24ndCBuZWVkIHRvIGxvb2t1cCB0aGUgbmVlZGVkIEdQ
SU8gbnVtYmVycyBhbmQgcGluY3RybC4NCj4+Pj4NCj4+Pj4gSnVzdCB0byBjbGFyaWZ5OiBJIGRv
bid0IHRoaW5rIHRoYXQgd2UgbmVlZCB0byBnZXQgdGhlIEdQSU8gbnVtYmVyDQo+Pj4+IGludm9s
dmVkIGluIHRoaXMgY2FzZSwgYmVjYXVzZSB3ZSBkb24ndCBoYXZlIHRvIHJlY29uZmlndXJlIHRo
ZSBwaW4gYXMNCj4+Pj4gR1BJTyB0byBtYWtlIHRoaXMgd29yay4gVGhlIG9ubHkgcmVhc29uIHRo
YXQgTWljaGFsJ3MgcHJvcG9zYWwgZGlkIHRoYXQNCj4+Pj4gaXMgYmVjYXVzZSB0aGF0IHdhcyBi
ZWxpZXZlZCB0byBiZSBuZWNlc3NhcnkuIEJ1dCBpZiB0aGUgcGluIGNhbiBqdXN0IGJlDQo+Pj4+
IGNvbmZpZ3VyZWQgd2l0aCBhIDEwMGsgcHVsbC11cCwgdGhhdCdzIGVub3VnaCB0byBwdWxsIHRo
ZSBwaW4gaGlnaCB3aGVuDQo+Pj4+IHdlIG5lZWQgaXQuDQoNClRoaWVycnksIEkgaGF2ZSB0byBk
aXNhZ3JlZSBoZXJlLiBJIGRvIG5vdCByZWFsbHkga25vdyBob3cgdG8gYWN0aXZhdGUNCnRoZSBp
bnRlcm5hbCBwdWxsLXVwIHdpdGhvdXQgcmVxdWVzdGluZyB0aGUgR1BJTyBhbmQgY29uZmlndXJp
bmcgdGhlIHBpbg0KYXMgKmlucHV0Ki4gQW5kIHRvIGRvIGl0IHRoZSBHUElPIG51bWJlciBuZWVk
cyB0byBiZSBzcGVjaWZpZWQgaW4gRFQuDQoNCj4+PiBVbmxlc3MgdGhlIGdwaW8gaGFwcGVucyB0
byBiZSBjb25maWd1cmVkIGFzIG91dHB1dCBhdCB0aGUgd3JvbmcgdmFsdWUuDQo+Pj4gRnVydGhl
ciBJJ20gbm90IHN1cmUgaWYgdGhlIHB3bSBpbiBkaXNhYmxlZCBzdGF0ZSBhY3RpdmVseSBwdWxs
cyB0byAwDQo+Pj4gYW5kIGlmIGluIHRoaXMgc3RhdGUgdGhlIFBVIG9mIHRoZSBwaW4gaXMgZ29v
ZCBlbm91Z2ggdG8gZW5zdXJlIGEgb25lDQo+Pj4gaGVyZS4gVGhhdCB3b3VsZCBuZWVkIHZlcmlm
aWNhdGlvbiBmaXJzdC4NCj4+DQo+PiBOby4gWW91IGNhbiBkaXNhYmxlIHRoZSBvdXRwdXQgZHJp
dmVyIHZpYSBwaW5jdHJsLCBzbyB0aGF0IG9ubHkgdGhlDQo+PiBzZWxlY3RlZCBwdWxsLXVwL2Rv
d24gaXMgcmVsZXZhbnQuIFRoZSBwaW4gZnVuY3Rpb24gYW5kIEdQSU8gcmVnaXN0ZXINCj4+IHNl
dHRpbmdzIGRvbid0IG1hdHRlciBhdCBhbGwgaW4gdGhpcyBjYXNlLg0KDQpMb3RoYXIsIHBsZWFz
ZSBjYW4geW91IGJlIG1vcmUgc3BlY2lmaWMgaG93IHdvdWxkIHlvdSBkbyB0aGF0PyBJRkFJSyB0
aGUNCnB1bGwtdXAvZG93biBpbnRlcm5hbCByZXNpc3RvcnMgaGF2ZSBlZmZlY3Qgb25seSBpZiB0
aGUgcGluIGlzIGNvbmZpZ3VyZWQNCmFzIEdQSU8gKmlucHV0KiAob24gaS5NWDYgYXQgbGVhc3Qp
LiBTZWUgdGhlIFRSTSwgMjkuNC4yLjIgT3V0cHV0IGRyaXZlcjoNCg0KICAiSW50ZXJuYWwgcHVs
bC11cCwgcHVsbC1kb3duIHJlc2lzdG9ycywgYW5kIHBhZCBrZWVwZXIgYXJlIGRpc2FibGVkIGlu
DQogICBvdXRwdXQgbW9kZS4iDQoNCj4gSXMgdGhpcyBhYm91dCBEU0U9SEktWiBpbiB0aGUgcGFk
IGNvbnRyb2wgcmVnaXN0ZXI/IEkgZGlkbid0IGtub3cgYWJvdXQNCj4gdGhpcy4gSSBzZWUgdGhp
cyBleGlzdHMgb24gaS5NWDYgYnV0IG5vdCBvbiBpLk1YMjUuIEFsc28gaS5NWDUxIGRvZXNuJ3QN
Cj4gc2VlbSB0byBoYXZlIHRoaXMgZmVhdHVyZS4NCg0KVXdlLCBJIGFsc28gZGlkIG5vdCBmaW5k
IHRoZSBEU0Ugb3B0aW9uIG9uIG90aGVyIFNvQ3MgaW4gdGhlaXIgcmVzcGVjdGl2ZQ0KbWFudWFs
cyBhbmQgc291cmNlIGNvZGUuIEJ1dCBldmVuIGlmIGl0IHdvdWxkIGJlIGF2YWlsYWJsZSBvbiBh
bGwgU29Dcw0KSSBzdGlsbCB0aGluayBpdCBpcyBub3QgZW5vdWdoLg0KDQpCZXN0IHJlZ2FyZHMs
DQpNaWNoYWwNCg==
