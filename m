Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBDDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACD124555
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EnN6fWiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACD124555
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeGDDvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:51:18 -0400
Received: from mail-eopbgr710083.outbound.protection.outlook.com ([40.107.71.83]:60672
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932404AbeGDDvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClMAiBwaMkOOnIJZcvYY8zK2jLYT4IPkRyUhK6BDP4U=;
 b=EnN6fWiEyfGGrZthHdvf8MTYlA3w4D6AXBfTt6VucOSamChFweaw4qsCNlsRGGFiY+Qsgb7E/Y0KVk7P3ISvVEmySG5zDN5FUyVixo+2QH1C84XIgpWQrqYoUkqRBqzFknJYZDtX9qo1LkQOvGUvewM5rDa0oTZ7FpeuZpoR0NY=
Received: from CY1PR02MB1692.namprd02.prod.outlook.com (10.162.161.26) by
 CY1PR02MB1103.namprd02.prod.outlook.com (10.163.15.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Wed, 4 Jul 2018 03:51:07 +0000
Received: from CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::68a6:1966:cf3e:c4a]) by CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::68a6:1966:cf3e:c4a%3]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 03:51:05 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Alan Tull <atull@kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>, Michal Simek <michals@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kedare06@gmail.com" <kedare06@gmail.com>
Subject: RE: [RFC PATCH 1/2] fpga: fpga-mgr: Add readback support
Thread-Topic: [RFC PATCH 1/2] fpga: fpga-mgr: Add readback support
Thread-Index: AQHUEqoU0mLTg7R9V0KQrVFjJCj+tqR9nFyAgAAODeA=
Date:   Wed, 4 Jul 2018 03:51:04 +0000
Message-ID: <CY1PR02MB1692CB8072255597611E27D3DC410@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1530607463-6287-1-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXRhRDmsqUxVi4p+vE-X+OL0ayQ=4zpM-4PxZBqJXjPsRw@mail.gmail.com>
In-Reply-To: <CANk1AXRhRDmsqUxVi4p+vE-X+OL0ayQ=4zpM-4PxZBqJXjPsRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1103;7:+Y8VaVpkrM3xc0gi1cuqSn9fHG5vjn5R6FdlDM5N4gLWudKQSkCB/ilAF5QMz3db2oNEsYoe/du1rGPzk02ejx7S0j+t0IN41CuqDL7mRE+pqvU9j2yNGVoIJEgJYeVM8j75byo1MsbvDfjbk42ZcYKAfpgyps9DBSX+F9qEoJIOsnp2FJi/DysalAKjW8uqYjMUehUKF/I8GERWyltR+qOu4TBG5RReZtwAflLWt5/NrpCv9459joGqEwkUAGxV
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0aff8efb-7bbd-4446-65b0-08d5e1615e41
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1103;
x-ms-traffictypediagnostic: CY1PR02MB1103:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <CY1PR02MB11034F7BA5C916870DC6A23ADC410@CY1PR02MB1103.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1103;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1103;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(51914003)(189003)(199004)(33656002)(305945005)(9686003)(6916009)(105586002)(6306002)(2900100001)(106356001)(5250100002)(6506007)(26005)(55236004)(7736002)(53936002)(4326008)(7696005)(5660300001)(8676002)(74316002)(102836004)(76176011)(2906002)(55016002)(99286004)(186003)(6246003)(25786009)(3846002)(39060400002)(6116002)(97736004)(68736007)(256004)(229853002)(8936002)(66066001)(14444005)(81166006)(14454004)(81156014)(446003)(478600001)(966005)(11346002)(54906003)(316002)(6436002)(86362001)(486006)(476003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1103;H:CY1PR02MB1692.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cqva3c+AykdtsiGvOchYh7YTnvAiF8wcgltcjqsblHB7mDvI5j1YtNj+I1/nPMr4IgOMLHVoUWk8m9dFEaUljl4EHMF3z8JksOpQEa/rA/cgzTkSkrCNE00bVK4+gtIu7IGcOOLJMKpS2e8iXQvrTVMKXqSb26q+aPif6EkgDKhV8q/p0x3fw2ZdL5UPNZ5AKWvapARAfTfujZFmf7YnCQB8LeHt0xaIbHJ/jcfQ01crJ5Eo0C3JgRg58Is9qSfF80mb159jqfU+B0TFAsWERaPEQROCaOTBSkaV57am4db5GptTcSN1dOOUrPzhg3IolYZTGVuK5glHrsuOTfml49d9EUw0EsHuUB1RhgIaAQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aff8efb-7bbd-4446-65b0-08d5e1615e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 03:51:05.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KCVRoYW5rcyBmb3IgdGhlIHJldmlldy4uLiANClBsZWFzZSBmaW5kIGNvbW1l
bnRzIGlubGluZS4uLiANCg0KPFNuaXA+DQo+IA0KPiBIaSBBcHBhbmEsDQo+IA0KPiA+IElub3Jk
ZXIgdG8gZGVidWcgaXNzdWVzIHdpdGggZnBnYSdzIHVzZXJzIHdvdWxkIGxpa2UgdG8gcmVhZCB0
aGUgZnBnYQ0KPiA+IGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24uDQo+ID4gVGhpcyBwYXRjaCBh
ZGRzIHJlYWRiYWNrIHN1cHBvcnQgZm9yIGZwZ2EgY29uZmlndXJhdGlvbiBkYXRhIGluIHRoZQ0K
PiA+IGZyYW1ld29yayB0aHJvdWdoIGRlYnVnZnMgaW50ZXJmYWNlLg0KPiA+DQo+ID4gVXNhZ2U6
DQo+ID4gICAgICAgICBjYXQgL3N5cy9rZXJuZWwvZGVidWcvZnBnYS9yZWFkYmFjaw0KPiANCj4g
VHdvIHRoaW5ncyBoZXJlOiBJJ2QgcHJlZmVyIGNhbGxpbmcgdGhlIGF0dHJpYnV0ZSAiaW1hZ2Ui
IHJhdGhlciB0aGFuDQo+ICJyZWFkYmFjayINCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGFuIGVudHJ5
IHBlciBmcGdhIG1hbmFnZXIsIG5vdCBvbmUgZW50cnkgZm9yIHRoZSB3aG9sZQ0KPiBmcmFtZXdv
cmssIHNvDQo+IA0KPiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvZnBnYS9mcGdhMC9pbWFnZQ0KDQpT
dXJlIHdpbGwgZml4IGluIHYyLi4uIA0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXBw
YW5hIER1cmdhIEtlZGFyZXN3YXJhIHJhbw0KPiA+IDxhcHBhbmEuZHVyZ2EucmFvQHhpbGlueC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZnBnYS9mcGdhLW1nci5jICAgICAgIHwgNTINCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRl
L2xpbnV4L2ZwZ2EvZnBnYS1tZ3IuaCB8ICA2ICsrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NTggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS9mcGdh
LW1nci5jIGIvZHJpdmVycy9mcGdhL2ZwZ2EtbWdyLmMgaW5kZXgNCj4gPiA5OTM5ZDJjLi43YTlm
ZDdjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9mcGdhLW1nci5jDQo+ID4gKysrIGIv
ZHJpdmVycy9mcGdhL2ZwZ2EtbWdyLmMNCj4gPiBAQCAtNDg0LDYgKzQ4NCwzOSBAQCB2b2lkIGZw
Z2FfbWdyX3B1dChzdHJ1Y3QgZnBnYV9tYW5hZ2VyICptZ3IpICB9DQo+ID4gRVhQT1JUX1NZTUJP
TF9HUEwoZnBnYV9tZ3JfcHV0KTsNCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGZw
Z2FfbWdyX3JlYWQoc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICpkYXRhKSB7DQo+ID4gKyAgICAg
ICBzdHJ1Y3QgZnBnYV9tYW5hZ2VyICptZ3IgPSAoc3RydWN0IGZwZ2FfbWFuYWdlciAqKXMtPnBy
aXZhdGU7DQo+ID4gKyAgICAgICBpbnQgcmV0ID0gMDsNCj4gDQo+IEhlcmUgeW91IHNob3VsZCBy
ZXR1cm4gYW4gZXJyb3IgZm9yIG1ncidzIHRoYXQgZG9uJ3Qgc3VwcG9ydCByZWFkIGZ1bmN0aW9u
Og0KPiANCj4gaWYgKCFtZ3ItPm1vcHMtPnJlYWQpDQo+ICAgICByZXR1cm4gLUVOT0VOVDsNCg0K
V2lsbCBmaXggaW4gdjIuLi4NCg0KPiANCj4gVGhlbiB5b3UgcHJvYmFibHkgc2hvdWxkIGxvY2sg
dGhlIG1nciBzbyB0aGF0IG5vYm9keSB0cmllcyB0byB3cml0ZSBpdCB3aGlsZQ0KPiB5b3UgYXJl
IHJlYWRpbmcuICBJZiB5b3UgY2FuJ3QgbG9jayBpdCwgcmV0dXJuIC1FQlVTWS4NCg0KT2sgc3Vy
ZSB3aWxsIGZpeCBpbiB2Mi4uLiANCg0KPiANCj4gPiArDQo+ID4gKyAgICAgICBpZiAobWdyLT5z
dGF0ZSAhPSBGUEdBX01HUl9TVEFURV9PUEVSQVRJTkcpDQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUJVU1k7DQo+IA0KPiBJZiB0aGUgRlBHQSBpc24ndCBwcm9ncmFtbWVkLCBJJ20gbm90
IHN1cmUgdGhhdCBFQlVTWSB3b3VsZCBiZSB0aGUgY29ycmVjdA0KPiBlcnJvci4NCg0KT2ssIFNo
b3VsZCBJIHJldHVybiBFUEVSTSAob3IpIEVBR0FJTiBoZXJlPz8/IA0KDQo+IA0KPiA+ICsNCj4g
PiArICAgICAgIC8qIFJlYWQgdGhlIEZQR0EgY29uZmlndXJhdGlvbiBkYXRhIGZyb20gdGhlIGZh
YnJpYyAqLw0KPiA+ICsgICAgICAgcmV0ID0gbWdyLT5tb3BzLT5yZWFkKG1nciwgcyk7DQo+ID4g
KyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJm1nci0+ZGV2
LCAiRXJyb3Igd2hpbGUgcmVhZGluZyBjb25maWd1cmF0aW9uIGRhdGEgZnJvbQ0KPiBGUEdBXG4i
KTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IERvbid0IG5lZWQgdGhp
cyByZXR1cm4gaGVyZSBzaW5jZSB3ZSByZXR1cm4gcmlnaHQgYWZ0ZXJ3YXJkcyBhbnl3YXkuDQoN
CldpbGwgZml4IGluIHYyLi4uDQoNCj4gDQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAg
ICAgcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBmcGdhX21ncl9y
ZWFkX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpDQo+ID4gK3sN
Cj4gPiArICAgICAgIHJldHVybiBzaW5nbGVfb3BlbihmaWxlLCBmcGdhX21ncl9yZWFkLCBpbm9k
ZS0+aV9wcml2YXRlKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29w
ZXJhdGlvbnMgZnBnYV9tZ3JfZGVidWdvcHMgPSB7DQo+IA0KPiBTdWdnZXN0IGluY2x1ZGluZyB0
aGUgbmFtZSBvZiB0aGUgZGVidWdmcyBmaWxlIGluIHRoZSBuYW1lIHNpbmNlIG1vcmUNCj4gZGVi
dWdmcyBmaWxlcyB3aWxsIGJlIGFkZGVkIG92ZXIgdGltZSwgc28NCj4gDQo+IHMvZnBnYV9tZ3Jf
ZGVidWdvcHMvZnBnYV9tZ3Jfb3BzX2ltYWdlLyBvciBzb21ldGhpbmcuDQoNClN1cmUgd2lsbCB1
c2UgZnBnYV9tZ3Jfb3BzX2ltYWdlIA0KDQo+IA0KPiA+ICsgICAgICAgLm93bmVyID0gVEhJU19N
T0RVTEUsDQo+ID4gKyAgICAgICAub3BlbiA9IGZwZ2FfbWdyX3JlYWRfb3BlbiwNCj4gPiArICAg
ICAgIC5yZWFkID0gc2VxX3JlYWQsDQo+ID4gK307DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAg
LyoqDQo+ID4gICAqIGZwZ2FfbWdyX2xvY2sgLSBMb2NrIEZQR0EgbWFuYWdlciBmb3IgZXhjbHVz
aXZlIHVzZQ0KPiA+ICAgKiBAbWdyOiAgICAgICBmcGdhIG1hbmFnZXINCj4gPiBAQCAtNTgxLDYg
KzYxNCwyMSBAQCBpbnQgZnBnYV9tZ3JfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LCBjb25z
dA0KPiBjaGFyICpuYW1lLA0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAg
ICAgZ290byBlcnJvcl9kZXZpY2U7DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19ERUJVR19GUw0K
PiANCj4gSSdkIHByZWZlciBhbiBhZGRlZCBjb25maWcgc3VjaCBhcyBDT05GSUdfRlBHQV9NR1Jf
REVCVUdfRlMuDQoNCk9rLCB3aWxsIGFkZCBhbiBlbnRyeSBpbiB0aGUgS2NvbmZpZyB3aXRoIHRo
ZSBuYW1lIGFzIHlvdSBzdWdnZXN0ZWQgaW4gdjIuLi4gIA0KDQo+IA0KPiA+ICsgICAgICAgbWdy
LT5kaXIgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoImZwZ2EiLCBOVUxMKTsNCj4gPiArICAgICAgIGlm
ICghbWdyLT5kaXIpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfZGV2aWNlOw0KPiA+
ICsNCj4gPiArICAgICAgIG1nci0+cGFyZW50ID0gbWdyLT5kaXI7DQo+ID4gKyAgICAgICBtZ3It
PmRpciA9IGRlYnVnZnNfY3JlYXRlX2ZpbGUoInJlYWRiYWNrIiwgMDY0NCwgbWdyLT5wYXJlbnQs
IG1nciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZnBnYV9t
Z3JfZGVidWdvcHMpOw0KPiA+ICsgICAgICAgaWYgKCFtZ3ItPmRpcikgew0KPiA+ICsgICAgICAg
ICAgICAgICBkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUobWdyLT5wYXJlbnQpOw0KPiA+ICsgICAg
ICAgICAgICAgICBtZ3ItPnBhcmVudCA9IE5VTEw7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8g
ZXJyb3JfZGV2aWNlOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gICAg
ICAgICBkZXZfaW5mbygmbWdyLT5kZXYsICIlcyByZWdpc3RlcmVkXG4iLCBtZ3ItPm5hbWUpOw0K
PiA+DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiBAQCAtNjA0LDYgKzY1MiwxMCBAQCB2b2lk
IGZwZ2FfbWdyX3VucmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+DQo+ID4gICAgICAg
ICBkZXZfaW5mbygmbWdyLT5kZXYsICIlcyAlc1xuIiwgX19mdW5jX18sIG1nci0+bmFtZSk7DQo+
ID4NCj4gPiArI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPiA+ICsgICAgICAgZGVidWdmc19yZW1v
dmVfcmVjdXJzaXZlKG1nci0+cGFyZW50KTsNCj4gPiArICAgICAgIG1nci0+cGFyZW50ID0gTlVM
TDsNCj4gPiArI2VuZGlmDQo+ID4gICAgICAgICAvKg0KPiA+ICAgICAgICAgICogSWYgdGhlIGxv
dyBsZXZlbCBkcml2ZXIgcHJvdmlkZXMgYSBtZXRob2QgZm9yIHB1dHRpbmcgZnBnYSBpbnRvDQo+
ID4gICAgICAgICAgKiBhIGRlc2lyZWQgc3RhdGUgdXBvbiB1bnJlZ2lzdGVyLCBkbyBpdC4NCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtbWdyLmgNCj4gPiBiL2luY2x1
ZGUvbGludXgvZnBnYS9mcGdhLW1nci5oIGluZGV4IDNjNmRlMjMuLjYwMTM4MDkgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9mcGdhL2ZwZ2EtbWdyLmgNCj4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L2ZwZ2EvZnBnYS1tZ3IuaA0KPiA+IEBAIC0xMTQsNiArMTE0LDcgQEAgc3RydWN0IGZw
Z2FfaW1hZ2VfaW5mbyB7DQo+ID4gICAqIEB3cml0ZTogd3JpdGUgY291bnQgYnl0ZXMgb2YgY29u
ZmlndXJhdGlvbiBkYXRhIHRvIHRoZSBGUEdBDQo+ID4gICAqIEB3cml0ZV9zZzogd3JpdGUgdGhl
IHNjYXR0ZXIgbGlzdCBvZiBjb25maWd1cmF0aW9uIGRhdGEgdG8gdGhlIEZQR0ENCj4gPiAgICog
QHdyaXRlX2NvbXBsZXRlOiBzZXQgRlBHQSB0byBvcGVyYXRpbmcgc3RhdGUgYWZ0ZXIgd3JpdGlu
ZyBpcyBkb25lDQo+ID4gKyAqIEByZWFkOiByZWFkIEZQR0EgY29uZmlndXJhdGlvbiBpbmZvcm1h
dGlvbg0KPiANCj4gUGxlYXNlIGFkZCBub3RlIHRoYXQgdGhlIHJlYWQgb3BzIGlzIG9wdGlvbmFs
IHNpbWlsYXIgdG8gYmVsb3cuDQoNClN1cmUgd2lsbCBhZGQgbm90ZXMgaW4gdjIuLi4gDQoNCj4g
DQo+ID4gICAqIEBmcGdhX3JlbW92ZTogb3B0aW9uYWw6IFNldCBGUEdBIGludG8gYSBzcGVjaWZp
YyBzdGF0ZSBkdXJpbmcgZHJpdmVyDQo+IHJlbW92ZQ0KPiA+ICAgKiBAZ3JvdXBzOiBvcHRpb25h
bCBhdHRyaWJ1dGUgZ3JvdXBzLg0KPiA+ICAgKg0KPiA+IEBAIC0xMzEsNiArMTMyLDcgQEAgc3Ry
dWN0IGZwZ2FfbWFuYWdlcl9vcHMgew0KPiA+ICAgICAgICAgaW50ICgqd3JpdGVfc2cpKHN0cnVj
dCBmcGdhX21hbmFnZXIgKm1nciwgc3RydWN0IHNnX3RhYmxlICpzZ3QpOw0KPiA+ICAgICAgICAg
aW50ICgqd3JpdGVfY29tcGxldGUpKHN0cnVjdCBmcGdhX21hbmFnZXIgKm1nciwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZnBnYV9pbWFnZV9pbmZvICppbmZvKTsN
Cj4gPiArICAgICAgIGludCAoKnJlYWQpKHN0cnVjdCBmcGdhX21hbmFnZXIgKm1nciwgc3RydWN0
IHNlcV9maWxlICpzKTsNCj4gPiAgICAgICAgIHZvaWQgKCpmcGdhX3JlbW92ZSkoc3RydWN0IGZw
Z2FfbWFuYWdlciAqbWdyKTsNCj4gPiAgICAgICAgIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3Jv
dXAgKipncm91cHM7ICB9OyBAQCAtMTUxLDYgKzE1MywxMA0KPiA+IEBAIHN0cnVjdCBmcGdhX21h
bmFnZXIgew0KPiA+ICAgICAgICAgZW51bSBmcGdhX21ncl9zdGF0ZXMgc3RhdGU7DQo+ID4gICAg
ICAgICBjb25zdCBzdHJ1Y3QgZnBnYV9tYW5hZ2VyX29wcyAqbW9wczsNCj4gPiAgICAgICAgIHZv
aWQgKnByaXY7DQo+ID4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4gPiArICAgICAgIHN0cnVj
dCBkZW50cnkgKmRpcjsNCj4gPiArICAgICAgIHN0cnVjdCBkZW50cnkgKnBhcmVudDsNCj4gPiAr
I2VuZGlmDQo+ID4gIH07DQo+ID4NCj4gPiAgI2RlZmluZSB0b19mcGdhX21hbmFnZXIoZCkgY29u
dGFpbmVyX29mKGQsIHN0cnVjdCBmcGdhX21hbmFnZXIsIGRldikNCj4gPiAtLQ0KPiA+IDIuNy40
DQo+ID4NCj4gPiAtLQ0KPiA+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRo
ZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1mcGdhIg0KPiA+IGluIHRoZSBib2R5IG9mIGEgbWVz
c2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnIE1vcmUNCj4gbWFqb3Jkb21vDQo+ID4g
aW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQo+IA0K
PiBUaGFua3MsDQo+IEFsYW4NCg==
