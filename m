Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D452EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E76214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="DGPWHULe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E76214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJJQyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:54:52 -0400
Received: from mail-ve1eur01on0054.outbound.protection.outlook.com ([104.47.1.54]:51811
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbeJJQyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZBObMQ2IWon78Fpzpunx5H9Dvea37PTFEJRFrsVKtc=;
 b=DGPWHULeugChSAg0KswjAq08lQr3rCpoCC0FGUGIJZz+AkHyADnudfnxXnbz2XXCFDgWBbJD0bkA46Zmof9lzu6B2HGrDpy574Z9O0ZWnyq2gIVOJKUEqrCCn+DQk8UAli56anQLh7SxyfcnSadx3H93TxiQsMzlIuFK1f7rLGg=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5194.eurprd04.prod.outlook.com (20.176.236.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Wed, 10 Oct 2018 09:33:25 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 09:33:25 +0000
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
Subject: =?utf-8?B?W1JDRsKgUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogcHdtOiBpbXg6IEFs?=
 =?utf-8?Q?low_switching_PWM_output_between_PWM_and_GPIO?=
Thread-Topic: =?utf-8?B?W1JDRsKgUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogcHdtOiBpbXg6IEFs?=
 =?utf-8?Q?low_switching_PWM_output_between_PWM_and_GPIO?=
Thread-Index: AQHUYHxLuuB1qoyy/USZ47x9z6qO2A==
Date:   Wed, 10 Oct 2018 09:33:25 +0000
Message-ID: <1539163920-9442-2-git-send-email-michal.vokac@ysoft.com>
References: <1539163920-9442-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1539163920-9442-1-git-send-email-michal.vokac@ysoft.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5194;6:OWIeuoPid7kTPbHLgQafGdzf88oTH9I4x7dyyAoZRFzB8gCEZF3qqU8oNFFqjdKtqItktreZYgrLG6C8d9tLROFEQd4yxiriRC7BcnPSk3VVK8cm/qWoZ2FmTR/1IKTpWz4IaX10VcY5GnK/NFgWepLFhj/MhxyOghSZewuqUdeiDi6WMNEHku7olY3upchqeGUd/eKEwEH4cXwaOvoHpu+DF6mwn1q1K/4uvnXMr+KfBhVUYQuCGs/1uTMtDNp0Ct83+NFjXE/a18DZlYbs05pfULHI5n5K2PRQiUH8tQKME4Mh45gK2Kg68hT42AbGbtrubaomdMabR8G40bgZybSFoRE+XGWA7YOdsfvI6jwqUb+6+AgFk0s+62d2cBxi9yBkugANn8jIAZRsFDf9WD+whSuE1yC4Qgap2VZ3ZlXzeCITimSGGOEyjeldkM3Y1fI2EbH9znUZ8ux78cj0lA==;5:vk5DpbBRYBz8mQPckdDSCxuH2p7zVVou2ekGCM4xbGI2Ci4aSGOQSAjD9lQSsRVkuQdy1aN5XUi2mvMehz6vdCeGvCRlBX+UwiBbJjtE7DVQOAthDLWBlEb621Uu7tVvA8oy0bPCFBoEf2LERfCsdiqwKrESzX5qXRzFYaqJ8Tw=;7:LFycflw3Ws0ZmIKhnYRp2eIwW8uVpqBkISvyEqkBXiCLWlEYq4lwojlxBu0NfxErR7A4SPwJpb8X+XGCCfb1fapDlTZpOJL1VdIlEdWw9I1MwcTAvkxeJX76q4ihUyh/cKA48ozF+SdGlCPXPnuvktd/ebxkPD954OlPBnTCMFt1/r1Sd6NV2jC8CAubnrvr0TWE2hKN/1EYd+ZlxdP2NkJqOFYGN5iLWzZHr51ldTDTdORm/2G1coa0YdkhjQlB
x-ms-office365-filtering-correlation-id: 9ebdadba-c79b-4045-64bc-08d62e936d6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5194;
x-ms-traffictypediagnostic: DB7PR04MB5194:
x-microsoft-antispam-prvs: <DB7PR04MB51948CF4276A1C9B115CA6829EE00@DB7PR04MB5194.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DB7PR04MB5194;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5194;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39850400004)(189003)(199004)(6436002)(26005)(186003)(6486002)(68736007)(6512007)(2900100001)(66066001)(2906002)(256004)(85182001)(5250100002)(97736004)(575784001)(316002)(102836004)(14444005)(86362001)(81166006)(305945005)(54906003)(25786009)(107886003)(105586002)(36756003)(110136005)(76176011)(71190400001)(476003)(7736002)(72206003)(478600001)(52116002)(4326008)(14454004)(71200400001)(53936002)(6116002)(3846002)(386003)(2616005)(106356001)(486006)(81156014)(8936002)(446003)(5660300001)(6506007)(11346002)(99286004)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5194;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hxN/y8HSZSJYpbL7S+hNiPCPR554aVPB2AJnOblMRr46c+M0NKEZ5Nj4OedygPPC0PGDMfmdMXXHfFE4Fv6neLUnZAIyQOQ5L2GtcDaXnsJe6raIO7EylxM49X+7rRFS16cXba9V8tPOrLmHvsx2jICUJtv+wbilQx5QmwoHE1kykg1cCmW3tcjHyCGEqchVN5GnimfOkhFbYWFT9D860Pt6vO5oneoU5VomUDzcKjO6RpVy5dlNVUQjNiQc0OLFGx4b4XFe7d7B7LdzG7rT05a0UhO4gQC/QDT18tIIzBmFxIaU3omkNSN9mdjVE3WowDutX6RTSWBY8V7fuQ6qcPxU16D8V65ONzwOulHfcI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6F6C2842899924CAC391AD19899271D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebdadba-c79b-4045-64bc-08d62e936d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 09:33:25.2805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3V0cHV0IG9mIHRoZSBQV00gYmxvY2sgb24gaS5NWCBTb0NzIGlzIGFsd2F5cyBsb3cgd2hlbiB0
aGUgYmxvY2sgaXMNCmRpc2FibGVkLiBUaGlzIGNhbiBjYXVzZSBpc3N1ZXMgd2hlbiBpbnZlcnRl
ZCBQV00gcG9sYXJpdHkgaXMgbmVlZGVkLg0KV2l0aCBpbnZlcnRlZCBwb2xhcml0eSBhIGR1dHkg
Y3ljbGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIGxldmVsIG9uDQp0aGUgb3V0cHV0LiBOb3cs
IHdoZW4gUFdNIGlzIGRpc2FibGVkIGl0cyBvdXRwdXQgaW5zdGFudGx5IGdvZXMgbG93DQp3aGlj
aCBjb3JyZXNwb25kcyB0byBkdXR5IGN5Y2xlID0gMTAwJS4NCg0KVG8gZ2V0IGEgdHJ1bHkgaW52
ZXJ0ZWQgUFdNIG91dHB1dCB0d28gcGluY3RybCBzdGF0ZXMgb2YgdGhlIFBXTSBwaW4NCmNhbiBi
ZSB1c2VkLiBDb25maWd1cmUgdGhlIHBpbiB0byBHUElPIGZ1bmN0aW9uIHdoZW4gUFdNIGlzIGRp
c2FibGVkDQphbmQgc3dpdGNoIGJhY2sgdG8gUFdNIGZ1bmN0aW9uIHdoZW5ldmVyIG5vbi16ZXJv
IGR1dHkgY3ljbGUgaXMgbmVlZGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8
bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0tLQ0KQ2hhbmdlcyBpbiB2MjoNCiAtIERvIG5vdCB1
c2UgdGhlICJkZWZhdWx0IiBwaW5jdHJsIHN0YXRlIGZvciBHUElPLg0KIC0gVXNlIHR3byBuZXcg
InB3bSIgYW5kICJncGlvIiBwaW5jdHJsIHN0YXRlcy4NCiAtIEFkZCBhIG5ldyBwd20tZ3Bpb3Mg
c2lnbmFsLg0KDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtcHdt
LnR4dCB8IDUxICsrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUxIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wd20vaW14LXB3bS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cHdtL2lteC1wd20udHh0DQppbmRleCBjNjFiZGY4Li5iZDViNmJkIDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtcHdtLnR4dA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtcHdtLnR4dA0KQEAgLTE0LDYg
KzE0LDE3IEBAIFNlZSB0aGUgY2xvY2sgY29uc3VtZXIgYmluZGluZywNCiAJRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdzLnR4dA0KIC0gaW50ZXJy
dXB0czogVGhlIGludGVycnVwdCBmb3IgdGhlIHB3bSBjb250cm9sbGVyDQogDQorT3B0aW9uYWwg
cHJvcGVydGllczoNCistIHBpbmN0cmw6IEZvciBpLk1YMjcgYW5kIG5ld2VyIFNvQ3MuIFVzZSAi
cHdtIiBhbmQgImdwaW8iIHNwZWNpZmljIHBpbmN0cmxzDQorICBpbnN0ZWFkIG9mIHRoZSAiZGVm
YXVsdCIgdG8gY29uZmlndXJlIHRoZSBQV00gcGluIHRvIEdQSU8gYW5kIFBXTSBmdW5jdGlvbi4N
CisgIEl0IGFsbG93cyBjb250cm9sIG92ZXIgdGhlIHBpbiBvdXRwdXQgbGV2ZWwgd2hlbiB0aGUg
UFdNIGJsb2NrIGlzIGRpc2FibGVkLg0KKyAgVGhpcyBpcyB1c2VmdWwgaWYgeW91IHVzZSB0aGUg
UFdNIGZvciBzaW5nbGUgcHVycG9zZSBhbmQgeW91IG5lZWQgaW52ZXJ0ZWQNCisgIHBvbGFyaXR5
IG9mIHRoZSBQV00gc2lnbmFsLiBTZWUgIkludmVydGVkIFBXTSBvdXRwdXQiIHNlY3Rpb24gYmVs
bG93Lg0KKy0gcHdtLWdwaW9zOiBTcGVjaWZ5IHRoZSBHUElPIHBpbiB0aGF0IHdpbGwgYWN0IGFz
IHRoZSBQV00gb3V0cHV0LiBUaGlzIHNob3VsZA0KKyAgYmUgdGhlIHNhbWUgcGluIGFzIGlzIHVz
ZWQgZm9yIG5vcm1hbCBQV00gb3V0cHV0LiBEZWZpbmUgdGhlIHBpbiBhcw0KKyAgR1BJT19BQ1RJ
VkVfTE9XIHRvIGdldCBISUdIIGxldmVsIG9uIHRoZSBvdXRwdXQgd2hlbiBQV00gaXMgZGlzYWJs
ZWQuIFNlZQ0KKyAgIkludmVydGVkIFBXTSBvdXRwdXQiIHNlY3Rpb24gYmVsbG93Lg0KKw0KIEV4
YW1wbGU6DQogDQogcHdtMTogcHdtQDUzZmI0MDAwIHsNCkBAIC0yNSwzICszNiw0MyBAQCBwd20x
OiBwd21ANTNmYjQwMDAgew0KIAljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCiAJaW50ZXJy
dXB0cyA9IDw2MT47DQogfTsNCisNCitJbnZlcnRlZCBQV00gb3V0cHV0DQorLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KKw0KK1RoZSBpLk1YwqBTb0MgaGFzIHN1Y2ggbGltaXRhdGlvbiB0aGF0IHdoZW5l
dmVyIGEgcGluIGlzIGNvbmZpZ3VyZWQgYXMgYSBQV00NCitvdXRwdXQsIHRoZSBvdXRwdXQgbGV2
ZWwgb24gdGhlIHBpbiBpcyBhbHdheXMgbG93IHdoZW4gdGhlIFBXTSBibG9jayBpcw0KK2Rpc2Fi
bGVkLiBUaGUgbG93IG91dHB1dCBsZXZlbCBpcyBhY3RpdmVseSBkcml2ZW4gYnkgdGhlIG91dHB1
dCBzdGFnZSBvZiB0aGUNCitQV00gYmxvY2sgYW5kIGNhbiBub3QgYmUgb3ZlcnJpZGRlbiBieSBw
dWxsLXVwLiBJdCBhbHNvIGRvZXMgbm90IG1hdHRlciB3aGF0DQorUFdNIHBvbGFyaXR5IGEgUFdN
IGNsaWVudCAoZS5nLiBiYWNrbGlnaHQpIHJlcXVlc3RlZC4NCisNCitUbyBnYWluIGNvbnRyb2wg
b2YgdGhlIG91dHB1dCBsZXZlbCBpbiBQV00gZGlzYWJsZWQgc3RhdGUgdHdvIHBpbmN0cmwgc3Rh
dGVzDQorY2FuIGJlIHVzZWQuIEEgImdwaW8iIHN0YXRlIGFuZCBhICJwd20iIHN0YXRlLiBJbiB0
aGUgZ3BpbyBzdGF0ZSB0aGUgcGluIGlzDQorY29uZmlndXJlZCBhcyBhIEdQSU8uIEluIHRoZSBw
d20gc3RhdGUgdGhlIHBpbiBpcyBjb25maWd1cmVkIGFzIGEgbm9ybWFsIFBXTQ0KK291dHB1dC4g
SW4gdGhlIGdwaW8gc3RhdGUgdGhlIG91dHB1dCBsZXZlbCBjYW4gYmUgY29udHJvbGxlZCBieSBh
Y3RpdmVseQ0KK2RyaXZpbmcgdGhlIG91dHB1dCBieSB0aGUgcHdtLWdwaW9zIHNpZ25hbC4gVGhp
cyBzZXR1cCBhc3N1cmVzIHRoYXQgdGhlIFBXTQ0KK291dHB1dCBpcyBhdCB0aGUgcmVxdWlyZWQg
bGV2ZWwgdGhhdCBjb3JyZXNwb25kcyB0byBkdXR5IGN5Y2xlID0gMCB3aGVuIFBXTQ0KK2lzIGRp
c2FibGVkLg0KKw0KK0V4YW1wbGU6DQorDQorJnB3bTEgew0KKwlwaW5jdHJsLW5hbWVzID0gInB3
bSIsICJncGlvIjsNCisJcGluY3RybC0wID0gPCZwaW5jdHJsX2JhY2tsaWdodF9wd20+Ow0KKwlw
aW5jdHJsLTEgPSA8JnBpbmN0cmxfYmFja2xpZ2h0X2dwaW8+Ow0KKwlwd20tZ3Bpb3MgPSA8Jmdw
aW8xIDkgR1BJT19BQ1RJVkVfTE9XPg0KK30NCisNCitwaW5jdHJsX2JhY2tsaWdodF9ncGlvOiBw
d20xZ3JwLWdwaW8gew0KKwlmc2wscGlucyA9IDwNCisJCS8qIEdQSU8gd2l0aCAxMDBrT2htIHB1
bGwtdXAgKi8NCisJCU1YNlFETF9QQURfR1BJT185X19HUElPMV9JTzA5CTB4YjAwMA0KKwk+Ow0K
K307DQorDQorcGluY3RybF9iYWNrbGlnaHRfcHdtOiBwd20xZ3JwLXB3bSB7DQorCWZzbCxwaW5z
ID0gPA0KKwkJLyogUFdNIG91dHB1dCAqLw0KKwkJTVg2UURMX1BBRF9HUElPXzlfX1BXTTFfT1VU
CTB4OA0KKwk+Ow0KK307DQotLSANCjIuMS40DQoNCg==
