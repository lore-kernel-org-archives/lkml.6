Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC840C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDC820863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nOkaxgYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfBHRCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:02:34 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:63545 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfBHRCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:02:33 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5db6250000>; Sat, 09 Feb 2019 01:02:29 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 09:02:29 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Feb 2019 09:02:29 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:02:28 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 17:02:28 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2646.namprd12.prod.outlook.com (20.176.255.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Fri, 8 Feb 2019 17:02:25 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 17:02:25 +0000
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
Subject: RE: [PATCH V16 4/6] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V16 4/6] i2c: tegra: Add DMA support
Thread-Index: AQHUv829t7ouq5xahU+WuWRXTJjcy6XWHr8AgAAA/AA=
Date:   Fri, 8 Feb 2019 17:02:25 +0000
Message-ID: <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-4-git-send-email-skomatineni@nvidia.com>
 <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
In-Reply-To: <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2646;6:GpTzCAfdZOrJNB4yMBu+8YvP4F4o4GsLCNbERqHDesw8Vsn9n9mmtOg/1xPk0sTK5Ro87aociRsapyh224Y742MjPMIoBMq0jNvdAFQyhfvjsTUKSKD6YngK/uzGKIpPSJ6GlzH+BbYct4ejEJCcdjubjzas7fuROB4KPoyVyahx1Jg19nTy11mZg3yNGDpU4NFaTaFRrd6NSFH+HF9tfrtw26A+tKMrR5AZpUXHajVZK3KllogYDeNb7dQ+IamNXLhhUlDe09iyk4A3gNO4pVwaxS0hFkLbIqiVLe5z08ma06y4JXrtfEQCjIVr15Nhk43zzxig3LO5Do0WL9Knbh1jekoLUf3T6urFuqERgjDcpqOSZbh2AbIB6hRMotKdAWG+paWAb0KghOo6dVU/+/W+MT2juEOeB32wftvVXcyUC2tBEM4vcxFA+sHHFO8LvQQujRbCConZrmQZK+/UUQ==;5:Prg9AS/2ZVBgsDNVOGD3zkmmMPJNtFPwAmf5OfTpgv8UdrTJEtB3KS3Aw/6Z26tXl392i8jM6Cv9h21wqg20dGHHKkk8tkXFBfm+yC6b7KE+6M2oMC6/JkDlSHAYaUX6b49R/cw468XDaMd9zcRhnm5KxtY2/CHOsAh3VO9dYLtgwowTymwPaWk7fP7BSOF4YqJ5CW47UlBRpoEsy0n9qA==;7:+MinfDv1yloL7/R+GqvIxGAWQpLXYbteDWgqdExdlVgg8I0pWfwcF0jDaemFAwFVCQYuO/ZIjKzScdQ8c/8O/2zqYpmmKd+24pf2i0/t3apysktyJqJeOhOLSHWsrtiwH0FmM3nJxukfiIixMWemSg==
x-ms-office365-filtering-correlation-id: 17b1db5e-6ce8-44c1-2616-08d68de732fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2646;
x-ms-traffictypediagnostic: BYAPR12MB2646:
x-microsoft-antispam-prvs: <BYAPR12MB26464F880EDB9D000100803DC2690@BYAPR12MB2646.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(74316002)(14444005)(2501003)(305945005)(33656002)(7736002)(97736004)(7696005)(99286004)(9686003)(76176011)(229853002)(478600001)(55016002)(54906003)(110136005)(316002)(14454004)(6436002)(71190400001)(71200400001)(11346002)(105586002)(476003)(106356001)(66066001)(486006)(256004)(81156014)(2906002)(25786009)(68736007)(8936002)(6506007)(6246003)(446003)(6636002)(102836004)(6346003)(86362001)(26005)(4744005)(4326008)(3846002)(6116002)(8676002)(53936002)(81166006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2646;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vtAOB/j+7LxobB++px4USPHAGE/vqjG0+8C1uFmvJWLRqfNpIBDyYHKWW4YacmNvhHERoxp5GbbWGp6SO5sQftL98tXg0vV8tTOEuWYkoy+mbs41FekWBl5jMxn9UV7nuLzC4017qHw+7I3L/V+8n7oLNO5m1Lfspe1/zSNrPF8hXtbuDL8X2z93aWApbLeTCw584vRWQX+jD0K8Xutfv8IIbQqjE7E6N11bRmrWFSt9UpaF08J/WuWO/qwhMsbG7c25Z/K8RsUzzPIyxgcAGO9iNfsex3kgxnGEwx9XE+j+eThlCqiHpPZSIci0dV4RBcm4fIq7rA7cULee/MnT11QceDkVOp4SBUfHWjxMPDSzQf4ywtzN1CN5GbZ5w6jQ/p6VhHQ5SaEWGMWl0esPDAx2ZG2165n3MNmVsWd+/7I=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b1db5e-6ce8-44c1-2616-08d68de732fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 17:02:25.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2646
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549645349; bh=CDuFwBRvG9ymX7JN1BfVS5Tn46y22HQYzkosmeY+u7E=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:x-originating-ip:x-ms-publictraffictype:
         x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         authentication-results:x-ms-exchange-senderadcheck:
         x-microsoft-antispam-message-info:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=nOkaxgYQW0LpCJoUQkIpnwqWqltlMYLjZzIdOK5pFPiwj6/6dlI6nUyf/QBGMDKLV
         hLgE68n7ZEziQWlpL57kjSxtUjPERWW9v1BfR4gaIa+6ZNpTl1YrMw8fcB9WfMWWaq
         +5SmfgwWaJPdE+9udCjXKJn5i4G4UAZuq189HtlVfDaooKrT5BWN7yD4vi35Ki5T8K
         J9OCtGC1bvT4yNJKJ5AOk98tBGrx4nQjceWupkyCbW5PCE0LBUzdThm5oLCL5A5wsf
         6DYG8doGNophHLFF86lDJDRIBGO7FZ3xSTrCGzUWogyzj0zq/Sgqyy9UKiyy6QxleO
         7zku323hVx4tQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEknbSBzdGlsbCBhbHNvIHN1Z2dlc3RpbmcgdG8gc3F1YXNoICJmaXggbWF4aW11bSB0cmFu
c2ZlciBzaXplIiBpbnRvIHRoaXMgcGF0Y2ggYmVjYXVzZSBpdCBpcyByZWFsbHkgcGFydCBvZiBE
TUEtc3VwcG9ydCBlbmFibGluZy4NCg0KTWF4IHRyYW5zZmVyIGxlbmd0aCBsaW1pdHMgYXBwbHkg
dG8gUElPIGFsc28gYnV0IGZvciBETUEgaXRzIG1vcmUgbmVlZGVkIHRvIHByZXZlbnQgY3Jhc2gu
DQpTbyBoYWQgdGhpcyBhcyBwYXRjaCBiZWZvcmUgRE1BIGFzIGl0cyBhcHBsaWNhYmxlIGZvciBi
b3RoIERNQSAmIFBJTy4NCldlIGV4Y2hhbmdlZCBvbiB0aGlzIHllc3RlcmRheSwgc28gdGhvdWdo
dCB0aGUgcmVhc29uIHlvdSB3YW50IHRvIHNxdWFzaCBzZXBhcmF0ZSBwYXRjaCBhbmQgaW5jbHVk
ZSBpbiB0aGlzIGlzIGR1ZSB0byBtYXggbXNnIGxlbiBsaW1pdCBhbmQgd2hlbiBtb3ZlZCBpbnRv
IGh3IGZlYXR1cmUNCg==
