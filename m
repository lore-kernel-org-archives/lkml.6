Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A2DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF0F2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QcQItYAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbfBOB4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:56:08 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:29921
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbfBOB4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDXe5sjjSWy/Nq5X62rbjAW81BvmWzneEJIALpTgIkU=;
 b=QcQItYAnGOouSWR+jywsL1QelzUKJEQuohp5aspppGKDfyPfozIRauORnrWYbJqSKdLfvyqZAD6qJmRWJcc3rYmxN+IPKdL/pD8Jtj1RDhUo1pboFg7vwRtT2GniIVC05LDfXiAKEUhG8QWp14A93n1InqDKsJYNlaZ9Ddk1MWI=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5999.eurprd04.prod.outlook.com (20.178.123.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 15 Feb 2019 01:56:00 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2%3]) with mapi id 15.20.1622.016; Fri, 15 Feb 2019
 01:56:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Rob Herring <robh@kernel.org>, Pawel Laszczak <pawell@cadence.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v3 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHUuVuTTBictDdkIUWlx3XxVyykfaXeadCAgAB69ICAAIPpAIAAxk7Q
Date:   Fri, 15 Feb 2019 01:56:00 +0000
Message-ID: <VI1PR04MB5327FF74C68A00D84C337DD58B600@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-2-git-send-email-pawell@cadence.com>
 <20190213224841.GA9319@bogus>
 <BYAPR07MB4709EA63F1374EA24E23C186DD670@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL_Jsq+wqtY=B1jKKxjFxnBMy_kiN9=MhHdMp=bEPa9wFo1NqQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+wqtY=B1jKKxjFxnBMy_kiN9=MhHdMp=bEPa9wFo1NqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9904ca15-f63e-42c4-b36c-08d692e8bbe6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5999;
x-ms-traffictypediagnostic: VI1PR04MB5999:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1OTk5OzIzOnVUMnNrK0ErZXh0Vnk5RUJYQm02Yzh5WU9l?=
 =?utf-8?B?RDZ2M0c0TC9LeFdlN21POHc4OFozSC9wQWJhZUNISVNTNFd3bitBcHQrMEp1?=
 =?utf-8?B?WGNIaUg3UnVVbkQ1eVF0dDRyQnJNazhRRE5EbGY2c3pvMWJjRHkydDVhUXVR?=
 =?utf-8?B?dHdCQjExQTNsQmwyV29WaGhtazhLVTI2TEpnTUxpZzdHRG03U3ZKSk1EelNp?=
 =?utf-8?B?amdOUG4zV0RKMXVmQldIUVlPRGNQa01qWTJCb1RhSjNLWWFuRGFjQU13ekxt?=
 =?utf-8?B?eVNzWm0zYStYOTM1WmRtK3ZWNG1HZFpEai9ub3ladG9sclFjckZicExQOHhT?=
 =?utf-8?B?U0F6akQwcDh5ZWdYdUxMNlZvMWV1cHBsL3JuNzJzeDNoTVloc0pXYVdTN0tC?=
 =?utf-8?B?L1lHSytKaURzcVBpdVpQcnF5K2dYN2oxQkRzd2tkUlZBaDFOSW9IVnZqRGlI?=
 =?utf-8?B?d2MvVklTNDZZOUZXRWZYcm1iNno1UFVuOVJCS0ZxS2hWS2lLc0F5RW5HK0Zr?=
 =?utf-8?B?VE1KN3RiSVM1cWxRa3d1UzY0MTgybmc3ck4ySmZNQVZrY2w3L1JhdGxRa0c3?=
 =?utf-8?B?RXJQbnNJdnJvZ1ZNWHN4R25QMWZlYmkySGFPWC9JU1dLUjFJYkw4cUtOTFV0?=
 =?utf-8?B?RVIydnNzanlvN2tLcWJQa3pVL0NZb2lZVlZtOFpRUXR0b0d6Mmpjd0E5dWtG?=
 =?utf-8?B?Wis5WUJ3Mjk1L0k0QWN0TFpEM29lOW1qcWFhNUJsT0JvdHBQUGRUK1Ivb3U4?=
 =?utf-8?B?VFJVWWpDQnVhcjE2QnMyRDNVcXlMTUt6VGltMk1RMVZZUkVrRVhOSEl4ZnYr?=
 =?utf-8?B?THd2aTZwclZFVWFlL3Z5ZXJ3czRmWlJ1QkU1OU05cXd4STNxb0xNQXJNWTQ5?=
 =?utf-8?B?dWNGaG5iT0Y2bmM1L1REb1NTT0h6cHNqTjdZZy9XbEhmelpJZER2am5RSFRu?=
 =?utf-8?B?a2o2dG90bW0zWjJaUlZpdWhCalJtTGVzdXVjMXpJS0ZLc1FBZkQzQTkySmor?=
 =?utf-8?B?WTFWQ3RQOTNIMkJsUmI5VlB2T2YrMnNSaWgzTTNtS2E4MEFMc0dLRU9OUWNr?=
 =?utf-8?B?WitZRm5KdmozclczRGFrZ2twY3ozTEZ2M0xUTWN3UndFYitscEJ4bXg1amJp?=
 =?utf-8?B?cEorRjhrZFhSTUVYeE9vZ3hibGFlTU9wMmZVZVI0Z2FNV3NCalgyckZGQUgy?=
 =?utf-8?B?MDZyL1FhdE5uSTRBektBUHl0SVdHRndNeGVyWldQKzYwcjdsUG1aODJsM0Vp?=
 =?utf-8?B?UFZVSG5jeXA0Z08wc2ZmSnNqN1AxS3VxNmlXNTkrd09sYTNmMnNCUmcxTU1r?=
 =?utf-8?B?a0l4dmRGRHQ0UFErN09OaGpIaUVMa0VTZTVFWjEvdEsvOVl2TTlXTFd2eC9P?=
 =?utf-8?B?bUIvLzVFbmZQcU1LTXVzS3VDamF4d096YjM2OEk0SzRSTzRFOVcyUmhHaE1t?=
 =?utf-8?B?Z213V04xSmtXWDJSWWo4RWcvMnVJTDIxazBpUmErYkFKNFVkNXVUOCtlZWg1?=
 =?utf-8?B?RW9VMkh5aEdBWXVSY053bDFyVHMzZVBXNElKRHo4QXc4blg3OWJFNW82a1RX?=
 =?utf-8?B?T04vYzFyU2Zrd1FLYlpOVGpnaHhFdE4xVFJTcHhYdmxYZjRveTB4Mms0ZDNG?=
 =?utf-8?B?cjJTRVQ4em5yQ2VXVUpBdHNwOHBpVGo4SWovNlJDRXVKU01TRWZJU3BBPT0=?=
x-microsoft-antispam-prvs: <VI1PR04MB5999EF9343555FD158CD17B58B600@VI1PR04MB5999.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(55016002)(3846002)(76176011)(478600001)(6116002)(6506007)(7736002)(7696005)(256004)(229853002)(9686003)(6436002)(68736007)(74316002)(99286004)(14454004)(316002)(54906003)(6246003)(53936002)(305945005)(33656002)(110136005)(8676002)(186003)(44832011)(4326008)(93886005)(81156014)(25786009)(8936002)(66066001)(7416002)(86362001)(486006)(106356001)(26005)(476003)(446003)(71200400001)(71190400001)(105586002)(2906002)(102836004)(97736004)(11346002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5999;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b5XmPKqKOQh5PGZbeK/tC+Kb0PPnJfnmYzlNt3HSvOV1JMcg91pzwCNdBokOSx9GIzIMo6uw05P7CTzDnnFIFMYPxG9cnM7h21DyyAFfxKxG8COWXNjTH4HQTxGuBs+i6Nh2dqQdNZIeyc2mgFm8H3CbyAET6JFUDSyLXz8iLeD+/5ftaXpUZt9BP5reMihb0uyqxARmCD0g/ialumm5MAI/5ZFhWAIGndCQ119xYKNlwDSVv/tZcU1pc3/pABLT2vOYbeE8uFfU9cB0N1xCwAJJ0YE5QjMlxt+/Y0hx71Tih8v9H4YJc41ZPfEPAPm2XBCmMibvcDuelxVRrC+Z6UbtcrT3ylcqhBEvYgIoG2WeeOAYh5cwPqWy9dneASLKsAMPh0jmPe6MbqOTSUwolVqaBdF01Sa7waKevT1CHrw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9904ca15-f63e-42c4-b36c-08d692e8bbe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 01:56:00.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+DQo+ID4gSGkgUm9iLA0KPiA+ID5PbiBUaHUsIEphbiAzMSwgMjAxOSBhdCAxMTo1Mjoy
OEFNICswMDAwLCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4gPiA+PiBUaGlzIHBhdGNoIGFpbSBh
dCBkb2N1bWVudGluZyBVU0IgcmVsYXRlZCBkdC1iaW5kaW5ncyBmb3IgdGhlDQo+ID4gPj4gQ2Fk
ZW5jZSBVU0JTUy1EUkQgY29udHJvbGxlci4NCj4gPiA+Pg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6
IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+ID4gPj4gLS0tDQo+ID4gPj4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jZG5zLXVzYjMudHh0ICAgICB8IDMzICsrKysr
KysrKysrKysrKysrKysNCj4gPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykN
Cj4gPiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9jZG5zLXVzYjMudHh0DQo+ID4gPj4NCj4gPiA+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jZG5zLXVzYjMudHh0DQo+
ID4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NkbnMtdXNiMy50
eHQNCj4gPiA+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uNmRjMzhiZTc3ZjVjDQo+ID4gPj4gLS0tIC9kZXYvbnVsbA0KPiA+ID4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvY2Rucy11c2IzLnR4dA0KPiA+ID4+IEBA
IC0wLDAgKzEsMzMgQEANCj4gPiA+PiArQmluZGluZyBmb3IgdGhlIENhZGVuY2UgVVNCU1MtRFJE
IGNvbnRyb2xsZXINCj4gPiA+PiArDQo+ID4gPj4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
Pj4gKyAgLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgc2l6ZSBvZiB0aGUgY29udHJv
bGxlcidzIHJlZ2lzdGVyIGFyZWFzLg0KPiA+ID4+ICsgICAgIENvbnRyb2xsZXIgaGFzIDMgZGlm
ZmVyZW50IHJlZ2lvbnM6DQo+ID4gPj4gKyAgICAgcmVnaW9uIDEgLSBIT1NUIHJlZ2lzdGVycyBh
cmVhDQo+ID4gPj4gKyAgICAgcmVnaW9uIDIgLSBERVZJQ0UgcmVnaXN0ZXJzIGFyZWENCj4gPiA+
PiArICAgICByZWdpb24gMyAtIE9URy9EUkQgcmVnaXN0ZXJzIGFyZWENCj4gPiA+PiArICAtIHJl
Zy1uYW1lcyAtIHJlZ2lzdGVyIG1lbW9yeSBhcmVhIG5hbWVzOg0KPiA+ID4+ICsgICAgInhoY2ki
IC0gZm9yIEhPU1QgcmVnaXN0ZXJzIHNwYWNlDQo+ID4gPj4gKyAgICAiZGV2IiAtIGZvciBERVZJ
Q0UgcmVnaXN0ZXJzIHNwYWNlDQo+ID4gPj4gKyAgICAib3RnIiAtIGZvciBPVEcvRFJEIHJlZ2lz
dGVycyBzcGFjZQ0KPiA+ID4+ICsgIC0gY29tcGF0aWJsZTogU2hvdWxkIGNvbnRhaW46ICJjZG5z
LHVzYjMtMS4wLjAiIG9yICJjZG5zLHVzYjMtMS4wLjEiDQo+ID4gPj4gKyAgLSBpbnRlcnJ1cHRz
OiBJbnRlcnJ1cHQgc3BlY2lmaWVyLiBSZWZlciB0byBpbnRlcnJ1cHQgYmluZGluZ3MuDQo+ID4g
Pj4gKyAgICAgICAgICAgIERyaXZlciBzdXBwb3J0cyBvbmx5IHNpbmdsZSBpbnRlcnJ1cHQgbGlu
ZS4NCj4gPiA+DQo+ID4gPkRyaXZlciBzdXBwb3J0cyBvciBoL3cgb25seSBoYXMgMSBpbnRlcnJ1
cHQ/DQo+ID4NCj4gPiBoL3cgaW50ZXJuYWxseSBoYXMgMyBzZXBhcmF0ZSBpbnRlcnJ1cHQgbGlu
ZSwgYnV0IGluIG15IHRlc3RpbmcgYm9hcmQNCj4gPiB0aGV5IGFyZSBvcmVkLiBTbyBwaHlzaWNh
bGx5IGRyaXZlciBzZWVzIG9ubHkgb25lIGgvdyBpbnRlcnJ1cHQgbGluZQ0KPiA+IGFuZCBhc3N1
bWVzIHRoYXQgaC93IGhhcyBzaW5nbGUgY29tbW9uIGludGVycnVwdCBsaW5lLg0KPiANCj4gSWYg
aXQgaXMgcG9zc2libGUgZm9yIG90aGVycyB0byBoYXZlIDMgc2VwYXJhdGUgbGluZXMgdGhlbiB5
b3Ugc2hvdWxkIGhhdmUgMy4gSnVzdA0KPiByZXBlYXQgdGhlIGNvbm5lY3Rpb24gMyB0aW1lcy4g
T3IgdGhlIGJpbmRpbmcgY2FuIHN1cHBvcnQNCj4gMSBvciAzIGludGVycnVwdHMgYmFzZWQgb24g
dGhlIGgvdy4gRWl0aGVyIHdheSBpdCdzIG5vdCBhYm91dCB3aGF0IHRoZSBkcml2ZXINCj4gc3Vw
cG9ydHMsIGJ1dCB3aGF0IHRoZSBoL3cgbG9va3MgbGlrZS4NCj4gDQogDQpGcm9tIElQIGxldmVs
LCBpdCBoYXMgdGhyZWUgaW50ZXJydXB0IHNvdXJjZXMgZm9yICJvdGciLCAiaG9zdCIgYW5kICJk
ZXZpY2UiLiBCdXQgZnJvbQ0KU29DIGxldmVsLCBpdCB1c3VhbGx5IG9ubHkgaGFzIG9uZSBVU0Ig
aW50ZXJydXB0IGxpbmUsIHRoZSBkZXZpY2UgZHJpdmVyIGludGVybmFsIGNvbnRyb2xzDQphbmQg
a25vd3Mgd2hpY2ggc291cmNlcyBmcm9tIFVTQiBjb250cm9sbGVyLg0KDQpQZXRlcg0K
