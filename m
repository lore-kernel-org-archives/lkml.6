Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A699C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B9D27765
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B9D27765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965836AbeF1Rmx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:42:53 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:26669 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934784AbeF1Rmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:42:50 -0400
Received: from G4W9119.americas.hpqcorp.net (g4w9119.houston.hp.com [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id C06EEC8;
        Thu, 28 Jun 2018 17:42:49 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 28 Jun 2018 17:42:36 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 17:42:36 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1042.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Thu, 28 Jun 2018 17:42:34 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.023; Thu, 28 Jun 2018
 17:42:34 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Topic: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Index: AQHUDZmxPUiSRvMdYEiEXSaB5fTEZaR18wmA
Date:   Thu, 28 Jun 2018 17:42:34 +0000
Message-ID: <1530207635.14039.308.camel@hpe.com>
References: <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
         <20180626185830.GA7171@redhat.com>
         <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
         <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
         <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
         <1530048093.14039.286.camel@hpe.com>
         <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
         <1530048545.14039.288.camel@hpe.com>
         <CAPcyv4ifHX95fCM9Xj87CugwNWzgq=y-4LxPQ5L6RdjX0jdctQ@mail.gmail.com>
         <20180626220430.GA4269@linux.intel.com>
In-Reply-To: <20180626220430.GA4269@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1042;7:2ebYFxX+249zMgKSXo8rEqX/CwTB36gIWXrX9SD0vjWQlqKiFHI4oQtee3gNwZ48vqwJLn4KYG743jk6XXkjsxcb/iJoxECqIrELVtKu9l8OvXpHBCBJCVMF97cXY9LoEXug8YXDdEHQ8pNl32B9W+ZqrL6cgIQWfHEvgEgzi/dqFAIongFUiiNG8uAHEixdYVQNsWKtkXvncawcmFIXORajivmMBt3BksIaRWBEwQCSxAm0FmmVDR65W/Ck8NlX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ff741488-b0ce-418e-c967-08d5dd1e881e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1042;
x-ms-traffictypediagnostic: AT5PR8401MB1042:
x-microsoft-antispam-prvs: <AT5PR8401MB1042626A7D17AE257B9268F2824F0@AT5PR8401MB1042.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1042;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1042;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(54534003)(199004)(189003)(81156014)(8676002)(97736004)(68736007)(81166006)(2501003)(7736002)(305945005)(86362001)(6246003)(53936002)(66066001)(25786009)(6486002)(2900100001)(6512007)(36756003)(6436002)(5660300001)(8936002)(11346002)(102836004)(14454004)(478600001)(3846002)(99286004)(2616005)(476003)(446003)(4326008)(93886005)(486006)(14444005)(106356001)(256004)(2906002)(54906003)(6116002)(103116003)(53546011)(26005)(6506007)(186003)(76176011)(229853002)(5250100002)(110136005)(316002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1042;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pNLTT3NIbJz6csKyg/FCMVsBu/5YQEoMBx92CTN0fbPItSECYOR6easo3TawLag17zCM1uRKtR22HKjIntFVuk24nysLcdonU1kcIO1mLYbAp8IaA64jpsklA6WSyjx1xaHUyBryUSiYCGun17ij59cbAwegC1FsiZ9e8P5RiSj4xewOfxvc8bDTubRTv2y4YKZroFPO9Ucm57HMkRlY5T2BMT49bhBAP1JmqeggMMNtctIFiUQQ8gkj+6NJNmhl5fSC93+32CjcKKBSHHBV32OtRqmHDuf58ZVAA4+mO4RGNRgADo5CWDi0uux5ycaySZTJGDBEP3ib+lG4fpfF7MAnhgC4RLrPPGCrs0INxjY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <21D4734DB95C3E49B2DAE47C2C3EA83D@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff741488-b0ce-418e-c967-08d5dd1e881e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 17:42:34.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1042
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTI2IGF0IDE2OjA0IC0wNjAwLCBSb3NzIFp3aXNsZXIgd3JvdGU6DQo+
IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0IDAyOjUxOjUyUE0gLTA3MDAsIERhbiBXaWxsaWFtcyB3
cm90ZToNCj4gPiBPbiBUdWUsIEp1biAyNiwgMjAxOCBhdCAyOjMxIFBNLCBLYW5pLCBUb3NoaSA8
dG9zaGkua2FuaUBocGUuY29tPiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAxOC0wNi0yNiBhdCAx
NDoyOCAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEp1biAyNiwg
MjAxOCBhdCAyOjIzIFBNLCBLYW5pLCBUb3NoaSA8dG9zaGkua2FuaUBocGUuY29tPiB3cm90ZToN
Cj4gPiA+ID4gPiBPbiBUdWUsIDIwMTgtMDYtMjYgYXQgMTQ6MDIgLTA3MDAsIERhbiBXaWxsaWFt
cyB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDI2LCAyMDE4IGF0IDE6NTQgUE0sIEth
bmksIFRvc2hpIDx0b3NoaS5rYW5pQGhwZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4g
Wy4uXQ0KPiA+ID4gPiA+ID4gPiBXaGVuIHRoaXMgZG0gY2hhbmdlIHdhcyBtYWRlLCB0aGUgcG1l
bSBkcml2ZXIgc3VwcG9ydGVkIERBWCBmb3IgYm90aCByYXcNCj4gPiA+ID4gPiA+ID4gYW5kIG1l
bW9yeSBtb2RlcyAobm90ZTogc2VjdG9yIG1vZGUgZG9lcyBub3QgdXNlIHRoZSBwbWVtIGRyaXZl
cikuICBJDQo+ID4gPiA+ID4gPiA+IHRoaW5rIHRoZSBpc3N1ZSB3YXMgaW50cm9kdWNlZCB3aGVu
IHdlIGRyb3BwZWQgREFYIHN1cHBvcnQgZnJvbSByYXcNCj4gPiA+ID4gPiA+ID4gbW9kZS4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU3RpbGwgREFYIHdpdGggcmF3IG1vZGUgbmV2ZXIgcmVh
bGx5IHdvcmtlZCBhbnkgd2F5LiBJdCB3YXMgYWxzbw0KPiA+ID4gPiA+ID4gc29tZXRoaW5nIHRo
YXQgd2FzIGJyb2tlbiBmcm9tIGRheSBvbmUuIFNvIHdoYXQgaGFwcGVucyB0byBzb21lb25lIHdo
bw0KPiA+ID4gPiA+ID4gaGFwcGVuZWQgdG8gYXZvaWQgYWxsIHRoZSBwcm9ibGVtcyB3aXRoIHBh
Z2UtbGVzcyBEQVggYW5kIGVuYWJsZWQNCj4gPiA+ID4gPiA+IGRldmljZS1tYXBwZXIgb24gdG9w
PyBUaGF0IGZhaWx1cmUgbW9kZSBkZXRhaWwgbmVlZHMgdG8gYmUgYWRkZWQgdG8NCj4gPiA+ID4g
PiA+IHRoaXMgY2hhbmdlbG9nIGlmIHdlIHdhbnQgdG8gcHJvcG9zZSB0aGlzIGZvciAtc3RhYmxl
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE15IHBvaW50IGlzIHRoYXQgdGhlIGJlaGF2aW9yIHNo
b3VsZCBiZSBjb25zaXN0ZW50IGJldHdlZW4gcG1lbSBhbmQNCj4gPiA+ID4gPiBkZXZpY2UtbWFw
cGVyLiAgV2hlbiAtbyBkYXggc3VjY2VlZHMgb24gYSBwbWVtLCB0aGVuIGl0IHNob3VsZCBzdWNj
ZWVkDQo+ID4gPiA+ID4gb24gYSBkZXZpY2UtbWFwcGVyIG9uIHRvcCBvZiB0aGF0IHBtZW0uDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGFzIHRoZSBkcm9wIG9mIGRheCBzdXBwb3J0IGZyb20gcmF3
IG1vZGUgbWFkZSB0byAtc3RhYmxlIGJhY2sgdG8gdGhlDQo+ID4gPiA+ID4gYmFzZWxpbmUgYWNj
ZXB0ZWQgNTQ1ZWQyMGU2ZGY2PyAgSXQgd2lsbCBpbnRyb2R1Y2UgaW5jb25zaXN0ZW5jeSwNCj4g
PiA+ID4gPiBvdGhlcndpc2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0IGNvbW1pdCwgNTY5ZDAz
NjVmNTcxICJkYXg6IHJlcXVpcmUgJ3N0cnVjdCBwYWdlJyBieSBkZWZhdWx0IGZvcg0KPiA+ID4g
PiBmaWxlc3lzdGVtIGRheCIsIGhhcyBub3QgYmVlbiB0YWdnZWQgZm9yIC1zdGFibGUuDQo+ID4g
PiANCj4gPiA+IFRoZW4sIEZpeGVzIHRhZyBzaG91bGQgYmUgc2V0IHRvIDU2OWQwMzY1ZjU3MSB0
byBrZWVwIHRoZSBiZWhhdmlvcg0KPiA+ID4gY29uc2lzdGVudC4NCj4gPiANCj4gPiBTdXJlLCBh
bmQgdGhlIGZhaWx1cmUgbW9kZSBpcy4uLj8gSSdtIHRoaW5raW5nIHRoZSBjb21taXQgbG9nIHNo
b3VsZCBzYXk6DQo+ID4gDQo+ID4gIlN0YXJ0aW5nIHdpdGggY29tbWl0IDU2OWQwMzY1ZjU3MSAi
ZGF4OiByZXF1aXJlICdzdHJ1Y3QgcGFnZScgYnkNCj4gPiBkZWZhdWx0IGZvciBmaWxlc3lzdGVt
IGRheCIsIGRheCBpcyBubyBsb25nZXIgc3VwcG9ydGVkIGZvciBwYWdlLWxlc3MNCj4gPiBjb25m
aWd1cmF0aW9ucy4gSG93ZXZlciwgZGV2aWNlLW1hcHBlciBzZWVzIHRoZSBRVUVVRV9GTEFHX0RB
WCBzdGlsbA0KPiA+IGJlaW5nIHNldCBhbmQgZmFsc2VseSBhc3N1bWVzIHRoYXQgREFYIGlzIGVu
YWJsZWQsIHRoaXMgbGVhZHMgdG8NCj4gPiA8aW5zZXJ0IHVzZXIgdmlzaWJsZSBmYWlsdXJlIG1v
ZGUgZGV0YWlscyBoZXJlPiINCj4gDQo+IERhbiBpcyBjb3JyZWN0IHRoYXQgdGhlcmUgaXMgbm8g
dXNlciB2aXNpYmxlIGNoYW5nZSBmb3IgdGhpcy4gIEl0IGlzIHRoZSByaWdodA0KPiB0aGluZyB0
byBkbyBmb3IgY29uc2lzdGVuY3kgYW5kIHNhbml0eSwgYnV0IGl0IGRvZXNuJ3QgYWN0dWFsbHkg
aGF2ZSB1c2VyDQo+IHZpc2libGUgYmVoYXZpb3IgdGhhdCBuZWVkcyB0byBiZSBiYWNrcG9ydGVk
IHRvIHN0YWJsZS4NCj4gDQo+IFRvc2hpIGlzIGNvcnJlY3QgdGhhdCB0aGlzIGNoYW5nZSBpcyBv
bmx5IGZvciByYXcgbW9kZSBuYW1lc3BhY2VzLCBub3QgYnR0DQo+IG5hbWVzcGFjZXMuDQo+IA0K
PiBJJ2xsIGFkanVzdCB0aGUgY2hhbmdlbG9nIGFuZCByZW1vdmUgdGhlIHN0YWJsZSBmbGFnIGZv
ciB2NSwgYW5kIEknbGwgYWRkIGENCj4gRml4ZXM6IHRhZyBmb3IgcGF0Y2ggMi4NCg0KSGkgUm9z
cywNCg0KWW91ciBwYXRjaGVzIGxvb2sgZ29vZC4gIEJ1dCBJIGFtIHN0aWxsIG5vdCBjbGVhciBh
Ym91dCB0aGUgRml4ZXMgJg0Kc3RhYmxlIGhhbmRsaW5nLiAgVGFsa2luZyBhYm91dCB1c2VyIHZp
c2libGUgYmVoYXZpb3IsIEkgZG8gbm90IHRoaW5rIHdlDQpoYWQgYW55IGlzc3VlIHVudGlsIGRh
eCBzdXBwb3J0IHdhcyBkcm9wcGVkIGZyb20gcmF3IG1vZGUuICBVbnRpbCB0aGVuLA0KdGhlIHBt
ZW0gZHJpdmVyIHN1cHBvcnRlZCBkYXggZm9yIGFsbCBtb2RlcywgYW5kIHRoZSBjaGVjayBmb3IN
CmRpcmVjdF9hY2Nlc3Mgd29ya2VkLiAgICANCg0KVGhhbmtzLA0KLVRvc2hpDQoNCg==
