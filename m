Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D861BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFE12075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AoFCpgLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfBFOsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:48:32 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:19987 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfBFOsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:48:31 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5af3bb0000>; Wed, 06 Feb 2019 22:48:28 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 06:48:27 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 06 Feb 2019 06:48:27 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:48:26 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 14:48:26 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3637.namprd12.prod.outlook.com (20.178.54.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 14:48:23 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 14:48:23 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAUt4CAAAEfAIAAAXOAgAAAhsCAAAYqgIAAADAAgAACQDCAAAL7gIAAA0OAgAAA7+CAAAJMgIAAAK1AgAACNoCAAAOeYA==
Date:   Wed, 6 Feb 2019 14:48:23 +0000
Message-ID: <BYAPR12MB3398ACF7999DFA8F24AB09DEC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
 <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
 <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33989329D0E0C0049F1DEA6EC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190206140141.GO21676@ulmo>
 <9b4bfee0-f3f2-bae7-5010-97a86bb5e03f@gmail.com>
 <BYAPR12MB3398D7685B5A7462161F9578C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <649cdfb4-214e-bf01-348d-f950628ecf9b@gmail.com>
 <BYAPR12MB33988A49F8831BD8CAB575E5C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <2f6ac9c6-bdc8-2a48-8f95-d761d5d56d8d@gmail.com>
In-Reply-To: <2f6ac9c6-bdc8-2a48-8f95-d761d5d56d8d@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3637;6:VOHABmhbgvkAT9wvMgL0YRQobxjg+e0XgiaulGDQSa5T21PaRzu/r3l/Q3GUNhCPzN+o7l5SOgRinG1Kb99HmjILdCqgyMbsF5dY8NpX4LK5hfCtOcO7cka3LYl34IqzOh2tsaVdplX+yvhkYCATNwJlKRo8GPtC1OTIK8IgsPckg7NmTqBwloFuEO6RZeKymANSLDwQckD2j2eqmXZXGIqlVN9po3g6xVQzaW2nNhH7D6CMJ0wMVfkB3VhBq9Ug5KsG7EkNWNksYbItYXjckiMESYS+zGA1u4Z8T5DjtoniM+9A4hdx5wZxszkRIy1/Ofy3LHAcnlOXx7/xDIwx+wMJk0hl/qM96oP3YOX2hFWIcJcw/kxtXTeUFLLgKwVuonHtN9E0rPZblEIcfhUVt3XAyJrlg9aePXQmQm++yE8hvBW3n8gFrqCzZ5wRoGrQ1bw6rE+HHgV8hxeox04mHw==;5:HyY9UnLb8kZxJJz4/Hs5pvLwhkY1x9ajoCM58c3MC8fZlAXqlKGPzN3lYji3hR4/pWhhF1YFN8pDUKdzoIEv3e+LXVGPFStyKu8R2r0iCxEBAqgsnnxP2ouMX+P/FtOTZmSm8hVB1o0VcQ5IMP2BSqlAFkzEM6rT26XsnPd/z8exTAQRgO7sdVStPMELTlKLAUCvBz4XUs7PkF8XypN3mA==;7:XJu+llpXYYKGYivoJHIPqkPgvCClQnVoUqfrITkFFm+iMY5wlwgQ6V9szCp+uGV+b9MJQBpW/JgkBjcoNmIivuBOxG+/5aavCdj48D4OZ+ZeXhixKAPKOwmpLzLsHsG5yZTGiytjH2QHcYAwTz5Y6w==
x-ms-office365-filtering-correlation-id: b1259a29-7f35-4087-3490-08d68c4224f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3637;
x-ms-traffictypediagnostic: BYAPR12MB3637:
x-microsoft-antispam-prvs: <BYAPR12MB3637710616D6A42E19C14A7FC26F0@BYAPR12MB3637.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(7696005)(86362001)(81156014)(99286004)(6506007)(81166006)(8676002)(102836004)(478600001)(966005)(26005)(4326008)(14454004)(53376002)(6246003)(97736004)(8936002)(186003)(2906002)(316002)(110136005)(25786009)(106356001)(3846002)(68736007)(6116002)(7736002)(305945005)(105586002)(74316002)(33656002)(486006)(93886005)(71190400001)(71200400001)(54906003)(14444005)(53936002)(446003)(11346002)(6436002)(55016002)(256004)(6306002)(229853002)(476003)(76176011)(9686003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3637;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L2d0l2LnYMW2J8C/PU09MvIiiENKdfhNUsdS2pGZ3rvpSdEvRxQf83AwDD8PMxxaByagrrcRY8NnT/u/+a62SQbr0xcEnjsKDU2pqOmDc9pYZRRcgX0ckpECAkARnRsDu9mKC/RfZTATK1LyU+OPoV9DgPjVkKW88YQry0GUk2FkErXX1Ezp65+aailw6jcJtnUwUdSumW06JSbspsQIVolBcK2T+EBS9nyYfJzklpb0jhCwDuG4Nj0u2ZXNKqOMsy9tlt8+S/58DwwoAC2YOLbVuIM5aImkl/Dyqf+PO3+j/iz4VEyoEz5U+Rhy+E8ULtBuohYIpxN9Z10zH7KM2AFkkYbLDzcdW3P/6JNpKe0l4ocesMsBOE7C5y7+lpjNy35Y4q8AmdhL/Ax6ui7RoaBqbGT/EkKN1nchdNuZFB4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b1259a29-7f35-4087-3490-08d68c4224f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 14:48:23.4489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549464508; bh=jT0orsHpKuo0jls3MhxOt8A0avqvV5D7dxKNjBzOxgg=;
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
        b=AoFCpgLdsKRhLX1YjY2aABC8crcOJAbbQFzPrsmg4DsZ1OMZpqgd1sU3DQ+i0LHFo
         Odm7TrWaGonuRGVeAjzmsdMHZCRt2IKjXCOguTuyMSsEiS0bl9rW34rDYy69IgcDAM
         dhoJ7PIRTJavGsAuyuNwDN+hdVEVJAMF5E4GV/WvhOtax9MdkTFx4sEYtrwK65lf55
         +56b5DRy0PuyTVFH8EuAdkXhGhhExQjZnUloHTTx2UIgDiW+goEOStggOgzOSJ/oOX
         Lo63+RoScUP1ruxaI3uphJVetoQIwdDVhsIzm6aN/gzLkpulmukJWbahyKfxevYqBT
         4VLX2V4l+qj0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4+Pj4gWWVzIHBsZWFzZSBwb3N0IGZ1bGwgbG9nIG9mIFBJTyBvbmx5IGFuZCBETUEgb25s
eSBBbHNvLCBpbiBhYm92ZSANCj4gPj4+Pj4+IGxvZywgbG90cyBvZiBETUEgdHJhbnNmZXIgd2Vu
dCB0aHJ1IGZpbmUgZXhjZXB0IHRoaXMgb25lIHRyYW5zZmVyIA0KPiA+Pj4+Pj4gd2hlcmUgRE1B
IHRpbWVkIG91dC4NCj4gPj4+Pj4+IERNQSBjb21wbGV0aW9uIGRvZXNudCBoYXBwZW4gb24gRE1B
IHN1Ym1pdCBkdXJpbmcgdGhpcyBwYXJ0aWN1bGFyIA0KPiA+Pj4+Pj4gdHJhbnNhY3Rpb24gdGlt
ZWZyYW1lIGZvciBzb21lIHJlYXNvbi4NCj4gPj4+Pj4NCj4gPj4+Pj4gRG1pdHJ5LCBjYW4geW91
IHByb3ZpZGUgc29tZSBiYWNrZ3JvdW5kIGluZm9ybWF0aW9uIG9uIHRoZSBzZXR1cCANCj4gPj4+
Pj4gdGhhdCB5b3UncmUgdXNpbmc/IEkgdmFndWVseSByZW1lbWJlciBzb21ldGhpbmcgYWJvdXQg
aTJjQDcwMDBkMDAwIA0KPiA+Pj4+PiBiZWluZyBzcGVjaWFsIG9uIG9sZGVyIFRlZ3JhIGRldmlj
ZXMuIFBlcmhhcHMgdGhlcmUncyBzb21ldGhpbmcgDQo+ID4+Pj4+IGFkZGl0aW9uYWwgdGhhdCB3
ZSBuZWVkIHRvIHRha2UgaW50byBhY2NvdW50Pw0KPiA+Pj4+Pg0KPiA+Pj4+PiBBaGEhIExvb2sg
YXQgdGVncmFfaTJjX3JlZ19hZGRyKCkgd2hpY2ggc3BlY2lhbC1jYXNlcyBJMkNfVFhfRklGTyAN
Cj4gPj4+Pj4gb24gdGhlIERWQyB2YXJpYW50IG9mIHRoZSBjb250cm9sbGVyLCB3aGljaCBpcyBl
eGFjdGx5IHRoZSBvbmUgDQo+ID4+Pj4+IHRoYXQgeW91IGFyZSBzZWVpbmcgdGhlIHRpbWVvdXRz
IG9uIGFuZCBpdCdzIGV4YWN0bHkgdGhlIHJlZ2lzdGVyIA0KPiA+Pj4+PiB0aGF0IHdlIHVzZSBh
cyBkZXN0aW5hdGlvbiBmb3IgdGhlIERNQSB0cmFuc2Zlci4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSB0
aGluayB3ZSBuZWVkIHRvIGRvIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4+Pj4+DQo+ID4+Pj4+
IAlzbHZfY29uZmlnLmRzdF9hZGRyID0gaTJjX2Rldi0+YmFzZV9waHlzICsgDQo+ID4+Pj4+IHRl
Z3JhX2kyY19yZWdfYWRkcihpMmNfZGV2LCBJMkNfVFhfRklGTyk7DQo+ID4+Pj4+DQo+ID4+Pj4+
IHRvIG1ha2Ugc3VyZSB3ZSBwYXNzIHRoZSByaWdodCBGSUZPIHJlZ2lzdGVyIGFkZHJlc3MgdG8g
RE1BLg0KPiA+Pj4+DQo+ID4+Pj4gSSdtIHJ1bm5pbmcgaXQgb24gVDIwIGF0IHRoZSBtb21lbnQu
IEkgZG9uJ3Qga25vdyBhYm91dCB0aGUgRFZDIHF1aXJrcywgYnV0IHNvdW5kcyBwbGF1c2libGUu
IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnkgb3RoZXIgaW5mby4NCj4gPj4+Pg0K
PiA+Pj4+IEhlcmUgdGhlIGZ1bGwgbG9nczoNCj4gPj4+Pg0KPiA+Pj4+IFBJTy1vbmx5OiBodHRw
Oi8vZHBhc3RlLmNvbS8yTVgzRUFOLnR4dA0KPiA+Pj4+IERNQS1vbmx5OiBodHRwOi8vZHBhc3Rl
LmNvbS8zVlhaU1NNLnR4dA0KPiA+Pj4+DQo+ID4+Pj4gTm90ZSB0aGUgIkZhaWxlZCB0byByZWFk
IFQ0NCBhbmQgVDUgKC0xMTApIiBlcnJvciB0aGF0IGhhcHBlbnMgaW4gRE1BLW9ubHkuIEFuZCBp
dCBoYXBwZW5zIG9uIGkyY0A3MDAwYzAwMCwgRFZDIGlzIGkyY0A3MDAwZDAwMC4NCj4gPj4+DQo+
ID4+PiBZZXMgdGhpcyBpcyBkdWUgdG8gc2FtZSBpc3N1ZSB0aGVpcnJ5IG1lbnRpb25lZC4NCj4g
Pj4+IFByaW9yIHRvIHRyYW5zZmVyIHRpbWVvdXQgZm9yIHRvdWNoLCB0cHM2NTg2eCByZWd1bGF0
b3IgcHJvYmUgZmFpbGVkIGR1ZSB0byBpMmMgdGltZW91dCB3aGljaCB1c2VzIERWQyAoNzAwMEQw
MDApIGFuZCBzaW5jZSBETUEgbW9kZSBpcyBlbmZvcmNlZCA+IGFsbCBEVkMvUFdSIEkyQyB0cmFu
c2FjdGlvbnMgYWxzbyBnbyB0aHJ1IERNQSBhbmQgRklGTyByZWdpc3RlciBmb3IgRFZDIG9mZnNl
dCBpcyBub3QgYWNjb3VudGVkIHdoZW4gY29uZmlndXJlIHRvIGRtYSBzbGF2ZS4NCj4gPj4+IFdp
bGwgZml4IGFuZCBzZW5kIHNvIHlvdSBjYW4gc2VlIGZvciByZXBybyB3aXRoIHVwZGF0ZWQgcGF0
Y2guLg0KPiA+Pj4NCg0KPiA+PiBJIHRoaW5rIHRwczY1ODZ4IGFuZCBhdG1lbC10b3VjaCBzaG91
bGQgYmUgaW5kZXBlbmRlbnQgaXNzdWVzLCBidXQgd2lsbCBzZWUuIFRoYW5rcyENCj4gPiBXaGF0
cyB5b3VyIHBsYXRmb3JtIHNldHVwPyBJcyBhdG1lbCB0b3VjaCBwb3dlciBPTiBkZWZhdWx0IG9y
IGl0cyBwcm9ncmFtbWVkIGR1cmluZyBib290IGJ5IFNXIHdoY2loIG5lZWQgdG8gdXNlIERWQz8N
Cj4gPiANCj4gDQo+IEl0J3MgInBvd2VyIE9OIGRlZmF1bHQiLiBJIHRyaWVkIHRvIGJvb3QgaW4g
UElPLW9ubHkgbW9kZSB3aXRoIHRwczY1ODZ4IGRpc2FibGVkIGFuZCB0aGVyZSBpcyBubyAiRmFp
bGVkIHRvIHJlYWQgVDQ0IGFuZCBUNSIgZXJyb3IsIGF0bWVsIHByb2JlZCA+IHN1Y2Nlc3NmdWxs
eS4NCg0KSSBzZWUgaW4gRE1BIGxvZyBidW5jaCBvZiA3MDAwRDAwMCBpMmMgdHJhbnNmZXJzIGJl
Zm9yZSBhdG1lbCB0b3VjaCBwcm9iZS4gVkRELVNZUyBmb3IgNVYgaXMgbm90IHNlZW4uDQpTbyBz
dGlsbCBjb3VsZCBiZSByZWxhdGVkIHRvIHBvd2VyIGR1ZSB0byBEVkMgdHJhbnNhY3Rpb25zIHRp
bWVkb3V0IGFzIGNoYW5nZSBkb2VzbnQgYWNjb3VudCBmb3IgRFZDIG9mZnNldC4NCg0KUGxlYXNl
IHRyeSB1cGRhdGVkIHBhdGNoIHdoaWNoIGhhcyBmaXggZm9yIERWQyB0cmFuc2FjdGlvbiBmYWls
dXJlcy4NCg==
