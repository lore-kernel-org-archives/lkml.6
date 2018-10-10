Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A63C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D22C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="RErhgizn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D22C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJJQyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:54:49 -0400
Received: from mail-ve1eur01on0054.outbound.protection.outlook.com ([104.47.1.54]:51811
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeJJQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyiFXpEqaZKxBhUWfPLHCPWY3Za/9WJ5+VxVrXo6mSA=;
 b=RErhgiznZ/g3tEefLm6fXvWGC2+9QsOfZO1uYBVfUHBgSrnns1umFnnWvdBz47DCRGo1vKZwRQvzJWC2H05Y2JXtWpqmGAZktMWNFv2GC2D9bUxalr5QFvXzBZqx5YFiZV+NHR8baZqsth59Apm9MZIZt+NuLsa1Pu48f+gVLmE=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5194.eurprd04.prod.outlook.com (20.176.236.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Wed, 10 Oct 2018 09:33:24 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 09:33:24 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: =?utf-8?B?W1JDRsKgUEFUQ0ggdjIgMC8yXSBwd206IGlteDogQ29uZmlndXJlIG91dHB1?=
 =?utf-8?Q?t_to_GPIO_in_disabled_state?=
Thread-Topic: =?utf-8?B?W1JDRsKgUEFUQ0ggdjIgMC8yXSBwd206IGlteDogQ29uZmlndXJlIG91dHB1?=
 =?utf-8?Q?t_to_GPIO_in_disabled_state?=
Thread-Index: AQHUYHxKUm0cn2YUq0+TW9Ra0o8/BQ==
Date:   Wed, 10 Oct 2018 09:33:24 +0000
Message-ID: <1539163920-9442-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0078.eurprd03.prod.outlook.com
 (2603:10a6:803:50::49) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5194;6:2DdFMFWFJC7bZWNfNk+cg98OOlYkxWCCWq18hcYf8adR5lp0XY82jsQxvRjzFoR5QOx+BrTSsRk4cFUsJpMtzhmy+XF5ceLIKtN2oObML3jhrfbLkYBsKEHwxDceVxqI6Ykvhyy0mqYAP3HstRVJQ8tqacavUINXF2+C2nxCfRqE8jTKgqbJTbI5CbzgUHeFEMksy1nQfeaI69bPrBqlBxKqsvfieEHv0BDLAQJtnMUuhTduGqHgpJsiIqft8z2SEQHHRV0gTMK2vECcuDhHDyLBVkFueEhjMwBCyHZUuV7bnZXwm4JQFcWkaBjrp9kd/tnBpFAL48h4DpR2dINtCw76YVlZdSWxO3dOZJ/cvZXwoMdYcuLeO4vyCjPkuCNTDVa6lfTiybaDgvfTwnKQQlGE4XZMzdfFMG+XRk1ZR/4otfFoPZdF9z4Hrn4PR7CULvCqEj1rgRpIyRh+PAQk6w==;5:7JTmuKzXkBPLtyzlMaUkSgpczAk8Gon05TuG/MThbK3QMhU5zjbUpIjvnvpEMkDrHckPCqJUW7zCBTKYQ0ZWhiPugYSWywjvYuBmLHr++3JAOohsip5DC5sKXMsISkGpvUETlrsuDZCbOyu4hJg+T+g+aK7tQZkdvZaAcFFu6dc=;7:TpPLVhPfWaBbwKa57Dna/ktPlHc4p7yo+M5CPttH2WItIjsMYSbih0+JTVmdKGdiSORYYEJfTT6Rn0S7YzJaG2TjtKGWMXAzT8g6gDUke5S+8t6IQnSwKQhu4on07JYoOR4I0ztBaM81SCOYlgQauPlyBlS/VwGq9Sll8t1a+XjdT52bdLK8dFfTY4U0XLAomT5Kjve4PFrZkG8W045+KKO8ZxAynxtjKukP+GjjV7tjuw6J4hjfJolvfkfPcxWi
x-ms-office365-filtering-correlation-id: 1732ed47-89e4-42f9-4118-08d62e936ccf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5194;
x-ms-traffictypediagnostic: DB7PR04MB5194:
x-microsoft-antispam-prvs: <DB7PR04MB519476B2839F5218BBC773899EE00@DB7PR04MB5194.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DB7PR04MB5194;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5194;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39850400004)(189003)(199004)(6306002)(6436002)(26005)(186003)(6486002)(68736007)(6512007)(2900100001)(66066001)(2906002)(256004)(85182001)(5250100002)(97736004)(316002)(102836004)(14444005)(86362001)(81166006)(305945005)(54906003)(25786009)(107886003)(105586002)(36756003)(110136005)(71190400001)(476003)(7736002)(72206003)(966005)(478600001)(52116002)(4326008)(14454004)(71200400001)(53936002)(6116002)(3846002)(386003)(2616005)(106356001)(486006)(81156014)(8936002)(5660300001)(6506007)(99286004)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5194;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MUt/TAlv4pCfxs1yzGCbDC0u2gU89tc6TCj9Uo5RhKVbFj+iK58+kQetpZT5bhFFqykAwtQYgQpuUOd1pmh+PJtGASISS9knWgXNzRqzZBDD5CBOscPivLrhOV+x+wM0qY6tspNxayzCRhi58diIMWPdMjbhvQ5CNQQW9nJ6NvMjo9qQJx41Kn3KCMRczSTGCSmq6q802jOlAqsbubZnGf46N1N74rIM3RA+XgPsSOqgsbiFOPsZPb5hnk7Ts+Zdo1Cs1Fh94X4FuyvQZKhPDu2te5Np3spDrMmo1IUN7yt+pz9hIrmIYfkdY7CTcf+LX6GHyH3e1OSls3uJIQC/DGfj79rvG9TCp7uH3DiAJ7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A50B41DAFF1AD14F9064867B803F0D80@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1732ed47-89e4-42f9-4118-08d62e936ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 09:33:24.3228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBhbiBhdHRlbXB0IHRvIGRlYWwgd2l0aCBpLk1YIFNvQyBQV00gSFcgbGltaXRhdGlv
bi4NCldoZW4gYSBwYWQgaXMgY29uZmlndXJlZCBhcyBhIFBXTSBvdXRwdXQgdGhlIG91dHB1dCBs
ZXZlbCBpcyBhbHdheXMgMFYNCmlmIHRoZSBQV00gYmxvY2sgaXMgZGlzYWJsZWQuIFRoaXMgY2Fu
IGNhdXNlIHByb2JsZW1zIHdoZW4gaW52ZXJ0ZWQgUFdNDQpzaWduYWwgaXMgbmVlZGVkIHRvIGRy
aXZlIHRoZSBjb25uZWN0ZWQgY2lyY3VpdC4gV2l0aCBpbnZlcnRlZCBvdXRwdXQNCmR1dHkgY3lj
bGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIG91dHB1dCBsZXZlbCBhbmQgZHV0eSBjeWNsZSA9
IDEwMCUNCmNvcnJlc3BvbmRzIHRvIGxvdyBvdXRwdXQgbGV2ZWwuIFRoaXMgbWVhbnMgdGhhdCB3
aGVuZXZlciB0aGUgUFdNIGJsb2NrDQppcyBkaXNhYmxlZCB0aGUgY29ubmVjdGVkIGNpcmN1aXQg
aXMgZmVkIHdpdGggMTAwJSBkdXR5IGN5Y2xlLg0KDQpUaGlzIGlzc3VlIGhhcyBiZWVuIGRpc2N1
c3NlZCBpbiB2YXJpb3VzIHRocmVhZHMgYWJvdXQgaW52ZXJ0ZWQgUFdNDQpzdXBwb3J0IGltcGxl
bWVudGF0aW9uLiBGaW5hbGx5IHRoaXMgY29tbWl0IDMyNmVkMzE0ZmVmZSAoInB3bTogaW14Og0K
QWRkIHBvbGFyaXR5IGludmVyc2lvbiBzdXBwb3J0IHRvIGkuTVgncyBQV012MiIpIGZyb20gTHVr
YXN6IHdhcyBtZXJnZWQuDQoNCkxhdGVyIG9uIEZhYmlvIGNhbWUgdXAgd2l0aCB0aGUgc2FtZSBw
cm9ibGVtIGFzIEkgZGVzY3JpYmVkLg0KSGlzIGNvbW1pdCAxZjZlZWZlYjdjZDQgKCJwd206IGlt
eDogTGV0IFBXTSBiZSBhY3RpdmUgZHVyaW5nIHN1c3BlbmQiKQ0Kc29sdmVzIHRoZSBwcm9ibGVt
IG9ubHkgaW4gc3VzcGVuZCBzdGF0ZSBhbmQgbm90IHdoZW5ldmVyIFBXTSBpcyBkaXNhYmxlZC4N
Cg0KSW4gdGhlIGRpc2N1c3Npb24gRmFiaW8gYWxzbyBzdWdnZXN0ZWQgYSBwaW5jdHJsIHNvbHV0
aW9uIHRob3VnaCBpdCB3YXMNCnN0aWxsIG9ubHkgZm9yIHN1c3BlbmQgWzFdLg0KDQpJIHdvdWxk
IGxpa2UgdG8gYnJpbmcgYXR0ZW50aW9uIHRvIHRoYXQgcGluY3RybCBzb2x1dGlvbiBvbmNlIGFn
YWluLg0KVGhlIGNvZGUgaXMgYmFzaWNhbGx5IGEgY29weSBvZiB0aGUgSTJDIHJlY292ZXJ5IGZ1
bmN0aW9uIFsyXS4NCg0KVGhpcyBiaW5kaW5nIGlzIHRvdGFsbHkgb3B0aW9uYWwgYW5kIGN1cnJl
bnQgdXNlcnMgYXJlIG5vdCBhZmZlY3RlZC4NCg0KVGhlIGlkZWEgaXMgdG8gdXNlIHR3byBuZXcg
cGluY3RybCBzdGF0ZXMsICJwd20iIGFuZCAiZ3BpbyIsIGluc3RlYWQgb2YNCnRoZSAiZGVmYXVs
dCIgcGluY3RybCBzdGF0ZS4gVGhlIGdwaW8gc3RhdGUgaXMgc2VsZWN0ZWQgIHdoZW4gUFdNIGlz
DQpkaXNhYmxlZCBhbmQgdGhlIHB3bSBwaW5jdHJsIHN0YXRlIGlzIHNlbGVjdGVkIHdoZW4gUFdN
IGlzIGVuYWJsZWQuIEluIHRoZQ0KZ3BpbyBzdGF0ZSBsZXZlbCBvbiB0aGUgb3V0cHV0IGlzIGNv
bnRyb2xsZWQgYnkgYSBuZXcgcHdtLWdwaW9zIHNpZ25hbC4NCg0KTm90ZSB0aGF0IHRoZXJlIGlz
IG5vIGNvbmZsaWN0IHdpdGggdGhlICJkZWZhdWx0IiBwaW5jdHJsIHN0YXRlLiBZb3UgY2FuDQph
Y3R1YWxseSBkZWZpbmUgYWxsIHRoZSB0aHJlZSBzdGF0ZXMgYXQgdGhlIHNhbWUgdGltZS4gVGhl
IG9ubHkgZWZmZWN0IGlzDQp0aGF0IHRoZSBwaW5jdGwgZHJpdmVyIHdpbGwgY29uZmlndXJlIHRo
ZSBwaW5zIHRvIHRoZSBkZWZhdWx0IHBpbmN0cmwNCnN0YXRlIGFzIHVzdWFsLiBUaGVuIHdoZW4g
dGhlIGlteC1wd20gZHJpdmVyIGdldHMgY29udHJvbCBvZiB0aGUgSFcsIGl0DQpjb25maWd1cmVz
IHRoZSByaWdodCBwaW5jdHJsIHN0YXRlIGFjY29yZGluZyB0byB0aGUgUFdNIHN0YXRlLiBTbyB5
b3UgbWF5DQplbmQgdXAgd2l0aCBzb21lIGFkZGl0aW9uYWwgbGV2ZWwgY2hhbmdlcyBvbiB0aGUg
b3V0cHV0IGR1cmluZyBwcm9iZS4NCg0KV2hlbiBzd2l0Y2hpbmcgdGhlIHBpbmN0cmwgc3RhdGVz
IGl0IGlzIGltcG9ydGFudCB0byBkbyBpdCBpbiB0aGUgcmlnaHQNCm9yZGVyLiBXaGVuIGRpc2Fi
bGluZyBQV00sIGZpcnN0IHNldCB0aGUgR1BJTyBvdXRwdXQgdmFsdWUsIHRoZW4gY2hhbmdlDQp0
aGUgbXV4aW5nIGFuZCBhdCBsYXN0IGRpc2FibGUgdGhlIFBXTS4gQW5kIHZpY2UgdmVyc2EgdG8g
ZW5hYmxlIHRoZSBQV00NCm91dHB1dC4gT3RoZXJ3aXNlIHlvdSB3aWxsIGdldCB1bndhbnRlZCBs
ZXZlbCBjaGFuZ2VzIG9uIHRoZSBvdXRwdXQuDQoNCkkgd291bGQgbGlrZSB0byBrbm93IHlvdXIg
b3BpbmlvbiBvbiB0aGlzLCB0aGFua3MuDQoNCk1pY2hhbA0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wYXRjaC84Mzk4MzQvIzE4MTk4NjUNClsyXSBodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14
LmMjTDk4OQ0KDQpDaGFuZ2VzIGluIHYyOg0KIC0gRG8gbm90IHVzZSB0aGUgImRlZmF1bHQiIHBp
bmN0cmwgc3RhdGUgZm9yIEdQSU8uDQogLSBVc2UgZXh0cmEgInB3bSIgYW5kICJncGlvIiBwaW5j
dHJsIHN0YXRlcy4NCiAtIEFkZCBhIHB3bS1ncGlvcyBzaWduYWwgdG8gZHJpdmUgdGhlIG91dHB1
dCBpbiAiZ3BpbyIgcGluY3RybCBzdGF0ZS4NCiAtIFNlbGVjdCB0aGUgcmlnaHQgcGluY3RybCBz
dGF0ZSBpbiBwcm9iZS4NCg0KTWljaGFsIFZva8OhxI0gKDIpOg0KICBkdC1iaW5kaW5nczogcHdt
OiBpbXg6IEFsbG93IHN3aXRjaGluZyBQV00gb3V0cHV0IGJldHdlZW4gUFdNIGFuZCBHUElPDQog
IHB3bTogaW14OiBDb25maWd1cmUgb3V0cHV0IHRvIEdQSU8gaW4gZGlzYWJsZWQgc3RhdGUNCg0K
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50eHQgfCA1MSAr
KysrKysrKysrKysrKw0KIGRyaXZlcnMvcHdtL3B3bS1pbXguYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCA4NiArKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwg
MTM3IGluc2VydGlvbnMoKykNCg0KLS0gDQoyLjEuNA0KDQo=
