Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D6EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA45278A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA45278A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeF1Tk0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:40:26 -0400
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:51127 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeF1TkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:40:22 -0400
X-Greylist: delayed 7052 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 15:40:22 EDT
Received: from G4W9119.americas.hpqcorp.net (g4w9119.houston.hp.com [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 12A7EB4;
        Thu, 28 Jun 2018 19:40:22 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 28 Jun 2018 19:40:16 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 19:40:16 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1282.NAMPRD84.PROD.OUTLOOK.COM (10.169.9.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Thu, 28 Jun 2018 19:40:14 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.023; Thu, 28 Jun 2018
 19:40:14 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Topic: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Thread-Index: AQHUDZmxPUiSRvMdYEiEXSaB5fTEZaR18wmAgAAXawCAAAl1gA==
Date:   Thu, 28 Jun 2018 19:40:14 +0000
Message-ID: <1530214695.14039.316.camel@hpe.com>
References: <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
         <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
         <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
         <1530048093.14039.286.camel@hpe.com>
         <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
         <1530048545.14039.288.camel@hpe.com>
         <CAPcyv4ifHX95fCM9Xj87CugwNWzgq=y-4LxPQ5L6RdjX0jdctQ@mail.gmail.com>
         <20180626220430.GA4269@linux.intel.com>
         <1530207635.14039.308.camel@hpe.com>
         <20180628190424.GC17758@linux.intel.com>
In-Reply-To: <20180628190424.GC17758@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1282;7:VkUty+S77+N5iimsMT79k3PjuMUhJJzxNTb5EsvHOr3wSzY6mM1/7BR/8jq2MOKDWidQPa3W1l8ipYy2f2UlQOQ1fTfM6c1FGLP0+i7CBMZHqs2D5Dxs/jAaU1rh4vtmjYdEfUNIRs3p2pueYz5D9xKBPh56291zjEVNSGrvjAxJnyt4iyhuUNfJND5OMCYOQbV6SuwiaejSStZNPz+EqrJNHJGJ+zAIi90HUhDicXMnfpOHHfIj7/B4OWwxGi63
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3ed4b62b-6462-4ed1-e0be-08d5dd2ef827
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1282;
x-ms-traffictypediagnostic: AT5PR8401MB1282:
x-microsoft-antispam-prvs: <AT5PR8401MB1282CA8870D828FDF4659E52824F0@AT5PR8401MB1282.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1282;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1282;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(346002)(396003)(189003)(199004)(2906002)(186003)(54906003)(6116002)(446003)(26005)(14454004)(2616005)(102836004)(76176011)(86362001)(3846002)(11346002)(68736007)(14444005)(81166006)(66066001)(8676002)(229853002)(93886005)(256004)(81156014)(8936002)(478600001)(6506007)(36756003)(6512007)(103116003)(53546011)(2900100001)(5640700003)(316002)(5660300001)(486006)(6436002)(476003)(2501003)(305945005)(2351001)(97736004)(25786009)(7736002)(99286004)(6246003)(5250100002)(4326008)(106356001)(6486002)(105586002)(6916009)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1282;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y+InjOouKCk9E9fVRi5PBV0XbF8mq9Dz6dHY4xfOxcu9aQrk4n7hl/b3+IRT7zSuY80bRL2dUmke+z/DAsuwmqpcq+gnTT8+XQZ2lO2JDGOeWYJYrmqa4a4qrYG6HNDYntNwGgXLNOz2+3LKNmaRJdyjpRhkuqWxMbUKzhp681oLGWSEB2eTmgGSBcYtvvV7uJRLDXbf6MlZksSuJG9QkyprA2lFxND/iLDt7ZD0qpeTAuDDxpe5KQNOSZK+8l0kgCSwihwABvi8Y0Vhfsc3kAV8MYZHGSJrYofh3obWoaryuYlSSpENxU1l5x/JnJyL8sy8ZOyXwjEfeScGkbbHUo2GQCdwC6BylSn8M/jiqFs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD982B3FCD049F479B5BFD2D4008C2C0@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed4b62b-6462-4ed1-e0be-08d5dd2ef827
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 19:40:14.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1282
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTI4IGF0IDEzOjA0IC0wNjAwLCBSb3NzIFp3aXNsZXIgd3JvdGU6DQo+
IE9uIFRodSwgSnVuIDI4LCAyMDE4IGF0IDA1OjQyOjM0UE0gKzAwMDAsIEthbmksIFRvc2hpIHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wNi0yNiBhdCAxNjowNCAtMDYwMCwgUm9zcyBad2lzbGVy
IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMjYsIDIwMTggYXQgMDI6NTE6NTJQTSAtMDcwMCwg
RGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEp1biAyNiwgMjAxOCBhdCAyOjMx
IFBNLCBLYW5pLCBUb3NoaSA8dG9zaGkua2FuaUBocGUuY29tPiB3cm90ZToNCiA6DQo+ID4gWW91
ciBwYXRjaGVzIGxvb2sgZ29vZC4gIEJ1dCBJIGFtIHN0aWxsIG5vdCBjbGVhciBhYm91dCB0aGUg
Rml4ZXMgJg0KPiA+IHN0YWJsZSBoYW5kbGluZy4gIFRhbGtpbmcgYWJvdXQgdXNlciB2aXNpYmxl
IGJlaGF2aW9yLCBJIGRvIG5vdCB0aGluayB3ZQ0KPiA+IGhhZCBhbnkgaXNzdWUgdW50aWwgZGF4
IHN1cHBvcnQgd2FzIGRyb3BwZWQgZnJvbSByYXcgbW9kZS4gIFVudGlsIHRoZW4sDQo+ID4gdGhl
IHBtZW0gZHJpdmVyIHN1cHBvcnRlZCBkYXggZm9yIGFsbCBtb2RlcywgYW5kIHRoZSBjaGVjayBm
b3INCj4gPiBkaXJlY3RfYWNjZXNzIHdvcmtlZC4gICAgDQo+IA0KPiBJIGFncmVlIHRoYXQgdGhl
IGZzZGF4ICsgcmF3IG1vZGUgZmFpbHVyZSBtb2RlIEkgbWVudGlvbmVkIGluIG15IGNvdmVyIGxl
dHRlcg0KPiBvbmx5IHN0YXJ0ZWQgd2hlbiB3ZSByZXN0cmljdGVkIGZpbGVzeXN0ZW0gREFYIHRv
IGhhdmluZyBzdHJ1Y3QgcGFnZSwgYnV0IEkNCj4gdGhpbmsgdGhhdCB0aGUgb3RoZXIgZmFpbHVy
ZSBtb2RlLCBmc2RheCArIHNvbWUgcmFuZG9tIGJsb2NrIGRyaXZlciAoSSB1c2VkDQo+IGJyZCkg
d2FzIHByZXNlbnQgaW4gRE0gZnJvbSB0aGUgYmVnaW5uaW5nLg0KDQpBaCwgSSBzZWUuDQoNCj4g
SW4gYW55IGNhc2UsIEkgdGhpbmsgYm90aCBhcmUgZml4ZWQgd2l0aCB0aGUgcGF0Y2hlcywgYW5k
IEkgdGhpbmsgaXQncyBmaW5lDQo+IHRoYXQgYWxsIDMgZ2V0IHRocm93biBhdCBzdGFibGUuICBU
aGFua3MsIE1pa2UsIGZvciB0aGUgaGVscC4NCg0KWXVwLCBhZ3JlZWQuIA0KDQpUaGFua3MhDQot
VG9zaGk=
