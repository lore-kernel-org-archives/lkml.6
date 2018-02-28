Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832006-2-1159976609768636474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  RCVD_IN_SORBS_WEB 1.5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RO'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832006; b=hTzw5bNuQmG7luyQkXEKJYQH6bUrnv79hMQ3/Wei4ncvG+w
    JSIZJbzmarRNdk5ULIRLDK8P/WSv7MNjPR1Z9yXM8vYl61OQOS/m+m+2+5hifRD6
    jQVkxdXjrLM7V9CKJizf+3QdQ2b7h8f4RD+i4wW5Z+uxv2jBg/JceNslCIKuXDMh
    1O7xmnU5C74D66Q9YQDqyFMerhuFF9tp0G/CgX7ng2DKrZ8ZqSMMWs7ZfLJ1ltO1
    1BIVjbro/FBWd72G7b0C+l5ely05NJf5e6OcN498cK26ZQk5W/207p9YQls/M94q
    16AF3ggKXdlHnpfFJXl4tN3vbmpHluHs7f/RHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1519832006; bh=gYE3cp
    QCaE+75IMQMJQ/j6rbBu3O4fqz1G3IsZV8dTo=; b=vfDBNZL8u/iNRg/dmZuNtb
    ChGFeax89QUsLUA6/Lm56k3iZvtmsDPOhlNTkk4mMfuST+o3vljTT1FZzjljM1dG
    xLy5VBdNXvNjUGeJWLPgF5DDBXXr6G/J703qW8Slh/k18ObNZPUDAALO5XXUNZB/
    zVmB/3JXIXq2HV/0G4ahpbfa0y9B1C9NBESt3Bvrz3KyfbfhenF9Q50V4MM3+ZGI
    8sPOwBFv/N+dIwpjzxNmi1M3gDWnI0mf6slmOVK24Cb4u15I9B4rjc2KN7WytAe1
    WRnPJUf66lSO9bEJJ1zviUBGh0/0d7UBqpVXcTsDDPqu+62fYHb0zG/E/TlPD4wg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=jgLygrKD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=jgLygrKD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeB1PdL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:33:11 -0500
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:3344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932439AbeB1PdI (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Feb 2018 10:33:08 -0500
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>
Subject: RE: [PATCH 4.9 09/66] KVM: arm/arm64: Check pagesize when allocating
 a hugepage at Stage 2
Thread-Topic: [PATCH 4.9 09/66] KVM: arm/arm64: Check pagesize when allocating
 a hugepage at Stage 2
Thread-Index: AQHTmQHtnl57HAZAbEaq+3oN79oto6O6G8fg
Date: Wed, 28 Feb 2018 15:33:03 +0000
Message-ID: <HE1PR04MB321245D8E0ED5DB3DA6F4DA0E0C70@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <20180129123839.842860149@linuxfoundation.org>
 <20180129123840.324072883@linuxfoundation.org>
In-Reply-To: <20180129123840.324072883@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1100;7:peh4wojP/jRoKHx5WTN3t1fhqb8zA6xuC1odVBjJTO4nhl+NAcp8PdKqUZfkNC2P5l52o684PA84Lj09U82B73lGhmbGZOflGUjVJGkDgGK00JkD6AeB0N/uMZ1klFdFCZC75dzgTsr2ahHFPLfqiPi48yJ8QeItWXZwnICeewwI5HI7zAbFzsetdBjTQ/DJD50eUP8wiPeV81YxDRVdtrhF47wtwJhuy7E4YX7OGhjKMQlyzhj4slUwmAy8u1od
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00cc48ce-4a3a-4286-9645-08d57ec08ed0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:HE1PR04MB1100;
x-ms-traffictypediagnostic: HE1PR04MB1100:
x-microsoft-antispam-prvs: <HE1PR04MB110090C440EEF7811D9A990BE0C70@HE1PR04MB1100.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1100;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1100;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(39380400002)(189003)(199004)(3660700001)(74316002)(110136005)(305945005)(6306002)(4326008)(54906003)(3280700002)(53936002)(5660300001)(7736002)(6436002)(6246003)(86362001)(9686003)(55016002)(66066001)(14454004)(478600001)(966005)(68736007)(2900100001)(575784001)(229853002)(25786009)(2906002)(97736004)(33656002)(3846002)(105586002)(5250100002)(99286004)(81166006)(59450400001)(8936002)(81156014)(2950100002)(2501003)(7696005)(76176011)(106356001)(6116002)(316002)(102836004)(186003)(8676002)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1100;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xMVEwy3+t5aulQcq9Wq1rHkUiOQB8SBnpRfm7R94+qXpAzfAcywbASyKlluqsaCg87sxLEyOzQpneD1QpBKCN0SpYL7CqC4kziN4UnK8nRoaMVCRdbc3/+tnv2MTEc1esgm4EdOPWuEEBA25sMKPSDKOFDJSLNlKc2vp7n+lOBQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cc48ce-4a3a-4286-9645-08d57ec08ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 15:33:03.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiA0Ljktc3RhYmxlIHJldmlldyBwYXRjaC4gIElmIGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMs
IHBsZWFzZSBsZXQgbWUga25vdy4NCg0KSSBrbm93IHRoYXQgbXkgcmVzcG9uc2UgY29tZXMgbGF0
ZSBidXQgSSBqdXN0IGZvdW5kIG91dCB0aGF0IHRoZSB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBhcHBs
aWVkIGluIDQuOS1zdGFibGUsIHRoZSBvbmUgaW4gdGhpcyBlbWFpbCwgaXMgZGlmZmVyZW50IHRo
YW4gdGhlIG9uZSBhcHBsaWVkIG9uIDQuMTQtc3RhYmxlLg0KVGhpcyBpcyB0aGUgb25lIGFwcGxp
ZWQgb24gNC4xNDogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDE3NzcxNS8N
Cg0KQXMgeW91IGNhbiBzZWUsIHRoZSBjaGVjayBhZ2FpbnN0IFBNRF9TSVpFIHdoaWNoIGlzIHBy
ZXNlbnQgaW4gNC4xNCBpcyBub3QgcHJlc2VudCBpbiB0aGlzIHZlcnNpb24gb2YgdGhlIHBhdGNo
Lg0KDQpBbSBJIG1pc3Npbmcgc29tZXRoaW5nIG9yIHNob3VsZCBJIHNlbmQgYSBwYXRjaCB0byBy
ZWN0aWZ5IHRoaXM/DQoNClRoYW5rcywNCklvYW5hIENpb3JuZWkNCg0KPiANCj4gLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IA0KPiBGcm9tOiBQdW5pdCBBZ3Jhd2FsIDxwdW5pdC5hZ3Jhd2FsQGFybS5j
b20+DQo+IA0KPiBjb21taXQgYzUwN2JhYmYxMGVhZDRkNWM4Y2NhNzA0NTM5YjE3MDc1MmE4YWM4
NCB1cHN0cmVhbS4NCj4gDQo+IEtWTSBvbmx5IHN1cHBvcnRzIFBNRCBodWdlcGFnZXMgYXQgc3Rh
Z2UgMiBidXQgZG9lc24ndCBhY3R1YWxseSBjaGVjayB0aGF0DQo+IHRoZSBwcm92aWRlZCBodWdl
cGFnZSBtZW1vcnkgcGFnZXNpemUgaXMgUE1EX1NJWkUgYmVmb3JlIHBvcHVsYXRpbmcNCj4gc3Rh
Z2UgMiBlbnRyaWVzLg0KPiANCj4gSW4gY2FzZXMgd2hlcmUgdGhlIGJhY2tpbmcgaHVnZXBhZ2Ug
c2l6ZSBpcyBzbWFsbGVyIHRoYW4gUE1EX1NJWkUgKHN1Y2ggYXMNCj4gd2hlbiB1c2luZyBjb250
aWd1b3VzIGh1Z2VwYWdlcyksIEtWTSBjYW4gZW5kIHVwIGNyZWF0aW5nIHN0YWdlIDINCj4gbWFw
cGluZ3MgdGhhdCBleHRlbmQgYmV5b25kIHRoZSBzdXBwbGllZCBtZW1vcnkuDQo+IA0KPiBGaXgg
dGhpcyBieSBjaGVja2luZyBmb3IgdGhlIHBhZ2VzaXplIG9mIHVzZXJzcGFjZSB2bWEgYmVmb3Jl
IGNyZWF0aW5nIFBNRA0KPiBodWdlcGFnZSBhdCBzdGFnZSAyLg0KPiANCj4gRml4ZXM6IDY2YjM5
MjNhMWEwZjc3YSAoImFybTY0OiBodWdldGxiOiBhZGQgc3VwcG9ydCBmb3IgUFRFIGNvbnRpZ3Vv
dXMNCj4gYml0IikNCj4gU2lnbmVkLW9mZi1ieTogUHVuaXQgQWdyYXdhbCA8cHVuaXQuYWdyYXdh
bEBhcm0uY29tPg0KPiBDYzogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IENocmlzdG9mZmVyIERhbGwgPGNocmlzdG9mZmVyLmRhbGxAbGluYXJvLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b2ZmZXIgRGFsbCA8Y2hyaXN0b2ZmZXIuZGFsbEBs
aW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPg0KPiANCj4gLS0tDQo+ICBhcmNoL2FybS9rdm0vbW11LmMgfCAg
ICAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IC0tLSBhL2FyY2gvYXJtL2t2bS9tbXUuYw0KPiArKysgYi9hcmNoL2FybS9rdm0vbW11
LmMNCj4gQEAgLTEyODQsNyArMTI4NCw3IEBAIHN0YXRpYyBpbnQgdXNlcl9tZW1fYWJvcnQoc3Ry
dWN0IGt2bV92Y3ANCj4gIAkJcmV0dXJuIC1FRkFVTFQ7DQo+ICAJfQ0KPiANCj4gLQlpZiAoaXNf
dm1faHVnZXRsYl9wYWdlKHZtYSkgJiYgIWxvZ2dpbmdfYWN0aXZlKSB7DQo+ICsJaWYgKHZtYV9r
ZXJuZWxfcGFnZXNpemUodm1hKSAmJiAhbG9nZ2luZ19hY3RpdmUpIHsNCj4gIAkJaHVnZXRsYiA9
IHRydWU7DQo+ICAJCWdmbiA9IChmYXVsdF9pcGEgJiBQTURfTUFTSykgPj4gUEFHRV9TSElGVDsN
Cj4gIAl9IGVsc2Ugew0KPiANCg0K
