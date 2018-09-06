Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5402DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCAB2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="YAbFX541"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCAB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeIFR1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:27:05 -0400
Received: from mail-sn1nam01on0100.outbound.protection.outlook.com ([104.47.32.100]:20288
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727678AbeIFR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWxRfZ9C4DmwOt/q1GDxmHVHSXtb4ahjVFVaYsuQQGM=;
 b=YAbFX541RfrJMNjawQIIrmA0EiSXr7UtpY07LhEqnlhAhMQLnH8+d3MzgmQckto2hyLF3y21lF2Yla3Rj0k+w97bchNwmZKFKFzE1NInFHF4WI3lFMozONMuz0hVkTFIblys6QL+9u2htcBM7tXI/ycQ2tvbH1bqoDpNmgcREsI=
Received: from MWHPR01MB2336.prod.exchangelabs.com (10.169.237.8) by
 MWHPR01MB2702.prod.exchangelabs.com (10.172.165.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 12:51:36 +0000
Received: from MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab]) by MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab%9]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 12:51:34 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Open Source Submission <patches@amperecomputing.com>,
        Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
Subject: RE: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Topic: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Index: AQHURZrT66fmRMLThEOv7d/ltUw1PKTi3A+AgABY2rA=
Date:   Thu, 6 Sep 2018 12:51:34 +0000
Message-ID: <MWHPR01MB233693C3A340055CC5CF3D40B3010@MWHPR01MB2336.prod.exchangelabs.com>
References: <1536208421-24867-1-git-send-email-stripathi@amperecomputing.com>
 <a1c6012f-3b50-0e5e-677c-41903b4ccf64@redhat.com>
In-Reply-To: <a1c6012f-3b50-0e5e-677c-41903b4ccf64@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
x-originating-ip: [2601:646:8e01:9030:ddb:a5b8:d993:eed7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR01MB2702;6:S2cJUdvQ4hQUlLchhqg9ymN8NRf2bBKYXUHkhlIgZMtlDuyjaYPZPG7IKn+6ZPrny+XOU4qeNCQUGBAYFc0/nUlB1VE/5gPYOJzHwzzADLMLdkT92VS48nVTqtLZkm4gEhc5e9EOLGA6m//e9YGN2D4TwfpnUG025XGJDHRJOGFskXdPUirbIj0gu+CregU/scfzBb4eY/DY0Z5H1Yg7fZqBBEM8Ms2ECLhvhBoWWTRJ1l9U7KB9ySANILix/zcOE83T/RZwVheISEZXKO6vUXJVXKF8EV7R5Lm5XK1vWdcW2tBri7VB3wigv33drKop3hkNvAaL30K6qrpHDM2kgHorlEGD5vctxClAlXUAZaS+xSl10U09hoMvSzSbSNVeXkZJCI70SwhcLYs7JM9M2OPZoIwM7pgD/hfMMOJHR0dSelu0lGB/NxykTvcdmHslrOzsw0PvyMls/b7GAeOAVQ==;5:uTXm3zhWOBa+XtmTL2x13P2NIFGFhh1Rv+xlb2X26Mo6vs7J0yGSEfArBAjlHUNsqiWuA5C0HrsUwBpjx3bvU5+p+GjtKchVe2jXI+vbMO94BZtJ4kTc41KlE8IZUKV3ExiDfGvrJ0YkFc40pa2Moo3RYMx2+a2vT9yuSb5l2j4=;7:QY58NigbjQMMVnWZDPx22csHimtCIjOeVC1lZMJf8VwuqguHQyOngvkUTR19ermH/WKVEdLRgk8mdlOwbP2Gs2Y16AoCBHzg4mu7zjYca489bfuQJt13LB4fqr2tmWOfJ++mufrewSZBuHzMOTYKB7SSQrtpdxaN0RteugJaxdwEqaPn7IxHNcMLmTefaU8qM/nQ9Aqwn84l4lQtoE4xOS0erAqOSQpGDdOAn9JTIjB+mQynhwZSF6rppDyDryHp
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(39840400004)(366004)(136003)(346002)(396003)(13464003)(54534003)(189003)(199004)(6436002)(446003)(316002)(68736007)(2501003)(106356001)(110136005)(97736004)(2900100001)(217873002)(53936002)(305945005)(7736002)(5250100002)(9686003)(33656002)(8936002)(478600001)(46003)(476003)(105586002)(486006)(74316002)(55016002)(11346002)(6116002)(81156014)(81166006)(186003)(107886003)(256004)(6506007)(14454004)(99286004)(14444005)(6246003)(53546011)(5660300001)(25786009)(8676002)(7696005)(86362001)(4326008)(76176011)(575784001)(2201001)(2906002)(54906003)(102836004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2702;H:MWHPR01MB2336.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: fb3a1c86-bbb3-4516-26a4-08d613f77a54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2702;
x-ms-traffictypediagnostic: MWHPR01MB2702:
x-microsoft-antispam-prvs: <MWHPR01MB27028722627188CFCF0EF5F2B3010@MWHPR01MB2702.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:MWHPR01MB2702;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2702;
x-forefront-prvs: 0787459938
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: jdi5jchABr1LbEMpCFKTuiqoVvt5rKHAzPJJaOr+V65Qqjqvmhbdmf2ceD5EFbB7LnYDuLMztHQUbIJNHsfdAnzr5NmPencFBWn52YCohROBicWY8K6LQ1c5G92JLRuZ5ACjjoRbZRbT+PPkgat82CJPFcOZLUOYH/D5OJ4WT0gBvkAK0LDCZDViswLCfG5mNtUEBwLPym/fFFFM5wlBZQoYnxDi5/m7geuhoeajRR974fJ0Xw7JaqRkVLZHOWWfK7hlmJB+Q3STIVyH3xH+8IpgLr4YWfXujsddwq+1sJm2cWAURj9ZCp+YMx9Kn995N7r86GDLcsF4I2QPpO2249jMV3MR4F9cl3lMmihmnmg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3a1c86-bbb3-4516-26a4-08d613f77a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 12:51:34.5938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KSSByYW4gY2hlY2twYXRjaCBhbmQgc2VlIG5vIGVycm9yLiBJIHdpbGwgY2hl
Y2sgbXkgZ2l0LXNlbmQtZW1haWwNCg0Kc2NyaXB0cy9jaGVja3BhdGNoLnBsICAwMDAxLWF0YS1E
aXNhYmxlLUFIQ0ktQUxQTS1mZWF0dXJlLWZvci1BbXBlcmUtQ29tcHV0aW5nLWUucGF0Y2ggdG90
YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCAzOSBsaW5lcyBjaGVja2VkDQoNCjAwMDEtYXRhLURp
c2FibGUtQUhDSS1BTFBNLWZlYXR1cmUtZm9yLUFtcGVyZS1Db21wdXRpbmctZS5wYXRjaCBoYXMg
bm8gb2J2aW91cyBzdHlsZSBwcm9ibGVtcyBhbmQgaXMgcmVhZHkgZm9yIHN1Ym1pc3Npb24uDQoN
Cg0KV2l0aCByZWdhcmRzLA0KU3VtYW4NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPiANClNlbnQ6IFRodXJz
ZGF5LCBTZXB0ZW1iZXIgNiwgMjAxOCAxMjozMiBBTQ0KVG86IFN1bWFuIFRyaXBhdGhpIDxzdHJp
cGF0aGlAYW1wZXJlY29tcHV0aW5nLmNvbT47IGF4Ym9lQGtlcm5lbC5kazsgdGpAa2VybmVsLm9y
ZzsgbGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBqb2VAcGVyY2hlcy5jb207
IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQpDYzogT3BlbiBTb3Vy
Y2UgU3VibWlzc2lvbiA8cGF0Y2hlc0BhbXBlcmVjb21wdXRpbmcuY29tPjsgUmFtZXNod2FyIFNh
aHUgPFJhbWVzaHdhci5TYWh1QGFtcGVyZWNvbXB1dGluZy5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIHYzXSBhdGE6IERpc2FibGUgQUhDSSBBTFBNIGZlYXR1cmUgZm9yIEFtcGVyZSBDb21wdXRp
bmcgZU1BRyBTQVRBDQoNCltOT1RJQ0U6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIGFuIGV4
dGVybmFsIHNlbmRlci4gUGxlYXNlIGJlIG1pbmRmdWwgb2Ygc2FmZSBlbWFpbCBoYW5kbGluZyBh
bmQgcHJvcHJpZXRhcnkgaW5mb3JtYXRpb24gcHJvdGVjdGlvbiBwcmFjdGljZXMuXSBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cg0KSGksDQoNCk9uIDA2LTA5LTE4IDA2OjMzLCBTdW1hbiBUcmlwYXRoaSB3cm90ZToNCj4gRHVl
IHRvIGhhcmR3YXJlIGVycmF0YSwgQW1wZXJlIENvbXB1dGluZyBlTUFHIFNBVEEgY2FuJ3Qgc3Vw
cG9ydCBBSENJIA0KPiBBTFBNIGZlYXR1cmUuIFRoaXMgcGF0Y2ggZGlzYWJsZXMgdGhlIEFIQ0kg
QUxQTSBmZWF0dXJlIGZvciBlTUFHIFNBVEEuDQo+DQo+IENoYW5nZXMgZm9yIHYyOg0KPg0KPiAq
IEludHJvZHVjZSB0aGUgbmV3IGF0YV9wb3J0X2luZm8gb2JqZWN0IHdoaWNoIGluY2x1ZGVzIEFU
QV9GTEFHX05PX0xQTS4NCj4gKiBJbmNsdWRlIHRoaXMgb2JqZWN0IGZvciBlTUFHIFNBVEEgaW5z
aWRlIHRoZSBhY3BpIG1hdGNoIHRhYmxlLg0KPiAqIFJldHJpZXZlIHRoZSBhdGFfcG9ydF9pbmZv
IGZyb20gdGhlIGFjcGkgbWF0Y2ggdGFibGUuDQo+DQo+IENoYW5nZXMgZm9yIHYzOg0KPg0KPiAq
IEZpeCB0aGUgaW5kZW50YXRpb24gYW5kIHdoaXRlc3BhY2Ugd2FybmluZ3MuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFN1bWFuIFRycGF0aGkgPHN0cmlwYXRoaUBhbXBlcmVjb21wdXRpbmcuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBSYW1lc2h3YXIgUHJhc2FkIFNhaHUgDQo+IDxyYW1lc2h3YXIuc2Fo
dUBhbXBlcmVjb21wdXRpbmcuY29tPg0KDQpTbWFsbCByZW1hcmssIG5vcm1hbGx5IHRoZSBjaGFu
Z2Vsb2cgaXMgcHV0IGFmdGVyIHRoZSBTaWduZWQtb2ZmLWJ5IG1lc3NhZ2VzIGxpa2UNCnRoaXM6
DQoNCiIiIg0KU2lnbmVkLW9mZi1ieTogU3VtYW4gVHJwYXRoaSA8c3RyaXBhdGhpQGFtcGVyZWNv
bXB1dGluZy5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSYW1lc2h3YXIgUHJhc2FkIFNhaHUgPHJhbWVz
aHdhci5zYWh1QGFtcGVyZWNvbXB1dGluZy5jb20+DQotLS0NCkNoYW5nZXMgZm9yIHYzOg0KKiBG
aXggdGhlIGluZGVudGF0aW9uIGFuZCB3aGl0ZXNwYWNlIHdhcm5pbmdzLg0KDQpDaGFuZ2VzIGZv
ciB2MjoNCg0KKiBJbnRyb2R1Y2UgdGhlIG5ldyBhdGFfcG9ydF9pbmZvIG9iamVjdCB3aGljaCBp
bmNsdWRlcyBBVEFfRkxBR19OT19MUE0uDQoqIEluY2x1ZGUgdGhpcyBvYmplY3QgZm9yIGVNQUcg
U0FUQSBpbnNpZGUgdGhlIGFjcGkgbWF0Y2ggdGFibGUuDQoqIFJldHJpZXZlIHRoZSBhdGFfcG9y
dF9pbmZvIGZyb20gdGhlIGFjcGkgbWF0Y2ggdGFibGUuDQoiIiINCg0KVGhpcyB3aWxsIGNhdXNl
IGdpdCBhbSB0byByZW1vdmUgaXQsIHNvIHRoYXQgdGhlIGdpdCBoaXN0b3J5IGp1c3QgaGFzIHlv
dXIgb3JpZ2luYWwgY29tbWl0IG1lc3NhZ2UuDQoNCkJ5IGl0c2VsZiB0aGlzIHdvdWxkIG5vdCBi
ZSBhIHJlYXNvbiB0byByZXF1ZXN0IGEgbmV3IHZlcnNpb24sIGJ1dCBpdCBzZWVtcyB5b3UndmUg
Y29weSBhbmQgcGFzdGVkIHRoZSBwYXRjaCBmcm9tICJnaXQgZm9ybWF0LXBhdGNoIiBvdXRwdXQg
aW50byB5b3UgbWFpbCBjbGllbnQuIEkgdHJpZWQgdG8gcnVuIGNoZWNrcGF0Y2ggbXlzZWxmIHRv
IG1ha2Ugc3VyZSB5b3UgY2F1Z2h0IGFsbCB3aGl0ZXNwYWNlIGlzc3VlcyBhbmQgSSBnb3QgdGhp
czoNCg0KW2hhbnNAc2hhbGVtIGxpbnV4XSQgc2NyaXB0cy9jaGVja3BhdGNoLnBsIH4vXFtQQVRD
SFwgdjNcXVwgYXRhXDpcIERpc2FibGVcIEFIQ0lcIEFMUE1cIGZlYXR1cmVcIGZvclwgQW1wZXJl
XCBDb21wdXRpbmdcIGVNQUdcIFNBVEEuZW1sDQpFUlJPUjogcGF0Y2ggc2VlbXMgdG8gYmUgY29y
cnVwdCAobGluZSB3cmFwcGVkPykNCiMxNzc6IEZJTEU6IGRyaXZlcnMvYXRhL2FoY2lfcGxhdGZv
cm0uYzozNDoNCg0KDQpFUlJPUjogRE9TIGxpbmUgZW5kaW5ncw0KIzE3ODogRklMRTogZHJpdmVy
cy9hdGEvYWhjaV9wbGF0Zm9ybS5jOjM1Og0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXRhX3BvcnRf
aW5mbyBhaGNpX3BvcnRfaW5mb19ub2xwbSA9IHteTSQNCg0KRVJST1I6IERPUyBsaW5lIGVuZGlu
Z3MNCiMxNzk6IEZJTEU6IGRyaXZlcnMvYXRhL2FoY2lfcGxhdGZvcm0uYzozNjoNCiteSS5mbGFn
c15JXkk9IEFIQ0lfRkxBR19DT01NT04gfCBBVEFfRkxBR19OT19MUE0sXk0kDQoNCkVSUk9SOiBE
T1MgbGluZSBlbmRpbmdzDQojMTgwOiBGSUxFOiBkcml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmM6
Mzc6DQorXkkucGlvX21hc2teST0gQVRBX1BJTzQsXk0kDQoNCkVSUk9SOiBET1MgbGluZSBlbmRp
bmdzDQojMTgxOiBGSUxFOiBkcml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmM6Mzg6DQorXkkudWRt
YV9tYXNrXkk9IEFUQV9VRE1BNixeTSQNCg0KRm9sbG93ZWQgYnkgbG90cyBtb3JlIGVycm9ycywg
bGluZSAxNzcgb2YgdGhlIGVtYWlsIGlzIGVtcHR5LCB3aGlsZSBpdCBzaG91bGQgY29udGFpbiBh
IHNpbmdsZSBzcGFjZS4gVGhpcyBzdHJpcHBpbmcgb2Ygd2hpdGVzcGFjZSB0eXBpY2FsbHkgaXMg
dGhlIHJlc3VsdCBvZiBjb3B5IHBhc3Rpbmcgb3Igc29tZSBvdGhlciBwcm9jZXNzaW5nIG9mIHRo
ZSBwYXRjaC4NCg0KUGxlYXNlIHRyeSB0byByZS1zZW5kIHYzIHVzaW5nIHRoZSAiZ2l0IHNlbmQt
ZW1haWwiIGNvbW1hbmQsIHNvIHRoYXQgd2UgZ2V0IGEgcGF0Y2ggd2hpY2ggd2UgY2FuIGFjdHVh
bGx5IGFwcGx5Lg0KDQpSZWdhcmRzLA0KDQpIYW5zDQoNCg0KDQoNCg0KPiAtLS0NCj4gICBkcml2
ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMgfCAxNSArKysrKysrKysrKysrKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jIGIvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9y
bS5jIA0KPiBpbmRleCA5OWY5YTg5Li45YmEyODNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2F0
YS9haGNpX3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jDQo+
IEBAIC0zMyw2ICszMywxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0YV9wb3J0X2luZm8gYWhj
aV9wb3J0X2luZm8gPSB7DQo+ICAgICAgIC5wb3J0X29wcyAgICAgICA9ICZhaGNpX3BsYXRmb3Jt
X29wcywNCj4gICB9Ow0KPg0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9pbmZvIGFo
Y2lfcG9ydF9pbmZvX25vbHBtID0gew0KPiArICAgICAuZmxhZ3MgICAgICAgICAgPSBBSENJX0ZM
QUdfQ09NTU9OIHwgQVRBX0ZMQUdfTk9fTFBNLA0KPiArICAgICAucGlvX21hc2sgICAgICAgPSBB
VEFfUElPNCwNCj4gKyAgICAgLnVkbWFfbWFzayAgICAgID0gQVRBX1VETUE2LA0KPiArICAgICAu
cG9ydF9vcHMgICAgICAgPSAmYWhjaV9wbGF0Zm9ybV9vcHMsDQo+ICt9Ow0KPiArDQo+ICAgc3Rh
dGljIHN0cnVjdCBzY3NpX2hvc3RfdGVtcGxhdGUgYWhjaV9wbGF0Zm9ybV9zaHQgPSB7DQo+ICAg
ICAgIEFIQ0lfU0hUKERSVl9OQU1FKSwNCj4gICB9Ow0KPiBAQCAtNDEsNiArNDgsNyBAQCBzdGF0
aWMgaW50IGFoY2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICB7DQo+
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAgICAgIHN0cnVjdCBh
aGNpX2hvc3RfcHJpdiAqaHByaXY7DQo+ICsgICAgIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9pbmZv
ICpwb3J0Ow0KPiAgICAgICBpbnQgcmM7DQo+DQo+ICAgICAgIGhwcml2ID0gYWhjaV9wbGF0Zm9y
bV9nZXRfcmVzb3VyY2VzKHBkZXYpOw0KPiBAQCAtNTcsNyArNjUsMTEgQEAgc3RhdGljIGludCBh
aGNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgIGlmIChvZl9k
ZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJoaXNpbGljb24saGlzaS1haGNpIikp
DQo+ICAgICAgICAgICAgICAgaHByaXYtPmZsYWdzIHw9IEFIQ0lfSEZMQUdfTk9fRkJTIHwgQUhD
SV9IRkxBR19OT19OQ1E7DQo+DQo+IC0gICAgIHJjID0gYWhjaV9wbGF0Zm9ybV9pbml0X2hvc3Qo
cGRldiwgaHByaXYsICZhaGNpX3BvcnRfaW5mbywNCj4gKyAgICAgcG9ydCA9IGFjcGlfZGV2aWNl
X2dldF9tYXRjaF9kYXRhKGRldik7DQo+ICsgICAgIGlmICghcG9ydCkNCj4gKyAgICAgICAgICAg
ICBwb3J0ID0gJmFoY2lfcG9ydF9pbmZvOw0KPiArDQo+ICsgICAgIHJjID0gYWhjaV9wbGF0Zm9y
bV9pbml0X2hvc3QocGRldiwgaHByaXYsIHBvcnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJmFoY2lfcGxhdGZvcm1fc2h0KTsNCj4gICAgICAgaWYgKHJjKQ0KPiAgICAg
ICAgICAgICAgIGdvdG8gZGlzYWJsZV9yZXNvdXJjZXM7DQo+IEBAIC04NSw2ICs5Nyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFoY2lfb2ZfbWF0Y2hbXSA9IHsNCj4gICBN
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhaGNpX29mX21hdGNoKTsNCj4NCj4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGFoY2lfYWNwaV9tYXRjaFtdID0gew0KPiArICAgICB7
ICJBUE1DMEQzMyIsICh1bnNpZ25lZCBsb25nKSZhaGNpX3BvcnRfaW5mb19ub2xwbSB9LA0KPiAg
ICAgICB7IEFDUElfREVWSUNFX0NMQVNTKFBDSV9DTEFTU19TVE9SQUdFX1NBVEFfQUhDSSwgMHhm
ZmZmZmYpIH0sDQo+ICAgICAgIHt9LA0KPiAgIH07DQo+IC0tDQo+IDIuNy40DQo+DQo=
