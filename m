Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20206C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE60820836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE60820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936817AbeFRTjl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:39:41 -0400
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:50170 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935743AbeFRTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:39:39 -0400
Received: from G9W8454.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 21919CC;
        Mon, 18 Jun 2018 19:39:38 +0000 (UTC)
Received: from G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1178.4; Mon, 18 Jun 2018 19:39:38 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W8455.americas.hpqcorp.net (16.216.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1178.4 via Frontend Transport; Mon, 18 Jun 2018 19:39:38 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1009.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Mon, 18 Jun 2018 19:39:35 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0863.016; Mon, 18 Jun 2018
 19:39:35 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "juston.li@intel.com" <juston.li@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Thread-Topic: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Thread-Index: AQHUBzbZn+ValLciZ02HwEaaHBM//KRmaT2A
Date:   Mon, 18 Jun 2018 19:39:35 +0000
Message-ID: <1529350667.14039.119.camel@hpe.com>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
         <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
         <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
In-Reply-To: <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1009;7:cI3m8lEbmzftdVUyFoQ6rCROOX+EI/QNOeuMcjRX5RzJ4PT7QbUytYjzWI9vNgCpbKfKPRPTjsKwjQqnaislmOVCjoHxl4nQeG1HVZ4jwmCPPK60sawa5VTmO4vuG2sd3z2/BJIDJND+NzHMvhfSxG6NKtEMbOP2YNadXiowja3QwvcnDJ/hbH0KAinopeMeZDILmBgGWqJjG1M7amFU6Lap/Vu+w9rIPGht1JbEWw4eMVJoy1aqILJUC5cgr/Mc
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(39380400002)(189003)(199004)(36756003)(99286004)(5640700003)(8936002)(6306002)(6116002)(6512007)(486006)(2501003)(6436002)(2616005)(14454004)(229853002)(5250100002)(54906003)(76176011)(102836004)(53546011)(6486002)(476003)(103116003)(25786009)(106356001)(6916009)(11346002)(4326008)(7736002)(8676002)(966005)(53936002)(5660300001)(3846002)(305945005)(6506007)(2900100001)(81166006)(81156014)(316002)(2351001)(6246003)(26005)(478600001)(186003)(86362001)(105586002)(68736007)(3660700001)(15650500001)(2906002)(446003)(3280700002)(97736004)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1009;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcd17055-39de-437c-7e97-08d5d55338c8
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1009;
x-ms-traffictypediagnostic: AT5PR8401MB1009:
x-microsoft-antispam-prvs: <AT5PR8401MB100944E0E7A705D02536752682710@AT5PR8401MB1009.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1009;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1009;
x-forefront-prvs: 0707248B64
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NhIN/YLspJzi6lRvhculNMT2s+sUTAOGG3YW47crKd3LbtAuuw5j+ar/33hVzWe8H8fH3eNDIEAQHVtg6+rnzlsvxJXl23iRAC53cFbj9qyUxIdXs5C1FQ0Ny/ZE0QcAN86PXY2DOzAq+VNbwbytwZF/JuJFd5XlgNUpAYNu1C+8cItAush2pZ2F+IjHQxWCUG1E6vK9EaII08ZDk3vdpGW1TkkXHKhXL0HgVW1B7+df5QH744nhBxcQwkvGkJseN+6EwPO/Ot61R/IaE31YOyv/cogzXrgvyXTxJvKz7YxWdY3ytbj6KNxO4L0I3pCOtytpUvmwIw17fb3k/EE74g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA7E9EEEE7D0534C854733E9A6DF8D30@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd17055-39de-437c-7e97-08d5d55338c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2018 19:39:35.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1009
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA2LTE4IGF0IDEyOjAxIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIE1vbiwgQXByIDI1LCAyMDE2IGF0IDI6NDMgUE0gVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBo
cGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiBBQ1BJIDYuMSwgVGFibGUgNS0xMzMsIHVwZGF0ZXMg
TlZESU1NIENvbnRyb2wgUmVnaW9uIFN0cnVjdHVyZQ0KPiA+IGFzIGZvbGxvd3MuDQo+ID4gIC0g
VmFsaWQgRmllbGRzLCBNYW51ZmFjdHVyaW5nIExvY2F0aW9uLCBhbmQgTWFudWZhY3R1cmluZyBE
YXRlDQo+ID4gICAgYXJlIGFkZGVkIGZyb20gcmVzZXJ2ZWQgcmFuZ2UuICBObyBjaGFuZ2UgaW4g
dGhlIHN0cnVjdHVyZSBzaXplLg0KPiA+ICAtIElEcyAoU1BEIHZhbHVlcykgYXJlIHN0b3JlZCBh
cyBhcnJheXMgb2YgYnl0ZXMgKGkuZS4gYmlnLWVuZGlhbg0KPiA+ICAgIGZvcm1hdCkuICBUaGUg
c3BlYyBjbGFyaWZpZXMgdGhhdCB0aGV5IG5lZWQgdG8gYmUgcmVwcmVzZW50ZWQNCj4gPiAgICBh
cyBhcnJheXMgb2YgYnl0ZXMgYXMgd2VsbC4NCj4gPiANCj4gDQo+IENpcmNsaW5nIGJhY2sgb24g
dGhpcyBhIGNvdXBsZSB5ZWFycyB0b28gbGF0ZS4uLiB3aGVyZSBhcmUgeW91IHJlYWRpbmcNCj4g
dGhpcyAiYXJyYXlzIG9mIGJ5dGVzIiBub3RlLiBBcyBmYXIgYXMgSSBjYW4gc2VlIHRoaXMgaXMg
d3JvbmcuIEpFREVDDQo+IHNheXMgdGhhdCB2ZW5kb3IgaWQgaXMgc3RvcmVkIExTQiBvZiB0aGUg
aWQgaXMgc3RvcmVkIGF0IHRoZSBsb3dlc3QNCj4gYnl0ZSBpbiBTUEQsIHdoaWNoIGlzIGxpdHRs
ZSBlbmRpYW4uIFNvIGl0IHNlZW1zIExpbnV4IGhhcyBzaG93aW5nIHRoZQ0KPiBpbmNvcnJlY3Qg
dmFsdWUgZm9yIGEgbG9uZyB0aW1lIG5vdy4NCg0KVGhpcyBmb2xsb3dzIEFDUEkgNi4yYSBzZWN0
aW9uIDUuMi4yNS4xMCBOVkRJTU0gUmVwcmVzZW50YXRpb24gRm9ybWF0LA0Kd2hpY2ggUm9iZXJ0
IGNpdGVkIGluIGhpcyBjb21tZW50IGJlbG93Og0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wYXRjaC8xMDIzNzYwOS8NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
