Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F95C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FD22148D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nf/I7vty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBAXRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:17:51 -0500
Received: from mail-eopbgr1310135.outbound.protection.outlook.com ([40.107.131.135]:7616
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbfBAXRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+ISnRKAt20/K+1WT9xXMN91Q0GGleO1l/u+e6mePxc=;
 b=nf/I7vtysUhtHZAbGlWiVIWtaFyDZkKc/xdr2kvLWr9eHBjdquz269CdOxXEWVxozFWMgWewp+sSftqIMbSzZo5toCiSbrYI94oXSC+HUDGXg6LG7D3bDvlgOlYt26aL6CM0zVluHsq0aNaTwGBW0jxUZUA/I8QVRyurDKf8BHc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.4; Fri, 1 Feb 2019 23:17:20 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.011; Fri, 1 Feb 2019
 23:17:20 +0000
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
Thread-Index: AdS3bN9R4nkrWGwLQkueB3AG7WN74AA93MgAAHsdi6AAALlsgAAB+BMA
Date:   Fri, 1 Feb 2019 23:17:19 +0000
Message-ID: <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
In-Reply-To: <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-01T23:17:17.1451793Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=495f2db0-dfda-4df3-a0f8-acce239e29e3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [131.107.174.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0169;6:+JiCOfXWkkITaq4jnkBHICvKMcp9L8mSdp3fS/Cqhs7nkJ5dtKe9Ed7mmEYKAQEd397nBofxdVD68eiszio06xQtXYIgptGa50atbv5Ie0rkgPvi9si5xri80FJualsvcq5XX3Uhe5cjk5FtL15cMnkdUdZ6/2q4uepMUVNvoRL5El0afdDEYIHHURw2dPKwpyD6LtL5P/iXPUc+d8NABDo8XHuJVKvw7NBvMDzGiilrvWzOK0IrglZzLQnQReAMkW1ujzeDW22r8J0klR/oJIizexIUxAR71T9y9iWV9Xg2j0YA8pOhNNhRGWqGZhUJASnikjJ+U1vSjBL3K9UtwattGbvFjDYzjH5jbWT7Y8QRgaI2ab6XWxBTEFjpZKpyoBhI15QQUJL304/BrXGbj6yha3eTER88ab8rzrhYB+KlDSfSFqNw31MFoXG9zOAZbJd0HE40/y9biST6C4j7TQ==;5:HrFQam5rnuk2KZj3TwW2oc5Br/REtceKJl2YhvRWFRXUna4UeQnRurQVCmY0TxiJcImpfZPzV3sXCNYJ0m5n0DrVeJqCgT9Xu8teebWbR8hAHaEdnAOKWsTTlNYbiYQQOS47G8097m8inzBSSfSbnpXQvomGxOs6WzfMEu9ClwXbGB8XpRhXuLFEPvTPgU399DfIAsY1Faf1iIRLxAMBVQ==;7:z2S7KVJVZ3zouRCdhgYv9+oIEeVmfoQ89qy63bJ5lsIG/IO/aQoNlmPW8/DWivz6pOLS36HGV0xubyFQuc7sSsCnBVeRbyIFoqm73BZSPO1+liqQiXH96ew2VjMCYhymb4iPZD1oMl7EW5Ndjb1M4w==
x-ms-office365-filtering-correlation-id: 657b0a5d-bdee-4f71-c6ff-08d6889b6a47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0169;
x-ms-traffictypediagnostic: PU1P153MB0169:
x-microsoft-antispam-prvs: <PU1P153MB0169DC6E85A72A4A8BB7D2BEBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(199004)(189003)(25786009)(26005)(5024004)(256004)(14444005)(2906002)(478600001)(4326008)(10290500003)(229853002)(71200400001)(102836004)(71190400001)(74316002)(55016002)(53936002)(7736002)(305945005)(6506007)(7696005)(486006)(186003)(6436002)(107886003)(6246003)(76176011)(11346002)(86612001)(476003)(217873002)(9686003)(446003)(86362001)(6116002)(33656002)(3846002)(68736007)(99286004)(54906003)(97736004)(22452003)(105586002)(106356001)(316002)(8990500004)(10090500001)(93886005)(14454004)(81166006)(6916009)(8936002)(66066001)(8676002)(81156014)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0169;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1IvcruBcWfzdAeKf+6eKqDpRte73zYHadTTS4x4P0tEnhyBfOjT+M98ft32qXwwUS+CjFKYjX62iGhx/ekEpq/Q03ibPvGC8ioYbv8HeNP9Ako5i3GZWCwxFPnotGgXPRYYW2mvSA2kH4HuazzXxRNj9hc2Hp9qWk1tDSsIx7wS8AEf/R+Ip4gr04xqM9pUHe8uV8IqHx/+5DKjGku3hh+mOj0Cw+5F/xYjHlt/hI4Wp1DVoDXLmR7AmtXSQvkK/1WcjwuKbmxR+Z9ixdyFiQX7264C4fYSsApQbEZyujKXV7Hc9Q3GblyJTPRgUuebIepQpKF85pibtcznizSKd7+Pdm0oNcYgxrw7JtATvRQL1YZEQW531WlRp6bwxIyado8xj+oXMOVxwb+gIxzkhfNMGUpwQK7RnTW2vJ0tDAAo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657b0a5d-bdee-4f71-c6ff-08d6889b6a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 23:17:19.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAxLCAyMDE5IDk6MjkgQU0NCj4gPiBIaSBEYW4sDQo+ID4gVW5sdWNr
aWx5IGl0IGxvb2tzIHRoaXMgY29tbWl0IGNhdXNlcyBhIHJlZ3Jlc3Npb24gLi4uDQo+ID4gV2l0
aCB0aGUgcGF0Y2gsICJuZGN0bCBsaXN0IiBzaG93cyBub3RoaW5nLCBhbmQgL2Rldi9wbWVtMCBj
YW4ndCBhcHBlYXIuDQo+ID4gSWYgSSByZXZlcnQgdGhlIHBhdGNoLCBpdCB3aWxsIGJlIGJhY2sg
dG8gbm9ybWFsLg0KPiA+DQo+ID4gSSBhdHRhY2hlZCB0aGUgY29uZmlnL2xvZ3MuIEluIHRoZSBi
YWQgY2FzZSwgImRtZXNnIiBzaG93cyBhIGxpbmUNCj4gPiBbICAgIDUuMjU5MDE3XSBuZF9wbWVt
IG5hbWVzcGFjZTAuMDogMHgwMDAwMDAwMDAwMDAwMDAwLCB0b28gc21hbGwNCj4gbXVzdCBiZSBh
dCBsZWFzdCAweDEwMDANCj4gPiBBbnkgaWRlYSB3aHkgdGhpcyBoYXBwZW5zPyBJJ20gZGlnZ2lu
ZyBpbnRvIHRoZSBkZXRhaWxzIGFuZCBJIGFwcHJlY2lhdGUgeW91cg0KPiBpbnNpZ2h0cy4NCj4g
DQo+IExvb2tzIGxpa2UgaXQgaXMgd29ya2luZyBhcyBleHBlY3RlZC4gDQoNCkkgd2FzIHdvcmtp
bmcgb24gbGludXgtbmV4dCB0cmVlJ3MgbmV4dC0yMDE5MDEwNyBhbmQgdGhpcyBwYXRjaCBkaWQg
IndvcmsgZmluZSINCnRoZXJlLiBUaGUgInJlZ3Jlc3Npb24iIGhhcHBlbnMgb24gZGpidy9udmRp
bW0uZ2l0IHRyZWUncyBsaWJudmRpbW0tcGVuZGluZw0KYnJhbmNoIGJlY2F1c2Ugd2UgaGF2ZSB0
aGlzIHJlY2VudCBjb21taXQgKEphbiAxOSk6DQoNCjExMTg5YzEwODlkYSAoImFjcGkvbmZpdDog
Rml4IGNvbW1hbmQtc3VwcG9ydGVkIGRldGVjdGlvbiIpLCB3aGljaCBtYWtlcyBzdWNoDQphIGNo
YW5nZSBpbiBhY3BpX25maXRfY3RsKCk6DQoNCi0gICAgICAgaWYgKCF0ZXN0X2JpdChjbWQsICZj
bWRfbWFzaykgfHwgIXRlc3RfYml0KGZ1bmMsICZkc21fbWFzaykpDQorICAgICAgIGlmIChjbWQg
PT0gTkRfQ01EX0NBTEwgJiYgIXRlc3RfYml0KGZ1bmMsICZkc21fbWFzaykpDQorICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9UVFk7DQorICAgICAgIGVsc2UgaWYgKCF0ZXN0X2JpdChjbWQsICZj
bWRfbWFzaykpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9UVFk7DQoNClNvIHByZXZpb3Vz
bHkgTkRfQ01EX0dFVF9DT05GSUdfREFUQSBmYWlscyB3aXRoIC1FTk9UVFkgYW5kIHdlJ3JlIGdv
b2QuDQoNCk5vdyB0aGUgY29tbWFuZCBzdWNjZWVkcywgYnV0IGl0IGxvb2tzIHRoZSByZXR1cm5l
ZCBkYXRhIGlzIGluYXZsaWQsIGFuZCBJIHNlZQ0KdGhlICJyZWdyZXNzaW9uIi4NCg0KPiBUaGUg
cmVncmVzc2lvbiB5b3UgYXJlIHNlZWluZyBpcyB0aGUgZmFjdCB0aGF0IHRoZSBwYXRjaCBlbmFi
bGVzIHRoZSBrZXJuZWwgdG8NCj4gZW5hYmxlIG52ZGltbS1uYW1lc3BhY2UtbGFiZWwgcmVhZHMu
IA0KWWVzLg0KDQo+IFRob3NlIHJlYWRzIGZpbmQgYSBuYW1lc3BhY2UgaW5kZXggYmxvY2sNCj4g
YW5kIGEgbGFiZWwuIFVuZm9ydHVuYXRlbHkgdGhlIGxhYmVsIGhhcyB0aGUgTE9DQUwgZmxhZyBz
ZXQgYW5kIExpbnV4DQo+IGV4cGxpY2l0bHkgaWdub3JlcyBwbWVtIG5hbWVzcGFjZSBsYWJlbHMg
d2l0aCB0aGF0IGJpdCBzZXQuIFRoZSByZWFzb24NCkNhbiB5b3UgcGxlYXNlIHBvaW50IG91dCB0
aGUgZnVuY3Rpb24gdGhhdCBpZ25vcmVzIHRoZSBmbGFnPw0KDQpJIGNoZWNrZWQgd2hlcmUgTlNM
QUJFTF9GTEFHX0xPQ0FMIGlzIHVzZWQsIGJ1dCBpdCBsb29rcyBJIGNhbid0IGZpbmQgYQ0KcmVs
YXRlZCBmdW5jdGlvbi4NCg0KPiBmb3IgdGhhdCBpcyBkdWUgdG8gdGhlIGZhY3QgdGhhdCB0aGUg
b3JpZ2luYWwgZGVmaW5pdGlvbiBvZiB0aGUgTE9DQUwNCj4gYml0IGZyb20gdjEuMSBvZiB0aGUg
bmFtZXNwYWNlIGxhYmVsIGltcGxlbWVudGF0aW9uIFsxXSBleHBsaWNpdGx5DQo+IGxpbWl0ZWQg
dGhlIExPQ0FMIGZsYWcgdG8gImJsb2NrIGFwZXJ0dXJlIiByZWdpb25zLiBJZiB5b3UgY2xlYXIg
dGhhdA0KPiBMT0NBTCBmbGFnIEkgZXhwZWN0IGl0IHdpbGwgd29yay4gVG8gbXkga25vd2xlZGdl
IFdpbmRvd3MgcHJldGVuZHMNCj4gdGhhdCB0aGUgdjEuMSBkZWZpbml0aW9uIG5ldmVyIGV4aXN0
ZWQuDQpJJ20gdHJ5aW5nIHRvIGZpbmQgb3V0IHdoZXJlIHRoZSBmbGFnIGlzIHVzZWQgYW5kIGhv
dyB0byBjbGVhciBpdC4NCg0KPiBUaGUgVUVGSSAyLjcgc3BlY2lmaWNhdGlvbiBmb3IgdjEuMiBs
YWJlbHMgc3RhdGVzIHRoYXQgc2V0dGluZyB0aGUNCj4gTE9DQUwgZmxhZyBpcyBvcHRpb25hbCB3
aGVuICJubGFiZWwiLCBudW1iZXIgb2YgbGFiZWxzIGluIHRoZSBzZXQsIGlzDQo+IDEuIExpbnV4
IG1ha2VzIHRoYXQgbWFuZGF0b3J5IGFzIExPQ0FMIGlzIHJlZHVuZGFudCB3aGVuIG5sYWJlbCBp
cyAxLg0KPiANCj4gVGhhdCBzYWlkLCB0aGUgUm9idXN0bmVzcyBQcmluY2lwbGUgbWFrZXMgYSBj
YXNlIHRoYXQgTGludXggc2hvdWxkDQo+IHRvbGVyYXRlIHRoZSBiaXQgYmVpbmcgc2V0LiBIb3dl
dmVyLCBpdCdzIGp1c3QgYSBub24tdHJpdmlhbCBhbW91bnQgb2YNCj4gd29yayB0byB1bndpbmQg
dGhlIGluZ3JhaW5lZCBibG9jay1hcGVydHVyZSBhc3N1bXB0aW9ucyBvZiB0aGF0IGJpdC4NCkNh
biB5b3UgcGxlYXNlIGV4cGxhaW4gdGhpcyBhIGJpdCBtb3JlPyBTb3JyeSwgSSdtIG5ldyB0byB0
aGlzIGFyZWEuLi4NCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
