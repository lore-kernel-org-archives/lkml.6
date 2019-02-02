Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45142C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4772148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oNodX+41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfBBAe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:34:28 -0500
Received: from mail-eopbgr1320097.outbound.protection.outlook.com ([40.107.132.97]:5408
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727078AbfBBAe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6sLHqJdM1HHlnELpTCuAM14tadK5STyspN1dHvZFbg=;
 b=oNodX+41futnIQ4u91XVWi9KGwtLLpD62i4g9e6qafNdmXHH8hQp1HWm4YiPXqGMvFtMaHCSymRMFUMIEXsByPBbPAhKCCQ2jt1H2yoaZgJTvkuOg5fGnShbry8R3l1ZDS6lcCZie5J4KvGZkc26XftY7h+cl0AwYwPC+YJx/k4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0124.APCP153.PROD.OUTLOOK.COM (10.170.188.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.3; Sat, 2 Feb 2019 00:34:15 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.011; Sat, 2 Feb 2019
 00:34:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white
 list
Thread-Index: AdS3bN9R4nkrWGwLQkueB3AG7WN74AA93MgAAHsdi6AAALlsgAAB+BMAAAs5uIAAAJW/gA==
Date:   Sat, 2 Feb 2019 00:34:14 +0000
Message-ID: <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
In-Reply-To: <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-02T00:34:12.6429755Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=27c1866a-708c-47ae-aca6-293447c2a175;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [167.220.2.92]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0124;6:EkXc21zuiqgkHQjoNfSMsCuU3JEZcb965gcnF6CQs5TOl2YyuO7Qt807rAyQk51P6zd/TUidsmvF7uKvy5bvkEkeW6Z+c8kqte3qBtuyUiJig6VtV6/5WWnj8lfCegiAws6HRIrNJSX34NDvlohC1/MkNw8HpSU+zt0KFGDQu35LTjjrgh8lwLxp89LijnSUy3wali+guZqTiNykimb0BVq5UULyoELr+vaE6F94VkybA7YFPZsRGhsMS+KzwUofIE2siNT8kocvgVjMEni4/V7+mHGIb2qgU+XpQEuKCp6UMC0+Rw/54qY2tG4akcJMOl/szXg6SVytAf5wOpLmVXslP1Jq/p7bbiJN24XQrXL/0eDPS8vanogX5koubqsUEmRRQld2k/56LtdVFri3g4MNwzgBltSbr4BvrgXQoPlBL4KVdwF4W742I4J8IsKtwXQQyTPF8llyzaVRGttJ/w==;5:oy28gQdRAOipuV3ZUQOIh4zVcJyA8iObz2VBeAxbPA/R5an0M8vyVdHtjelI+Ln1ZGeNCxeX3sLRU/VS4Fb/diBGB47IpQBIdZj0UtsZeP6F2zxqn4gy0Om15eTYpqNWjYLTXbe9K1mIZU/bN4SE4gvzYi9EvlMOBJn0ji3gudRfRa/0AZ50l5F/czVMERjfeMGJ/Z4G/8DCGFwUskKQmw==;7:0+IkRQH63TfnoyrAog1ooEC1DnUDGcc9XSS8mBTakzf6hbx3U4v5RdBmxJuAkLw5Uq3fk5CqcY8Q378EeTmhH9FQxkEk43OouC7vYtb4C/Zv2DAZIGNWjiPM6Zi6FKtNnth8MtAX7Xpugw6AwiAXAA==
x-ms-office365-filtering-correlation-id: dd457881-6ce1-4c5c-899a-08d688a628d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0124;
x-ms-traffictypediagnostic: PU1P153MB0124:
x-microsoft-antispam-prvs: <PU1P153MB0124BD8B67A4F516FD59D6F2BF930@PU1P153MB0124.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(51914003)(6436002)(229853002)(22452003)(97736004)(86612001)(86362001)(316002)(54906003)(9686003)(6246003)(107886003)(53936002)(25786009)(6916009)(8676002)(4326008)(99286004)(93886005)(33656002)(55016002)(7696005)(76176011)(81156014)(6506007)(81166006)(7416002)(8936002)(105586002)(102836004)(478600001)(26005)(53546011)(217873002)(10090500001)(68736007)(71200400001)(71190400001)(8990500004)(106356001)(14454004)(256004)(5024004)(305945005)(446003)(66066001)(11346002)(7736002)(14444005)(476003)(486006)(2906002)(3846002)(6116002)(74316002)(186003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0124;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b/aU6+9NT1oG2jnBBCpN7/97RQniALFr9ULV/BJzHNtQvipL6s4j/L5qhDOahzdO9HxdoUW2uZT5YFQSYgnjLwcj9Li8Jq47wL7oP1oeNMGXLQWVEWl8nMR6XY4geN1nIjBIvTUefZvYbSGmOZNkqPIQSvLReUvBPvYcWzQks8Fe4xFNJS3qFrM+XfKRjGsrKuwFtzXTE4A1EDaGLGaeVgnXEhs6zy8c+JEA1iRBLyKS94Uqa0B35ao6cNxBDs39aroXoUbrEidTo7xoCOYUpgbXeh5L7YN5j5lpwNFE9+1wZcGNI5vFPqmuBHUwRGkmPPc6iybiy19EeyHt25phdveENqiSudh9aYR9NX7UyqvijzWsuA7tFrG1KK+Dtjb0CDVVSrbbYIopMNtHh2780zdVj/A85a/0n3Ey8WfJyz4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd457881-6ce1-4c5c-899a-08d688a628d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 00:34:14.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAxLCAyMDE5IDM6NDcgUE0NCj4gVG86IERleHVhbiBDdWkgPGRlY3Vp
QG1pY3Jvc29mdC5jb20+DQo+IA0KPiBJIGJlbGlldmUgaXQncyB0aGUgc2FtZSByZWFzb24uIFdp
dGhvdXQgMTExODljMTA4OWRhIHRoZSBfTFNSIG1ldGhvZA0KPiB3aWxsIGZhaWwsIGFuZCBvdGhl
cndpc2UgaXQgd29ya3MgYW5kIGZpbmRzIHRoZSBsYWJlbCB0aGF0IGl0IGRvZXNuJ3QNCj4gbGlr
ZS4NCkV4YWN0bHkuDQogDQo+IEknbSBub3Qgc2VlaW5nICJpbnZhbGlkIiBkYXRhIGluIHlvdXIg
ZmFpbHVyZSBsb2cuIENvdWxkIHlvdSBkb3VibGUNCj4gY2hlY2sgdGhhdCBpdCdzIGp1c3Qgbm90
IHRoZSBzdWNjZXNzIG9mIF9MU1IgdGhhdCBjYXVzZXMgdGhlIGlzc3VlPw0KDQphY3BpX2xhYmVs
X3JlYWQoKSBuZXZlciBmYWlscyBmb3IgbWUuDQoNCkJ5ICJpbnZhbGlkIiwgSSBvbmx5IG1lYW4g
dGhlIG1lc3NhZ2VzIGluIHRoZSBkbWVzZy5iYWQudHh0IEkgcHJldmlvdXNseQ0KYXR0YWNoZWQg
KEknbSBqdXN0IHJlYWRpbmcgdGhlIHNwZWNzIHRvIGxlYXJuIHRoZSBkZXRhaWxzIGFib3V0IE5W
RElNTQ0KbmFtZXNwYWNlJ3MgbGFiZWxzLCBzbyBteSBkZXNjcmlwdGlvbiBtaWdodCBiZSBpbmFj
Y3VyYXRlKSA6DQoNClsgICAgNC44MzIzNjddIG52ZGltbSBubWVtMTogbnNpbmRleDAgbGFiZWxz
aXplIDEgaW52YWxpZA0KWyAgICA0LjgzMjM2OV0gbnZkaW1tIG5tZW0xOiBuc2luZGV4MSBsYWJl
bHNpemUgMSBpbnZhbGlkDQouLi4NClsgICAgNS4yNTkwMTddIG5kX3BtZW0gbmFtZXNwYWNlMC4w
OiAweDAwMDAwMDAwMDAwMDAwMDAsIHRvbyBzbWFsbCBtdXN0IGJlIGF0IGxlYXN0IDB4MTAwMA0K
DQo+ID4gPiBUaGUgcmVncmVzc2lvbiB5b3UgYXJlIHNlZWluZyBpcyB0aGUgZmFjdCB0aGF0IHRo
ZSBwYXRjaCBlbmFibGVzIHRoZSBrZXJuZWwNCj4gdG8NCj4gPiA+IGVuYWJsZSBudmRpbW0tbmFt
ZXNwYWNlLWxhYmVsIHJlYWRzLg0KPiA+IFllcy4NCj4gPg0KPiA+ID4gVGhvc2UgcmVhZHMgZmlu
ZCBhIG5hbWVzcGFjZSBpbmRleCBibG9jaw0KPiA+ID4gYW5kIGEgbGFiZWwuIFVuZm9ydHVuYXRl
bHkgdGhlIGxhYmVsIGhhcyB0aGUgTE9DQUwgZmxhZyBzZXQgYW5kIExpbnV4DQo+ID4gPiBleHBs
aWNpdGx5IGlnbm9yZXMgcG1lbSBuYW1lc3BhY2UgbGFiZWxzIHdpdGggdGhhdCBiaXQgc2V0LiBU
aGUgcmVhc29uDQo+ID4gQ2FuIHlvdSBwbGVhc2UgcG9pbnQgb3V0IHRoZSBmdW5jdGlvbiB0aGF0
IGlnbm9yZXMgdGhlIGZsYWc/DQo+ID4NCj4gPiBJIGNoZWNrZWQgd2hlcmUgTlNMQUJFTF9GTEFH
X0xPQ0FMIGlzIHVzZWQsIGJ1dCBpdCBsb29rcyBJIGNhbid0IGZpbmQgYQ0KPiA+IHJlbGF0ZWQg
ZnVuY3Rpb24uDQo+IA0KPiBzY2FuX2xhYmVscygpIGlzIHdoZXJlIHRoZSBuYW1lc3BhY2UgbGFi
ZWwgaXMgdmFsaWRhdGVkIHJlbGF0aXZlIHRvDQo+IHRoZSByZWdpb24gdHlwZToNCj4gDQo+ICAg
ICAgICAgICAgICAgICBpZiAoaXNfbmRfYmxrKCZuZF9yZWdpb24tPmRldikNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA9PSAhIShmbGFncyAmIE5TTEFCRUxfRkxBR19MT0NBTCkp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIHBhc3MsIHJlZ2lvbiBtYXRjaGVzIGxhYmVs
IHR5cGUgKi87DQo+ICAgICAgICAgICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRpbnVlOw0KPiANCj4gSXQgYWxzbyBoYXMgbWVhbmluZyBmb3IgdGhlIG5hbWVzcGFj
ZSBjYXBhY2l0eSBhbGxvY2F0aW9uDQo+IGltcGxlbWVudGF0aW9uIHRoYXQgbmVlZGVkIHRoYXQg
ZmxhZyB0byBkaXN0aW5ndWlzaCBhbGlhc2VkIGNhcGFjaXR5DQo+IGJldHdlZW4gQmxvY2sgQXBl
cnR1cmUgTW9kZSBhbmQgUE1FTSBNb2RlIGFjY2Vzcy4NClRoYW5rcyBmb3IgdGhlIHBvaW50ZXIh
IEknbSBsb29raW5nIGF0IHRoaXMgZnVuY3Rpb24uDQoNCj4gPiA+IGZvciB0aGF0IGlzIGR1ZSB0
byB0aGUgZmFjdCB0aGF0IHRoZSBvcmlnaW5hbCBkZWZpbml0aW9uIG9mIHRoZSBMT0NBTA0KPiA+
ID4gYml0IGZyb20gdjEuMSBvZiB0aGUgbmFtZXNwYWNlIGxhYmVsIGltcGxlbWVudGF0aW9uIFsx
XSBleHBsaWNpdGx5DQo+ID4gPiBsaW1pdGVkIHRoZSBMT0NBTCBmbGFnIHRvICJibG9jayBhcGVy
dHVyZSIgcmVnaW9ucy4gSWYgeW91IGNsZWFyIHRoYXQNCj4gPiA+IExPQ0FMIGZsYWcgSSBleHBl
Y3QgaXQgd2lsbCB3b3JrLiBUbyBteSBrbm93bGVkZ2UgV2luZG93cyBwcmV0ZW5kcw0KPiA+ID4g
dGhhdCB0aGUgdjEuMSBkZWZpbml0aW9uIG5ldmVyIGV4aXN0ZWQuDQo+ID4gSSdtIHRyeWluZyB0
byBmaW5kIG91dCB3aGVyZSB0aGUgZmxhZyBpcyB1c2VkIGFuZCBob3cgdG8gY2xlYXIgaXQuDQo+
IA0KPiBBc3N1bWluZyBIeXBlci1WIGltcGxlbWVudHMgX0xTVywgeW91IGNhbiByZWNyZWF0ZSAv
IHJlaW5pdGlhbGl6ZSB0aGUNCj4gbGFiZWwgYXJlYToNCg0KSSB0aGluayBIeXBlci1WIG9ubHkg
aW1wbGVtZW50cyBfTFNSOg0KWyAgICA0LjcyMDYyM10gbmZpdCBBQ1BJMDAxMjowMDogZGV2aWNl
OjAwOiBoYXMgX0xTUg0KWyAgICA0LjcyMzY4M10gbmZpdCBBQ1BJMDAxMjowMDogZGV2aWNlOjAx
OiBoYXMgX0xTUg0KIA0KPiA+ID4gVGhlIFVFRkkgMi43IHNwZWNpZmljYXRpb24gZm9yIHYxLjIg
bGFiZWxzIHN0YXRlcyB0aGF0IHNldHRpbmcgdGhlDQo+ID4gPiBMT0NBTCBmbGFnIGlzIG9wdGlv
bmFsIHdoZW4gIm5sYWJlbCIsIG51bWJlciBvZiBsYWJlbHMgaW4gdGhlIHNldCwgaXMNCj4gPiA+
IDEuIExpbnV4IG1ha2VzIHRoYXQgbWFuZGF0b3J5IGFzIExPQ0FMIGlzIHJlZHVuZGFudCB3aGVu
IG5sYWJlbCBpcyAxLg0KPiA+ID4NCj4gPiA+IFRoYXQgc2FpZCwgdGhlIFJvYnVzdG5lc3MgUHJp
bmNpcGxlIG1ha2VzIGEgY2FzZSB0aGF0IExpbnV4IHNob3VsZA0KPiA+ID4gdG9sZXJhdGUgdGhl
IGJpdCBiZWluZyBzZXQuIEhvd2V2ZXIsIGl0J3MganVzdCBhIG5vbi10cml2aWFsIGFtb3VudCBv
Zg0KPiA+ID4gd29yayB0byB1bndpbmQgdGhlIGluZ3JhaW5lZCBibG9jay1hcGVydHVyZSBhc3N1
bXB0aW9ucyBvZiB0aGF0IGJpdC4NCj4gPiBDYW4geW91IHBsZWFzZSBleHBsYWluIHRoaXMgYSBi
aXQgbW9yZT8gU29ycnksIEknbSBuZXcgdG8gdGhpcyBhcmVhLi4uDQo+IA0KPiBUaGUgc2hvcnQg
c3RvcnkgaXMgdGhhdCBMaW51eCBlbmZvcmNlcyB0aGF0IExPQ0FMID09IEJsb2NrIE1vZGUNCj4g
TmFtZXNwYWNlcy4gU2VlIHNlY3Rpb24gMi4yIE5hbWVzcGFjZSBMYWJlbCBMYXlvdXQgaW4gdGhl
IG9yaWdpbmFsDQo+IHNwZWMgWzFdLiBUaGUgRUZJIDIuNyBkZWZpbml0aW9uIHRyaWVkIHRvIGFs
bG93IGZvciBMT0NBTCB0byBiZSBzZXQNCj4gd2hlbiBhbiBpbnRlcmxlYXZlLXNldCB3YXMgY29t
cHJpc2VkIG9mIGEgc2luZ2xlIE5WRElNTSwgYnV0IHRoZW4gYWxzbw0KPiBzdGF0ZXMgaXRzIG9w
dGlvbmFsIHdoZW4gTmxhYmVsIGlzIDEuIEl0IGhhcyB6ZXJvIGZ1bmN0aW9uYWwgdXNlIGZvcg0K
PiBpbnRlcmxlYXZlLXNldCBiYXNlZCBuYW1lc3BhY2VzIGV2ZW4gd2hlbiB0aGUgaW50ZXJsZWF2
ZS1zZXQtd2lkdGggaXMNCj4gMS4gU28gTGludXggdGFrZXMgdGhlIG9wdGlvbiB0byBuZXZlciBz
ZXQgaXQsIGFuZCBnb2VzIGZ1cnRoZXIgdG8NCj4gcmVqZWN0IGl0IGlmIGl0J3Mgc2V0IGFuZCB0
aGUgcmVnaW9uLXR5cGUgZG9lcyBub3QgbWF0Y2gsIGJlY2F1c2UgdGhhdA0KPiBmb2xsb3dzIHRo
ZSB2MS4xIG1lYW5pbmcgb2YgdGhlIGZsYWcuDQo+IA0KPiBbMV06DQpUaGFua3MgZm9yIHRoZSBs
aW5rISBJJ2xsIHJlYWQgaXQuDQpCVFcsIGl0IGxvb2tzIEh5cGVyLVYgb25seSBzdXBwb3J0cyBQ
TUVNIG5hbWVzcGFjZSwgYXQgbGVhc3Qgc28gZmFyLg0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg==
