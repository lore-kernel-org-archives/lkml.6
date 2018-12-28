Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FCBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946C120861
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bAiowg2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbeL1UQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:16:22 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5201 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbeL1UQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 15:16:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c26848a0000>; Fri, 28 Dec 2018 12:16:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Dec 2018 12:16:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Dec 2018 12:16:19 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Dec
 2018 20:16:19 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Dec
 2018 20:16:18 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 28 Dec 2018 20:16:18 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2676.namprd12.prod.outlook.com (20.176.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 20:16:17 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%2]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 20:16:15 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V6 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Thread-Topic: [PATCH V6 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Thread-Index: AQHUni9Klulm+k8Dr0Wv3salJ23MqKWT2n8AgAC5RzA=
Date:   Fri, 28 Dec 2018 20:16:15 +0000
Message-ID: <BN7PR12MB2836645A118593A969ABA5AEC2B70@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1545947882-18875-1-git-send-email-skomatineni@nvidia.com>
 <1545947882-18875-3-git-send-email-skomatineni@nvidia.com>
 <317b5abe-894a-097a-cbfa-0cab5e253a0d@intel.com>
In-Reply-To: <317b5abe-894a-097a-cbfa-0cab5e253a0d@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2676;6:qVemyJUHnAA4TZVknf+XBsMQ3p6V7bbI4j74cjYpguBn8aT1O02QztYiRRN2MeiIp1YG471ZLH01oIpXeMndD1eQnr5zu4Q2b4IWrXmz1dV0DAvcVI6Gb1v/pMCiEccW6zqrxGQbpt/A99sD2J/FTmFW3YL5GKF13m+lHw/0mCKT0zzJHbAWfcvOjuM8jOh3cY+8th/3N0FHytsyM+4fS543CkQjjWZYkhWKOwV/saCcI7h8u8qNg7fB4apdMJc0x/uR3tqCw/tgTQaTsKfJ08xVQd/zwNeXRhssBZ9WtIAKS8q/ovRLsf0DqvFaQAiI+zMXNY/q6YIrX1k0XkOQA7vs8ShFe7F0rW4wigKb6P54aFmIzjII2IkdUUCmAbo+XZ4AHeSVCHYNeYNmzaUAtpNlwN/dWhogk3MO4i3DeCNHf8kGcXzG3q8j4yXvltYE+M6D4u1f4d7VS5khC2JQUg==;5:tHpQD+itr3CY9Pe7XmVs/DSf7VCwrFuxwT1WxEpsPE/O1DvZwxZPYEaJF7vUEaLNK+aTryJYbKOEaVmw0PY2ezqvsJa6mntj772aAi+TKVSJzQBA7vO7tYOIrBlDNYyZNl8zfyXIjQ2lV2bgZhCW+H+2OWio97YKMYQGN8XLhoI=;7:8PnTlYpVVcvrXQtlVnC5cAv+LXzzcwhNPxvvcxOb/UQNQOMS+AtcvapJr0tHSGBYqKE1EDsUFBCgqfC76GGDrQRydrPFgy+yrtSXVeyXI002sL2+UNKOgLY/lo/Aq9odI69Vti+tGIPb+CjfgMGHBg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(6636002)(305945005)(8936002)(229853002)(86362001)(106356001)(81156014)(81166006)(3846002)(6116002)(105586002)(8676002)(7736002)(11346002)(446003)(476003)(97736004)(53936002)(5660300001)(9686003)(316002)(110136005)(99286004)(54906003)(102836004)(186003)(26005)(6506007)(7696005)(76176011)(74316002)(71200400001)(71190400001)(68736007)(2906002)(39060400002)(6246003)(25786009)(66066001)(4326008)(14444005)(486006)(256004)(2501003)(55016002)(14454004)(33656002)(6436002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2676;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 88bfe78b-deb0-4b9b-5761-08d66d015203
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2676;
x-ms-traffictypediagnostic: BN7PR12MB2676:
x-microsoft-antispam-prvs: <BN7PR12MB2676156EFE7A02DCB89877A9C2B70@BN7PR12MB2676.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2676;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2676;
x-forefront-prvs: 09007040D4
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GSx6XVw9AKA/YTkFyWoiogeHtstHzoW5hN1Vx7XRZTwtHU7RGgAXAdnc0t4W7HYuLUq2cdlCBxR64zBK9UwMlrStrJ9SPXh1zDSCHhewI8E4b6ke8euT0DbakvcIUWOEERvI0yfcPYFykB/a7Yaar5oHqrSmaD3KEDrNNVG2Ix/1htMe2Wp0zZB/1QKR8SOoGayWOtWM+l1mxlm1ICjHDDqLxA4s2TkaU+L5+V2bMzWiJmguFPp+hWztI+L5wU8Id10RoBl9+kOXYbGIF2+ANZmtfx6mdTIUsscXxRO1SyTPcWycJuugZzR//Tv6hbUa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bfe78b-deb0-4b9b-5761-08d66d015203
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 20:16:15.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2676
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546028170; bh=h2n4PBV0xxK1P8kjm2yfio71kWMYrScrEHokzhz6+VE=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-exchange-antispam-report-cfa-test:x-forefront-prvs:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=bAiowg2UBSWSrjZ6DWEeNhyvSqUqnTDsecU5QjquhaOj+F6fOzh1Pp1U5ILH4VQmI
         nO0kNVUzA7y8p4yGbSIeu5bEHxXW2q+0YKiw51WpFUj5/o78TsXlC/WwWKuTYps03n
         5Ej+pAeIjOGEV0ZLxzk6pFayijKPqcAFNS7+BEuFlTj6VWuu+YocqWWLt9pQRxAGMO
         57DWov6EunmpIBxbV9LpPh7vm8XFAPd4OYkuxB5TmqmJsMktoidUL1HGyeec9LD1XS
         de0rYIu7xp2dBhD5q7/SxYky3tHodyCFVPeGMtYPQ3ywvHApvPflpHGLOAPr0/PWhB
         z2/ArTZOBYUVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuDQoNCj4+IFRoaXMgcGF0Y2ggYWRkcyBIVyBDb21tYW5kIFF1ZXVlIGZvciBzdXBw
b3J0ZWQgVGVncmEgU0RNTUMgDQo+PiBjb250cm9sbGVycy4NCj4+IA0KPj4gVGVncmEgU0RIQ0kg
d2l0aCBRdWlyayBTREhDSV9RVUlSSzJfQlJPS0VOXzY0X0JJVF9ETUEgZGlzYWJsZXMgdGhlIHVz
ZSANCj4+IG9mIDY0X0JJVCBETUEgdG8gZGlzYWJsZSA2NC1iaXQgYWRkcmVzc2luZyBtb2RlIGFj
Y2VzcyB0byB0aGUgc3lzdGVtIA0KPj4gbWVtb3J5IGFuZCBzZGhjaV9jcWVfZW5hYmxlIHVzaW5n
IGZsYWcgU0RIQ0lfVVNFXzY0X0JJVF9ETUEgZm9yIA0KPj4gQURNQTMyL0FETUEyIFZzIEFETUE2
NC9BRE1BMyBETUEgc2VsZWN0aW9uLg0KPj4gDQo+PiBDUUUgbmVlZCB0byB1c2UgQURNQTMgYXMg
aXQgbmVlZCB0byBmZXRjaCB0YXNrIGRlc2NyaXB0b3IgYWxvbmcgd2l0aCANCj4+IHRyYW5zZmVy
IGRlc2NyaXB0b3IsIHNvIHRoaXMgcGF0Y2ggZm9yY2VzIERNQSBTZWxlY3QgdG8gYmUNCj4+IEFE
TUEzIGZvciBDUUUuDQoNCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3UgdXNlIHRoZSB0ZXJt
ICJBRE1BMyIgc2luY2UgaXQgaXMgbm90IENRRSB0ZXJtaW5vbG9neSwgY2FuIGJlIDMyLWJpdCBv
ciA2NC1iaXQsIGFuZCwgZnJvbSB0aGUgZHJpdmVyIHBvaW50IG9mIHZpZXcsIGhhcyBxdWl0ZSBk
aWZmZXJlbnQgcmVxdWlyZW1lbnRzIGZyb20gQ1FFLg0KPiANCj4gSXQgc2VlbXMgeW91IGFyZSBz
YXlpbmcgdGhhdCBUZWdyYSBzdXBwb3J0cyBvbmx5IDMyLWJpdCBETUEgYnV0IG11c3Qgc2VsZWN0
IDY0LWJpdCBETUEgZm9yIENRRT8gIENhbiB5b3UgY2xhcmlmeSB0aGlzIGEgYml0Pw0KPiANCg0K
QXMgcGVyIEhvc3QgU3BlYywgV2hlbiBIb3N0IFZlcnNpb24gNCBpcyBlbmFibGVkLCBETUFfU0VM
RUNUIG9wdGlvbnMgc3VwcG9ydGVkIGFyZQ0KMDA6IFNETUENCjAxOiBOb3QgVXNlZA0KMTA6IEFE
TUEyDQoxMTogQURNQTIgb3IgQURNQTMNCg0KV2hlbiBIb3N0IFZlcnNpb24gNCBpcyBkaXNhYmxl
ZCwgRE1BX1NFTEVDVCBvcHRpb25zIHN1cHBvcnRlZCBhcmUNCjAwOiBTRE1BDQowMTogTm90IFVz
ZWQNCjEwOiAzMi1CaXQgYWRkcmVzc2luZyBBRE1BMg0KMTE6IDY0LUJpdCBhZGRyZXNzaW5nIEFE
TUEyDQoNClZlcnNpb24gNCBpcyBlbmFibGVkIGZvciBDUUUgYW5kIG5lZWQgdG8gdXNlIEFETUEz
IERNQSBTZWxlY3QuIEFETUEzIGVuYWJsZXMgaG9zdCB0byBwcm9ncmFtIG11bHRpcGxlIEFETUEy
IG9wZXJhdGlvbnMuDQpDUUUgbmVlZCB0byBmZXRjaCBib3RoIHRhc2sgZGVzY3JpcHRvciBhbmQg
dHJhbnNmZXIgZGVzY3JpcHRvciBhbmQgc2hvdWxkIHVzZSBBRE1BMy4NCkFETUEzIGlzIHN1cHBv
cnRlZCB3aXRoIGJvdGggMzItYml0IGFuZCA2NC1iaXQgYWRkcmVzc2luZyBtb2Rlcy4gDQpTREhD
SSBkcml2ZXIgaGFzIERNQSBzZWxlY3Qgb3B0aW9ucyBkZWZpbmVkIGFzIHBlciBIb3N0IHZlcnNp
b25zIGJlbG93IDQgYW5kIHVzaW5nIEFETUEzMiwgQURNQTY0IHdoaWNoIGFyZSBlcXVpdmFsZW50
IHRvIEFETUEyIGFuZCBBRE1BMyBmb3IgSG9zdCBWNC4NCklmIHVzaW5nIHNhbWUgQURNQTY0IGlz
IGFkZGluZyBjb25mdXNpb24sIHByb2JhYmx5IEkgY2FuIGFkZCBkZWZpbmUgQURNQTNfQ1FFIHdp
dGggc2FtZSBiJzExIHRvIGF2b2lkIGNvbmZ1c2lvbi4gUGxlYXNlIGxldCBtZSBrbm93Lg0KDQo+
PiANCj4+IFRlZ3JhIFNETU1DIEhvc3QgZGVzaWduIHByZXZlbnRzIHdyaXRlIGFjY2VzcyB0byBC
TE9DS19DT1VOVCByZWdpc3RlcnMgDQo+PiB3aGVuIENRRSBpcyBlbmFibGVkIHRvIHByZXZlbnQg
U1cgZnJvbSB1cGRhdGluZyBibG9jayBzaXplIGR1cmluZyANCj4+IENvbW1hbmQgUXVldWUgbW9k
ZS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogU293amFueWEgS29tYXRpbmVuaSA8c2tvbWF0aW5l
bmlAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyAgICAg
ICB8ICAgMSArDQo+PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jIHwgMTA3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS5jICAgICAgIHwgICA2ICsrLQ0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpTb3dqYW55YQ0K
