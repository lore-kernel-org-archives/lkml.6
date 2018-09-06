Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C3CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5671F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RnG/xm5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5671F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeIFUaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:30:10 -0400
Received: from mail-dm3nam03on0050.outbound.protection.outlook.com ([104.47.41.50]:39504
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730149AbeIFUaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijg9jPB05u13TNqyy6WmZcJRjK1Z2zA3WkRLPtAlG+U=;
 b=RnG/xm5QvVmr6MssImZ4Sp/OfEU600rs2x3KDE1Dx4seBHWA7mZ2xtAt4wEnp0a53raBv+qVB2Z8b+mCdfPhMBa/CG6pnpklH/H5KuQL4Wy150dSvzRS7oMUHEqO5pSFFanarJtbwleyKkvy0j6DW9TU5/E7cPcRREgKuf44FfA=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4108.namprd02.prod.outlook.com (20.176.75.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 6 Sep 2018 15:53:54 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644%3]) with mapi id 15.20.1080.020; Thu, 6 Sep 2018
 15:53:54 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Topic: [PATCH v5 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Index: AQHUQS6BQY0T0l0NbUuoLQoaTAo9uKTgXqMAgAMM2bA=
Date:   Thu, 6 Sep 2018 15:53:54 +0000
Message-ID: <DM6PR02MB522730A32310C1CBB2971B61C1010@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-2-git-send-email-manish.narani@xilinx.com>
 <20180904165828.GM32615@zn.tnic>
In-Reply-To: <20180904165828.GM32615@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4108;6:rcoI5w5mpxy5bnEly9p+5N9PVbxwu7wFVlnDfWqGv/aXD1Q37lQ3LuP11nX3Q7gU8iqk7tP5iIZ+FvJK6aaHJmAv2Md+tNT+aCCeTDROSHVPFKH/fILaZUzW0pWiV7l2aWcb8aqx/y+EozAQJqoJOyb0gvxv1zftQLuL7omYKP8eqtSi+pNYrexNDcMK0sgtHu3THZSE2RQ2AH3YoaAAGrxUtG4VKUpBhLkQc7n3Gw8mQFPJlb/SfO3/92TUV9/Th4N4CfgTyHhZ+omy9VkQ2jGek3OordVTRhI+Xg7jxGhzZydwvHsyCoSQTgafo/1MMtrJi8kjwXgWaTjM3iu1fXLAB0WM+Iria+XfH2WXWmIJCWcdhMS0TmcpD0+MRXE2DHvGYdMGqLNPZ4GgUtXGuXnS1IdGgg8MFRrENcimf8ZzD0c0lbF2AHYu/NfTQ5N5VTketDGhyYC4QlIhkeJejw==;5:vX9dn4VEourRMVW0AcY2nmTot2FTpbM2qGw9u4Iid9pH0dAmuNTcPn7deDUttT0zMh0qYyoiv6FZOfK2neoYg6If1qdE2+FP1bZ3NXztvb3DiWco3LhNl4nD7q7hg5Vga7lnrZmEwrlPwR1eVWOkXSIWR/dDBRua2TCO9qJDzaE=;7:GM+dgBchftaamQg+rMgy0WetAZ4oiJ+v1dKUpNfmhHhhmxgv8xYHpOAE93fX9T1oWh2dPyVn6PZllzSHNtx2i2+28oe8MxJoyn4s2LgZ2zBimmO/aDEcdvK89jRc0wXeDl4EUht9SJ8K8SOP52QUudr8agTpJuM5n9SY+eCrFHiMnDiOUGhbbEge82vYmiXxLphrZijVghuO3zqYKTGTfXYFsWkC9hT80fRHkMcM73uL/HAGb9ALsfU0x55QkMhY
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 0a1de350-0bd9-46fe-21bd-08d61410f2e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4108;
x-ms-traffictypediagnostic: DM6PR02MB4108:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB4108D1777842F67BFDC46ACDC1010@DM6PR02MB4108.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR02MB4108;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4108;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(346002)(136003)(13464003)(189003)(199004)(72206003)(6116002)(6436002)(81156014)(14444005)(256004)(186003)(478600001)(81166006)(53546011)(26005)(8936002)(5250100002)(486006)(66066001)(229853002)(33656002)(446003)(54906003)(6916009)(105586002)(3846002)(5660300001)(6506007)(106356001)(476003)(316002)(11346002)(97736004)(25786009)(6246003)(68736007)(7416002)(76176011)(53936002)(305945005)(7736002)(7696005)(74316002)(102836004)(4326008)(8676002)(55016002)(99286004)(86362001)(2900100001)(9686003)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4108;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 473QtNb/73WxpgAbaZbCvdIQlyDdlHsqK2BQWkFcTKQCzfIiObaMqS+KHJoDv7nKxgCabH06UXBgPHEWZo/lqEcB30n549sCE54Y86q85I7TItdstXcOIvCX+ZtgHzSTUFGgVIdZ2s/zymrSkPi1cp63NagSgYeb8dLE35fAJ/V5zeyGRRpNL6KjpLU53nK1Tp9wte+QsU1XRZPGYbN4FdvWfwGwjulsuy3RdbL7Xs3hm1UMqJ0SVlQvhM2HMNtll5Y7APjX/adgJ5kLeWTJ4K9WsNAvD0+GLfBsHgYZ9qgF7Dp2xP1hmvEcBc9o2El0bnnBLhX8xVvfKB7CRRDoQG26MBXfrtZ06BSBnhM5Qg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1de350-0bd9-46fe-21bd-08d61410f2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 15:53:54.5048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHJldmlldy4gUGxlYXNlIHNlZSBteSBj
b21tZW50cyBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Qm9yaXNsYXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgNCwgMjAxOCAxMDoyOCBQTQ0KPiBUbzogTWFuaXNoIE5hcmFuaSA8TU5BUkFOSUB4
aWxpbnguY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBtY2hlaGFiQGtlcm5lbC5v
cmc7IGxlb3lhbmcubGlAbnhwLmNvbTsNCj4gYW1pdC5rdWNoZXJpYUBsaW5hcm8ub3JnOyBvbG9m
QGxpeG9tLm5ldDsgU3Jpbml2YXMgR291ZCA8c2dvdWRAeGlsaW54LmNvbT47DQo+IEFuaXJ1ZGhh
IFNhcmFuZ2kgPGFuaXJ1ZGhAeGlsaW54LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBlZGFjQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY1IDEvNF0gZWRhYzogc3lucHM6IEFkZCBwbGF0Zm9ybSBzcGVjaWZpYyBz
dHJ1Y3R1cmVzIGZvcg0KPiBkZHJjIGNvbnRyb2xsZXINCj4gDQo+IE9uIEZyaSwgQXVnIDMxLCAy
MDE4IGF0IDA2OjU3OjQ3UE0gKzA1MzAsIE1hbmlzaCBOYXJhbmkgd3JvdGU6DQo+ID4gQWRkIHBs
YXRmb3JtIHNwZWNpZmljIHN0cnVjdHVyZXMsIHNvIHRoYXQgd2UgY2FuIGFkZCBkaWZmZXJlbnQg
SVANCj4gPiBzdXBwb3J0IGxhdGVyIHVzaW5nIHF1aXJrcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyB8IDc4DQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU5IGlu
c2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFj
LmMgaW5kZXggMGM5YzU5ZS4uMjQ3MGQzNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2VkYWMv
c3lub3BzeXNfZWRhYy5jDQo+ID4gKysrIGIvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYw0K
PiA+DQo+ID4gIC8qKg0KPiA+ICsgKiBzdHJ1Y3Qgc3lucHNfcGxhdGZvcm1fZGF0YSAtICBzeW5w
cyBwbGF0Zm9ybSBkYXRhIHN0cnVjdHVyZQ0KPiA+ICsgKiBAZWRhY19nZXRlcnJvcl9pbmZvOglm
dW5jdGlvbiBwb2ludGVyIHRvIHN5bnBzIGVkYWMgZXJyb3IgaW5mbw0KPiA+ICsgKiBAZWRhY19n
ZXRfbXR5cGU6CWZ1bmN0aW9uIHBvaW50ZXIgdG8gc3lucHMgZWRhYyBtdHlwZQ0KPiA+ICsgKiBA
ZWRhY19nZXRfZHR5cGU6CWZ1bmN0aW9uIHBvaW50ZXIgdG8gc3lucHMgZWRhYyBkdHlwZQ0KPiA+
ICsgKiBAZWRhY19nZXRfZWNjc3RhdGU6CWZ1bmN0aW9uIHBvaW50ZXIgdG8gc3lucHMgZWRhYyBl
Y2NzdGF0ZQ0KPiA+ICsgKiBAcXVpcmtzOgkJdG8gZGlmZmVyZW50aWF0ZSBJUHMNCj4gDQo+IEtp
bGwgYWxsIHRoYXQgImZ1bmN0aW9uIHBvaW50ZXIiIGZsdWZmLiBIZXJlJ3MgaG93IEkndmUgY2hh
bmdlZCBpdDoNCj4gDQo+IC8qKg0KPiAgKiBzdHJ1Y3Qgc3lucHNfcGxhdGZvcm1fZGF0YSAtICBz
eW5wcyBwbGF0Zm9ybSBkYXRhIHN0cnVjdHVyZQ0KPiAgKiBAZWRhY19nZXRlcnJvcl9pbmZvOiBl
ZGFjIGVycm9yIGluZm8NCj4gICogQGVkYWNfZ2V0X210eXBlOiAgICAgZ2V0IG10eXBlDQo+ICAq
IEBlZGFjX2dldF9kdHlwZTogICAgIGdldCBkdHlwZQ0KPiAgKiBAZWRhY19nZXRfZWNjc3RhdGU6
ICBnZXQgRUNDIHN0YXRlDQo+ICAqIEBxdWlya3M6ICAgICAgICAgICAgIHRvIGRpZmZlcmVudGlh
dGUgSVBzDQo+ICAqLw0KPiANCj4gU2hvcnRlciwgcXVpY2tlciB0byByZWFkL3NjYW4vZXRjLi4u
DQoNCk9rYXkuIEkgd2lsbCB1cGRhdGUgdGhpcyB3YXkgdGhyb3VnaG91dCBhbGwgdGhlIHBhdGNo
ZXMuDQoNCj4gDQo+ID4gKy8qKg0KPiA+ICAgKiBzeW5wc19lZGFjX2dldGVycm9yX2luZm8gLSBH
ZXQgdGhlIGN1cnJlbnQgZWNjIGVycm9yIGluZm8NCj4gPiAtICogQGJhc2U6CVBvaW50ZXIgdG8g
dGhlIGJhc2UgYWRkcmVzcyBvZiB0aGUgZGRyIG1lbW9yeSBjb250cm9sbGVyDQo+ID4gLSAqIEBw
OgkJUG9pbnRlciB0byB0aGUgc3lub3BzeXMgZWNjIHN0YXR1cyBzdHJ1Y3R1cmUNCj4gPiArICog
QHByaXY6CVBvaW50ZXIgdG8gRERSIG1lbW9yeSBjb250cm9sbGVyIHByaXZhdGUgaW5zdGFuY2Ug
ZGF0YQ0KPiA+ICAgKg0KPiA+ICAgKiBEZXRlcm1pbmVzIHRoZXJlIGlzIGFueSBlY2MgZXJyb3Ig
b3Igbm90DQo+IA0KPiBBbGwgc2VudGVuY2VzIGVuZCB3aXRoIGEgZnVsbHN0b3AuIENoZWNrIGFs
bCB5b3VyIHBhdGNoZXMuDQoNCk9rYXkuDQoNCj4gDQo+IEFsc28sIGl0IGlzIG5vdCAiZWNjIiBp
dCBpcyAiRUNDIi4gQWxzbyBnbyBvdmVyIGFsbCB5b3VyIHBhdGNoZXMuDQoNCk9rYXkuIEkgdXBk
YXRlZCB0aGlzIGluICgzLzQpLCBidXQgSSB3aWxsIHVwZGF0ZSB0aGlzIGFzIGEgc2VwYXJhdGUg
cGF0Y2ggaW4gdjYuDQoNCj4gDQo+ID4gICAqDQo+ID4gICAqIFJldHVybjogb25lIGlmIHRoZXJl
IGlzIG5vIGVycm9yIG90aGVyd2lzZSByZXR1cm5zIHplcm8NCj4gPiAgICovDQo+ID4gLXN0YXRp
YyBpbnQgc3lucHNfZWRhY19nZXRlcnJvcl9pbmZvKHZvaWQgX19pb21lbSAqYmFzZSwNCj4gPiAt
CQkJCSAgICBzdHJ1Y3Qgc3lucHNfZWNjX3N0YXR1cyAqcCkNCj4gPiArc3RhdGljIGludCBzeW5w
c19lZGFjX2dldGVycm9yX2luZm8oc3RydWN0IHN5bnBzX2VkYWNfcHJpdiAqcHJpdikNCj4gPiAg
ew0KPiA+ICsJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ICsJc3RydWN0IHN5bnBzX2VjY19zdGF0
dXMgKnA7DQo+ID4gIAl1MzIgcmVndmFsLCBjbGVhcnZhbCA9IDA7DQo+IA0KPiBQbGVhc2Ugc29y
dCBmdW5jdGlvbiBsb2NhbCB2YXJpYWJsZXMgZGVjbGFyYXRpb24gaW4gYSByZXZlcnNlIGNocmlz
dG1hcyB0cmVlDQo+IG9yZGVyOg0KPiANCj4gCTx0eXBlPiBsb25nZXN0X3ZhcmlhYmxlX25hbWU7
DQo+IAk8dHlwZT4gc2hvcnRlcl92YXJfbmFtZTsNCj4gCTx0eXBlPiBldmVuX3Nob3J0ZXI7DQo+
IAk8dHlwZT4gaTsNCj4gDQoNCk9rYXkuDQoNCj4gPg0KPiA+ICsJaWYgKCFwcml2KQ0KPiA+ICsJ
CXJldHVybiAxOw0KPiANCj4gV2h5IGFyZSB5b3UgZXZlbiBjaGVja2luZyB0aGlzIGhlcmU/DQo+
IA0KPiBzeW5wc19lZGFjX2NoZWNrKCkgaXMgbWVycmlseSBkZXJlZmVyZW5jaW5nIGl0IC0gaWYg
YW55dGhpbmcgd2Ugd2lsbCBleHBsb2RlDQo+IHRoZXJlIGFscmVhZHkuDQoNCk9rYXkuIEkgd2ls
bCByZW1vdmUgdGhpcyBpbiB2Ni4NCg0KPiANCj4gPg0KPiA+IEBAIC0zNzAsMTIgKzM5OCwxMiBA
QCBzdGF0aWMgaW50IHN5bnBzX2VkYWNfaW5pdF9jc3Jvd3Moc3RydWN0DQo+ID4gbWVtX2N0bF9p
bmZvICptY2kpDQo+IA0KPiBUaGF0IGZ1bmN0aW9uIHJldHVybnMgMCB1bmNvbmRpdGlvbmFsbHku
IE1ha2UgaXQgYSB2b2lkIGluIGEgcHJlcGF0Y2guDQoNClN1cmUuDQoNCj4gDQo+ID4gLQlpZiAo
IXN5bnBzX2VkYWNfZ2V0X2VjY3N0YXRlKGJhc2VhZGRyKSkgew0KPiA+ICsJcF9kYXRhID0gb2Zf
ZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiA+ICsJaWYgKCEocF9kYXRhLT5l
ZGFjX2dldF9lY2NzdGF0ZShiYXNlYWRkcikpKSB7DQo+IA0KPiBUb28gbWFueSBwYXJlbnRoZXNl
czoNCj4gDQo+IAlpZiAoIXBfZGF0YS0+Li4uDQo+IA0KPiBpcyBlbm91Z2guDQoNCk9rYXkuDQoN
Cg0KVGhhbmtzLA0KTWFuaXNoIE5hcmFuaQ0K
