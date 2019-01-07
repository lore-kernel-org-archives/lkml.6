Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167E6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C182E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HVLviGU3";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="sFThpTfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAGUpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:45:02 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45116 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbfAGUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:45:01 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x07KeGLs009101;
        Mon, 7 Jan 2019 12:43:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8otvqqtHb29KJlfdbs5NoTEETaa82dYhxEK6dwodD7U=;
 b=HVLviGU3q3xsO4fcYzT15a4Y5p5Af40EeZqQYQlUUaZ4oowgLF/qB2lEK3J8YqWZ6/HU
 l7idb0e8jS7CoRN0WOkH69OIbBiynolFgilP1Tx+D29zGO7LzsnmR7GbAJKivlF3Deu7
 Hl4UtOzM9kgwIxb+GzNkjcBir40nfKHNDQkW+QJuAtAQ2y2y6hCXx0KV7LnXo/TmDcKo
 arkyeQ/tdf35ZnR6QL3QFeIIXR8bZaCp7Oa4IVe/ipfdm/JbNo2XkycF2iqnO5wxmJqp
 Op055q/1qYDKUUnunLoEW6YpNX9Gg6VTECbLJtWmlKP7AiqKTvWzpEhrpeuCxpeB5UgC cg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2pv58st04j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Jan 2019 12:43:51 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 7 Jan
 2019 12:43:50 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Jan 2019 12:43:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8otvqqtHb29KJlfdbs5NoTEETaa82dYhxEK6dwodD7U=;
 b=sFThpTfppyaxiUos6/YtlWW9FxVasmKMhkk1etJdNgDLk5hdgEQyiJDjtTDkwneqeGqkJe5+U82wehpX7+ZnwnKWN7yWSO4tHxmj1G12+vK5paV8Df8SZF+3JFFHbQw6swzfc8uoaKAbp1Gh1OVy09idqqx+OFzGySO1fiBWdzY=
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2453.namprd18.prod.outlook.com (20.179.92.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 20:43:46 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 20:43:46 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        "Alexander Graf" <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        "Christoph Muellner" <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Florian Weimer" <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        "Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Thread-Topic: [PATCH v9 00/24] ILP32 for ARM64
Thread-Index: AQHUpsmv+58npX8bJEqbH9XEHunGfA==
Date:   Mon, 7 Jan 2019 20:43:46 +0000
Message-ID: <20190107204336.GB25178@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190107155028.GA25178@yury-thinkpad>
 <DC9A951E-B638-4820-8499-02D5322E7DF7@amacapital.net>
In-Reply-To: <DC9A951E-B638-4820-8499-02D5322E7DF7@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:7:16::36) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR18MB2453;20:ZMoYBuwD/nLZSNI8BGplUeA/cHKeABKDJ+Hnihw6b372YRcrm/aUBNhDnoDm44B5sOQsYLz8nCmNy5rzmbkpsIhP/e2Xo9Ri0wYdAQzOteK5k+cwYJXNji/mYPS/f+OV0lRthWJTbORVwV1OUd2HSL4ivjKeiLC6wduabGafQbs=
x-ms-office365-filtering-correlation-id: 952b9c69-9829-4e46-89a1-08d674e0d153
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2453;
x-ms-traffictypediagnostic: BYAPR18MB2453:
x-microsoft-antispam-prvs: <BYAPR18MB24539933BDFA361AAF31B033CB890@BYAPR18MB2453.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR18MB2453;BCL:0;PCL:0;RULEID:;SRVR:BYAPR18MB2453;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(346002)(376002)(136003)(396003)(39850400004)(53754006)(189003)(199004)(97736004)(26005)(33656002)(39060400002)(478600001)(68736007)(486006)(25786009)(14454004)(106356001)(966005)(7416002)(7406005)(305945005)(6116002)(4326008)(6436002)(3846002)(186003)(105586002)(1076003)(99286004)(102836004)(6246003)(66066001)(6916009)(7736002)(6486002)(8676002)(6506007)(386003)(33896004)(53546011)(6306002)(9686003)(6512007)(5660300001)(14444005)(256004)(53936002)(52116002)(81166006)(81156014)(8936002)(446003)(316002)(2906002)(476003)(229853002)(11346002)(86362001)(71190400001)(76176011)(33716001)(54906003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2453;H:BYAPR18MB2888.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RYQC9HxBqGGZS0QPGuFSxo+Gbij7gE/eDyluvZwaV2m8/vFtPKa9BHmWUZ+WXI6phV9WgS74BvkaRTaI9/T8GveryDs6y8aS/gYs6FfeNHvuHp/vrrNyBWkiIwyCXmRJkOVsyH3m2329arRtP0lyYWWSaEvH+asQ6Hy3KJ5YV6XQDXzQv4j6a3XTqOWvge0TTOj0R74eGhtTF4fcppNY6UJaWtb2INFNOxAoBGFwtr1wY4jp20OhHmKsWdDmWTBc3Qk2nQhgZ0Z/51CUDFoGJbxWDRAvv5gxAuUCoYBm5vzGvb3Wa8UKQrp8NQh5fHtc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1DBAF8345D5D438A0F2FFD218A7497@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b9c69-9829-4e46-89a1-08d674e0d153
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 20:43:46.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2453
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMDcsIDIwMTkgYXQgMDk6NDg6NDRBTSAtMDgwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOg0KPiANCj4gDQo+ID4gT24gSmFuIDcsIDIwMTksIGF0IDc6NTAgQU0sIFl1cmkgTm9y
b3YgPHlub3JvdkBtYXJ2ZWxsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSGkgYWxsLA0KPiA+IA0K
PiA+PiBPbiBXZWQsIE1heSAxNiwgMjAxOCBhdCAxMToxODo0NUFNICswMzAwLCBZdXJ5IE5vcm92
IHdyb3RlOg0KPiA+PiBUaGlzIHNlcmllcyBlbmFibGVzIEFBUkNINjQgd2l0aCBJTFAzMiBtb2Rl
Lg0KPiA+PiANCj4gPj4gQXMgc3VwcG9ydGluZyB3b3JrLCBpdCBpbnRyb2R1Y2VzIEFSQ0hfMzJC
SVRfT0ZGX1QgY29uZmlndXJhdGlvbg0KPiA+PiBvcHRpb24gdGhhdCBpcyBlbmFibGVkIGZvciBl
eGlzdGluZyAzMi1iaXQgYXJjaGl0ZWN0dXJlcyBidXQgZGlzYWJsZWQNCj4gPj4gZm9yIG5ldyBh
cmNoZXMgKHNvIDY0LWJpdCBvZmZfdCB1c2Vyc3BhY2UgdHlwZSBpcyB1c2VkIGJ5IG5ldyB1c2Vy
c3BhY2UpLg0KPiA+PiBBbHNvIGl0IGRlcHJlY2F0ZXMgZ2V0cmxpbWl0IGFuZCBzZXRybGltaXQg
c3lzY2FsbHMgcHJpb3IgdG8gcHJsaW1pdDY0Lg0KPiA+PiANCj4gPj4gQmFzZWQgb24ga2VybmVs
IHY0LjE2LiBUZXN0ZWQgd2l0aCBMVFAsIGdsaWJjIHRlc3RzdWl0ZSwgdHJpbml0eSwgbG1iZW5j
aCwNCj4gPj4gQ1BVU3BlYy4NCj4gPj4gDQo+ID4+IFRoaXMgc2VyaWVzIG9uIGdpdGh1YjogDQo+
ID4+IGh0dHBzOi8vZ2l0aHViLmNvbS9ub3Jvdi9saW51eC90cmVlL2lscDMyLTQuMTYNCj4gPj4g
TGluYXJvIHRvb2xjaGFpbjoNCj4gPj4gaHR0cDovL3NuYXBzaG90cy5saW5hcm8ub3JnL2NvbXBv
bmVudHMvdG9vbGNoYWluL2JpbmFyaWVzLzcuMy0yMDE4LjA0LXJjMS9hYXJjaDY0LWxpbnV4LWdu
dV9pbHAzMi8NCj4gPj4gRGViaWFuIHJlcG86DQo+ID4+IGh0dHA6Ly9wZW9wbGUubGluYXJvLm9y
Zy9+d29va2V5L2lscDMyLw0KPiA+PiBPcGVuU1VTRSByZXBvOg0KPiA+PiBodHRwczovL2J1aWxk
Lm9wZW5zdXNlLm9yZy9wcm9qZWN0L3Nob3cvZGV2ZWw6QVJNOkZhY3Rvcnk6Q29udHJpYjpJTFAz
Mg0KPiA+PiANCj4gPj4gQ2hhbmdlczoNCj4gPj4gdjM6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDE0LzkvMy83MDQNCj4gPj4gdjQ6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE1LzQvMTMvNjkx
DQo+ID4+IHY1OiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNS85LzI5LzkxMQ0KPiA+PiB2Njog
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTYvNS8yMy82NjENCj4gPj4gdjc6IGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE3LzEvOS8yMTMNCj4gPj4gdjg6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDE3LzYvMTkvNjI0DQo+ID4+IHY5OiAtIHJlYmFzZWQgb24gdG9wIG9mIHY0LjE2Ow0KPiA+PiAg
ICAtIHNpZ25hbCBzdWJzeXN0ZW0gcmV3b3JrZWQgdG8gYXZvaWQgY29kZSBkdXBsaWNhdGlvbiwg
YXMgcmVxdWVzdGVkDQo+ID4+ICAgICAgYnkgRGF2ZSBNYXJ0aW4gKHBhdGNoZXMgMTggYW5kIDIw
KTsNCj4gPj4gICAgLSBuZXcgZmlsZXMgaW50cm9kdWNlZCBpbiBzZXJpZXMgdXNlIFNQRFggbm90
YXRpb24gZm9yIGxpY2Vuc2U7DQo+ID4+ICAgIC0gbGludXgtYXBpIGFuZCBsaW51eC1hcmNoIEND
ZWQgYXMgdGhlIHNlcmllcyBjaGFuZ2VzIGtlcm5lbCBBQkk7DQo+ID4+ICAgIC0gY2hlY2twYXRj
aCBhbmQgb3RoZXIgbWlub3IgZml4ZXMuDQo+ID4+ICAgIC0gWmhvdSBDaGVuZ21pbmcncyByZXBv
cnRlZC1ieSBmb3IgcGF0Y2ggMiBhbmQgc2lnbmVkLW9mZi1ieSBmb3INCj4gPj4gICAgICBwYXRj
aCAyMSByZW1vdmVkIGJlY2F1c2UgaGlzIGVtYWlsIGJlY2FtZSBpbnZhbGlkLiBaaG91LCBwbGVh
c2UNCj4gPj4gICAgICBzaGFyZSB5b3VyIG5ldyBlbWFpbC4NCj4gPiANCj4gPiBUaGlzIGlzIDQu
MjAtYmFzZWQgdmVyc2lvbi4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vbm9yb3YvbGludXgvdHJl
ZS9pbHAzMi00LjIwDQo+ID4gDQo+ID4gVGhlcmUncyBubyBpbXBvcnRhbnQgY2hhbmdlcyBjb21w
YXJpbmcgdG8gNC4xOSwgYnV0IEkgd291bGQgbGlrZSB0byByZW1pbmQNCj4gPiB0aGF0IHRoaXMg
c2VyaWVzIGNvbnRhaW5zIHNvbWUgZ2VuZXJpYyBhcmNoIHBhdGNoZXMgdGhhdCBBQ0tlZCwgYnV0
IHN0aWxsDQo+ID4gbm90IHVwc3RyZWFtZWQ6DQo+ID4gWXVyeSBOb3JvdiAgICAgIGFzbS1nZW5l
cmljOiBEcm9wIGdldHJsaW1pdCBhbmQgc2V0cmxpbWl0IHN5c2NhbGxzIGZyb20gZGVmYXVsdCBs
aXN0DQo+ID4gWXVyeSBOb3JvdiAgICAgIDMyLWJpdCB1c2Vyc3BhY2UgQUJJOiBpbnRyb2R1Y2Ug
QVJDSF8zMkJJVF9PRkZfVCBjb25maWcgb3B0aW9uDQo+ID4gWXVyeSBOb3JvdiAgICAgIGNvbXBh
dCBBQkk6IHVzZSBub24tY29tcGF0IG9wZW5hdCBhbmQgb3Blbl9ieV9oYW5kbGVfYXQgdmFyaWFu
dHMNCj4gPiBKYW1lcyBNb3JzZSAgICAgcHRyYWNlOiBBZGQgY29tcGF0IFBUUkFDRV97RyxTfUVU
U0lHTUFTSyBoYW5kbGVycw0KPiA+IERhdmUgTWFydGluICAgICBhcm02NDogc2lnbmFsOiBNYWtl
IHBhcnNlX3VzZXJfc2lnZnJhbWUoKSBpbmRlcGVuZGVudCBvZiBydF9zaWdmcmFtZSBsYXlvdXQN
Cj4gPiANCj4gPiBQbGVhc2UgYWxzbyBub3RpY2UgdGhhdCBteSBlbWFpbCBhZGRyZXNzIGlzIGNo
YW5nZWQsIGZyb20gbm93IGl0J3MNCj4gPiB5bm9yb3ZAbWFydmVsbC5jb20NCj4gPiANCj4gDQo+
IEhhdmluZyBzcGVudCBzb21lIHRpbWUgaGF0aW5nIHgzMiBsYXRlbHksIGhlcmUgaXMgYSBjdXJz
b3J5IHJldmlldzoNCg0KSSBmb2xsb3dlZCB0aGUgcmVjZW50IGRpc2N1c3Npb24gb24geDMyIGRy
b3AsIGJ1dCBJIGRvbid0IHRyYWNrIHRoZSBzdG9yeQ0KZnJvbSB0aGUgYmVnaW5uaW5nLiBDYW4g
eW91IHN1bW1hcml6ZSB5b3VyIGNvbXBsYWlucyBoZXJlIChvciBtYXliZSBpbg0KcGF0Y2ggZm9y
IERvY3VtZW50YXRpb24pPyBJdCB3aWxsIGJlIGdvb2QgZm9yIGlscDMyIGJlY2F1c2Ugd2Ugd2ls
bCBjaGVjaw0KdGhlIHNlcmllcyBhZ2FpbnN0IGFsbCBwb3NzaWJsZSBwcm9ibGVtcywgYW5kIGl0
IHdpbGwgYmUgZ29vZCBmb3IgaGlzdG9yeQ0KYmVjYXVzZSBmdXR1cmUgY29tcGF0IGFyY2hpdGVj
dHVyZXMgZGV2ZWxvcGVycyB3aWxsIGJlIGF3YXJlLg0KDQpPbiB5b3VyIGZvbGxvd2luZyBxdWVz
dGlvbnMsIEknbGwgdHJ5IGFuc3dlciBhY2NvcmRpbmcgdG8gbXkgdW5kZXJzdGFuZGluZy4NCklm
IGl0J3Mgd3Jvbmcgb3IgaW5jb21wbGV0ZSwgSSBraW5kbHkgYXNrIG90aGVycyBmaXggbWUuDQoN
Cj4gWW91IHNheSDigJxJTFAzMiBoYXMgY29udGV4dC1yZWxhdGVkIHN0cnVjdHVyZXMgZGlmZmVy
ZW50IGZyb20gYm90aCBhYXJjaDMyIGFuZA0KPiBhYXJjaDY0L2xwNjQu4oCdICBXaHk/ICBXaHkg
bm90IGp1c3QgdXNlIHRoZSBscDY0IGNvbnRleHQgc3RydWN0dXJlPw0KDQpCZWNhdXNlIHRoZSBh
bHRlcm5hdGl2ZSBpcyBub3RoaW5nIGJldHRlciB0aGFuIGhvdyB3ZSBkbyBub3cuIFdlIGNhbiBt
YWtlDQpydF9zaWdmcmFtZSBmb3IgaWxwMzIgbG9vayBleGFjdGx5IGxpa2UgbHA2NC4gQnV0IG9u
IHVzZXIgc2lkZSB3ZSB3aWxsDQpoYXZlIHRvIGFkZCBwYWRzIHRoZXJlZm9yZS4gT24gdGhlIGtl
cm5lbCBzaWRlLCBiZWZvcmUgcGFzc2luZyBydF9zaWdmcmFtZQ0KdG8ga2VybmVsLCB3ZSB3aWxs
IGhhdmUgdG8gbWFrZSBzdXJlIHRoYXQgcGFkcyBhcmUgemVyb2VkLCBqdXN0IGxpa2Ugd2UgZG8N
CndpdGggeDAteDcgaW4gZGVsb3VzZV9wdF9yZWdzKCkgYmVmb3JlIHBhc3Npbmcgc3lzY2FsbCBh
cmd1bWVudHMgdG8gaGFuZGxlcnMuDQpTbyB3ZSBjYW5ub3QgZ2V0IHJpZCBvZiBnZXQvc2V0X3Np
Z2ZyYW1lKCkgY29udmVydGVycyBpbiB0aGlzIGNhc2UuDQoNCkN1cnJlbnQgYXBwcm9hY2ggbGV0
cyB1cyBrZWVwIHVzZXIgcGFydCBsb29raW5nIG1vcmUgbmF0dXJhbCwgYW5kIG9uDQprZXJuZWwg
c2lkZSB3ZSBkb24ndCBhZGQgY29tcGxleGl0eSBiZWNhdXNlIHdlIHJldXNlIGV4aXN0aW5nIGFh
cmNoMzINCm9yIGV4aXN0aW5nIGxwNjQgaGFuZGxlcnMsIGFuZCBkb24ndCBpbnZlbnQgc29tZXRo
aW5nIG5ldy4NCg0KPiBEbyB5b3UgaGF2ZSBzb21lIG9iamVjdGlvbiB0byBsZXR0aW5nIGdyZWdf
dCBiZSBhIHU2NCBvbiBpbHAzMj8NCg0KSW4gYmluZm10X2lscDMyLmMgd2UNCiAgICAgICAgI2Rl
ZmluZSBjb21wYXRfZWxmX2dyZWdzZXRfdCAgICBlbGZfZ3JlZ3NldF90DQpTbyBpbiBmYWN0IHdl
IHVzZSA2NC1iaXQgZ3JlZ3NldC4gT3IgSSBtaXN1bmRlcnN0b29kIHlvdT8NCg0KPiBTaW5jZSB5
b3UgY2Fu4oCZdCB0ZWxsIExQNjQgYW5kIElMUDMyIHN5c2NhbGxzIGFwYXJ0IGJ5IG51bWJlciwg
eW91IG5lZWQgdG8gYWRkDQo+IGFuZCB3aXJlIHVwIGEgbmV3IEFVRElUX0FSQ0ggdmFsdWUgZm9y
IElMUDMyLiBzeXNjYWxsX2dldF9hcmNoKCkgbmVlZHMgdG8gd29yayBjb3JyZWN0bHkuDQoNClRo
YW5rcyBmb3IgcG9pbnRpbmcgdG8gdGhpcy4gSSdsbCBhcHBlbmQgQVVESVRfQVJDSCBwYXRjaCB0
byB0aGlzIHNlcmllcy4NCg0KWXVyeQ0K
