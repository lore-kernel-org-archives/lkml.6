Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F01BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93B8208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Qu/KJp1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93B8208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeHBGUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:20:06 -0400
Received: from mail-dm3nam03on0088.outbound.protection.outlook.com ([104.47.41.88]:36454
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbeHBGUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twWRF3Pw9+XKlCNfWhLXVNDGyHAGqhqoLHSwoRp/6vE=;
 b=Qu/KJp1YJPBNZrrjvl205fj2fsfTkZdpilg76d+uSv+WVU//RIZL8LkyBhY64qEIwIFNOtQXnfzfIEO/XXHWB1Gfl9/ve2EsigamNU9eCTNf6plLlBWnrMazYe/yfkk9+f8QZwQr5a7piJhwykm33Gwl6rrYtMxn6abbhhGil84=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5383.namprd07.prod.outlook.com (20.177.125.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Thu, 2 Aug 2018 04:26:46 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::6cda:d8eb:38e2:9ecb]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::6cda:d8eb:38e2:9ecb%5]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 04:26:45 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Thread-Topic: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Thread-Index: AQHUH4o1bKndmEN6kkap8iKK8m7246Sq1kwAgAEW1gA=
Date:   Thu, 2 Aug 2018 04:26:45 +0000
Message-ID: <BYAPR07MB4709106F8160EBF0F3B5DBB4DD2C0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <82e8093d-eb6b-ea04-7d36-54ee27df3e06@ti.com>
In-Reply-To: <82e8093d-eb6b-ea04-7d36-54ee27df3e06@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNGE3MTA3ZDAtOTYwYy0xMWU4LTg3MTQtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDRhNzEwN2QyLTk2MGMtMTFlOC04NzE0LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNjAxMiIgdD0iMTMxNzc2NTc2MTc3NTQxMDc0IiBoPSI4QTlxQ2RBZGlERUNLcDJUakgvVVZjb2d0RmM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5383;20:okfz0sY29WV2awElllv91grMg573TSZG0bO4WX1PDTZAcQXJYU5Xi8Ht+5PJzCKmW10NUNc1cql2mG3e8AA4E3G7P7LCDiCo9APYfGSmC4P82K/if660h2a5hXbdCOr6FPJ/BC9UV42n4vDSr63dbhY5+i+QmH0w6OI79wiGR/wL9wGKv+Q2tSBqC0XRgoitLdNykSX1A2HHx+c3raOpHpI27Xcf94JdGo2M6JWXddVQp0Uf21rqM1AdatnAWdeH
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(36092001)(186003)(53936002)(3846002)(5250100002)(25786009)(217873002)(76176011)(107886003)(7736002)(478600001)(6246003)(6916009)(14454004)(11346002)(4326008)(446003)(54906003)(106356001)(6116002)(7696005)(105586002)(26005)(6506007)(305945005)(5660300001)(316002)(99286004)(102836004)(2906002)(81166006)(476003)(81156014)(486006)(33656002)(74316002)(14444005)(8936002)(8676002)(229853002)(68736007)(55016002)(9686003)(66066001)(6436002)(97736004)(86362001)(2900100001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5383;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 76a69014-a2d2-4b65-e3e8-08d5f8302830
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5383;
x-ms-traffictypediagnostic: BYAPR07MB5383:
x-microsoft-antispam-prvs: <BYAPR07MB5383686AF86EC9726D603DE4DD2C0@BYAPR07MB5383.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5383;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5383;
x-forefront-prvs: 07521929C1
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5s3Vvjgxxb3Hj2uuVMucD11KYIN4p5PAxbS1X/7IaqMB+daY7w298rA9kg9CMkyaFxeVCkW3nH+m/TC1gxM5GjDyzjwVGPv6EzxTdxHvAVcxiFmoJvvxepg4xHDFQknZu/klV8+/9/ysafqMOdi+ssatfdeM18sKyip9/D7ZyMwQU6faSRoVIwL23n9wBzYQ3Ev0hgV4vF3ag47G5XbN7ZPv0SxAQCD5XaYmQ5m25Ep7xUR5ztPQEtSHIEUPKU4AixhMIraq2sUhMmAV8w1HLnm4Q2MqnkLnOLQULhBSYRxMSVbss3aragSmA9pRiAQYcuL/+EHkqpF33dszyXETzlQE4rjIL6ar9SNcDhkL+mU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a69014-a2d2-4b65-e3e8-08d5f8302830
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 04:26:45.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoaXMgcGF0Y2ggc2V0IGludHJvZHVjZSBuZXcgQ2FkZW5jZSBVU0JTU1AgRFJEIGRyaXZl
ciB0byBsaW51eA0KPiA+IGtlcm5lbC4NCj4gPg0KPiA+IFRoZSBDYWRlbmNlIFVTQlNTUCBEUkQg
RHJpdmVyIHMgYSBoaWdobHkgY29uZmlndXJhYmxlIElQIENvcmUgd2hpY2gNCj4gPiBjYW4gYmUg
aW5zdGFudGlhdGVkIGFzIER1YWwtUm9sZSBEZXZpY2UgKERSRCksIFBlcmlwaGVyYWwgT25seSBh
bmQNCj4gPiBIb3N0IE9ubHkgKFhIQ0kpIGNvbmZpZ3VyYXRpb25zLg0KPiA+DQo+ID4gVGhlIGN1
cnJlbnQgZHJpdmVyIGhhcyBiZWVuIHZhbGlkYXRlZCB3aXRoIEZQR0EgYnVybmVkLiBXZSBoYXZl
DQo+ID4gc3VwcG9ydCBmb3IgUENJZSBidXMsIHdoaWNoIGlzIHVzZWQgb24gRlBHQSBwcm90b3R5
cGluZy4NCj4gPg0KPiA+IFRoZSBob3N0IHNpdGUgb2YgVVNCU1NQIGNvbnRyb2xsZXIgaXMgY29t
cGxpYW5jZSB3aXRoIFhIQ0kNCj4gPiBzcGVjaWZpY2F0aW9uLCBzbyBpdCB3b3JrcyB3aXRoIHN0
YW5kYXJkIFhIQ0kgbGludXggZHJpdmVyLg0KPiA+DQo+ID4gQWxzbywgZGV2aWNlIHNpZGUgb2Yg
VVNCU1NQIGNvbnRyb2xsZXIgd2FzIGRlc2lnbmVkIGluIHN1Y2ggd2F5IHRvDQo+ID4gbG9va3Mg
bGlrZSBYSENJLiBJdCBtZWFucyB0aGF0IG1vc3Qgb2YgbG9naWMgb2YgVVNCU1NQIGNvbnRyb2xs
ZXIgaXMNCj4gPiBhbHNvIGNvbXBsaWFuY2Ugd2l0aCBYSENJIHNwZWNpZmljYXRpb24uDQo+ID4N
Cj4gPiBDb25zZXF1ZW50bHksIHRoZSBVU0JTU1AgZHJpdmVyIGZvciBwZXJpcGhlcmFsIG1vZGUg
aXMgdmVyeSBzaW1pbGFyIHRvDQo+ID4gWEhDSSBkcml2ZXIuDQo+ID4NCj4gPiBUaGlzIHZlcnNp
b24gb2YgZHJpdmVyIHN1cHBvcnRzIG9ubHkgRGV2aWNlIG1vZGUgYnV0IERSRCBhbmQgSG9zdCBt
b2RlDQo+ID4gd2lsbCBiZSBhZGRlZCBpbiB0aGUgZnV0dXJlLg0KPiA+DQo+IA0KPiBCYXNlZCBv
biB0aGUgcG9zdGluZyBkYXRlIHRoaXMgc2VyaWVzIGxvb2tzIGxpa2UgdjMuDQo+IA0KPiBZb3Ug
c2hvdWxkIGFkZCB0aGUgdmVyc2lvbiBwcmVmaXggdG8gdGhlIHBhdGNoZXMgbmV4dCB0aW1lLg0K
PiBlLmcuIFtQQVRDSCB2NCAuLi5dDQo+DQpJIHdhbnRlZCB0byBzdGFydCB2ZXJzaW9uaW5nIGRy
aXZlciBhZnRlciB0aGlzIHNldCBwYXRjaCB3aWxsIGJlIGFwcHJvdmVkLiANCkFsc28gSSBoYXZl
IHBsYW4gdG8gYWRkIGNoYW5nZS1sb2cgYWZ0ZXIgYXBwcm92YWwgdGhpcyBwYXRjaCBzZXQuIA0K
SSBub3cgdHJlYXQgdGhpcyBwYXRjaCBzZXQgYXMgSW5pdGlhbCB2ZXJzaW9uIG9mIGRyaXZlci4g
DQpJZiBteSBhcHByb2FjaCAgaXMgaW5jb3JyZWN0IHBsZWFzZSBjb3JyZWN0IG1lID8/DQpNYXli
ZSBiZWZvcmUgYXBwcm92YWwgIHRoZSBiZXR0ZXIgdmVyc2lvbmluZyB3aWxsIGJlIFtQQVRDSCB2
cmM0XSA/DQogDQo+IEl0IGlzIGFsc28gcmVjb21tZW5kZWQgdG8gYWRkIGEgQ2hhbmdlLWxvZyBp
biB0aGUgY292ZXIgbGV0dGVyIGV4cGxhaW5pbmcNCj4gd2hhdCBjaGFuZ2VzIHdlcmUgbWFkZSBp
biBlYWNoIHJldmlzaW9uLg0KPiANCkkNCg0KPiBUaGVyZSBhcmUgYSBidW5jaCBvZiBjaGVja3Bh
dGNoIHdhcm5pbmdzIGluIHRoaXMgc2VyaWVzLg0KPiBZb3UgY2FuIHVzZSAuL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCBvbiB0aGUgcGF0Y2hlcyBhbmQgZml4IHRoZSBpc3N1ZXMuDQpZZXMgSSBrbm93
LCBidXQgbW9zdCBvZiB0aGVtIGFyZSByZWxhdGVkIHRvICJsaW5lIG92ZXIgODAgY2hhcmFjdGVy
cyIgDQphbmQgIiBxdW90ZWQgc3RyaW5nIHNwbGl0IGFjcm9zcyBsaW5lcyIgd2FybmluZ3MuIFRo
ZSBmaXJzdCBncm91cCBJIGNvdWxkIGNvcnJlY3QNCmJ1dCB0aGVuIEkgd2lsbCBtYWtlIHJlYWRh
YmlsaXR5IHdvcnNlLiANClRvIGVsaW1pbmF0ZSB0aGUgc2Vjb25kIGdyb3VwIEkgd2lsbCBoYXZl
IHRvIGVubGFyZ2UgdGhlIGZpcnN0IGdyb3VwIG9mIHdhcm5pbmdzIGFuZCANCnRoZSBudW1iZXIg
b2YgIGNoYXJhY3RlcnMgaW4gc2luZ2xlIGxpbmUgd2lsbCBiZSBiaWdnZXIgdGhhbiAxMDAuICAN
Cj4gPiAtLS0NCj4gPg0KPiA+IFBhd2VsIExhc3pjemFrICgzMSk6DQo+ID4gICB1c2I6IHVzYnNz
cDogRGVmaW5lZCByZWdpc3RlciBtYXBzIGFuZCBvdGhlciB1c2VmdWwgc3RydWN0dXJlcy4NCj4g
PiAgIHVzYjogdXNic3NwOiBBZGRlZCBzb21lIGRlY29kaW5nIGZ1bmN0aW9ucy4NCj4gPiAgIHVz
YjogdXNic3NwOiBBZGQgdHJhY2UgZXZlbnRzIHVzZWQgaW4gZHJpdmVyDQo+ID4gICB1c2I6IHVz
YnNzcDogQWRkZWQgVVNCU1NQIHBsYXRmb3JtIGRyaXZlcg0KPiA+ICAgdXNiOiB1c2Jzc3A6IEFk
ZGVkIGZpcnN0IHBhcnQgb2YgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UuDQo+ID4gICB1c2I6IHVz
YnNzcDogYWRkZWQgdGVtcGxhdGUgZnVuY3Rpb25zIHVzZWQgYnkgdXBwZXIgbGF5ZXIuDQo+ID4g
ICB1c2I6IHVzYnNzcDogSW5pdGlhbGl6YXRpb24gLSBhZGRlZCB1c2Jzc3BfbWVtX2luaXQNCj4g
PiAgIHVzYjogdXNic3NwOiBBZGRlZCByaW5nIGFuZCBzZWdtZW50IGhhbmRsaW5nIGZ1bmN0aW9u
cy4NCj4gPiAgIHVzYjogdXNic3NwOiBhZGQgaW1wbGVtZW50YXRpb24gb2YgdXNic3NwX21lbV9j
bGVhbnVwDQo+ID4gICB1c2I6IHVzYnNzcDogYWRkZWQgdXNic3NwX3RyYl9pbl90ZCBmdW5jdGlv
bi4NCj4gPiAgIHVzYjogdXNic3NwOiBhZGRlZCBmdW5jdGlvbiBmb3Igc3RvcHBpbmcgZHJpdmVy
Lg0KPiA+ICAgdXNiOiB1c2Jzc3A6IGFkZGVkIGZ1bmN0aW9ucyBmb3IgcXVldWluZyBjb21tYW5k
cy4NCj4gPiAgIHVzYjogdXNic3NwOiBhZGRlYyBwcm9jZWR1cmUgZm9yIGhhbmRsaW4gUG9ydCBT
dGF0dXMgQ2hhbmdlIGV2ZW50cy4NCj4gPiAgIHVzYjogdXNic3NwOiBhZGRlZCBwcm9jZWR1cmUg
aGFuZGxpbmcgY29tbWFuZCBjb21wbGV0aW9uIGV2ZW50cy4NCj4gPiAgIHVzYjogdXNic3NwOiBh
ZGRlZCBkZXZpY2UgY29udHJvbGxlciBlcnJvciwgdHJhbnNmZXIgYW5kIFNFVFVQDQo+ID4gICAg
IGNvbXBsZXRpb24gZXZlbnQuDQo+ID4gICB1c2I6IHVzYnNzcDogYWRkZWQgY29ubmVjdC9kaXNj
b25uZWN0IHByb2NlZHVyZXMuDQo+ID4gICB1c2I6IHVzYnNzcDogYWRkZWQgaW1wbGVtZW50YXRp
b24gb2YgdXNic3NwX2hhbHRfZW5kcG9pbnQgZnVuY3Rpb24uDQo+ID4gICB1c2I6IHVzYnNzcDog
YWRkZWQgaGFuZGxpbmcgb2YgUG9ydCBSZXNldCBldmVudC4NCj4gPiAgIHVzYjogdXNic3NwOiBh
ZGRlZCBzdXBwb3J0IGZvciBVU0IgZW51bWVyYXRpb24gcHJvY2Vzcy4NCj4gPiAgIHVzYjogdXNi
c3NwOiBhZGRlZCBxdWV1aW5nIHByb2NlZHVyZSBmb3IgY29udHJvbCB0cmFuc2Zlci4NCj4gPiAg
IHVzYjogdXNic3NwOiBhZGRlZCBxdWV1aW5nIHByb2NlZHVyZSBmb3IgQlVMSyBhbmQgSU5UIHRy
YW5zZmVyLg0KPiA+ICAgdXNiOiB1c2Jzc3A6IGFkZGVkIHByb2NlZHVyZSByZW1vdmluZyByZXF1
ZXN0IGZyb20gdHJhbnNmZXIgcmluZw0KPiA+ICAgdXNiOiB1c2Jzc3A6IGFkZGVkIGltcGxlbWVu
dGF0aW9uIG9mIHRyYW5zZmVyIGV2ZW50cy4NCj4gPiAgIHVzYjogdXNic3NwOiBhZGRlZCBkZXRl
Y3RpbmcgY29tbWFuZCB0aW1lb3V0Lg0KPiA+ICAgdXNiOiB1c2Jzc3A6IGFkZGVkIGltcGxlbWVu
dGF0aW9uIG9mIHVzYnNzcCBpbnRlcmZhY2UuDQo+ID4gICB1c2I6IHVzYnNzcDogYWRkZWQgZW5k
cG9pbnQgY29uZmlndXJhdGlvbiBmdW5jdGlvbmFsaXR5Lg0KPiA+ICAgdXNiOiB1c2Jzc3A6IGlt
cGxlbWVudHMgdXNic3NwX2dhZGdldF9lcF9lbmFibGUgZnVuY3Rpb24NCj4gPiAgIHVzYjogdXNi
c3NwOiBpbXBsZW1lbnRlZCB1c2Jzc3BfZ2FkZ2V0X2VwX2Rpc2FibGUgZnVuY3Rpb24uDQo+ID4g
ICB1c2I6IHVzYnNzcDogYWRkZWQgc3VwcG9ydCBmb3IgTFBNLg0KPiA+ICAgdXNiOiB1c2Jzc3A6
IGFkZGVkIHN1cHBvcnQgZm9yIFRFU1RfTU9ERS4NCj4gPiAgIHVzYjogdXNic3NwOiBhZGQgcGNp
IHRvIHBsYXRmb3JtIGRyaXZlciB3cmFwcGVyLg0KPiA+DQo+ID4gIGRyaXZlcnMvdXNiL0tjb25m
aWcgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiA+ICBkcml2ZXJzL3VzYi9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgfCAgICAyICsNCj4gPiAgZHJpdmVycy91c2IvdXNic3NwL0tjb25maWcg
ICAgICAgICAgIHwgICAyOSArDQo+ID4gIGRyaXZlcnMvdXNiL3VzYnNzcC9NYWtlZmlsZSAgICAg
ICAgICB8ICAgMTUgKw0KPiA+ICBkcml2ZXJzL3VzYi91c2Jzc3AvZ2FkZ2V0LWRiZy5jICAgICAg
fCAgIDM5ICsNCj4gPiAgZHJpdmVycy91c2IvdXNic3NwL2dhZGdldC1lcDAuYyAgICAgIHwgIDU3
MSArKysrKw0KPiA+ICBkcml2ZXJzL3VzYi91c2Jzc3AvZ2FkZ2V0LWV4dC1jYXBzLmggfCAgMTAy
ICsNCj4gPiAgZHJpdmVycy91c2IvdXNic3NwL2dhZGdldC1pZi5jICAgICAgIHwgIDU2OSArKysr
Kw0KPiA+ICBkcml2ZXJzL3VzYi91c2Jzc3AvZ2FkZ2V0LW1lbS5jICAgICAgfCAxOTM4ICsrKysr
KysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3VzYi91c2Jzc3AvZ2FkZ2V0LXBvcnQuYyAgICAgfCAg
Mjg3ICsrKw0KPiA+ICBkcml2ZXJzL3VzYi91c2Jzc3AvZ2FkZ2V0LXJpbmcuYyAgICAgfCAzNDUy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvdXNiL3VzYnNzcC9nYWRn
ZXQtdHJhY2UuYyAgICB8ICAgMTMgKw0KPiA+ICBkcml2ZXJzL3VzYi91c2Jzc3AvZ2FkZ2V0LXRy
YWNlLmggICAgfCAgNDgyICsrKysNCj4gPiAgZHJpdmVycy91c2IvdXNic3NwL2dhZGdldC5jICAg
ICAgICAgIHwgMTkwOSArKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3VzYi91c2Jzc3AvZ2Fk
Z2V0LmggICAgICAgICAgfCAyMzczICsrKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3Vz
Yi91c2Jzc3AvdXNic3NwLXBjaS13cmFwLmMgfCAgMjI2ICsrDQo+ID4gIGRyaXZlcnMvdXNiL3Vz
YnNzcC91c2Jzc3AtcGxhdC5jICAgICB8ICAxODYgKysNCj4gPiAgMTcgZmlsZXMgY2hhbmdlZCwg
MTIxOTUgaW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy91c2Iv
dXNic3NwL0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGRyaXZlcnMvdXNiL3VzYnNz
cC9NYWtlZmlsZSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy91c2IvdXNic3NwL2dh
ZGdldC1kYmcuYyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy91c2IvdXNic3NwL2dh
ZGdldC1lcDAuYyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy91c2IvdXNic3NwL2dh
ZGdldC1leHQtY2Fwcy5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi91c2Jz
c3AvZ2FkZ2V0LWlmLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGRyaXZlcnMvdXNiL3VzYnNz
cC9nYWRnZXQtbWVtLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGRyaXZlcnMvdXNiL3VzYnNz
cC9nYWRnZXQtcG9ydC5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL3VzYi91c2Jz
c3AvZ2FkZ2V0LXJpbmcuYyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy91c2IvdXNi
c3NwL2dhZGdldC10cmFjZS5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL3VzYi91
c2Jzc3AvZ2FkZ2V0LXRyYWNlLmggIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGRyaXZlcnMvdXNi
L3VzYnNzcC9nYWRnZXQuYyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy91c2IvdXNi
c3NwL2dhZGdldC5oICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL3VzYi91c2Jzc3Av
dXNic3NwLXBjaS13cmFwLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL3Vz
YnNzcC91c2Jzc3AtcGxhdC5jDQo+ID4NCj4gDQo+IC0tDQpjaGVlcnMsDQpQYXdlbA0KDQo=
