Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE9C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A939A2177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YpMaBhrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfBCRV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:21:59 -0500
Received: from mail-eopbgr1300103.outbound.protection.outlook.com ([40.107.130.103]:29278
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbfBCRV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKuKel9yIZHsfLzARlaaTiE4eeBvuMOQI9iw5UWwyiU=;
 b=YpMaBhrwIrCoEOwVskzObZUp6Z9w+kyRZHTJgEbtRlWkI0xZU0Zh7tKcKl3YL+JiqcaXcwueINVFsgSCcUDX4DS8vABkAN4mREoDADnT9+oJlxXhKe1hi7IYbcOY6p7rQlW/Iz6heEagSHVOtT5UTZ/zBZhrCU72sajO9ck6Xoo=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.5; Sun, 3 Feb 2019 17:21:32 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.000; Sun, 3 Feb 2019
 17:21:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
Thread-Topic: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM
 family
Thread-Index: AQHUu+TohgnD5hWBBUGGy2lRJKF6bA==
Date:   Sun, 3 Feb 2019 17:21:32 +0000
Message-ID: <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-03T17:21:29.5103866Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fb27237-01a2-4b9a-94d4-2e2d28b259d0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [73.53.115.85]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0172;6:+mKiMk+KGvJ4t0LquFlfbGx9dTVHh0sNAkGBiGT3pQSrQUv1WkZjf4KPnupoe7P5/mFzKbQjgQuli/TBGoe7A/P6LAoIhMenJ2o2WoTLJ81cgNwqLORPpRQsicA6ShP0apvRBD3zt0q8hSnT8La1bIKdgH8DutX/kVpAKu7OvM8uE8ylsrisKchfAD1d2b2U9Sht/8p0yLDw/IL0n9RQbgfE/w6r9hbNqyGbgaqS/cjpukWzgKTNTLvScLZqhO4kwtzKQh6RYbCi4vrqlQzX4hiRz2xtw9gWBXySu9H1b/UBTp7DJ1wnywI5dKRxaa+3rD6EKkO4R9RmdzxkMHlv8mWiric5JZg0W6dEiMXYwugQ/UDOKzP5HRg/gN7dLXHgpjmJqd5hoLeLVn4MRnMoGKarUa2Wq5x3KQlJ91OCJe/b6EJNn6zyaYZLDaEEizbh/lpR+EmrdifMbtCaMCjvow==;5:yrhV8BTgpJkyQyziHwBW2K5LLyRIJRnKmt2oVP4utzWu6PlJt/T2j0RnlxnPCs+8MTcEz5h3nqg2KyyvVNH4uOpH8ArVCQDHC/qgwsF7fv2jGL4upKpYstYCyoxyyJje5T6niF3zUFGwqycviqo9J7+7KKux2+UF5HO61UAyGX7J6fTgY2WLpfngTWROTWONWgJgByF5IconPQ9dVJks7A==;7:NQJBxqj79fhIE//q1M0YK5h6CKE5R2d1aRngZmJgNKTkW8/hPdfL+hUU/4uxYuBb5bUcWGHjYsByMwiVxoFtTXcqxmBRUWgtoJgqxjnY9pia4SYxMbFmt0i0lmbf4Kk0nqZcRlHhE4+d5JNmzAsWcw==
x-ms-office365-filtering-correlation-id: b2abc130-fdb9-408f-807a-08d689fc0ac6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0172;
x-ms-traffictypediagnostic: PU1P153MB0172:
x-microsoft-antispam-prvs: <PU1P153MB0172905EA7D48E397E27C916BF6C0@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(189003)(106356001)(25786009)(68736007)(86362001)(26005)(446003)(6116002)(4326008)(186003)(74316002)(305945005)(7736002)(8936002)(3846002)(2906002)(11346002)(256004)(14444005)(81166006)(8676002)(81156014)(486006)(6436002)(229853002)(105586002)(476003)(66066001)(33656002)(14454004)(7696005)(9686003)(86612001)(71190400001)(71200400001)(99286004)(76176011)(316002)(22452003)(97736004)(110136005)(54906003)(6246003)(6506007)(55016002)(10290500003)(107886003)(102836004)(478600001)(8990500004)(10090500001)(53936002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /s+JfgnQkYTzJLPId7OY/NFqWR1miVLtCKMORdDufTHTS0udK3VMm461JTF7o9poaXyRb7dgr0AL0++mBL//SSu6YRNEaMG0BmfgTjnpkaHoXmIKo9tgUVOXfevfH3EczmJpWDIJfFJDZQYZIpssSBuAAF/4dr39m8+Y0dJmzUA7UzEUnrBNpzQF4SdZYxv0Vtc8y/8ZPAPnTx9gSTbougcNL72Bhn5EhqBMCZNcURYCOkT3fnug+WYii7Yk8MeGrNukuaj6sbFMH9o/VcSLPJPUnJku5soTt5JEQgQTII3s+JLHamipqq0eo2BMKuKDp+WJUAQLAOwvILUuhX+2F8FVvaHnkz4LDNjSGfV7amXR+/UJklM5SZfH2zUMvRdb8huV0XnfsekAHyrrrDLUHKXTaiTZdmZo3aUdz6MJhsQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2abc130-fdb9-408f-807a-08d689fc0ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 17:21:32.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
U2F0dXJkYXksIEZlYnJ1YXJ5IDIsIDIwMTkgNToxMyBQTQ0KPiAuLi4NCj4gQXMgRGV4dWFuIHJl
cG9ydHMgdGhlIE5WRElNTV9GQU1JTFlfSFlQRVJWIHBsYXRmb3JtIGlzIGluY29tcGF0aWJsZSB3
aXRoDQo+IHRoZSBleGlzdGluZyBMaW51eCBuYW1lc3BhY2UgaW1wbGVtZW50YXRpb24gYmVjYXVz
ZSBpdCB1c2VzDQo+IE5TTEFCRUxfRkxBR19MT0NBTCBmb3IgeDEtd2lkdGggUE1FTSBpbnRlcmxl
YXZlIHNldHMuIFF1aXJrIGl0IGFzIGFuDQo+IHBsYXRmb3JtIC8gRElNTSB0aGF0IGRvZXMgbm90
IHByb3ZpZGUgQkxLLWFwZXJ0dXJlIGFjY2Vzcy4gQWxsb3cgdGhlDQo+IGxpYm52ZGltbSBjb3Jl
IHRvIGFzc3VtZSBubyBwb3RlbnRpYWwgZm9yIGFsaWFzaW5nLiBJbiBjYXNlIG90aGVyDQo+IGlt
cGxlbWVudGF0aW9ucyBtYWtlIHRoZSBzYW1lIG1pc3Rha2UsIHByb3ZpZGUgYSAibm9ibGsiIG1v
ZHVsZQ0KPiBwYXJhbWV0ZXIgdG8gZm9yY2UtZW5hYmxlIHRoZSBxdWlyay4NCg0KSGkgRGFuLA0K
VGhhbmtzIHZlcnkgbXVjaCBmb3IgdGhlIHBhdGNoISBXaXRoIGl0LCAibmRjdGwgbGlzdCIgY2Fu
IHNob3cgdGhlIGJlbG93Og0KDQpyb290QGRlY3VpLWdlbjItdTE5MDQ6fi9uZGN0bCMgbmRjdGwg
bGlzdA0KWw0KICB7DQogICAgImRldiI6Im5hbWVzcGFjZTEuMCIsDQogICAgIm1vZGUiOiJyYXci
LA0KICAgICJzaXplIjoxMzc0Mzg5NTM0NzIsDQogICAgInV1aWQiOiJjMjU4YWFhYi1mNzJiLWU1
NDYtYmZhNS1iZTVlMDc3NjFkYmMiLA0KICAgICJibG9ja2RldiI6InBtZW0xIiwNCiAgICAibmFt
ZSI6Ik1pY3Jvc29mdCBIeXBlci1WIE5WRElNTSAxIExhYmVsIg0KICB9LA0KICB7DQogICAgImRl
diI6Im5hbWVzcGFjZTAuMCIsDQogICAgIm1vZGUiOiJyYXciLA0KICAgICJzaXplIjozNDM1OTcz
ODM2OCwNCiAgICAidXVpZCI6IjlmMDQ5N2E3LTQ0NTMtN2M0MC1hZDM1LTIxYTc5MWUwMDM0NSIs
DQogICAgImJsb2NrZGV2IjoicG1lbTAiLA0KICAgICJuYW1lIjoiTWljcm9zb2Z0IEh5cGVyLVYg
TlZESU1NIDAgTGFiZWwiDQogIH0NCl0NCg0KQW5kIC9kZXYvcG1lbTAgY2FuIGFwcGVhciwgYnV0
IC9kZXYvcG1lbTBwMSBjYW4gbm90IGFwcGVhciwgYW5kIHRoZSAibW9kZSIgb2YNCiJuYW1lc3Bh
Y2UwLjAiIGlzIG5vdCBjb3JyZWN0LiAgV2l0aCB0aGUgVWJ1bnR1IDE5LjA0IDQuMTgga2VuZWws
IEkgZ2V0IHRoZSBiZWxvdzoNCg0Kcm9vdEBkZWN1aS1nZW4yLXUxOTA0On4vbmRjdGwjIG5kY3Rs
IGxpc3QNClsNCiAgew0KICAgICJkZXYiOiJuYW1lc3BhY2UxLjAiLA0KICAgICJtb2RlIjoicmF3
IiwNCiAgICAic2l6ZSI6MTM3NDM4OTUzNDcyLA0KICAgICJibG9ja2RldiI6InBtZW0xIg0KICB9
LA0KICB7DQogICAgImRldiI6Im5hbWVzcGFjZTAuMCIsDQogICAgIm1vZGUiOiJmc2RheCIsDQog
ICAgIm1hcCI6ImRldiIsDQogICAgInNpemUiOjMzODIwNzcwMzA0LA0KICAgICJ1dWlkIjoiZWYw
MjhjNGUtMmIxZi00YmY4LWI5MmEtMTEwOWQ3YTFjOTE0IiwNCiAgICAiYmxvY2tkZXYiOiJwbWVt
MCINCiAgfQ0KXQ0KYW5kIC9kZXYvcG1lbTBwMSBjYW4gYXBwZWFyLg0KDQpJdCBsb29rcyB0aGUg
bmFtZXNwYWNlIGNyZWF0ZWQgYnkgVWJ1bnR1IDE5LjA0ICg0LjE4KSBpcyBpbmNvbXBhdGlibGUg
d2l0aA0KdGhlIGxpYm52ZGltbS1wZW5kaW5nIGJyYW5jaCArIHRoaXMgcGF0Y2guDQoNCkl0IGxv
b2tzIHdlIG5lZWQgdG8gY29tcGxldGVseSBkaXNhYmxlIHRoZSBsYWJlbCB1c2FnZSBmb3IgTlZE
SU1NX0ZBTUlMWV9IWVBFUlYgDQpkdWUgdG8gY29tcGFiaWxpdHk/DQoNClRoYW5rcywNCi0tIERl
eHVhbg0K
