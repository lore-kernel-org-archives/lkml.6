Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D16AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F41620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F41620832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aquantia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeK1Ulf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:41:35 -0500
Received: from mail-eopbgr770050.outbound.protection.outlook.com ([40.107.77.50]:22496
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbeK1Ule (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=AQUANTIA1COM.onmicrosoft.com; s=selector1-aquantia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFhRMAO2LLIKJkC2gZLrSBrD63lPvxV8yUHtI0AzRNw=;
 b=bY962SQ+H6ptttEd+AQkLZ8t3Y8++Nlb2+wa/KNYGCqMoALkOYtuGOjnjsbf1gYo6BMlm4tQnzK4gOixLyMZKtiIpna0zJ2yu9tvU8L1pbJTBhkiJg3TiZeJZGnqj5WgizkMwnQolmRI8EtLumKtIFLyGe+g5Dl1rOaBYZ0bbH4=
Received: from BY1PR0701MB1660.namprd07.prod.outlook.com (10.162.110.22) by
 BY1PR0701MB1675.namprd07.prod.outlook.com (10.162.110.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 28 Nov 2018 09:40:29 +0000
Received: from BY1PR0701MB1660.namprd07.prod.outlook.com
 ([fe80::f8ee:2260:e410:fffd]) by BY1PR0701MB1660.namprd07.prod.outlook.com
 ([fe80::f8ee:2260:e410:fffd%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:40:28 +0000
From:   Igor Russkikh <Igor.Russkikh@aquantia.com>
To:     David Miller <davem@davemloft.net>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
CC:     Nikita Danilov <Nikita.Danilov@aquantia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: aquantia: return 'err' if set MPI_DEINIT
 state fails
Thread-Topic: [PATCH net-next] net: aquantia: return 'err' if set MPI_DEINIT
 state fails
Thread-Index: AQHUhv5lHuqhJjToJE+xC4y6DWMl+Q==
Date:   Wed, 28 Nov 2018 09:40:28 +0000
Message-ID: <403a5d75-cb7f-bacf-17b3-b03a55abd571@aquantia.com>
References: <20181124101641.7072-1-yuehaibing@huawei.com>
 <20181127.152539.1127313634090592618.davem@davemloft.net>
In-Reply-To: <20181127.152539.1127313634090592618.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0009.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::22) To BY1PR0701MB1660.namprd07.prod.outlook.com
 (2a01:111:e400:522a::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Igor.Russkikh@aquantia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [95.79.108.179]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR0701MB1675;6:0tNL0Qdhhpg8OJHFi3vXyWj9/4d/VgAqeZlAHpLRBE455B9G5lMJu/Nf7034prBCvHnppjQjw96Zv7DGS8v68P1DZqlc3MaVCvyBU+vePIlpfgbEqmGIKdke1Lqnum0wWdFoJ54D/hkhZXs7I0zR+qDu7EK1SxBx15Z7myZbw/PPFAcR/iH6uHaCORwuLB9fo8db73Nv5BFhhxk2h0lPqXK04EJhYB2DUCN1yFnW4vq5rJUg9JtMmIMe14uHksz/OO0HYamu3KBJDuBGj/2JbGmbdMG+NUTlf6OMQ46/kbJ/GhInzVUKJEQmf1xBN0X6wIJhc4R9bFwLTGlwYZBEseeIRFrNjpwytlf0wKqJpOq43U8nC9FkmdqPvYFot6dRW5MQAqO+RVTXXfkNNdlCsn2xzT0mPE3PgmV8Pb90edcUIynI5BTh9CvJtjBCuKImwFYZ2Sqvaa6PKo5FfmWQ7w==;5:9xAh/fraii1Q9YDG9FEz3MiQViLRn9xy3dSBxxO5Csac0fL48maMOP1f1OEINU/ajqTfNVsOOWI/5wMBYcF/qKIk+Hxf/1Q2jmHiUhIJZgLJs5enSw6S+/V8y/WNIH27Brvimm4kLUrkEfUOAhs7ADoxqyFwbf2INqYaaMFo54I=;7:oU+bVlm2az9Yx0VvmZ1H8YM9PgZsF+7J8zMgwm2JRK7HXhEgi/bl/RaoSRh3n2H518ArYi0t26Gr1HET9Nyqxt9fVGSYwgyUplKvZ5el38Uzimw81toeLJDn1bKnSH+VQnBs/MNlLIPCjNviOo3VgQ==
x-ms-office365-filtering-correlation-id: c6af12a9-355c-4b7e-bbdb-08d6551587fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY1PR0701MB1675;
x-ms-traffictypediagnostic: BY1PR0701MB1675:
x-microsoft-antispam-prvs: <BY1PR0701MB16753F51BECAC20EEA06371098D10@BY1PR0701MB1675.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY1PR0701MB1675;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1675;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39850400004)(199004)(189003)(478600001)(76176011)(476003)(446003)(2616005)(11346002)(54906003)(105586002)(25786009)(110136005)(72206003)(5660300001)(14454004)(316002)(36756003)(256004)(31686004)(106356001)(99286004)(4326008)(14444005)(386003)(6436002)(8936002)(229853002)(305945005)(7736002)(68736007)(6486002)(81156014)(2906002)(6506007)(26005)(81166006)(102836004)(6512007)(8676002)(3846002)(6116002)(97736004)(71200400001)(53936002)(71190400001)(44832011)(86362001)(486006)(2501003)(66066001)(52116002)(6246003)(186003)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1675;H:BY1PR0701MB1660.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: aquantia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xCXfQQLCEME5qNsRAMGkSuNtljFSuGDgq4K1Ak4LiX7RVHgbSDhoZS9tBAPCt4yWir/9HhqAPD+HlIlyCNVpnzKxMkLTwm/WLhRs2q82c/07D3UonAnsz+m6J5pJCiiarTXkoxa1b8sb/PVUTOY3m1FO9DBvG07krrrxHWXrGzdgChV6uUWwQQ7Uf6AcxM6JMWkMgXdmzUGTWRxajGmOArwY5MlIywLbXhXoT0tFSs8btrCZrAMSlhUp/jK7uFZ7HxVkZmNq3NzLsETpWEF98sfC4QK0MfG2ZPXEuonoSCLVW8s5k5NFQD7pw5ticf3+J9J2l28p7IOnNf3zGiISYjT7AsRP4AfVR9EaWJ7Hp6k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <59A1D1D246B24D4AB24340A6F6A2FC71@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aquantia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6af12a9-355c-4b7e-bbdb-08d6551587fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:40:28.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 83e2e134-991c-4ede-8ced-34d47e38e6b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBkcml2ZXJzL25ldC9ldGhlcm5ldC9hcXVhbnRpYS9hdGxhbnRpYy9od19hdGwvaHdfYXRs
X3V0aWxzLmM6MjYwOjc6DQo+PiAgd2FybmluZzogdmFyaWFibGUgJ2Vycicgc2V0IGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCj4+DQo+PiAnZXJyJyBzaG91bGQgYmUg
cmV0dXJuZWQgd2hpbGUgc2V0IE1QSV9ERUlOSVQgc3RhdGUgZmFpbHMNCj4+IGluIGh3X2F0bF91
dGlsc19zb2Z0X3Jlc2V0Lg0KPj4NCj4+IEZpeGVzOiBjY2U5NmQxODgzZGEgKCJuZXQ6IGFxdWFu
dGlhOiBSZWdyZXNzaW9uIG9uIHJlc2V0IHdpdGggMS54IGZpcm13YXJlIikNCj4+IFNpZ25lZC1v
ZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gDQo+IEFwcGxpZWQu
DQo+IA0KPiBCdXQgdGhpcyBBUV9IV19TVEFURV9GT1IgbWFjcm8gX01VU1RfIGJlIGZpeGVkLg0K
PiANCj4gTm8gbWFjcm8gc2hvdWxkIGhhdmUgaW52aXNpYmxlIHJlZmVyZW5jZXMgdG8gdmFyaWFi
bGVzIGxpa2UgdGhpcywgYW5kDQo+IHRoYXQgaXMgZXhhY3RseSB3aGF0IGxlYWRzIHRvIGJ1Z3Mg
bGlrZSB0aGlzLiAgQ1BQIG1hY3JvcyB3cml0dGVuIHRoaXMNCj4gd2F5IG1ha2UgaXQgaW1wb3Nz
aWJsZSB0byBwcm9wZXJseSBhdWRpdCBjb2RlLg0KPiANCj4gJ2Vycicgc2hvdWxkIGJlIGFuIGV4
cGxpY2l0IGFyZ3VtZW50IGdpdmVuIHRvIHRoaXMgZnVuY3Rpb24gaW5zdGVhZCBvZg0KPiBob3cg
aXQgd29ya3Mgbm93Lg0KDQpIaSBEYXZpZCwNCg0KQWdyZWVkLCBJJ2xsIGNsZWFuIHRoaXMgdXAu
DQoNClJlZ2FyZHMsDQogIElnb3INCg==
