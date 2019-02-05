Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E85EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4AF2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b+416Cjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBEBhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:37:15 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:65154 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfBEBhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:37:14 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c58e8c50000>; Tue, 05 Feb 2019 09:37:09 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 04 Feb 2019 17:37:09 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 04 Feb 2019 17:37:09 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 01:37:08 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 01:37:07 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 5 Feb 2019 01:37:06 +0000
Received: from DM6PR12MB3403.namprd12.prod.outlook.com (20.178.198.138) by
 DM6PR12MB2857.namprd12.prod.outlook.com (20.179.71.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 01:37:04 +0000
Received: from DM6PR12MB3403.namprd12.prod.outlook.com
 ([fe80::a0a6:e7b1:61f7:dc6e]) by DM6PR12MB3403.namprd12.prod.outlook.com
 ([fe80::a0a6:e7b1:61f7:dc6e%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 01:37:04 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUulC5gnNOlUi0AEWt0UGRYeTykqXOKkQAgAFzZwCAANKY0A==
Date:   Tue, 5 Feb 2019 01:37:04 +0000
Message-ID: <DM6PR12MB34033CFF789C5115721B5BAEC26E0@DM6PR12MB3403.namprd12.prod.outlook.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <467a3ac8-5667-66bf-50eb-7d21a103d901@gmail.com>
 <fa8a64fd-87e5-a70c-5ee7-c6c100b712c1@gmail.com>
In-Reply-To: <fa8a64fd-87e5-a70c-5ee7-c6c100b712c1@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2857;6:a3flAYFbHRAL4w225v1r2jBwTz0TnOGvXFl965q5L+ImMbV+kEdBFtxJk/hyugz5FQhPz5lPpDRZNdNvIg35xZiFD7id9bbDQoUxstzykjHY9pkfeHWIhIc/ZpNiEoI87K19ajkHx0avhllEfOcR/tCydxyq4WNdsAZg2ctieCWkYUf1S9ock3YefdPNzE/A6/LyYkm7ERfoGRjgSRV2lqQdGDxGzma5onEjRg+Guw440dBTQZfxHAtSrh0hO47/8/D+JMcUGy9sW1QgQ5iAHTEZOejk/kSwoLOffGLDA+Y9IJHrIvR0+G4GClvWSkmrV043MX77MdV6iSijwfN+nzKCpWLAl0omMD9ZdQIlgpJucEPie7fP5fe7K5IGDgS4SAiH9/b4kL62pFRm/mgF+ZZOh3diwPPPcO1OLD3yiLA1lwkPKEOof3Fu1Gy6hSE/wFbDf7vILoOA9P5wzbqt0g==;5:FDxVTU4KYpJ0ssfRFbu4qE6Yfth2XHLHFQ4MVKrXWLeX5GuKlHKrzKxF/BVfs4dMt7YFJTnLPb0eQs+RecYnZezU1PlzI9SEZsnjkxO881QvMBAH526DWQ+nQWeG6lTSW3GePOWnj7KbYahirLrJ25AnrUHdvKIEjyoNu9w/3uO2s9al35qQ6GNar4rSvDcSYHBFrYFEqY8HPwWNLzaN0A==;7:TFXfg7kQAtxxEqQVAFriyuWLrcwGWFNWtnxkB7yn+sLQVL/hRoxGp7Gk3Crl9SiO90Seeq+dPdSJhoix4Zr6DvWy9ZxZPwsYUplAI1NC35RfRaYkqcalyz7t8oAXAJyXCB3TVHWO8mYK+4FzfG6aqQ==
x-ms-office365-filtering-correlation-id: 104360b5-0c05-48e7-946c-08d68b0a6f1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2857;
x-ms-traffictypediagnostic: DM6PR12MB2857:
x-microsoft-antispam-prvs: <DM6PR12MB2857F29C57A4FF0FACE12856C26E0@DM6PR12MB2857.namprd12.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(110136005)(6116002)(316002)(186003)(486006)(76176011)(6506007)(102836004)(476003)(26005)(256004)(105586002)(446003)(106356001)(6636002)(54906003)(66066001)(86362001)(11346002)(7696005)(99286004)(305945005)(53936002)(7736002)(55016002)(478600001)(9686003)(14454004)(97736004)(229853002)(74316002)(33656002)(6436002)(81166006)(81156014)(8936002)(2501003)(71190400001)(71200400001)(8676002)(2906002)(6246003)(4326008)(25786009)(93886005)(3846002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2857;H:DM6PR12MB3403.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: axwle2z4HarBXHCsvTQH+6kaZukk2HEGT6wQJQUgH9jjgeWlK7zv0HG0NRgzMpBFfJhYC6MPkZF05Hc+M57Ye2d5ilb0xDmpkjI4WKf2fVSor3mi5sYwEa5aOcDtEGIxF/fNOkpzxs4raP60g2DHHjf8haJKIiabcxDFbCrjKr7EBlAsXa6Kx50b9w4/XuQ+DAo4dcy97nVoh0P6zO3HFct+nwlCL1ylbYVP+QIkY5/lyXxO0JT1EHNZjcgSTpqY6PJnDxOk8Xxcu+/Od/jd9uYJVD3JgiNS/+/OX36X2DIwi3xuYI3v9WtHZRhW1qEQsYTlypMHVZxtLErqjFzf8dd1QZJ4aDrUEvEdw24g8Q+bKfuzYixnqcV+PZw+UR4xQjcXmYGONViyLCBh4j4ye1wnI/eTPqr4ps3u8+iQTcw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 104360b5-0c05-48e7-946c-08d68b0a6f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 01:37:04.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549330630; bh=Qav1UG9ZtcRkZIO9/1ve8YAcSb6ZttFSM1oEWEJ0FeU=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=b+416CjqMIuE12d6PCAwh3ubgRldBUiFfdTDXZAbgWR9CvLtrzmURWQpCQESUIL1F
         /7/g8PqqFhf+hMxa0nBObFsdm+240/N/VUhiPCLyF05Ahj0N2iaLY1hhkE/wEX0ZdT
         F8DtaH2RkcU57zSd6zs85ZSd8IydP7TpF5w1kE/JB3EvNgvEiBiaCCrExxdceSYq6b
         dIV4gFTY4cvdI8rubsBCaMPyJMSp3QECZ8nmPcUEi1Udv/AWzJySH2G5tg4809KmWT
         CsPjQaCvQGS3xCmIWGImYxfnp5jAXmCiv7vz7S8uSh1uvLw2sS0FBDeLfzsW6SsZLF
         kAN8jyCjr8V8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGtub3cgdGhhdCBBUEIgRE1BIGRyaXZlciBlbmFibGVzIGZsb3cgY29udHJvbCBiYXNlZCBv
biB0aGUgY2hhbm5lbHMgc3BlYywgYnV0IHN0aWxsIHdvbid0IGh1cnQgdG8gZXhwbGljaXRseSBz
aG93IHRoYXQgY2hhbm5lbHMgYXJlIGZsb3ctY29udHJvbGxlZC4gSWRlYWxseSBBUEIgRE1BIGRy
aXZlciBzaG91bGQgcmVzcGVjdCB0aGUgZGV2aWNlX2ZjIGZpZWxkLg0KPg0KPgkJZG1hX3Njb25m
aWcuZGV2aWNlX2ZjID0gdHJ1ZTsNCg0KDQpEbWl0cnksDQpUaGFua3MgZm9yIGFsbCBmZWVkYmFj
ay4gU2VudCB1cGRhdGVkIHBhdGNoIFYxMCB3aGljaCBoYXMgYWxsIGJlbG93IFY5IGZlZWRiYWNr
IGNoYW5nZXMuDQoNCi0gQWRkZWQgZXhwbGljaXQgZmxvdyBjb250cm9sIHNldHRpbmdzIHRvIGRt
YSBzbGF2ZSBjb25maWcgYW5kIGVycm9yIGNoZWNrIHNvIG5lZWQgdG8gbW92ZSByZWxlYXNpbmcg
b2YgZG1hIHJlc291cmNlcyB0byBzZXBhcmF0ZSBmdW5jdGlvbiBhcyBJIGFtIHVzaW5nIGl0IG11
bHRpcGxlIHBsYWNlcyAod2hlbiBkbWEgc2xhdmUgY29uZmlnIGZhaWxlZCwgb24gdGVncmEgZHJp
dmUgcmVtb3ZlLCB0ZWdyYV9pMmNfaW5pdF9kbWEpLg0KQXMgYSBwYXJ0IG9mIHRoaXMsIG1vdmVk
IGVycm9yIGhhbmRsaW5nIGFsc28gaW5zaWRlIGluaXRfZG1hIGFzIHlvdSBzdWdnZXN0ZWQgaW4g
ZWFybGllciBmZWVkYmFjay4NCi0gQWRkZWQgYXBiZG1hIGh3IHN1cHBvcnQgZmxhZyB0byBub3cg
YWxsb3cgVGVncmExODYgYW5kIGxhdGVyIHVzZSBBUEJETUEgZHJpdmVyLg0KLSBVcGRhdGVkIHRv
IHJlZ2lzdGVyIHRlZ3JhX2kyY19kcml2ZXIgZnJvbSBtb2R1bGUgbGV2ZWwgcmF0aGVyIHRoYW4g
c3Vic3lzIGxldmVsLg0KLSBGaXhlZCB0aW1lb3V0IGZvciBidXMgY2xlYXIgdG8gNTBtcyAoMTBt
cyBpcyBlbm91Z2ggYnV0IGNvbnNpZGVyaW5nIHNsYXZlcyByZXNwb25kaW5nIHNsb3cpLiBBbHNv
IGFkZGVkIGFkYXB0ZXIgdGltZW91dCB0byA2cyBjb25zaWRlcmluZyB3b3JzdCBjYXNlIHRyYW5z
ZmVyIHJhdGUuDQotIG90aGVyIG1pbm9yIGZpeGVzLg0KDQpQbGVhc2UgcmV2aWV3Lg0KLSBTb3dq
YW55YQ0KDQo=
