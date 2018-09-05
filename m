Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5074C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A0B2086D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="p7QpdwGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A0B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeIFAxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:53:05 -0400
Received: from mail-co1nam03on0133.outbound.protection.outlook.com ([104.47.40.133]:54816
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727527AbeIFAxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRAthMXDVmoSK6Co7sLgEwSfuV+HdCaVPBY7UnpJWRY=;
 b=p7QpdwGJK04XsdKEQCsgRmPBizvfYImsTY5OPU0ah2qVSRkMrXZK+uEzKTCNeiBo+9L6/RtmID1IcAEYCW96HNTSI7oPDl14XwPSy8FILDJyegijqocbs64pIygvsU3F2bMQ6q5RvFJN3/E0z5dWiPDFYjlTuaPDBpOrXYT83NQ=
Received: from MWHPR01MB2336.prod.exchangelabs.com (10.169.237.8) by
 MWHPR01MB2719.prod.exchangelabs.com (10.172.165.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 20:21:12 +0000
Received: from MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab]) by MWHPR01MB2336.prod.exchangelabs.com
 ([fe80::c086:ef30:bfc3:29ab%9]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 20:21:11 +0000
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
Subject: RE: [PATCH v2] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Topic: [PATCH v2] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
Thread-Index: AQHURVTe00l27CjeWU65jRCK1oP4VqTiH9uAgAABVZA=
Date:   Wed, 5 Sep 2018 20:21:11 +0000
Message-ID: <MWHPR01MB2336D986A5C5E74E0F3D008FB3020@MWHPR01MB2336.prod.exchangelabs.com>
References: <1536178375-31700-1-git-send-email-stripathi@amperecomputing.com>
 <e865f801-dc68-7583-62a0-40579c324e84@redhat.com>
In-Reply-To: <e865f801-dc68-7583-62a0-40579c324e84@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR01MB2719;6:SBY4owEt/iQ/n1XsTXRrogbH1GcLOtgGdI8d0r0qb83jIGDoZzDQouI8Ktcr7Q4GBMpYp1MYwBVPr+PrOXntlkAaCMektRmSojFUtn2TiXpmpqtGqAThFsp+R7URjEj5Wp9UGvzOl1MIt9JbA2gUpO9S7b/12vx3bnNHAupvt0l+cRE+BLb9PDWO4OxEUbIK5ArodxVT43/vnVXlr3RMtQmt+0JD8bp/G+Xu3ZV+Y3UwrVYVflxdPLyWnAY/mlVbWlz3+3gmkNjj/C7PRvaeN+jT1gnkmWO2UTFWhEVucis8nCZlUrCfZ8oNhmfDyFtUMsvj6dhlstdgqw3K6A+wfvCz5THN9keWd+v4R0QpLfdayh19xWtjrW2HdPxlQoIM4AwYQSlb5ks66mk+Vi1V3oy9jDvHG9xg+hIjcEdWZ6xK6qaMLtT/SCexm98ZGTHoixDVY2br1oreNvTfSRIqNw==;5:YxJKpY2oPpP9iuq0lzNjgI9CHDOHCdR4ev3tvBSbSu4xKaEjIJdV7m+KlSW5NsDgxpxlMBiOoQPKwLCv+cbkycJu9W+DNEy2ANBzvn398fQzGTbYzhFDgE9sTvvk/hcYam+WF6emIaKH+Zc/wVxLsBHhEIBJc+CynQqjQBvDFjQ=;7:mCSwZgEGCOSYI8hqll2mFFmzlhn8pmmRxpnp4MbO4xuWZMRhTs242PUvNcIN83YbaC3Wz8VaI3bnXi19SVHFiwK3kryWGO29Jam0K8qltB6zhAM6SzV6Bjdbzw8j1azA0LQpb3Pqv7b6eFBl7x57GNPG3vh64U5UooXo26o9dyzi0JwZI1cU089tbnH+RvhVXNS/D911ERdL2XiCnJ6/SnhLe9zJHHknnMh73ktmdj9XZVINuPeDKwtsFQcYf0vc
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39840400004)(366004)(13464003)(199004)(189003)(53936002)(3846002)(7736002)(229853002)(7696005)(55016002)(68736007)(575784001)(33656002)(2201001)(217873002)(76176011)(74316002)(9686003)(6436002)(99286004)(8676002)(476003)(26005)(102836004)(2906002)(53546011)(25786009)(6506007)(4326008)(66066001)(8936002)(86362001)(256004)(14444005)(107886003)(305945005)(5660300001)(81156014)(81166006)(14454004)(6246003)(446003)(106356001)(186003)(2501003)(11346002)(97736004)(486006)(5250100002)(316002)(2900100001)(54906003)(478600001)(105586002)(110136005)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2719;H:MWHPR01MB2336.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 2ad484c2-46d0-4b3b-9499-08d6136d1f66
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2719;
x-ms-traffictypediagnostic: MWHPR01MB2719:
x-microsoft-antispam-prvs: <MWHPR01MB2719DE66E29AE1652A389213B3020@MWHPR01MB2719.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR01MB2719;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2719;
x-forefront-prvs: 078693968A
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 57HSXWk2PC8WV9wWAAfMZFSZWRKc04ptMruwYYcgIn/dw7cEDwew6njY7hVpQ65FDkF7OEEoy1TvZaxBTBZEpZaeimg+yj8oQo3mJMuXY3Do38ini8ZoQ4qB/XGxVQX0/i3GQyCUZ44AARSa6GEIWPeWQ+jzvPsRrBYG4RKFR3T6B3EyJuTdOLVa7Me+38MKu/nv22wWWg2cX8I5ZkG7T+XJI21D9HFd7z+V3Fov78ZF7dX8JqC2Cy5rhGYwTleXRTypCTxhJFZEkHlE1MYcL/bwFNHkGwd1PoiQ77jzqYwJ6BLG0NfqKEZToK+IJsGgqOBzrrHWghBNP7eX7GGUIQoU5Y7UqWDagJQJO/JWl8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad484c2-46d0-4b3b-9499-08d6136d1f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 20:21:11.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucw0KDQpUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmV2aWV3ICEhDQoNCg0KV2l0aCByZWdh
cmRzLA0KU3VtYW4NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYW5z
IGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDUsIDIwMTggMToxNiBQTQ0KVG86IFN1bWFuIFRyaXBhdGhpIDxzdHJpcGF0aGlAYW1wZXJl
Y29tcHV0aW5nLmNvbT47IGF4Ym9lQGtlcm5lbC5kazsgdGpAa2VybmVsLm9yZzsgbGludXgtaWRl
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBqb2VAcGVyY2hlcy5jb207IGFybmRAYXJuZGIu
ZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQpDYzogT3BlbiBTb3VyY2UgU3VibWlzc2lv
biA8cGF0Y2hlc0BhbXBlcmVjb21wdXRpbmcuY29tPjsgUmFtZXNod2FyIFNhaHUgPFJhbWVzaHdh
ci5TYWh1QGFtcGVyZWNvbXB1dGluZy5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBhdGE6
IERpc2FibGUgQUhDSSBBTFBNIGZlYXR1cmUgZm9yIEFtcGVyZSBDb21wdXRpbmcgZU1BRyBTQVRB
DQoNCltOT1RJQ0U6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIGFuIGV4dGVybmFsIHNlbmRl
ci4gUGxlYXNlIGJlIG1pbmRmdWwgb2Ygc2FmZSBlbWFpbCBoYW5kbGluZyBhbmQgcHJvcHJpZXRh
cnkgaW5mb3JtYXRpb24gcHJvdGVjdGlvbiBwcmFjdGljZXMuXSBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KSGksDQoNCk9u
IDA1LTA5LTE4IDIyOjEyLCBTdW1hbiBUcmlwYXRoaSB3cm90ZToNCj4gRHVlIHRvIGhhcmR3YXJl
IGVycmF0YSwgQW1wZXJlIENvbXB1dGluZyBlTUFHIFNBVEEgY2FuJ3Qgc3VwcG9ydCBBSENJIA0K
PiBBTFBNIGZlYXR1cmUuIFRoaXMgcGF0Y2ggZGlzYWJsZXMgdGhlIEFIQ0kgQUxQTSBmZWF0dXJl
IGZvciBlTUFHIFNBVEEuDQo+DQo+IENoYW5nZXMgZm9yIHYyOg0KPg0KPiAqIEludHJvZHVjZSB0
aGUgbmV3IGF0YV9wb3J0X2luZm8gb2JqZWN0IHdoaWNoIGluY2x1ZGVzIEFUQV9GTEFHX05PX0xQ
TS4NCj4gKiBJbmNsdWRlIHRoaXMgb2JqZWN0IGZvciBlTUFHIFNBVEEgaW5zaWRlIHRoZSBhY3Bp
IG1hdGNoIHRhYmxlLg0KPiAqIFJldHJpZXZlIHRoZSBhdGFfcG9ydF9pbmZvIGZyb20gdGhlIGFj
cGkgbWF0Y2ggdGFibGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFN1bWFuIFRycGF0aGkgPHN0cmlw
YXRoaUBhbXBlcmVjb21wdXRpbmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSYW1lc2h3YXIgUHJh
c2FkIFNhaHUgDQo+IDxyYW1lc2h3YXIuc2FodUBhbXBlcmVjb21wdXRpbmcuY29tPg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMgfCAxNyArKysrKysrKysrKysrKystLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvYWhjaV9wbGF0Zm9ybS5jIGIvZHJpdmVycy9hdGEv
YWhjaV9wbGF0Zm9ybS5jIA0KPiBpbmRleCA5OWY5YTg5Li5jMzA0M2Y2IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2F0YS9haGNpX3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVycy9hdGEvYWhjaV9w
bGF0Zm9ybS5jDQo+IEBAIC0zMyw2ICszMywxMyBAQA0KPiAgICAgICAucG9ydF9vcHMgICAgICAg
PSAmYWhjaV9wbGF0Zm9ybV9vcHMsDQo+ICAgfTsNCj4NCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
YXRhX3BvcnRfaW5mbyBhaGNpX3BvcnRfaW5mb19ub2xwbSA9IHsNCj4gKyAgICAgLmZsYWdzICAg
ICAgICAgID0gQUhDSV9GTEFHX0NPTU1PTiB8IEFUQV9GTEFHX05PX0xQTSwNCj4gKyAgICAgLnBp
b19tYXNrICAgICAgID0gQVRBX1BJTzQsDQo+ICsgICAgIC51ZG1hX21hc2sgICAgICA9IEFUQV9V
RE1BNiwNCj4gKyAgICAgLnBvcnRfb3BzICAgICAgID0gJmFoY2lfcGxhdGZvcm1fb3BzLA0KPiAr
fTsNCj4gKw0KPiAgIHN0YXRpYyBzdHJ1Y3Qgc2NzaV9ob3N0X3RlbXBsYXRlIGFoY2lfcGxhdGZv
cm1fc2h0ID0gew0KPiAgICAgICBBSENJX1NIVChEUlZfTkFNRSksDQo+ICAgfTsNCj4gQEAgLTQx
LDcgKzQ4LDggQEAgc3RhdGljIGludCBhaGNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAgew0KPiAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0K
PiAgICAgICBzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYgKmhwcml2Ow0KPiAtICAgICBpbnQgcmM7DQo+
ICsgICAgIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9pbmZvICpwb3J0Ow0KPiArICAgICAgICBpbnQg
cmM7DQoNCllvdSBhcmUgYWNjaWRlbnRhbGx5IGNoYW5naW5nIHRoZSBpbmRlbnRhdGlvbiBvZiBy
YyBoZXJlLg0KW1N1bWFuIFRyaXBhdGhpXSB5ZXMgd2lsbCBmaXggaW4gdjMNCg0KUGxlYXNlIGZp
eCB0aGlzIGFuZCBydW4gc2NyaXB0cy9jaGVja3BhdGNoLnBsIG9uIHRoZSBwYXRjaCBiZWZvcmUg
c3VibWl0dGluZyB2My4gT3RoZXJ3aXNlIHYyIGxvb2tzIGdvb2QuDQoNClJlZ2FyZHMsDQoNCkhh
bnMNCg0KDQoNCg0KDQoNCj4NCj4gICAgICAgaHByaXYgPSBhaGNpX3BsYXRmb3JtX2dldF9yZXNv
dXJjZXMocGRldik7DQo+ICAgICAgIGlmIChJU19FUlIoaHByaXYpKQ0KPiBAQCAtNTcsNyArNjUs
MTEgQEAgc3RhdGljIGludCBhaGNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICAgICAgIGlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJoaXNp
bGljb24saGlzaS1haGNpIikpDQo+ICAgICAgICAgICAgICAgaHByaXYtPmZsYWdzIHw9IEFIQ0lf
SEZMQUdfTk9fRkJTIHwgQUhDSV9IRkxBR19OT19OQ1E7DQo+DQo+IC0gICAgIHJjID0gYWhjaV9w
bGF0Zm9ybV9pbml0X2hvc3QocGRldiwgaHByaXYsICZhaGNpX3BvcnRfaW5mbywNCj4gKyAgICAg
cG9ydCA9IGFjcGlfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ICsgICAgIGlmICghcG9y
dCkNCj4gKyAgICAgICAgICAgICBwb3J0ID0gJmFoY2lfcG9ydF9pbmZvOw0KPiArDQo+ICsgICAg
IHJjID0gYWhjaV9wbGF0Zm9ybV9pbml0X2hvc3QocGRldiwgaHByaXYsIHBvcnQsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFoY2lfcGxhdGZvcm1fc2h0KTsNCj4gICAg
ICAgaWYgKHJjKQ0KPiAgICAgICAgICAgICAgIGdvdG8gZGlzYWJsZV9yZXNvdXJjZXM7DQo+IEBA
IC04NSw2ICs5Nyw3IEBAIHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhhaGNpX3BtX29wcywgYWhj
aV9wbGF0Zm9ybV9zdXNwZW5kLA0KPiAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFoY2lfb2Zf
bWF0Y2gpOw0KPg0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgYWhjaV9h
Y3BpX21hdGNoW10gPSB7DQo+ICsgICAgIHsgIkFQTUMwRDMzIiwgKHVuc2lnbmVkIGxvbmcpJmFo
Y2lfcG9ydF9pbmZvX25vbHBtIH0sDQo+ICAgICAgIHsgQUNQSV9ERVZJQ0VfQ0xBU1MoUENJX0NM
QVNTX1NUT1JBR0VfU0FUQV9BSENJLCAweGZmZmZmZikgfSwNCj4gICAgICAge30sDQo+ICAgfTsN
Cj4NCg==
