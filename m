Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1EAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FB3222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="YZFcCv37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395463AbfBNKwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:52:12 -0500
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:24320
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387932AbfBNKwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBrMNdVHGFBrUys9f53BrvHVP9cx3RhqpM/lWnxa1mw=;
 b=YZFcCv37ZtEk9RN5NjfMgIKIs7DMAnOn5Wt8nkezjHK7voYWlZ/LvK6aL0D/n/ecTK4FvERwS3jqE6STkxum9XmS7PH5R0i80nbWw3pKhJbCdiuFYBv0iPsELTO8ugpiiMl7waXM9SO5eiEV0yRQUA8bBvxEHvXmUHWPxqUXQ0E=
Received: from BN6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:405:6f::19)
 by BYAPR03MB3749.namprd03.prod.outlook.com (2603:10b6:a03:6f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.18; Thu, 14 Feb
 2019 10:51:56 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR03CA0081.outlook.office365.com
 (2603:10b6:405:6f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 10:51:55 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; usp.br; dkim=none (message not signed)
 header.d=none;usp.br; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 14 Feb 2019 10:51:50 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1EApnEm008396
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 02:51:49 -0800
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Thu, 14 Feb 2019 05:51:49 -0500
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael.tsuha@usp.br" <rafael.tsuha@usp.br>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD ->
 RESERVED
Thread-Topic: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD ->
 RESERVED
Thread-Index: AQHUtBumolPUtAfENESQVOuCH7nrI6W/+RoAgAEDBQCAAAe0AIABLWuAgAQfPQCAGJKngIAArvgA
Date:   Thu, 14 Feb 2019 10:51:49 +0000
Message-ID: <1550141494.9460.51.camel@analog.com>
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
         <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
         <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
         <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
         <20190126181321.1439e485@archlinux>
         <CA+U=DsqwVsXyaDiBa1VLUjWmEcGLCYfk3iVZ5h5xEAcqyrXgQw@mail.gmail.com>
         <CAOeBkLok_PJ-ZbHcTN-yc6+p-qb5RMMmALp4fOpfAr2cqRO5Ug@mail.gmail.com>
In-Reply-To: <CAOeBkLok_PJ-ZbHcTN-yc6+p-qb5RMMmALp4fOpfAr2cqRO5Ug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.224.122]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBDB34605C7208418A869A6A2C057FC7@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(51444003)(316002)(2501003)(72206003)(6116002)(3846002)(478600001)(7696005)(106466001)(50466002)(76176011)(8676002)(446003)(14454004)(23676004)(2486003)(436003)(426003)(86362001)(36756003)(186003)(53546011)(102836004)(54906003)(26005)(110136005)(336012)(106002)(126002)(47776003)(246002)(6306002)(356004)(2616005)(4326008)(486006)(476003)(7736002)(11346002)(14444005)(103116003)(305945005)(6246003)(229853002)(66574012)(8936002)(93886005)(7416002)(7636002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3749;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT046;1:OXiGkGL2G8R77oIBmISqIyBQDCftBcl5ngMY8rWEdMO0/lOPgl/DbuWwOdP5X65TT9t/psluO1RapJ2o4EW47DTJjP2KcYPpczbDHM+ajXrpRDmh6I9SIj7GyIT0O66p15B7fGC72QK+XS/1W+NPPAplYvBZBpBQLMVkzDRNV40=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91fba52-f6c1-4ff2-2ae3-08d6926a6f33
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3749;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3749:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3749;20:Iy7oLbwFqHESa3so1+3BFJs0gbEh5CIGQP6FQABM+zrr3bwVWrpd2OPWlL3VDpnMjAhGHg3X9uTR/ymCkPnkMxNcQNBe+8lXJr86+FaKZibNiaD5KOcJottgd1ZiUyZJ1fllwpu4fYSjqh6GKSFzbhwtfXzL/Bske8UTZQrVJ8F8qAuJ5NAep3MAsCdspxyvLP2xnbD9jYpIz78ZsdPWHZDdQxY61vDwCpMWMgDWVeihrL+FofsQcdEg/be8Vll27Fg4o/rU3+Qda4aH4fCpypIibhoZGjn+cW6sU4R1AUybzlMrCTiwkUgVLC7SucZv2FpjCoN3S4NYhaDrZ0ivf4ULSCQ8HQjiooT+G/jXDLJmVRv4wcrFHRtCQfhCP2ocQ7G7HJryI9gX5qFCGbOQvKK6TDv9O7/UUEjgakcKld0ATTqKWgpBYwhFPfI6bxkSBH/TosIayqTxdujE7gjgrpvAOrOqu1S4EHCe/Zd5kWCPSEGBQRz6I+qE4FXPY36p
X-Microsoft-Antispam-PRVS: <BYAPR03MB37495100504B7CA23ACC22579D670@BYAPR03MB3749.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAzTUIzNzQ5OzIzOitXVHRiekRiVHk4aWFnYW5XL2E0TDhERldk?=
 =?utf-8?B?QlYvUHp6eS9uVzNibENZaGpMbHRVQmZuc3JLN2l2QkdmUTRjcTlrbGMrMExa?=
 =?utf-8?B?dUNYdWtZVnY2UG8rS3I5cGh3TUpSNHR1SmFubDBDbE9HOWhSdVZPeVZYNGRZ?=
 =?utf-8?B?RWdKb1N6aERCcHhTNkd4NUl1SzBWMGFVT2ZXVE1kWWdTZk1uekVGeW0xM1lC?=
 =?utf-8?B?czhnRGJtWGFQZndzWnUwbzBhL000V2dYSlROVHFnTmF3RVFVbjVGSUtPbzZy?=
 =?utf-8?B?U25FNFRzNGozM3IvdWttS3RQUytwQndNR0RWMGxvZXcrdFczU01OUkozZFBz?=
 =?utf-8?B?NmJVRExZRHBrZ3FJWFVPZUd1aU9YM01STWlOTGw4ME1ONzVMVEFCT3hxb045?=
 =?utf-8?B?Qldoa3haTlFnL1A4RGFUUy9sNkZrRWgrZFJFcXZVWE82Zkw4VkNJYTQxOFQ3?=
 =?utf-8?B?dWU3ZjBDNEpNWjBmaE1oVERlN2dmZW14aSt3cm1LZlhaVU42aXRhWExwbFVn?=
 =?utf-8?B?dmE1SHg0aWlXVWlYV2FRVmppUTRvRmNqL1dBQ1lCS2R4M09OcTcxZnBsT3hu?=
 =?utf-8?B?dDBtamIxbTE2VmFPbEk2Z0JKSXlTVW9Jck9kWld3Uzh6d0NmbXBLUDJKSURW?=
 =?utf-8?B?YStndzVDMi9jWmZCUFFrMnYvd29tcWFZODRyQWhGbXRGZkVUck1oVzhVSG5p?=
 =?utf-8?B?dExEeTc0SUJpUFJCdTdTS2lUdXZjclIzOVpqMzNzQkkvRTgzY1RNYU9qRXNN?=
 =?utf-8?B?Wm9kT2xMd1hMT1I2RGZSQW15NzBIRmRkOVR2eERaR0ZwUFNYWG43S21RL1ZK?=
 =?utf-8?B?bFV4NUp4RTlJUGRKSTl2K1o3anFWdkxKMncxcFBBYk5raGNOTzhtZjNxZGF5?=
 =?utf-8?B?Zlc1dWx0dWFZZllYaUNCdCt0WUVkWFIvVU5UT1plT1ZBMDBQcFBaZkhHS05H?=
 =?utf-8?B?WFNYaFhtM3gydEU4UElCUHhJUUJKNmpMZk5ESXNMTDlTbFJBdFJPU3dvQjZQ?=
 =?utf-8?B?Uy9DMHJDT25NWUc3RTdJdXFYVzgreERabGRrWVR3VWdVY3YvbXhkSFpQWE9K?=
 =?utf-8?B?NHJlclpOT3AyUytEak82QjN4dkkvdVptQWRIQ1FkeFEyNE55ZG5uMiszZWZI?=
 =?utf-8?B?NEFYN2V1dkR5Z2E2bjl0MVdRaWo0TFFiUnFqcDVtaGhoYkZlazh1YU0vOWRS?=
 =?utf-8?B?SXR3czAxLzh1eFk0VDZvdVlCQXpWcFJQbllsZWVRVW5aaW1qNW5BWVpGRkM0?=
 =?utf-8?B?L1VnWGRvVXFKeEpkeHdkdGs2dFRIejJVVDBQMmZPMStCck82YWNESVd1L0tN?=
 =?utf-8?B?OGp3VTFBcVdlSDlUNGVZUGpUbkdvOFIxcDVKVnFrTnF4U1czWDhQYjM5SDRn?=
 =?utf-8?B?S2ZxcUpSajNlZmFpbGc3dzZ4SjZkd2ZsQllTOTZ0ZWpMSGwxNnh1QTIwWURl?=
 =?utf-8?B?MUgwUUdMYmduVm50dmI1RWFDalNsak1BbUxYNDhITDhoRERUbGVwOEVCWXJN?=
 =?utf-8?B?VENabkFyaUlEQ1RuN2QxWnZBd1hsT2cvWms5Mkd5NjloZlVpdEZmbDgvZlV4?=
 =?utf-8?B?UlFNTW5rbllSTWhHMG5RWHhqcmpmc0ttSE5VcDZwN1h2S0RHVFY3eHpWaEJs?=
 =?utf-8?B?YUZSUHFWVXRadGlMMkhNVEo1c1NiOFFmbjNMSjBxRHFTclFMTTZXQktoN3BQ?=
 =?utf-8?Q?eby7TDsFvTNIeymbWs=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GvK302PkKxoaFSzEm+mxgyQ9JVIKqlDxUGxkDEyCLy4tj+6F9TTyb7kUgkkO3sKma8KN6vTSnC3Gvtyg8vhDLPCQj0k1DUp+DsOGzxZ+BizKjSwt+A/Zpr4HLWLYtx7ju6q1Kz4I/Q5Gk0YaoUzafWXoTFnmE1ErXD9579mdXk9Mvex6YExYzrVJIqJlEzIo46BOxNUIr0ROQS6qAiaqtHVS8iyxZSGHRUcTFGBcyjGsc96ylbgXrhX+j9PmHbV2mEHPoWhjvK7dxFvwS/em19qjpAqiUlXwoWFi4c5G8EoD6V0wWOQNd0OyygCUmLzCYcPJJIkBOtQIzzyIKBu6NGm/Lfkqdwo9UHajsPLAY0EFtixYiDPwysHPvz3qoSnGfMJk9RtlVMM0Npsze7ee2b/EJ8t1otWNMOxsJCMDUug=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 10:51:50.5860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d91fba52-f6c1-4ff2-2ae3-08d6926a6f33
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMTktMDItMTMgYXQgMjI6MjUgLTAyMDAsIFJvZHJpZ28gUmliZWlybyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gDQo+IEVtIHRlciwgMjkgZGUgamFuIGRlIDIwMTkgw6BzIDA3
OjEwLCBBbGV4YW5kcnUgQXJkZWxlYW4gPGFyZGVsZWFuYWxleEBnbWFpDQo+IGwuY29tPiBlc2Ny
ZXZldToNCj4gPg0KPiA+IE9uIFNhdCwgSmFuIDI2LCAyMDE5IGF0IDg6MTMgUE0gSm9uYXRoYW4g
Q2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gRnJp
LCAyNSBKYW4gMjAxOSAyMjoxNDozMiAtMDIwMA0KPiA+ID4gUm9kcmlnbyBSaWJlaXJvIDxyb2Ry
aWdvcnNkY0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRW0gc2V4LCAyNSBkZSBq
YW4gZGUgMjAxOSDDoHMgMjE6NDYsIFJvZHJpZ28gUmliZWlybw0KPiA+ID4gPiA8cm9kcmlnb3Jz
ZGNAZ21haWwuY29tPiBlc2NyZXZldToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEVtIHNleCwgMjUg
ZGUgamFuIGRlIDIwMTkgw6BzIDA2OjIwLCBBbGV4YW5kcnUgQXJkZWxlYW4NCj4gPiA+ID4gPiA8
YXJkZWxlYW5hbGV4QGdtYWlsLmNvbT4gZXNjcmV2ZXU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gT24gVGh1LCBKYW4gMjQsIDIwMTkgYXQgOTozNSBQTSBSb2RyaWdvIFJpYmVpcm8gPHJvZHJp
Z29yc2RjQGdtDQo+IGFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiBSZW1vdmUgdGhlIGNoZWNrcGF0Y2gucGwgY2hlY2s6DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IENIRUNLOiAnUkVTRVZFUkQnIG1heSBiZSBtaXNzcGVsbGVkIC0gcGVyaGFwcyAnUkVT
RVJWRUQnPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEhleSwNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IEhpLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzIGZvciBhbnN3ZXJpbmcuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IEEgYml0IGN1cmlvcyBhYm91dCB0aGlzIG9uZS4NCj4gPiA+ID4g
PiA+IEFyZSB5b3UgdXNpbmcgdGhpcyBjaGlwL2RyaXZlciA/DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBObywgSSBhbSBqdXN0IGEgc3R1ZGVudCBhdCBVU1AgKFVuaXZlcnNpdHkgb2YgU8OjbyBQYXVs
bykgc3RhcnRpbmcNCj4gaW4gTGludXgNCj4gPiA+ID4gPiBLZXJuZWwgYW5kIGEgbmV3IG1lbWJl
ciBvZiB0aGUgVVNQIExpbnV4IEtlcm5lbCBncm91cCB0aGF0IGhhcw0KPiBjb250cmlidXRlZA0K
PiA+ID4gPiA+IGZvciBhIGZldyBtb250aHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoaW5n
IGlzOiB0aGUgcGFydCBpcyBuZWFyaW5nIEVPTCwgYW5kIGl0IGNvdWxkIGJlIGFuIGlkZWEgdG8N
Cj4gYmUNCj4gPiA+ID4gPiA+IG1hcmtlZCBmb3IgcmVtb3ZhbCAoc2luY2UgaXQncyBzdGlsbCBp
biBzdGFnaW5nKS4NCj4gPiA+ID4gPiA+IEJ1dCBpZiB0aGVyZSBhcmUgdXNlcnMgZm9yIHRoaXMg
ZHJpdmVyLCBpdCBjb3VsZCBiZSBsZWZ0IGFyb3VuZA0KPiBmb3IgYSB3aGlsZS4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IFRoaXMgaXMgbXkgZmlyc3QgcGF0Y2ggaW4gTGludXggS2VybmVsLCBidXQg
aWYgdGhlIGRyaXZlciB3aWxsIGJlDQo+IHJlbW92ZWQsIEkNCj4gPiA+ID4gPiBjYW4gc2VuZCBh
IHBhdGNoIGZvciBhbm90aGVyIGRyaXZlci4gSXMgdGhlcmUgYW55IGRyaXZlciB0aGF0IEkNCj4g
Y2FuDQo+ID4gPiA+ID4gZml4IGEgc3R5bGUgd2FybmluZz8NCj4gPiA+ID4NCj4gPiA+ID4gTWF5
YmUsIG9uZSBjaGVja3N0eWxlIHBhdGNoIGlzIGVub3VnaCwgcmlnaHQ/IFdoaWNoIGRyaXZlcnMg
Y2FuIEkNCj4gdHJ1bHkNCj4gPiA+ID4gY29udHJpYnV0ZSB0bz8NCj4gPiA+DQo+ID4gPiBIb3cg
YWJvdXQgdGhlIGFkNzE1MD/CoCBUaGF0IG9uZSBpcyBzdGlsbCBsaXN0ZWQgYXMgcHJvZHVjdGlv
bi4NCj4gPiA+IFdoYXQgZG8geW91IHRoaW5rIEFsZXgsIHlvdSBwcm9iYWJseSBoYXZlIGJldHRl
ciB2aXNpYmlsaXR5IG9uIHRoZQ0KPiA+ID4gc3RhdHVzIG9mIHRoZXNlIHBhcnRzIGFuZCB0aGVp
ciBkcml2ZXJzIHRoYW4gSSBkbyENCj4gPiA+DQo+ID4gPiAobm90ZSBJIGhhdmVuJ3QgZXZlbiBv
cGVuZWQgdGhhdCBvbmUgZm9yIGEgZmV3IHllYXJzIHNvIG5vIGlkZWENCj4gPiA+IHdoYXQgc3Rh
dGUgdGhlIGRyaXZlciBpcyBpbiEpDQo+ID4gPg0KPiA+DQo+ID4gYWQ3MTUwIGlzIGEgZ29vZCBh
bHRlcm5hdGl2ZS4NCj4gPiBBdCBhIGZpcnN0IGdsYW5jZSBvdmVyIHRoZSBkcml2ZXIgaXQgbG9v
a3MgbGlrZSBpdCBjb3VsZCBkbyB3aXRoIHNvbWUNCj4gPiBwb2xpc2gvY29udmVyc2lvbnMgdG8g
bmV3ZXIgSUlPIGNvbnN0cnVjdHMgKGxpa2UgSUlPIHRyaWdnZXJzLCBtYXliZQ0KPiA+IHNvbWUg
bmV3ZXIgZXZlbnQgaGFuZGxpbmcgbWVjaGFuaXNtcz8pLg0KPiA+IEknbGwgc3luYyB3aXRoIFN0
ZWZhbiBbUG9wYV0gdG8gc2VlIGFib3V0IHRoaXMgc3R1ZmYgYXQgYSBsYXRlciBwb2ludA0KPiBp
biB0aW1lLg0KPiA+DQo+ID4gSSdkIGFsc28gYWRkIGhlcmUgdGhlIGFkeGwzNDUgZHJpdmVyLg0K
PiA+IFRoaXMgaXMgbW9zdGx5IGluZm9ybWF0aW9uYWwgZm9yIGFueW9uZSB3aG8nZCBmaW5kIHRo
aXMgaW50ZXJlc3RpbmcuDQo+ID4gVGhlcmUgYXJlIDIgZHJpdmVycyBmb3IgdGhpcyBjaGlwLCBv
bmUgaW4gSUlPDQo+ID4gW2RyaXZlcnMvaWlvL2FjY2VsL2FkeGwzNDVdIGFuZCBhbm90aGVyIG9u
ZSBpbg0KPiA+ICJkcml2ZXJzL21pc2MvYWR4bDM0eC5jIiBhcyBwYXJ0IG9mIHRoZSBpbnB1dCBz
dWItc3lzdGVtLg0KPiA+IFdoYXQgd291bGQgYmUgaW50ZXJlc3RpbmcgaGVyZSBpcyB0byBmaW5h
bGl6ZSB0aGUgSUlPIGRyaXZlciBbIEkgdGhpbmsNCj4gPiBzb21lIGZlYXR1cmVzIGFyZSBsYWNr
aW5nIGJlaGluZCB0aGUgaW5wdXQgZHJpdmVyXSwgYW5kIG1ha2UgdGhlIGlucHV0DQo+ID4gZHJp
dmVyIGEgY29uc3VtZXIgb2YgdGhlIElJTyBkcml2ZXIuDQo+ID4NCj4gPiBGcm9tIG15IHNpZGUs
IGJvdGggdGhlc2UgdmFyaWFudHMgYXJlIGZpbmUgdG8gdGFrZSBvbi4NCj4gPiBUaGUgYWQ3MTUw
IGlzIGEgZ29vZCBpZGVhIGFzIGEgc3RhcnRlciBwcm9qZWN0LCBhbmQgdGhlIGFkeGwgb25lIGlz
DQo+ID4gbW9yZSBvZiBhIGxvbmctdGVybSBtZWRpdW0tbGV2ZWwgcHJvamVjdC4NCj4gPg0KPiA+
IFRoYW5rcw0KPiA+IEFsZXgNCj4gPg0KPiANCj4gSGkgQWxleCwgdGhhbmtzIGZvciBzdWdnZXN0
aW9ucy4NCj4gDQo+IEkgcmVhZCB0aGUgSUlPIHRyaWdnZXIgZG9jdW1lbnRhdGlvbsKgDQo+ICho
dHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0LjEyL2RyaXZlci1hcGkvaWlvL3RyaWdn
ZXJzLmh0bWwpIGFuZA0KPiBhc2sgb25lIHF1ZXN0aW9uOiBXaGF0IGlzIHRoZSBkaWZmZXJlbmNl
IGJldHdlZW4gZXZlbnRzIGFuZCB0cmlnZ2Vycz/CoA0KPiBUaGV5IGFyZSBzb3VuZHMgbWUgc2Ft
ZSB0aGluZ3MuDQo+IA0KPiBJIGFtIHRyeWluZyB0byB1bmRlcnN0YW5kIGhvdyB0byBpbXBsZW1l
bnQgYSBJSU8gdHJpZ2dlciBieSByZWFkaW5nDQo+IHRoZSBJSU8gU2ltcGxlIER1bW15IGNvZGUg
YnV0IHRoaXMgZHJpdmVyIGRvZXMgbm90IGltcGxlbWVudHMgSUlPDQo+IHRyaWdnZXJzDQo+IGJ1
dCBvbmx5IElJTyBldmVudHMuIElzIHRoZXJlIGEgZGlkYWN0aWMgZXhhbXBsZSBsaWtlIElJTyBT
aW1wbGUgRHVtbXkNCj4gdGhhdCBpbXBsZW1lbnRzIElJTyB0cmlnZ2Vycz8NCj4gDQo+IFRoYW5r
cw0KPiBSb2RyaWdvDQo+IA0KDQpIaSBSb2RyaWdvLA0KDQpGcm9tIHdoYXQgSSBrbm93LCBJSU8g
RXZlbnRzIGFyZSBub3QgdXNlZCBmb3IgcGFzc2luZyByZWFkaW5ncyBmcm9tIGRldmljZXMNCnRv
IHVzZXJzcGFjZSwgYnV0IHJhdGhlciBvdXQgb2YgYm91bmRzIGluZm9ybWF0aW9uIHN1Y2ggYXMg
Y3Jvc3Npbmcgb2YNCnZvbHRhZ2UgdGhyZXNob2xkcywgcHJveGltaXR5IGRldGVjdGlvbiwgbW90
aW9uIGRldGVjdGlvbiwgZXRjLg0KVHJpZ2dlcnMgYXJlIHR5cGljYWxseSB1c2VkIHRvIGRldGVy
bWluZSB3aGVuIHZhbGlkIGRhdGEgY2FuIGJlIHJlYWQgZnJvbSBhDQpkZXZpY2Ugd2hpY2ggaXMg
dGhlbiBzdG9yZWQgaW4gdGhlIGJ1ZmZlci4NCg0KQWZ0ZXIgYSBxdWljayBsb29rIG92ZXIgdGhl
IEFENzE1MCwgSSB0aGluayB0aGF0IHVzaW5nIElJTyBldmVudHMsIG1pZ2h0IGJlDQp0aGUgY29y
cmVjdCBhcHByb2FjaCwgc2luY2UgaXQgaXMgYSBwcm94aW1pdHkgc2Vuc2luZyBkZXZpY2UuwqAN
Cg0KLVN0ZWZhbg0KDQo+ID4gPiBKb25hdGhhbg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiBU
aGFua3MNCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRW0gc2V4LCAyNSBkZSBqYW4g
ZGUgMjAxOSDDoHMgMDY6MjAsIEFsZXhhbmRydSBBcmRlbGVhbg0KPiA+ID4gPiA+IDxhcmRlbGVh
bmFsZXhAZ21haWwuY29tPiBlc2NyZXZldToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPbiBU
aHUsIEphbiAyNCwgMjAxOSBhdCA5OjM1IFBNIFJvZHJpZ28gUmliZWlybyA8cm9kcmlnb3JzZGNA
Z20NCj4gYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFJlbW92
ZSB0aGUgY2hlY2twYXRjaC5wbCBjaGVjazoNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
Q0hFQ0s6ICdSRVNFVkVSRCcgbWF5IGJlIG1pc3NwZWxsZWQgLSBwZXJoYXBzICdSRVNFUlZFRCc/
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSGV5LA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IEEgYml0IGN1cmlvcyBhYm91dCB0aGlzIG9uZS4NCj4gPiA+ID4gPiA+IEFyZSB5b3UgdXNpbmcg
dGhpcyBjaGlwL2RyaXZlciA/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpbmcgaXM6IHRo
ZSBwYXJ0IGlzIG5lYXJpbmcgRU9MLCBhbmQgaXQgY291bGQgYmUgYW4gaWRlYSB0bw0KPiBiZQ0K
PiA+ID4gPiA+ID4gbWFya2VkIGZvciByZW1vdmFsIChzaW5jZSBpdCdzIHN0aWxsIGluIHN0YWdp
bmcpLg0KPiA+ID4gPiA+ID4gQnV0IGlmIHRoZXJlIGFyZSB1c2VycyBmb3IgdGhpcyBkcml2ZXIs
IGl0IGNvdWxkIGJlIGxlZnQgYXJvdW5kDQo+IGZvciBhIHdoaWxlLg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiA+ID4gQWxleA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBSaWJlaXJvIDxyb2Ry
aWdvcnNkY0BnbWFpbC5jb20+DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBU
c3VoYSA8cmFmYWVsLnRzdWhhQHVzcC5icj4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
PiA+IFRoaXMgbWFjcm8gaXMgbm90IHVzZWQgYW55d2hlcmUuIFNob3VsZCB3ZSBqdXN0IGNvcnJl
Y3QgdGhlDQo+ID4gPiA+ID4gPiA+IHNwZWxsaW5nIG9yIHJlbW92ZSB0aGUgbWFjcm8/DQo+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IMKgZHJpdmVycy9zdGFnaW5nL2lpby9jZGMvYWQ3MTUy
LmMgfCAyICstDQo+ID4gPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3N0YWdpbmcvaWlvL2NkYy9hZDcxNTIuYw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9p
aW8vY2RjL2FkNzE1Mi5jDQo+ID4gPiA+ID4gPiA+IGluZGV4IDI1ZjUxZGIuLmM5ZGE2ZDQgMTAw
NjQ0DQo+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vY2RjL2FkNzE1Mi5j
DQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vY2RjL2FkNzE1Mi5jDQo+
ID4gPiA+ID4gPiA+IEBAIC0zNSw3ICszNSw3IEBADQo+ID4gPiA+ID4gPiA+IMKgI2RlZmluZSBB
RDcxNTJfUkVHX0NIMl9HQUlOX0hJR0ggwqAgwqAgwqAgMTINCj4gPiA+ID4gPiA+ID4gwqAjZGVm
aW5lIEFENzE1Ml9SRUdfQ0gyX1NFVFVQIMKgIMKgIMKgIMKgIMKgIDE0DQo+ID4gPiA+ID4gPiA+
IMKgI2RlZmluZSBBRDcxNTJfUkVHX0NGRyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxNQ0KPiA+
ID4gPiA+ID4gPiAtI2RlZmluZSBBRDcxNTJfUkVHX1JFU0VWRVJEIMKgIMKgIMKgIMKgIMKgIMKg
MTYNCj4gPiA+ID4gPiA+ID4gKyNkZWZpbmUgQUQ3MTUyX1JFR19SRVNFUlZFRCDCoCDCoCDCoCDC
oCDCoCDCoDE2DQo+ID4gPiA+ID4gPiA+IMKgI2RlZmluZSBBRDcxNTJfUkVHX0NBUERBQ19QT1Mg
wqAgwqAgwqAgwqAgwqAxNw0KPiA+ID4gPiA+ID4gPiDCoCNkZWZpbmUgQUQ3MTUyX1JFR19DQVBE
QUNfTkVHIMKgIMKgIMKgIMKgIMKgMTgNCj4gPiA+ID4gPiA+ID4gwqAjZGVmaW5lIEFENzE1Ml9S
RUdfQ0ZHMiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDI2DQo+ID4gPiA+ID4g
PiA+IC0tDQo+ID4gPiA+ID4gPiA+IDIuNy40DQo+ID4gPiA+ID4gPiA+DQo+ID4gPg==
