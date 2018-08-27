Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F25C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86877208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="vuUaBqGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86877208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH0XBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:01:07 -0400
Received: from mail-eopbgr730102.outbound.protection.outlook.com ([40.107.73.102]:43433
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbeH0XBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQJ2/Iu4q7+adgG3PJSauu+rcj9vD3xW+T84c6FQLw4=;
 b=vuUaBqGsaO7D75qCdg+V2jckv+OciH9XDnYnJsBJ6wVt/ZbdgESQY6zSdC65UE4NX4OC28QNzFsbG/WmGE5NGOTiOkoJpy/6rtnHN2T3dSqciZplNy1j0KEPfhZdgXrykxXDN9ANJbaxpTEXiKcScZN2izmWgsSVqr5+9VTECII=
Received: from MWHPR01MB2336.prod.exchangelabs.com (10.169.237.8) by
 MWHPR01MB2463.prod.exchangelabs.com (10.168.202.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 19:13:09 +0000
Received: from MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::7416:1d64:d3fb:29fc]) by MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::7416:1d64:d3fb:29fc%4]) with mapi id 15.20.1080.015; Mon, 27 Aug 2018
 19:13:08 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Open Source Submission <patches@amperecomputing.com>,
        Rameshwar P Sahu <Rameshwar.Sahu@amperecomputing.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG
 SATA
Thread-Topic: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG
 SATA
Thread-Index: AQHUPjZ+z0HIkB9pzUSyM0F9FMyxiqTT9keAgAAAgZA=
Date:   Mon, 27 Aug 2018 19:13:08 +0000
Message-ID: <MWHPR01MB23360AA3459B7502DE5D5F4BB30B0@MWHPR01MB2336.prod.exchangelabs.com>
References: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
 <d3cef828-6c18-f061-0fe8-1579bcf602c5@redhat.com>
In-Reply-To: <d3cef828-6c18-f061-0fe8-1579bcf602c5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR01MB2463;6:x3vdsMnuncMwDd/CWvZybKeDRjrZM2shgr9Yz3u18nzg2vtWAsUMcXtnFVRT6FR6dbuLmnb41jRygv0pPrIOMTR4+U8EAd0o36K6s3mAx7XSRyBbliUK6U+3KE51DapgswPvrPa0Drw/nRsLMJEn/0zGck+8aADpQ+hpfOSwDHelVYiiDM/tEPruGLX57bg6hdnOmBgN2vW0Fr7Tc551g8rsfnGO/VjCZ/crLONs/RBCtbVkTtG7bBcWW2KsyMRq4pT3C5fBPAZp1cnR6yQ+JM1DPz+LujMGGaaWZu/tXe3qDpPRHdWcPQtscUMPhl2EFoACUktbm8q7dnkh9VMTJjHiK9LayZusf9FTMOqrcb11Rk71fi/qFrU/DQwWKL0UDI7cTev2fJ8Y6CvRhSGGbyZkJ4DOXSaUILsvThi81ijyB7qp+jOUjC73n6jaRy6Rz0OPalit+4tgH7f05MxNUg==;5:ECb8OU+ldQAwDws6AnuQ3CRApQ9E6zLnlMi0RrjQf01YPtD2Yr2Jg0CS5V5gVTVTaVCimPm8u83SYpfP5q0KUiFn8Ity9+UANyESD2a5/nW0xt0EDPHtepBV96n2dPrFiNqjIEU0Liab8e3JdLV+xMHkHzqpZHf74X0I6Yo45Ek=;7:xNGr8DqkyxPJjSjBVNGXtW85OVyTY4p22xkJXei/9apEY8DrbWJQn8/AJzlCleKyW80djTw4gsiUPEb2NSANWVnXg9/L3WjJVw99qiDuI4wH3d0E16wO1fh+Y/7V6FA7AKznSO3rtyx8YlfIwARJHbYvP2hQNV1G3Ztdw70L/5qOrGwxeatFdAV74UGmEnOxcsBocGbVumnI4g9PAigfmNS2sTIXKTB4YG3oyb/ZDtE5pGPj4t5oyldW9rxdww0K
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(376002)(136003)(346002)(189003)(199004)(13464003)(9686003)(99286004)(186003)(8936002)(14444005)(14454004)(54906003)(26005)(68736007)(6436002)(256004)(478600001)(6246003)(345774005)(33656002)(6506007)(110136005)(102836004)(7696005)(53546011)(217873002)(86362001)(575784001)(55016002)(76176011)(74316002)(229853002)(2201001)(97736004)(5250100002)(5660300001)(4326008)(305945005)(7736002)(316002)(25786009)(476003)(486006)(446003)(3846002)(2906002)(11346002)(53936002)(106356001)(2501003)(105586002)(6116002)(66066001)(8676002)(2900100001)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2463;H:MWHPR01MB2336.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: f31f17cc-8710-438d-1bc4-08d60c511fda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2463;
x-ms-traffictypediagnostic: MWHPR01MB2463:
x-microsoft-antispam-prvs: <MWHPR01MB24631C1AEC9CEB8538046618B30B0@MWHPR01MB2463.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:MWHPR01MB2463;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2463;
x-forefront-prvs: 07778E4001
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: ipYyIX6ACdbBNe6RbW38Fl9UTTCLgCAcVyG2EpoFpaqUW2ktHhVN8MsC1ZW2XJ78gcVv2xiVxq7J425/+iq088+uoSG9KmuA72PND3Hz9UOndSgiq1QlNh8DChyrjDHgxlbeGJiz9XgNrnvXc2qKyBuRhFvywrSbK+pYT1gOwxc79DADqSoGHRBYyrnO3tFh4Zma7cdqrHpyeJx6jKJkgKk0zJZxClm6VMz6jr9iWkewNB95yfN+gs49o+FtXIc9GEPCRE01Ew66q/MJPV3Mmb4vwjdsUwTNkszLPUeZRK3VpSwTNxbC9KkGte0t8pflv2XNPctVtf5+TgrRCl5jC4nPt++fPmG2blaNZja3eMk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31f17cc-8710-438d-1bc4-08d60c511fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 19:13:08.4525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucw0KDQpUaGFua3MgZm9yIHlvdXIgZmFzdCByZXNwb25zZS4NCg0KV2l0aCByZWdhcmRz
LA0KU3VtYW4NCg0KUGxlYXNlIG5vdGUgbXkgbmV3IGVtYWlsIGFkZHJlc3Mg4oaSIHN0cmlwYXRo
aUBhbXBlcmVjb21wdXRpbmcuY29tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPiANClNlbnQ6IE1vbmRheSwgQXVn
dXN0IDI3LCAyMDE4IDEyOjA5IFBNDQpUbzogU3VtYW4gVHJpcGF0aGkgPHN0cmlwYXRoaUBhbXBl
cmVjb21wdXRpbmcuY29tPjsgdGpAa2VybmVsLm9yZzsgbGludXgtaWRlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBqb2VAcGVyY2hlcy5jb207IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnDQpDYzogT3BlbiBTb3VyY2UgU3VibWlzc2lvbiA8cGF0Y2hlc0BhbXBl
cmVjb21wdXRpbmcuY29tPjsgUmFtZXNod2FyIFAgU2FodSA8UmFtZXNod2FyLlNhaHVAYW1wZXJl
Y29tcHV0aW5nLmNvbT47IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGF0YTogRGlzYWJsZSBBSENJIEFMUE0gZmVhdHVyZSBmb3IgQW1wZXJlIENvbXB1
dGluZyBlTUFHIFNBVEENCg0KW05PVElDRTogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gYW4g
ZXh0ZXJuYWwgc2VuZGVyLiBQbGVhc2UgYmUgbWluZGZ1bCBvZiBzYWZlIGVtYWlsIGhhbmRsaW5n
IGFuZCBwcm9wcmlldGFyeSBpbmZvcm1hdGlvbiBwcm90ZWN0aW9uIHByYWN0aWNlcy5dIF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KDQpIaSwNCg0KT24gMjctMDgtMTggMjA6NDcsIFN1bWFuIFRyaXBhdGhpIHdyb3RlOg0KPiBE
dWUgdG8gaGFyZHdhcmUgZXJyYXRhLCBBbXBlcmUgQ29tcHV0aW5nIGVNQUcgU0FUQSBjYW4ndCBz
dXBwb3J0IEFIQ0kgDQo+IEFMUE0gZmVhdHVyZS4gVGhpcyBwYXRjaCBkaXNhYmxlcyB0aGUgQUhD
SSBBTFBNIGZlYXR1cmUgZm9yIGVNQUcgU0FUQS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU3VtYW4g
VHJpcGF0aGkgPHN0cmlwYXRoaUBhbXBlcmVjb21wdXRpbmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBSYW1lc2h3YXIgUHJhc2FkIFNhaHUgDQo+IDxyYW1lc2h3YXIuc2FodUBhbXBlcmVjb21wdXRp
bmcuY29tPg0KDQpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4gMiByZW1hcmtzOg0KDQoxKSBUaGUg
YXRhIGNvZGUgaXMgbWFpbnRhaW5lZCBieSBKZW5zIEF4Ym9lIChhZGRlZCB0byB0aGUgQ2MpIG5v
dywgdGhpcyBpcyBhIHZlcnkgcmVjZW50IGNoYW5nZSwgd2hpY2ggc3RpbGwgaGFzIHRvIGhpdCBN
QUlOVEFJTkVSUw0KW1N1bWFuIFRyaXBhdGhpXSBEaWRuJ3Qgc3RpbGwgc2VlIGhpbSBmb3IgbGli
YXRhIHN1YnN5c3RlbS4gU3VyZWx5IHdpbGwgZml4IHRoZSBjb21tZW50cyBjYyBoaW0gZm9yIHRo
ZSBuZXh0IHZlcnNpb24uIEkgc2VlIGhpbSBpbiB0aGUgc2NzaSBzdWJzeXN0ZW0uDQoNCjIpIFNl
ZSBiZWxvdw0KDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jIHwgMTMg
KysrKysrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMg
Yi9kcml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMgDQo+IGluZGV4IDk5ZjlhODkuLjBkMDIzM2Ug
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYXRhL2FoY2lfcGxhdGZvcm0uYw0KPiArKysgYi9kcml2
ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMNCj4gQEAgLTI2LDcgKzI2LDcgQEANCj4NCj4gICAjZGVm
aW5lIERSVl9OQU1FICJhaGNpIg0KPg0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9p
bmZvIGFoY2lfcG9ydF9pbmZvID0gew0KPiArc3RhdGljIHN0cnVjdCBhdGFfcG9ydF9pbmZvIGFo
Y2lfcG9ydF9pbmZvID0gew0KPiAgICAgICAuZmxhZ3MgICAgICAgICAgPSBBSENJX0ZMQUdfQ09N
TU9OLA0KPiAgICAgICAucGlvX21hc2sgICAgICAgPSBBVEFfUElPNCwNCj4gICAgICAgLnVkbWFf
bWFzayAgICAgID0gQVRBX1VETUE2LA0KDQpQbGVhc2UgZG8gbm90IHJlbW92ZSBjb25zdCBoZXJl
LCBpZiB5b3UgbmVlZCB0byBtYWtlIGEgc2hhcmVkIGluZm8gc3RydWN0IGxpa2UgdGhpcyBub24g
Y29uc3QgeW91IGFyZSB1c3VhbGx5IGRvaW5nIHNvbWV0aGluZyB3cm9uZyAoc2VlIGJlbG93KS4N
Cg0KPiBAQCAtNDEsNiArNDEsOCBAQCBzdGF0aWMgaW50IGFoY2lfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gICB7DQo+ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZw
ZGV2LT5kZXY7DQo+ICAgICAgIHN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqaHByaXY7DQo+ICsgICAg
IHN0cnVjdCBhY3BpX2RldmljZV9pbmZvICppbmZvOw0KPiArICAgICBhY3BpX3N0YXR1cyBzdGF0
dXM7DQo+ICAgICAgIGludCByYzsNCj4NCj4gICAgICAgaHByaXYgPSBhaGNpX3BsYXRmb3JtX2dl
dF9yZXNvdXJjZXMocGRldik7DQo+IEBAIC01Nyw2ICs1OSwxNSBAQCBzdGF0aWMgaW50IGFoY2lf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgaWYgKG9mX2Rldmlj
ZV9pc19jb21wYXRpYmxlKGRldi0+b2Zfbm9kZSwgImhpc2lsaWNvbixoaXNpLWFoY2kiKSkNCj4g
ICAgICAgICAgICAgICBocHJpdi0+ZmxhZ3MgfD0gQUhDSV9IRkxBR19OT19GQlMgfCBBSENJX0hG
TEFHX05PX05DUTsNCj4NCj4gKyAgICAgc3RhdHVzID0gYWNwaV9nZXRfb2JqZWN0X2luZm8oQUNQ
SV9IQU5ETEUoZGV2KSwgJmluZm8pOw0KPiArICAgICBpZiAoQUNQSV9TVUNDRVNTKHN0YXR1cykp
IHsNCj4gKyAgICAgICAgICAgICBpZiAoaW5mby0+dmFsaWQgJiBBQ1BJX1ZBTElEX0hJRCkgew0K
PiArICAgICAgICAgICAgICAgICAgICAgaWYgKCFzdHJjbXAoIkFQTUMwRDMzIiwgaW5mby0+aGFy
ZHdhcmVfaWQuc3RyaW5nKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWhjaV9w
b3J0X2luZm8uZmxhZ3MgfD0gQVRBX0ZMQUdfTk9fTFBNOw0KPiArICAgICAgICAgICAgIH0NCj4g
KyAgICAgICAgICAgICBBQ1BJX0ZSRUUoaW5mbyk7DQo+ICsgICAgIH0NCj4gKw0KPiAgICAgICBy
YyA9IGFoY2lfcGxhdGZvcm1faW5pdF9ob3N0KHBkZXYsIGhwcml2LCAmYWhjaV9wb3J0X2luZm8s
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFoY2lfcGxhdGZvcm1fc2h0
KTsNCj4gICAgICAgaWYgKHJjKQ0KDQpUaGUgbm9ybWFsIHdheSB0byBnZXQgc3BlY2lmaWMgYmVo
YXZpb3IgZm9yIGEgc3BlY2lmaWMgQUNQSSBISUQgaXMgdG8gcHV0IHRoZSBISUQgaW4gdGhlIGFo
Y2lfYWNwaV9tYXRjaCB0YWJsZSBhbmQgdXNlIHRoZSBhY3BpX2RldmljZV9pZCBmaWVsZCB0byBw
YXNzIHNvbWUgZmxhZ3MgKG9yIGEgcG9pbnRlcikuDQpbU3VtYW4gVHJpcGF0aGldIEFncmVlIG9u
IHRoaXMuDQoNClNvIHRoZSBwcm9wZXIgd2F5IHRvIGZpeCB0aGlzIGlzIHRvIGRvIHNvbWV0aGlu
ZyBsaWtlIHRoaXM6DQoNCjEpIEFkZDoNCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9p
bmZvIGFoY2lfcG9ydF9pbmZvX25vbHBtID0gew0KICAgICAgICAgLmZsYWdzICAgICAgICAgID0g
QUhDSV9GTEFHX0NPTU1PTiB8IEFUQV9GTEFHX05PX0xQTSwNCiAgICAgICAgIC5waW9fbWFzayAg
ICAgICA9IEFUQV9QSU80LA0KICAgICAgICAgLnVkbWFfbWFzayAgICAgID0gQVRBX1VETUE2LA0K
ICAgICAgICAgLnBvcnRfb3BzICAgICAgID0gJmFoY2lfcGxhdGZvcm1fb3BzLA0KfTsNCg0KMikg
TW9kaWZ5IGFoY2lfYWNwaV9tYXRjaCB0YWJsZSB0bzoNCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCBh
Y3BpX2RldmljZV9pZCBhaGNpX2FjcGlfbWF0Y2hbXSA9IHsNCiAgICAgICAgeyAiQVBNQzBEMzMi
LCAodW5zaWduZWQgbG9uZykmYWhjaV9wb3J0X2luZm9fbm9scG0gfSwNCiAgICAgICAgIHsgQUNQ
SV9ERVZJQ0VfQ0xBU1MoUENJX0NMQVNTX1NUT1JBR0VfU0FUQV9BSENJLCAweGZmZmZmZikgfSwN
CiAgICAgICAgIHt9LA0KfTsNCg0KMykgSW4gYWhjaV9wcm9iZSgpIGRvOg0KDQogICAgICAgIGNv
bnN0IHN0cnVjdCBhdGFfcG9ydF9pbmZvICpwb3J0Ow0KDQogICAgICAgIC4uLg0KDQogICAgICAg
IHBvcnQgPSBhY3BpX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KICAgICAgICBpZiAoIXBv
cnQpDQogICAgICAgICAgICAgICAgcG9ydCA9ICZhaGNpX3BvcnRfaW5mbzsNCg0KICAgICAgICBy
YyA9IGFoY2lfcGxhdGZvcm1faW5pdF9ob3N0KHBkZXYsIGhwcml2LCBwb3J0LCAmYWhjaV9wbGF0
Zm9ybV9zaHQpOw0KDQoNClJlZ2FyZHMsDQoNCkhhbnMNCg==
