Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF7AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509AF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hQDjBmrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfBFOTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:19:48 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5026 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfBFOTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:19:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5aecee0000>; Wed, 06 Feb 2019 06:19:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 06:19:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 06:19:45 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:19:38 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:19:38 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.53) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 14:19:37 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3286.namprd12.prod.outlook.com (20.179.93.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 14:19:36 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 14:19:36 +0000
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
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAUt4CAAAEfAIAAAXOAgAAAhsCAAAYqgIAAADAAgAACQDCAAAL7gIAAA0OAgAAA7+A=
Date:   Wed, 6 Feb 2019 14:19:36 +0000
Message-ID: <BYAPR12MB3398D7685B5A7462161F9578C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
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
In-Reply-To: <9b4bfee0-f3f2-bae7-5010-97a86bb5e03f@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3286;6:svavlZKfGluBH0LiNzLH6+9CZl+YsUFhWFPtqiV3Mc6KrhB1BlPE0FJdPP8kGuVwuOxbhhdNLbXtVOKQi2YDR3hhPI9ezWiOYSpePRJOtn06CqZ8BYVEK4FlKZfhFsOl3S/AiRxaVRtZQS8EmqhFbKugTufVxLo74OFHH3iC89E6AsmYwvScRRaDcDitPI5UTrL7hXED7JdykuHy+1lWn3KBgzI5VLDq03SWOKP/DIVIhYAgVOjTaBdh/LTlgtMaf/mMULoYOocRBIV5WK4Jt/UdR1wQxjFINDC0pkATDVCt0QRj7ph5gwQOHqASFYg8mLZ0CtzVPAXTbS9vt+uzCTLTeyBXUtdqBAaFprz57Rli8Cj1dQK+0izkoktfDSocmt2YSzVDTWnQkvA+eK6kjFrWjh6NrcPOsEhIDYFkL54JZLIoFuWFfQghN/3pOwmRPwUY2X2UElK61nEiltGX2g==;5:oTXHPxDhL9W8/feE8qRnTO2stcLsosHM95F3am881aIUCmJluEL8Dla0dyP21MeZtrs9KjbNpariAsErUT0RtqVTe8bURMJTRnV07QLwaG7bDpvkuNltcxYVmQjF2QPe0LojkoTO36TDmtwNDK97xLMWjO6fcVkKYTauoqjnt18bVHxsoYdZCu9yA2S7shrvZiPbhjxnU9F2pekaxfhivw==;7:cKekiNHlMjD4VR5+H0bYU7FRrFgx5gTlOb2JVLEic1p0iJzfnm7BLvtTLIHEVn0FRsOQEyhGePwKkeywv3NqZpqVpPMuOU+J9m5Okt51dJdfsnTC+2b6HrQHLAP2T2RXeu3WbzRUn0uLe09kdBMmJQ==
x-ms-office365-filtering-correlation-id: f2480875-d179-45e7-c33f-08d68c3e1fb8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3286;
x-ms-traffictypediagnostic: BYAPR12MB3286:
x-microsoft-antispam-prvs: <BYAPR12MB328655011B4005DB9D6960D5C26F0@BYAPR12MB3286.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(81166006)(81156014)(8936002)(106356001)(74316002)(25786009)(7696005)(76176011)(9686003)(54906003)(71190400001)(476003)(2906002)(86362001)(71200400001)(53376002)(102836004)(99286004)(6246003)(4326008)(55016002)(6506007)(14454004)(105586002)(966005)(6306002)(446003)(11346002)(68736007)(33656002)(6436002)(110136005)(316002)(256004)(478600001)(305945005)(3846002)(26005)(6116002)(14444005)(97736004)(486006)(53936002)(66066001)(186003)(93886005)(8676002)(229853002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3286;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dFK8ebDEIwBXJieQmT6eBgHT0CL5i2k+6k7EFvX18byzanV3zBHSdAxWPSqFjOU7Q01a0jXUdKCphGryxa7RloN8ob/QP6bp71PN3mnQQWYhMbIQhhuLmguJCj3xrLa0DBwSfH63un1IsGaTNRi7UBBAOJGSBSWAwPcqobMZeay19npZTVhb6DBj8/+rI3LWUaQUwV/ZE/qIt5yiWJa3Meuce+KA8ZPW4aIE0QH6sxuBi50Jb00XAE3HFGsUEx+FDYFP7bxQm/a9T/KWZ47xWG9LS4j+/1ppHsMk64tlFeSQwMfcFFG5BhyoRVYxDnxbfoAIBqfWPVdVlWcObId5gU2H0lWl2ANS8oAMDruCm0HI0tiMwbNcB5zEiPsAW//EmjN+2O+YvU+9DFjuWch6WRt3ma5zY2GAMEZJ8sDKLKI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2480875-d179-45e7-c33f-08d68c3e1fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 14:19:36.5705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3286
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549462772; bh=yMMqEuE3pCrTC4VL2+Gm4USbixVk48dfo64OnEuMmKk=;
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
        b=hQDjBmrmWu6zbjXluISagHArKeaypw30OCCJMlfu1s/lK0w53GlP/wVL8dj6v2ALE
         cVz+ek5vLWOpw2NJE6biNwiHR8w9z5maeuHnK0VljW9N6I98V2fqX3XHfvRzXIt+9S
         HPhwWOwhJhzWk/rs2eqgDhX/2VeOpL0c7OHvUDNr3wh+im9NnpBxSClIZF4sQwhCfq
         eXY7XCQS0tJJ/IcG6sAURwsYLCsG2C8MqBUnDMLMIo5Yrw+lt6Nsu7U+eIkgcSVZoF
         TfdfMbwcQM2UdLpaCAGDaA7GCedpF3AY+w+x435wLpBfIHYpCPsdOyt1GV0bMAXiax
         mU/A5whCJVvag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gTm8sIHRoZXJlIGFyZSBubyB0aW1lb3V0IGVycm9ycyBpbiBQSU8gbW9kZS4gSSBjb3Vs
ZCBwb3N0IGZ1bGwgbG9nIHdpdGggdGhlIFBJTy1vbmx5IG1vZGUgaWYgeW91IHdhbnQuDQo+ID4+
Pg0KPiA+PiBZZXMgcGxlYXNlIHBvc3QgZnVsbCBsb2cgb2YgUElPIG9ubHkgYW5kIERNQSBvbmx5
IEFsc28sIGluIGFib3ZlIGxvZywgDQo+ID4+IGxvdHMgb2YgRE1BIHRyYW5zZmVyIHdlbnQgdGhy
dSBmaW5lIGV4Y2VwdCB0aGlzIG9uZSB0cmFuc2ZlciB3aGVyZSANCj4gPj4gRE1BIHRpbWVkIG91
dC4NCj4gPj4gRE1BIGNvbXBsZXRpb24gZG9lc250IGhhcHBlbiBvbiBETUEgc3VibWl0IGR1cmlu
ZyB0aGlzIHBhcnRpY3VsYXIgDQo+ID4+IHRyYW5zYWN0aW9uIHRpbWVmcmFtZSBmb3Igc29tZSBy
ZWFzb24uDQo+ID4gDQo+ID4gRG1pdHJ5LCBjYW4geW91IHByb3ZpZGUgc29tZSBiYWNrZ3JvdW5k
IGluZm9ybWF0aW9uIG9uIHRoZSBzZXR1cCB0aGF0IA0KPiA+IHlvdSdyZSB1c2luZz8gSSB2YWd1
ZWx5IHJlbWVtYmVyIHNvbWV0aGluZyBhYm91dCBpMmNANzAwMGQwMDAgYmVpbmcgDQo+ID4gc3Bl
Y2lhbCBvbiBvbGRlciBUZWdyYSBkZXZpY2VzLiBQZXJoYXBzIHRoZXJlJ3Mgc29tZXRoaW5nIGFk
ZGl0aW9uYWwgDQo+ID4gdGhhdCB3ZSBuZWVkIHRvIHRha2UgaW50byBhY2NvdW50Pw0KPiA+IA0K
PiA+IEFoYSEgTG9vayBhdCB0ZWdyYV9pMmNfcmVnX2FkZHIoKSB3aGljaCBzcGVjaWFsLWNhc2Vz
IEkyQ19UWF9GSUZPIG9uIA0KPiA+IHRoZSBEVkMgdmFyaWFudCBvZiB0aGUgY29udHJvbGxlciwg
d2hpY2ggaXMgZXhhY3RseSB0aGUgb25lIHRoYXQgeW91IA0KPiA+IGFyZSBzZWVpbmcgdGhlIHRp
bWVvdXRzIG9uIGFuZCBpdCdzIGV4YWN0bHkgdGhlIHJlZ2lzdGVyIHRoYXQgd2UgdXNlIA0KPiA+
IGFzIGRlc3RpbmF0aW9uIGZvciB0aGUgRE1BIHRyYW5zZmVyLg0KPiA+IA0KPiA+IEkgdGhpbmsg
d2UgbmVlZCB0byBkbyBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiA+IA0KPiA+IAlzbHZfY29uZmln
LmRzdF9hZGRyID0gaTJjX2Rldi0+YmFzZV9waHlzICsgDQo+ID4gdGVncmFfaTJjX3JlZ19hZGRy
KGkyY19kZXYsIEkyQ19UWF9GSUZPKTsNCj4gPiANCj4gPiB0byBtYWtlIHN1cmUgd2UgcGFzcyB0
aGUgcmlnaHQgRklGTyByZWdpc3RlciBhZGRyZXNzIHRvIERNQS4NCj4NCj4gSSdtIHJ1bm5pbmcg
aXQgb24gVDIwIGF0IHRoZSBtb21lbnQuIEkgZG9uJ3Qga25vdyBhYm91dCB0aGUgRFZDIHF1aXJr
cywgYnV0IHNvdW5kcyBwbGF1c2libGUuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBh
bnkgb3RoZXIgaW5mby4NCj4NCj4gSGVyZSB0aGUgZnVsbCBsb2dzOg0KPg0KPiBQSU8tb25seTog
aHR0cDovL2RwYXN0ZS5jb20vMk1YM0VBTi50eHQNCj4gRE1BLW9ubHk6IGh0dHA6Ly9kcGFzdGUu
Y29tLzNWWFpTU00udHh0DQo+DQo+IE5vdGUgdGhlICJGYWlsZWQgdG8gcmVhZCBUNDQgYW5kIFQ1
ICgtMTEwKSIgZXJyb3IgdGhhdCBoYXBwZW5zIGluIERNQS1vbmx5LiBBbmQgaXQgaGFwcGVucyBv
biBpMmNANzAwMGMwMDAsIERWQyBpcyBpMmNANzAwMGQwMDAuDQoNClllcyB0aGlzIGlzIGR1ZSB0
byBzYW1lIGlzc3VlIHRoZWlycnkgbWVudGlvbmVkLg0KUHJpb3IgdG8gdHJhbnNmZXIgdGltZW91
dCBmb3IgdG91Y2gsIHRwczY1ODZ4IHJlZ3VsYXRvciBwcm9iZSBmYWlsZWQgZHVlIHRvIGkyYyB0
aW1lb3V0IHdoaWNoIHVzZXMgRFZDICg3MDAwRDAwMCkgYW5kIHNpbmNlIERNQSBtb2RlIGlzIGVu
Zm9yY2VkIGFsbCBEVkMvUFdSIEkyQyB0cmFuc2FjdGlvbnMgYWxzbyBnbyB0aHJ1IERNQSBhbmQg
RklGTyByZWdpc3RlciBmb3IgRFZDIG9mZnNldCBpcyBub3QgYWNjb3VudGVkIHdoZW4gY29uZmln
dXJlIHRvIGRtYSBzbGF2ZS4NCldpbGwgZml4IGFuZCBzZW5kIHNvIHlvdSBjYW4gc2VlIGZvciBy
ZXBybyB3aXRoIHVwZGF0ZWQgcGF0Y2guLg0KDQoNClsgICAgMC45MjUxNTVdIHRlZ3JhLWkyYyA3
MDAwZDAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxNg0KWyAgICAwLjkyNTE2NV0g
dGVncmEtaTJjIDcwMDBkMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KWyAgICAxLjAyODk2MV0g
dGVncmEtaTJjIDcwMDBkMDAwLmkyYzogaTJjIHRyYW5zZmVyIHRpbWVkIG91dA0KWyAgICAxLjAy
ODk2OF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogRE1BIHRyYW5zZmVyIHRpbWVvdXQNClsgICAg
MS4wMjg5OTVdIHRwczY1ODZ4IDMtMDAzNDogQ2hpcCBJRCByZWFkIGZhaWxlZDogLTExMA0KWyAg
ICAxLjAyOTAyOV0gdHBzNjU4Nng6IHByb2JlIG9mIDMtMDAzNCBmYWlsZWQgd2l0aCBlcnJvciAt
NQ0KWyAgICAxLjAyOTA0NV0gYXRtZWxfbXh0X3RzIDAtMDA0YzogX19teHRfcmVhZF9yZWc6IGky
YyB0cmFuc2ZlciBmYWlsZWQgKC0xMTApDQpbICAgIDEuMDI5MDUxXSBhdG1lbF9teHRfdHMgMC0w
MDRjOiBGYWlsZWQgdG8gcmVhZCBUNDQgYW5kIFQ1ICgtMTEwKQ0K
