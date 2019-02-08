Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380F9C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF75720863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aqJh6GXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfBHRGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:06:35 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:13397 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHRGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:06:34 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5db7180001>; Sat, 09 Feb 2019 01:06:32 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 09:06:29 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 08 Feb 2019 09:06:29 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:06:28 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:06:27 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.53) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 17:06:27 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3510.namprd12.prod.outlook.com (20.179.94.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Fri, 8 Feb 2019 17:06:24 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 17:06:24 +0000
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
Thread-Index: AQHUv829t7ouq5xahU+WuWRXTJjcy6XWHr8AgAAA/ACAAAGHIA==
Date:   Fri, 8 Feb 2019 17:06:24 +0000
Message-ID: <BYAPR12MB33987BF143F5903AE5DA196AC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-4-git-send-email-skomatineni@nvidia.com>
 <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
 <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3510;6:KEtCSZqGi4dlYty2vUbaoUXLKhC0KEqSRdMd2X7e5zStTlkat+82HJsgZnIIn+rOaOhekagQxoa0BffWYQtg03bogoHCCay6Fuk3za9LwF2ltce+IpWBj/QOMjVwuHvv8AQ4asJjCpMAqO8H8M6Q8Q5jNoE8Ja/85bXBy3Ex4hX5B+hRTmU8nRUGMOnbWFz2goLOxsN1fKydP6xGdbTY/rHQmca2F7arSta1iOGRQs+YeXoDGlsFlRTICzexGfowugRSG6k8OLUtl0/+1oYMD05sbHoHfbAUB/CiCwHC2lcN/wy7PFRRIfTNxZ/x2OpgsBhXC+G4JilcDJKo2F7B5WbHb9Vzr+Anqp5V+qfrjaEOq7/aBTMnmeGSDj24HKDplidEfstkeqawMt7pGwcnodxYEx/QDXByuwv4uiauh07SihWJFSCWtjJ6kbcIJy96XL52a4M/0eysueWbsG+ujg==;5:7dTEUMrQeCftzV42sXjiBbTbIQnFTMZSadsQzFwktPiFI6gZ4+1XrQt49C03PZxOnYVDGFxrfWoZ1pD3DrRFapFJFSZL1UewIauI04w3THa0kuLDWWOmB+5YvS1y73iU0Ud8Y1wGKHzEiygxGCEm+VBPnKlLVKYOFZWs5fqF/0xsPUfg8RskkwYaQZFAFdrCNQ2rBpguU4V/NUAl+Olntg==;7:G1oCovQE9lkjMTMOiizNEu4jTCvF1u7nOvPIRmIUzhk0rsBfzuim3tTLoJVcMUWq8Tvq872cs8Kqq5R+pjEFMMJC0xR2cWL7YGHNiD4gB7yFe+vShEkfUeBxIS57WedUjxorASL3QuN2Wd6zA6mdEQ==
x-ms-office365-filtering-correlation-id: 263f3811-b3e8-4332-6649-08d68de7c17d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3510;
x-ms-traffictypediagnostic: BYAPR12MB3510:
x-microsoft-antispam-prvs: <BYAPR12MB35106823FCC022B9FC7D0C81C2690@BYAPR12MB3510.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(76176011)(93886005)(14444005)(256004)(476003)(6246003)(11346002)(7736002)(478600001)(446003)(55016002)(9686003)(33656002)(8936002)(106356001)(6506007)(97736004)(99286004)(105586002)(81156014)(2906002)(81166006)(102836004)(229853002)(6436002)(54906003)(110136005)(68736007)(7696005)(316002)(8676002)(26005)(6636002)(2501003)(186003)(14454004)(71190400001)(93156006)(53936002)(71200400001)(86362001)(74316002)(6116002)(3846002)(25786009)(66066001)(305945005)(2940100002)(486006)(4744005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3510;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ucU4ypveLCmhXb/fseUKWkGxfhSEneeIolDdbL4RVLbMEihGX+ZY5yLn7WulpgR+9bH7USeOagyo9GaCKi+igap5lyZC/4NOppljhE5KfGm8TbV8ESztl5tATuhtO6zT7FlkEEwvEKTJ2iLBZR0hwdrkCr6jy6/IiOafS+1rQGwK3Ouf83NpC/dA4ha8ej079NjaG/B49eOtTstSgj2RK+phRID2dt7Vih/CZIkD2buzIRFmbCZra1ZIgGEY0XzcLX5vKsBrBRRO8K0MJ1oCPedaWj1Gp0U1kbDMgVYURcsD4na68thv2bObfLKDXnvkx1Yeju0P6Kx/oV9ljfcJmS+ZvoPrIebYvAdjZLTyfXusgIalEU2P42Ru0XqGPLNe1VAp15oa6qNNrKEcXZLqn45NCB9Zh01YGuieS0Njprk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 263f3811-b3e8-4332-6649-08d68de7c17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 17:06:24.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3510
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549645593; bh=f8+EZlB8vkHyTeDVxdsnMX/20L4bzObPwWIAKQ2BKbY=;
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
        b=aqJh6GXP6tvyY3YLA/Ja504zPPvoFugF7HCGmNHQTTnhcj8WReEX6ohayVH0wo0GM
         C3b3JLdKdF3tiTIUGQw13JS2WqTn+EN31yZcJbJhyxMBzq/OgwrQpsT8fa9p0mTYIt
         T4KTaxrf6WusSpt9BxB3CwIzImcaHIlf6n7bfAAbDCWdYTuKVmAfOYXS2EAnN86Xk7
         WOElJ5csLMISLr8GG0jgFiNiCLiv4mSrg85dReWIzWFKRTGrtItPkOi4RQfXpXPFwV
         sB17/Z6Gih8TrJGnlddhabZo8Wxph81FTeoD96rirz9vW5qsMAAUPEn220csVxLRvT
         fPVUP0xiAD1ZA==
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
IGh3IGZlYXR1cmUuDQoNClNvcnJ5IHNob3VsZCBoYXZlIHZlcmlmaWVkIGJlZm9yZSBzZW5kaW5n
LiBQbGVhc2UgY29uZmlybSBpZiBJIGxlYXZlIG1heCB0cmFuc2ZlciBhcyBzZXBhcmF0ZSBwYXRj
aCBvciBhZGQgdG8gdGhpcyBETUEgc3VwcG9ydC4gV2lsbCB1cGRhdGUgYWxvbmcgd2l0aCBkbWEg
YnVmIHNpemUgZml4Lg0KDQpCdXQgbWF4IHRyYW5zZmVyIGxpbWl0IGFwcGxpZWQgdG8gUElPIGFs
c28gYW5kIHRoYXTigJlzIHdoeSBhZGRlZCBpdCBiZWZvcmUgRE1BIHBhdGNoIHRvIHNob3cgaXRz
IGRlcGVuZGVuY3kNCg==
