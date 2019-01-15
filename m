Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F22DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4105820645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QQ6DMSX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfAOD0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:26:25 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6835 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfAOD0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:26:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3d52ca0000>; Mon, 14 Jan 2019 19:26:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Jan 2019 19:26:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Jan 2019 19:26:22 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 03:26:21 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 03:26:21 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.59) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 15 Jan 2019 03:26:21 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2674.namprd12.prod.outlook.com (20.176.176.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 03:26:20 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%3]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 03:26:19 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Thread-Topic: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Thread-Index: AQHUotKSxBXfHJPe7kWiv8CqukYPGKWoiBQAgAC77dCABnYqAIAAA/7g
Date:   Tue, 15 Jan 2019 03:26:18 +0000
Message-ID: <BN7PR12MB2836B186E2AB62D58F6D08B1C2810@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
 <5722018a-7654-c6f9-c2aa-2817b39b1a35@intel.com>
 <BN7PR12MB2836750BAFFAEAF8436C7C58C2850@BN7PR12MB2836.namprd12.prod.outlook.com>
 <CABOV4+UkA48Jc9hTSkM=cEoH0zktmjazrcWVZZ1LMqRXSdjVuA@mail.gmail.com>
In-Reply-To: <CABOV4+UkA48Jc9hTSkM=cEoH0zktmjazrcWVZZ1LMqRXSdjVuA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2674;6:MvbEKsZ5scfcfSQLMN4Gn/W2pfsblpacAv7leLVkCUZ+AhH4T+n/eBmI9IapDTQzIBRmRIGlW59raTRPUJx9ppzO66yXRIScQ2iXCXTR2net194olwmR2mgdikX1L3fyXi5YDOreilLH3TsqUNJFOdReT3tZYdf2uxN5fEc5LnaLq1wmXczSAVcHVOFOnUZNbxHoqShoKQkUPet1Bq6E752OWAdedqeYHG7vvu3EWSkLijzfgBZUe7tyo6ERG2xRns+QN9GJzKUTzx7uR/VXUpI+1TY+hKuUF8Vttmzog6llxcYBT0VzabaFdfSmary4+OGSpm+j4sKSYTH3tkS9seBS7QEsxOYIrPugUzOfm+Se6QV6tpCdcHOJurM9jaZZf+twcKPjo5WsMhTeGAWyQSo7gNTJfkvKHUwoIbZPBVcO0ANlq+OEF3VrsQlo8nLKhYEPwE+h6jAGyrRihBCALg==;5:JdozMx6jGmbZ8ZbV74yjBR54JrlQ9GzFrrJZ/KauPf0yCftX/0npu3KFkBQLq5AbwnraK3tx9Cieh8OsbBjTj19VWN41FKaqn+fK4y9KwwsCo1ANyTlTf++2t7L/9uomurzsryJEIU3jG4IDVJ4M5sBJoVE5QuH2F828z4GUBicOHxlmJaZlN8JQyLbQQ8TjI7DZEdRpeSzQ8nBfpg6cqg==;7:UOe26Vfi/zMlXUWVOKoJrPVxmkouYJy9mfMzsZ52KxRxz0kj5/qUSZo7tEh1/uKWiozRVSza3H25nzFjgpEGi/HHIJC3HmBaCXxio/EoLco/kK6L5CzzRGhsTh5+Sx4ckciS9s2FWzPoOPa7hx91jA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(71200400001)(71190400001)(97736004)(256004)(93886005)(68736007)(6246003)(26005)(229853002)(2906002)(305945005)(4326008)(86362001)(6436002)(102836004)(55016002)(6506007)(25786009)(186003)(476003)(33656002)(486006)(8936002)(316002)(9686003)(76176011)(5660300001)(7696005)(446003)(478600001)(81156014)(81166006)(74316002)(53936002)(6116002)(8676002)(11346002)(3846002)(99286004)(39060400002)(14454004)(66066001)(7736002)(6916009)(54906003)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2674;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 50a9d62b-3f1c-454c-0de7-08d67a9936fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2674;
x-ms-traffictypediagnostic: BN7PR12MB2674:
x-microsoft-antispam-prvs: <BN7PR12MB2674964AB80969B1E5FC5C3EC2810@BN7PR12MB2674.namprd12.prod.outlook.com>
x-forefront-prvs: 0918748D70
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 55+4JNFRxdoNsW/8+oqI9qiCJuP/Aiz7B35TMvHxitW97f6d/OAGYQ9wZsHDayFiCmki4v1ETmSJH1qjwdzbuX4fBxmX47HKwz5jW96pxBMxXx6C0Ec1wnBEVAUBhgUFRhhD+TIerV056d8aTXNwmtgjzF2rFmrnAyHiKOFRbwvbhQrvRCiOU8d3rz1ibHBcOWZsxnX8++BYWDRMe7BNh5d4z1XkrRfYNyDmpGugdfugv1AlDrlCshogUB/0tLMwg6Y/wN4pDoptJSG3qu9IqUoMnWltmgdb1kpSILF0vulxsoKO6OF4DORv/E+0Ps/M9CKKNeOvNa8XCMwxiU+Ip0bJlt+P0XvH8Vsv+vVnuFXikpXhl6esm/NgpViYYBk+3Sij7Dls0dHWBqQ/+qHmS8pC4oSco8qLTIbOat7cVxw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a9d62b-3f1c-454c-0de7-08d67a9936fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 03:26:18.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547522762; bh=CirNDZgI255udzJD3Lfp1s+f37gYvcwQ0h6i7eGi+l8=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:received-spf:x-ms-exchange-senderadcheck:
         x-microsoft-antispam-message-info:spamdiagnosticoutput:
         spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=QQ6DMSX8AoK6nv69yh4MMv2NfSeGhB1e+26t3PLhqTpH2rlbxkApKH3T9oCeQfj1w
         CeNzTXg/IvOdEyJldXKgKKSicW9Yo/W7MCp+mRIEONHxoOCr8LomF9ZaZW2vPZBA8K
         D7iY9h5IQ0zhn6djbxIe2A7qur2c8PLtQMXmW6M/QjlH6tSBti9yL3yzo3jkzOSNyO
         tJV7vmE0Pf41bLjHRFKNhEGsUweqpLXLW2EuqoKGYpavvpih1wEQNlHzIqvva9iS3B
         MyekQT3wYLNqtix4t05DTAniDiRoq0Arq14TO4CT0hba66fqkXg50PgAXp/6ubwaJJ
         LYCRz/WG87fIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+Pg0KPj4gPj4gK3N0YXRpYyBpbnQgc2RoY2lfdGVncmFfYWRkX2hvc3Qoc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QpIHsNCj4+ID4+ICsgICAgc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZt
X2hvc3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPj4gPj4gKyAgICBzdHJ1Y3Qgc2RoY2lfdGVncmEg
KnRlZ3JhX2hvc3QgPSBzZGhjaV9wbHRmbV9wcml2KHBsdGZtX2hvc3QpOw0KPj4gPj4gKyAgICBz
dHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdDsNCj4+ID4+ICsgICAgYm9vbCBkbWE2NDsNCj4+ID4+
ICsgICAgaW50IHJldDsNCj4+ID4+ICsNCj4+ID4+ICsgICAgaWYgKCF0ZWdyYV9ob3N0LT5lbmFi
bGVfaHdjcSkNCj4+ID4+ICsgICAgICAgICAgICByZXR1cm4gc2RoY2lfYWRkX2hvc3QoaG9zdCk7
DQo+PiA+PiArDQo+PiA+PiArICAgIGhvc3QtPnY0X21vZGUgPSB0cnVlOw0KPj4gPg0KPj4gPkNh
biB5b3UgdXNlIHNkaGNpX2VuYWJsZV92NF9tb2RlKCkgaGVyZT8NCj4+DQo+PiBIaSBBZHJpYW4s
DQo+PiBzZGhjaV9yZWFkX2NhcHMgc2V0cyB2NCBtb2RlIHRocnUgc2RoY2lfZG9fZW5hYmxlX3Y0
X21vZGUgaWYgdjRfbW9kZSANCj4+IGlzIHRydWUgc2RoY2lfc2V0dXBfaG9zdCBjYWxscyBzZGhj
aV9yZWFkX2NhcHMgc28gSSB3YXMgc2V0dGluZyB2NF9tb2RlIHRvIHRydWUgc28gdjQgbW9kZSBn
ZXRzIGVuYWJsZWQgZHVyaW5nIHJlYWQgY2Fwcy4NCj4+DQo+DQo+SGkgc293amFueWEsIA0KPg0K
PkkgYWxzbyB3b3VsZCBzdWdnZXN0IHRvIHVzZSBzZGhjaV9lbmFibGVfdjRfbW9kZSgpIGluc3Rl
YWQgb2Ygc2V0dGluZw0KPmhvc3QtPnY0X21vZGUgZGlyZWN0bHkuDQo+RW5hYmxpbmcgdjRfbW9k
ZSBpbiByZWFkIGNhcHMgd2FzIGp1c3QgYmVjYXVzZSB0aGF0IEkgd2FzIHdvcnJpZWQgYWJvdXQg
djQgbW9kZSB3b3VsZCBiZSBjbGVhcmVkIGFmdGVyIHJlc2V0IGFsbCBvbiBzb21lIGNvbnRyb2xs
ZXJzLiBJZiB0aGF0J3Mgbm90IHRoZSBjYXNlIGZvciBhbGwgc2QgaG9zdCBjb250cm9sbGVycywg
SSBndWVzcyBpdCBjYW4gYmUgcmVtb3ZlZC4NCj4NCj5UaGFua3MsDQo+Q2h1bnlhbg0KDQpPSywg
V2lsbCBjaGFuZ2UgaXQgYW5kIHByb3ZpZGUgdXBkYXRlZCB2ZXJzaW9uLiBUaGFua3MgQW5kcmlh
biBhbmQgQ2h1bnlhbi4NClNvd2phbnlhDQo=
