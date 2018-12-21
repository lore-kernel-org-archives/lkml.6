Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2243821928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nCrdh6qe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cu9Hmd17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391646AbeLUTWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:45 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12902 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389636AbeLUTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545420163; x=1576956163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3JtFwj7JIVLVqDsn3o7mL/ddTorrjWonzsYGX+cyCvs=;
  b=nCrdh6qe3LbpG8H9mrl5KWumJ3y7KG4Ptpi9scwUDhd5mVNvrTrUcuuc
   Fqxh/mu/UBsEToZzAdDMmFIhGrjstJMEojHZJV9rNL5vjqc56XYO46nvH
   9NFFkrxgbSI5PfZnlgQC7wBSY3latPo5/wZ9X6DujlfWMpzJZSBz9DfZk
   LEDYlTo22TzlGNEOj+IMzcyES3onPPjXevfbqhwdL5j0cRuPG6//QEFCK
   eFRP6SDHrXE0rnVURbwg8gQYPisbZtUUrbqyEUJCn2C5cleAL2d6dgXAf
   NMtiM9cyHgXZrD7BgixgcETDrldHgUYEteJ4S6FKuauUlldzBRL3OzZWC
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,382,1539619200"; 
   d="scan'208";a="201937778"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2018 03:22:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JtFwj7JIVLVqDsn3o7mL/ddTorrjWonzsYGX+cyCvs=;
 b=cu9Hmd172iKKa5ygzVTZpEBonolfc6jI1UIQdqz6ETcLrAk9XDd3uaSOKt2zi3Tmun7ZMBitjlwzCaaiJyO3MNlPdiPOp2d7ajXtWnT/QjLVmZqa7l8eY2xVnBAfLyeTpgdt6DS22MTDffSThzRDMmwrHiuADoHi2urzj5/pMv8=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB0896.namprd04.prod.outlook.com (10.174.174.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 21 Dec 2018 19:22:41 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604%4]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 19:22:41 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUmWBEawqGhX/hUk+WG09gQflaXKWJj9CAgAACgwA=
Date:   Fri, 21 Dec 2018 19:22:41 +0000
Message-ID: <541e8b85bc2d3010741daadddc71ada52b847b8f.camel@wdc.com>
References: <20181221190615.19003-1-alistair.francis@wdc.com>
         <alpine.DEB.2.21.9999.1812211110260.777@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1812211110260.777@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.171]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0896;6:z/IJp3jtYLiLdz1Ts16gUR4x0Sq10QaVwyugubQTuDuh87QayC4oNtyj6hCkEkESfHVR66xOB9dHLyOW67tKmoDqvEeO5uoU+WW9LxWBBO/x20HUs/Pmso7HZc7rQZMdsxOil4gFfgb+B8mXwXuXQkYGZcKzdYf6CWoAEtKcLXzpIKDCDUGcIjlsqWR1S/3FRUIVkYbw5MpfBmSg0B59oIIVNdStXafAUEggQAW9HUh2Gyt9jxH++5u3STyePU+H8k2sLaJ0IVU3DOJKM7nmvhRFR+ExPnHjsOj1CIrGNcultlYZiVZZn4uB9c52Eicd+jPOU+CZjvcmHqNtl5tSKpMSFvBJBWM3rIHfBwuJ6d7Ja44e0Xqm+OqDXX555cMKRNSs6MoHUicIhlgFoNG5SVf2nLtzBvXJN/wutbMWUIbCC+F+ThLzH5PUpHx7wVo3W5w25bs1gcGDusNuAuzEqg==;5:4umdCcRnzj94qxJ1mkdkf3Ib8ECkzsOc1KOStxdQeowLJ55NTYEmKpmaeMRcWK7IbTgWnsdsCTCpiMKYUXkYc3MQfCn2gbDMeOv8J95cdc6lA3esTPU2FmxzRUz++2sDzXVOPOlJEfiav5U2Hze2zmbBSH94DW4Bhnzv4i2Jets=;7:FKrMOZOv5NtQwEq1B+ipAp9pUydaDePeVnX1n5mXeYcMYogvfHnW+/mU8QQaucLp7GUjNsXXkYr8GQtFlCLHQD4W+Y3uLJ3wLAb1FLcZ5D4cs5+0c/0EojjwWE84jVHcNpEcTzbt/cg0QZKYOveQtA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 665cec4e-dc50-4bc2-1f54-08d66779ad17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0896;
x-ms-traffictypediagnostic: MWHPR04MB0896:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0896536C1FA67F598E9A4F1790B80@MWHPR04MB0896.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR04MB0896;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0896;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(396003)(376002)(199004)(189003)(316002)(2616005)(25786009)(446003)(11346002)(66066001)(5660300001)(72206003)(486006)(6506007)(478600001)(6246003)(256004)(26005)(118296001)(186003)(476003)(4001150100001)(5640700003)(53936002)(102836004)(7736002)(4326008)(2501003)(6512007)(71190400001)(6486002)(36756003)(2351001)(229853002)(6436002)(86362001)(2906002)(81156014)(81166006)(8676002)(99286004)(106356001)(6916009)(97736004)(105586002)(6116002)(8936002)(14454004)(54906003)(305945005)(3846002)(76176011)(71200400001)(68736007)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0896;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1u45yUifKk5G3ju6E4wHCOEi/0EMwrX3ENSJbnJ4tgtMYWvY12DquWa7idiqNtyIMMtstBIqO23GNpLBYAz9n1CeDb5R+DMLM1v42nFI5hJjoRYPqyeZb4sVYX6q1v71/R4fPtmEIQmG7nWfvxt11a1wAvhXmTeJhc62XqvifD2k5vQbusKZLZvD46ZGmHx4HEO+OtVC1W0TBklkFWfKvzSdjYuwAuLg8jr0MpyVNCcK6mCWKFsKMevpJe2nbGn5JP6w6SZigU01oj+WOr/fspK0Ox3EWyLy5aDuHYs/NbI2ofLlYYux8ABD2d8tvyX5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6679154E5971D444BD097404BD5A869E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665cec4e-dc50-4bc2-1f54-08d66779ad17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 19:22:41.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEyLTIxIGF0IDExOjEzIC0wODAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBIZWxsbyBBbGlzdGFpciwNCj4gDQo+IE9uIEZyaSwgMjEgRGVjIDIwMTgsIEFsaXN0YWlyIEZy
YW5jaXMgd3JvdGU6DQo+IA0KPiA+IEVuYWJsZSBnZW5lcmljIFBDSWUgYnkgZGVmYXVsdCBpbiB0
aGUgUklTQy1WIGRlZmNvbmZpZywgdGhpcyBhbGxvd3MNCj4gPiB1cw0KPiA+IHRvIHVzZSBRRU1V
J3MgUENJZSBzdXBwb3J0IG91dCBvZiB0aGUgYm94LiBBbHNvIHJlbW92ZSB0aGUgWGlsaW54DQo+
ID4gUENJZQ0KPiA+IHN1cHBvcnQgYnkgZGVmYXVsdCBhcyB0aGlzIGlzIHJhcmVseSB1c2VkIGFu
ZCBjb25mbGljdHMgd2l0aCB0aGUNCj4gPiBtb3JlDQo+ID4gY29tbW9ubHkgdXNlZCAob3V0IG9m
IHRyZWUpIE1pY3JvU2VtaSBQQ0llIHJvb3QgY29tcGxleC4NCj4gDQo+IFRoZXJlIGFyZSBtYW55
IGZvbGtzIHdvcmtpbmcgb24gRlBHQXMgd2hvIHVzZSB0aGUgWGlsaW54IGRyaXZlci4NCj4gDQo+
IEFsc28sIHdlIHNob3VsZCBub3QgcmVtb3ZlIHN1cHBvcnQgZm9yIGFuIGluLXRyZWUgZHJpdmVy
IGJlY2F1c2UgYW4gDQo+IG91dC1vZi10cmVlIGRyaXZlciBjb25mbGljdHMuICBUaGUgcmlnaHQg
YXBwcm9hY2ggaXMgdG8gZ2V0IHRoZSANCj4gb3V0LW9mLXRyZWUgZHJpdmVyIHVwc3RyZWFtLg0K
DQpJJ20gaGFwcHkgdG8ga2VlcCBpdCBpbi4NCg0KV2hlbiB0aGUgTWljcm9TZW1pIGRyaXZlciBk
b2VzIGV2ZW50dWFsbHkgZ28gdXBzdHJlYW0gdGhpcyB3aWxsDQpwcm9iYWJseSBoYXZlIHRvIGJl
IGRpc2N1c3NlZCB0aG91Z2ggYXMgZWl0aGVyIHRoZSBjb25maWcgb3IgZGV2aWNlDQp0cmVlIHdp
bGwgbmVlZCB0byBiZSBlZGl0ZWQgdG8gZW5zdXJlIG9ubHkgb25lIFBDSWUgZGV2aWNlIGlzIHBy
ZXNlbnQuDQoNCj4gDQo+IEVuYWJsaW5nIGdlbmVyYWwgc3VwcG9ydCBmb3IgUENJZSBpbiB0aGUg
ZGVmY29uZmlnIHNob3VsZCBiZSBmaW5lLA0KPiB0aG91Z2guDQoNCk9rLCBJJ2xsIHNlbmQgYSB2
MiB3aXRoIHRoZSBYaWxpbnggUENJZSBzdGlsbCBlbmFibGVkLg0KDQpBbGlzdGFpcg0KDQo+IA0K
PiANCj4gLSBQYXVsDQo+IA0K
