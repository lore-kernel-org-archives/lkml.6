Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4622C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CDF2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="mmUllyfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CDF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeK2B3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:29:25 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.113]:15212 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbeK2B3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:29:25 -0500
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-west-2.aws.symcld.net id B0/32-11706-4D5AEFB5; Wed, 28 Nov 2018 14:27:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTYUwTZxjud3e9HoxbPoqMd01hWROXDHMdrcb
  cj5mY7MduWUiciZmTjXHIra1rC+sVRZ2RlUGghAgqqJSpmSi1myGFLRMCbuhUUBMcWM1git1Q
  qCGIMzoNWbO7Hrrt3/M9z/M+7/t9eT+GNAYMJkaq8ks+r+i20OmUczZOcOPHk0UFd8I2vvvSB
  ZI/0HoV8cO/fkHzg/MhPR86UEPwA4MjFD/e30HzNS2TBr4u+gjxE80XCH7xicINnK8n+VN7HG
  tZoTecLxwbSBBCT6SBFhpDSUq4fyZGC1eO/mwQHvbkCaNTScM6ZpPe5S0tryrROyfrnhIVs+a
  qvdOZ1ei0OYjSGSOeQfBb+y+kdjiHoD8WMwRRGkPhMAnDTWma0ExAbPE20g43EZz4607KRePX
  YWTuOqniZXgFtHQMpaJIvJeCrhv9iolhsvD7MDP8kebZCEPj5wkN2yHQEkZat+UQ3H8jZWfxh
  zB3fKtKG/FOWBhpo1Wcht+DH3pDqbYI50Lb71OpGBLnwFdt7XoVA8bQOTBKajgbEn8kl3gLhP
  fVIw3nwtiRxtRdAMcRXA73UZpgg4snf1wq/pKGb5tf0XAhXEsM0lrBVQSHZoNLqflwsTdAqUM
  jvB7mvyvW6E9hX210KScPIk1xSqs9R0K4NkBoghkCczVUM+La/3OJdiWKVN60u/8NjX4V9jfG
  DSpmcSaMHJqmjiIqgvhSn8vh9HtEl5uzFRRwNpuds61cxdnsvFXcwZVaK2VumyT7ObtV3CZb5
  e2eze4yq1fy9yBlE8sq6qpPoz+7HGfRywxhyWaL/Mki44ul5WXbnaLs/NhX6Zbks8jMMBZgpz
  oVLdMnOaSqT1xuZZ2fycBkWJaxoCy0kZUrRI/scmjSJbSSOTNRe5Bkrl1pOEgaKW+5VzLlsK+
  pVqxanZXe50HPvsYYyjVlsUin0xkzKiSfx+X/v34P5TDIksWa1JQMl9f/vN89ZRRCGeV6y6I6
  il/8VzJVo+i7j8mXujpzD6/R1894gscecUxTQezEZ4V/l/TdNV/e0NGna1219vstZelPNuxZU
  9/wU2R94eMXNqbh4reORKdX7M7u5t7cXDtPdN5cqNQZb90etR8WHmz6/NStRNfTscjbrsA3H9
  wNTSbGd1kftuYVvtODT64eKtmyzlE8EV9OLES/tlCyU7Tlkz5Z/AfiySG0FQQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-28.tower-346.messagelabs.com!1543415247!2266266!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27292 invoked from network); 28 Nov 2018 14:27:31 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-28.tower-346.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Nov 2018 14:27:31 -0000
Received: from USEXEDGE02.lenovo.com (unknown [10.62.65.5]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 1a80_a83e_75214e43_7d63_45bc_9c69_405afcb98004;
        Wed, 28 Nov 2018 14:27:18 +0000
Received: from APC01-SG2-obe.outbound.protection.outlook.com (65.55.88.245) by
 USEXEDGE02.lenovo.com (10.62.65.5) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 28 Nov 2018 09:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APRvKwEp3Q7OIl7H2GMLESXL6mBxQJnExPRX09Op9f8=;
 b=mmUllyfO8cU/M8ogjCpsGCqiaicIQHQ+lwo7oznzlq9wYHmT258JyRxR4PzWSwYeSie6/rD1Rjbg4UUVt87fCnEFPAfBFHqoVeF+/sbODKaIIbmivjs0HG/+xRoT5tqFMESUc1rE0FzloySFQZaqExzu4R78aDU4csfbWevpdvQ=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB1841.apcprd03.prod.outlook.com (10.167.69.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.11; Wed, 28 Nov 2018 14:27:13 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::7c75:8d6:20c3:2bed]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::7c75:8d6:20c3:2bed%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 14:27:12 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "device-mapper development" <dm-devel@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [RFC PATCH v2 0/3] realize dax_operations for
 dm-snapshot
Thread-Topic: [External]  Re: [RFC PATCH v2 0/3] realize dax_operations for
 dm-snapshot
Thread-Index: AQHUhQH6PB8Z7pxK/kCQ6RcejWF1HKVk565w
Date:   Wed, 28 Nov 2018 14:27:12 +0000
Message-ID: <HK2PR03MB4418C7DE4A2A55E691711CE692D10@HK2PR03MB4418.apcprd03.prod.outlook.com>
References: <20181121032702.3048-1-yehs2007@zoho.com>
 <CAPcyv4hmCsNOZPEAzOLxhFCQpyaG0_9TJvJnyuytQAVEU7_wbA@mail.gmail.com>
In-Reply-To: <CAPcyv4hmCsNOZPEAzOLxhFCQpyaG0_9TJvJnyuytQAVEU7_wbA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.118.177.91]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1841;20:6ZRfR0JXESP1XVTQHg6liFsK3qfapsOYS2N8Jjj8z6sWS0nDxO3udgQPDvAVM95SRiErheN0V9Ooa+3CxGCrDCeQhJ/Md0fiEIZm/RKKQTNHTsOttEFlnZmaxQfQfqTDd05FLeZTSfjRQEmvbLxdgH5sbGdzAjHtBax/az6+eIw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(7736002)(486006)(217873002)(2906002)(71200400001)(71190400001)(6116002)(3846002)(54906003)(14444005)(8936002)(256004)(316002)(8676002)(966005)(68736007)(5660300001)(229853002)(81156014)(66066001)(6916009)(81166006)(6306002)(86362001)(446003)(9686003)(478600001)(99286004)(14454004)(7416002)(102836004)(106356001)(97736004)(105586002)(186003)(74316002)(6436002)(55016002)(476003)(4326008)(6246003)(11346002)(6506007)(7696005)(76176011)(33656002)(53546011)(305945005)(26005)(25786009)(53936002)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1841;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4733ab60-e709-46e2-70be-08d6553d9694
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1841;
x-ms-traffictypediagnostic: HK2PR03MB1841:
x-microsoft-antispam-prvs: <HK2PR03MB1841419E823CE8BD1395383492D10@HK2PR03MB1841.apcprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231443)(999002)(944501436)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HK2PR03MB1841;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1841;
x-forefront-prvs: 0870212862
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6/Oi80KwmRJ+skN8xRAD3JUjSQ4d4O6rHwPJD4L23YlqsLlrPIMKytcW0uJTPnZIVKiZz90h51Pg6snRxFi7DTDMEAapG8tYu9Of6cTEt0aXHsI+m0pWT6858A47GOkgm+yuBKB0Y64nGahFt6OBDPSCZnbT1EcPBvO/ygJp7+LHv2KVc4XiKhljefsjhjVbO3uZbWQBK2fJoOiV6UnPk4wNIcu8dR3KsBTUuXXJ/eRAbV/DsB59D+MYUG6fPG6lYPRDISsz/i6NdsKG7EwuoevFzfnT5YgIJqXRL9O8wSwUYN2Ks/RQco/Ir5JQVKhhneojwW8H41b0dicAV0ADsu0ebEZff0mE6WTepD3Ccgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4733ab60-e709-46e2-70be-08d6553d9694
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:27:12.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQpTZW50OiBNb25k
YXksIE5vdmVtYmVyIDI2LCAyMDE4IDU6MDAgQU0+IA0KPiBPbiBUdWUsIE5vdiAyMCwgMjAxOCBh
dCA3OjI3IFBNIEh1YWlzaGVuZyBZZSA8eWVoczIwMDdAem9oby5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gRnJvbTogSHVhaXNoZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+DQo+ID4gQ2hhbmdl
cw0KPiA+IHYxLT52MjoNCj4gPiAgICAgICAgIEFkZCBOVUxMIGZ1bnRpb25zIGZvciBvcmlnaW5f
ZGF4X2RpcmVjdF9hY2Nlc3MgYW5kDQo+ID4gICAgICAgICBvcmlnaW5fZGF4X2NvcHlfZnJvbS90
b19pdGVyIGluIG9yZGVyIHRvIGF2b2lkIGJ1aWxkaW5nDQo+ID4gICAgICAgICBlcnJvciB3aGVu
IENPTkZJR19EQVhfRFJJVkVSIGhhcyBOT1QgYmVlbiBlbmFibGVkLg0KPiA+DQo+ID4gW3YxXTog
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvMTEvMjAvNzU5DQo+ID4NCj4gPiBUaGlzIHNlcmll
cyBwYXRjaGVzIGFyZSB1c2VkIHRvIHJlYWxpemUgdGhlIGRheF9vcGVyYXRpb25zIGZvciBkbS1z
bmFwc2hvdA0KPiA+IHdpdGggcGVyc2lzdGVudCBtZW1vcnkgZGV2aWNlLg0KPiANCj4gSG93IGRv
ZXMgdGhpcyBpbnRlcmFjdCB3aXRoIG1tYXAgd3JpdGUgZmF1bHRzIGlmIHRoZSBtYXBwaW5nIGlz
IGRheA0KPiBhbmQgdGhlIHBhZ2UgbmVlZHMgdG8gYmUgY293J2Q/DQoNCkhpIERhbiwNCg0KQmFz
ZWQgb24gbXkgdW5kZXJzdGFuZGluZywgSSB0aGluayBkbS1zbmFwc2hvdCBpcyBpbXBvc3NpYmxl
IHRvIHdvcmsNCndpdGggZmlsZSBtYXBwaW5nIGluIERBWCB3YXkuDQoNCldoZW4gZmlsZSBtYXBw
aW5nIGhhcyBiZWVuIHVzZWQgd2l0aCBEQVgsIHVzZXJzcGFjZSBjb3VsZCBnZXQgdGhlIHBvaW50
ZXINClRvIGFjY2VzcyBwZXJzaXN0ZW50IG1lbW9yeSBkaXJlY3RseSBieSBwYWdlIGZhdWx0Lg0K
SGVyZSBpcyB0aGUgY2FsbCB0cmFjZS4NCg0KIDc0IFsgNzY3Ny44OTczNTRdIENhbGwgVHJhY2U6
DQogNzUgWyA3Njc3LjkwMDUzOF0gIGR1bXBfc3RhY2srMHg2Ny8weDgyDQogNzYgWyA3Njc3Ljkw
NDY5NV0gIF9fcG1lbV9kaXJlY3RfYWNjZXNzKzB4YTkvMHgxMDEgW25kX3BtZW1dDQogNzcgWyA3
Njc3LjkxMDkyMl0gID8gbGluZWFyX2N0cisweDEyYS8weDEyYSBbZG1fbW9kXQ0KIDc4IFsgNzY3
Ny45MTYzNDBdICBwbWVtX2RheF9kaXJlY3RfYWNjZXNzKzB4MzAvMHgzNyBbbmRfcG1lbV0NCiA3
OSBbIDc2NzcuOTIyNjQxXSAgZGF4X2RpcmVjdF9hY2Nlc3MrMHgzMC8weDU4DQogODAgWyA3Njc3
LjkyNzQ4MF0gIGxpbmVhcl9kYXhfZGlyZWN0X2FjY2VzcysweDY2LzB4NzEgW2RtX21vZF0NCiA4
MSBbIDc2NzcuOTMzODQ4XSAgZG1fZGF4X2RpcmVjdF9hY2Nlc3MrMHg5Yy8weGYxIFtkbV9tb2Rd
DQogODIgWyA3Njc3LjkzOTg1Nl0gID8gb3JpZ2luX2RheF9jb3B5X2Zyb21faXRlcisweDg4LzB4
ODggW2RtX3NuYXBzaG90XQ0KIDgzIFsgNzY3Ny45NDcwMzJdICBkYXhfZGlyZWN0X2FjY2Vzcysw
eDMwLzB4NTgNCiA4NCBbIDc2NzcuOTUxODc2XSAgb3JpZ2luX2RheF9kaXJlY3RfYWNjZXNzKzB4
NmEvMHg3NSBbZG1fc25hcHNob3RdDQogODUgWyA3Njc3Ljk1ODc1M10gIGRtX2RheF9kaXJlY3Rf
YWNjZXNzKzB4OWMvMHhmMSBbZG1fbW9kXQ0KIDg2IFsgNzY3Ny45NjQ3MzhdICBkYXhfZGlyZWN0
X2FjY2VzcysweDMwLzB4NTgNCiA4NyBbIDc2NzcuOTY5NTQyXSAgZGF4X2lvbWFwX3BmbisweDg0
LzB4MTBkDQogODggWyA3Njc3Ljk3NDA2MV0gIGRheF9pb21hcF9wdGVfZmF1bHQrMHg0YTkvMHg3
NzMNCiA4OSBbIDc2NzcuOTc5MjcxXSAgZGF4X2lvbWFwX2ZhdWx0KzB4MjEvMHgzNg0KIDkwIFsg
NzY3Ny45ODM4OTVdICBleHQyX2RheF9mYXVsdCsweDcwLzB4OWEgW2V4dDJdDQogOTEgWyA3Njc3
Ljk4OTA2MV0gIF9fZG9fZmF1bHQrMHgxZC8weDc0DQogOTIgWyA3Njc3Ljk5MzE1OV0gIF9faGFu
ZGxlX21tX2ZhdWx0KzB4ZjA0LzB4MTdhNA0KIDkzIFsgNzY3Ny45OTgyMjVdICBoYW5kbGVfbW1f
ZmF1bHQrMHgxYTAvMHgyMDQNCiA5NCBbIDc2NzguMDAzMDM1XSAgX19kb19wYWdlX2ZhdWx0KzB4
MzliLzB4NGQzDQogOTUgWyA3Njc4LjAwNzgzOV0gIGRvX3BhZ2VfZmF1bHQrMHhmYy8weDExYg0K
IDk2IFsgNzY3OC4wMTIzMTZdICA/IHBhZ2VfZmF1bHQrMHg4LzB4MzANCiA5NyBbIDc2NzguMDE2
NDk4XSAgcGFnZV9mYXVsdCsweDFlLzB4MzANCg0KVGhlIGFwcGxpY2F0aW9uIGluIHVzZXJzcGFj
ZSBjb3VsZCBkaXJlY3RseSByZWFkIG9yIHdyaXRlIHRoZSBkYXRhIG9mDQp0aGUgZmlsZSBjb250
ZW50IGJ5IG1tYXAgaW4gREFYIHdheS4NCmRtLXNuYXBzaG90IHdvcmtzIGF0IGtlcm5lbCBzcGFj
ZSwgc28gaXQgZG9lc24ndCBoYXZlIGNoYW5jZSB0byBiZSBhd2FyZQ0Kb2YgdGhlIG1vZGlmaWNh
dGlvbiBvZiBGUy4NCg0KSSB0aGluayBpbiB0aGlzIGNhc2UsIHBlcmhhcHMgdXNlcnNwYWNlIHNo
b3VsZCB0YWtlIHRoZSByZXNwb25zaWJpbGl0eQ0KZm9yIHNuYXBzaG90IHdoZW4gZmlsZSBtYXBw
aW5nIGhhcyBiZWVuIHVzZWQgaW4gREFYIHdheS4gSnVzdCBsaWtlIHdoYXQNCk5WTUwgaGFzIGRv
bmUgYXMgQ0xGTFVTSCBmb3IgY2FjaGUgbGluZXMgZmx1c2guDQoNCkNvcnJlY3QgbWUgaWYgYW55
dGhpbmcgaXMgbm90IGFjY3VyYXRlLg0KDQpDaGVlcnMsDQpIdWFpc2hlbmcgWWUNCg==
