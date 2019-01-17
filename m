Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D842C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BE3205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="soZu0BNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfAQQJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:09:37 -0500
Received: from mail-eopbgr720077.outbound.protection.outlook.com ([40.107.72.77]:42592
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728448AbfAQQJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSJTuAUkof/v4mX9NatQcrmRngz0wVmViznedB8xZOw=;
 b=soZu0BNelFeEE/m5vLb2EAEYb3iD1fVFqc4AwownrdT1Du7V20sxcurgfFrTZAbwHu9Swmm4FXsspzaTmpLWJccdRk21RESGVXj77+FPiQIVcAeE8/3V6psSS2vKfA8FQ/e28/1QccWcYHkptisgC9PzqrI40EXCCSQb7PLzGLA=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4725.namprd02.prod.outlook.com (52.135.232.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Thu, 17 Jan 2019 16:09:31 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::b99c:d66c:95dd:5a7b]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::b99c:d66c:95dd:5a7b%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 16:09:31 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>
CC:     Michal Simek <michals@xilinx.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        sundeep subbaraya <sundeep.lkml@gmail.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Topic: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Index: AQHUltf+YluIb4uVqUmedk5eQWaR76Wxt22AgAIUbRA=
Date:   Thu, 17 Jan 2019 16:09:31 +0000
Message-ID: <BYAPR02MB5591E4BF4C547C3E29D9CF8AA7830@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1545140733-20689-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <b521679a-0c79-44b1-8a2b-1f3391a362ae@ti.com>
In-Reply-To: <b521679a-0c79-44b1-8a2b-1f3391a362ae@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4725;6:YiNQcLP1HkR/ljunmpHXuQXyjJHdByZttQcRL44vXM0MBRyD0aPpAH3y3ajN5G9/c/idGJzfNGJaVBkgR3qTZ1iCLLYiy3s9DrAvv60op1JH5IrlAbRhvmblI4CgxCNTeixtuYj8rz1rhT203R+bUx7mu/qqLCE6rZ/vZYmT4deuEEGTaBISbygexugBIOvEbMR3kdBA97A4HNBiyfmmYxdmc4qpbyQMIHUmMfutlRouqjytgkDfhal+GseA1zFho7OoGtWOKIDX+ZQHiYWhjWdO2IMC4tREyty/V5GDBwZ+ZDJngr0MBkbkIwQnOZTnEWVrYtVxTkyBYsybvoNeLb+uAJ60yxkeV9YyJWFKvqdG+JgwzgdtAFxzUQlcqwUJYOpiz0TNOgksyMcFqA/rUrvhI0o4edtZknDWMCqei3FLCPrwWfx4ezzoz3/fKggO3Q9oHzwP1SRNNtxbl9PTXA==;5:12PCb/WiLnkpg12xMXhnzvCDGfcyG8xEkG+/mApDrfGHcrcxJibfAIK+4EWo1/Wt3x4L+rvfuudo/8cBF4pXxAVyM4q/+uRVeuEo7gBXtT1GJxtB7DJLeen/tnGBD2wBtDayaLA27MSVhezttIhg/DQddcjVUbVn4ddZ/1hMvmoVb7LgqN5MGlqR6VQXXBLiZ0+ryFCUJbKpblBaYQhZ3A==;7:P8+Jw4M6KcbtibBlDSZY1vX6usf79qHc6uktxRFWvI5ViZaURsC6A+AvoDwLjMCouA2Fkn3N9Zx/LXaSWmbYvuj2qMReMFImKV1oGKS1Y0MeC8Em5BRYuX5GoNneeG7ProHTF94gUVlor11eD58sEA==
x-ms-office365-filtering-correlation-id: 1c627370-94e4-4ede-e665-08d67c962a49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4725;
x-ms-traffictypediagnostic: BYAPR02MB4725:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB47255D963DC23755196EC473A7830@BYAPR02MB4725.namprd02.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(13464003)(110136005)(478600001)(316002)(99286004)(86362001)(54906003)(6246003)(7736002)(97736004)(305945005)(6506007)(256004)(68736007)(26005)(229853002)(186003)(8936002)(81156014)(81166006)(102836004)(74316002)(8676002)(76176011)(486006)(7696005)(53936002)(5660300001)(105586002)(39060400002)(55016002)(25786009)(106356001)(33656002)(2501003)(2906002)(446003)(11346002)(476003)(66066001)(4326008)(6436002)(6116002)(3846002)(71190400001)(71200400001)(9686003)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4725;H:BYAPR02MB5591.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vLWvBHbSwL5KglisbKYa2uTAmBQws4irJ3huP9/5GJvdppeqBYowHShaFw+ciwJ8pJ7XRUo+/bJu4g9r5tjjOlrF/llidOzUf6II4nCAZ0yGWIsK7nj+VdIoRpN71OhMDPfLylrzHTtXKO00J3zQjuQE6bWkm85Aq8YUeMzpziYZbQ9oONfn7hk3KjdHhFe9kPEJIuJ02UjasdrTBvHOoVcMu8wD9OJ6fjHmlremKUdA4mfkO1oWQPce5jaH4vSuubInit1Mj5nXVzgWlAZyfMwmqA9oDu6frVdIBxBaGR8XpJ+Nb495cGFEXGnPhyqlIbMVGRbLy089+HQVyJ8P3xpdWoGmYuEz2xYCuP6N6lCN1tKNyARTdDDkfqFX6oJWAV6iYg8rcUTmxsQqlTEMNYYPSszo4OQ5eUDrjyyoDrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c627370-94e4-4ede-e665-08d67c962a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 16:09:31.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBLaXNob24g
VmlqYXkgQWJyYWhhbSBJIFttYWlsdG86a2lzaG9uQHRpLmNvbV0NCj5TZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMTYsIDIwMTkgMTozOCBQTQ0KPlRvOiBBbnVyYWcgS3VtYXIgVnVsaXNoYSA8YW51
cmFna3VAeGlsaW54LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgTWFyaw0KPlJ1dGxhbmQgPG1h
cmsucnV0bGFuZEBhcm0uY29tPjsgdml2ZWsuZ2F1dGFtQGNvZGVhdXJvcmEub3JnDQo+Q2M6IE1p
Y2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgdi5hbnVyYWdrdW1hckBnbWFpbC5jb207
IHN1bmRlZXANCj5zdWJiYXJheWEgPHN1bmRlZXAubGttbEBnbWFpbC5jb20+OyBBamF5IFl1Z2Fs
a2lzaG9yZSBQYW5kZXkNCj48QVBBTkRFWUB4aWxpbnguY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi8yXSBwaHk6
IHp5bnFtcDogQWRkIHBoeSBkcml2ZXIgZm9yIHhpbGlueCB6eW5xbXAgcGh5IGNvcmUNCj4NCj5I
aSwNCj4NCj5PbiAxOC8xMi8xOCA3OjE1IFBNLCBBbnVyYWcgS3VtYXIgVnVsaXNoYSB3cm90ZToN
Cj4+IFp5bnFNUCBTb0MgaGFzIGEgR2lnYWJpdCBUcmFuc2NlaXZlciB3aXRoIGZvdXIgbGFuZXMu
IEFsbCB0aGUgaGlnaA0KPj4gc3BlZWQgcGVyaXBoZXJhbHMgc3VjaCBhcyBVU0IsIFNBVEEsIFBD
SUUsIERpc3BsYXkgUG9ydCBhbmQgRXRoZXJuZXQNCj4+IFNHTUlJIGNhbiByZWx5IG9uIGFueSBv
ZiB0aGUgZm91ciBHVCBsYW5lcyBmb3IgUEhZIGxheWVyLiBUaGlzIHBhdGNoDQo+PiBhZGRzIGRy
aXZlciBmb3IgdGhhdCBaeW5xTVAgR1QgY29yZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbnVy
YWcgS3VtYXIgVnVsaXNoYSA8YW51cmFnLmt1bWFyLnZ1bGlzaGFAeGlsaW54LmNvbT4NCj4+IC0t
LQ0KPj4gQ2hhbmdlcyBpbiB2NToNCj4+IAkxLiBObyBmdW5jdGlvbmFsIGNoYW5nZXMuIEFkZGVk
IG1pc3NpbmcgQXV0aG9yIG5hbWUNCj4+DQo+PiBDaGFuZ2VzIGluIHY0Og0KPj4gCTEuIE1vdmVk
IGluY2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS5oIGludG8gcGF0Y2ggMSBhcyBzdWdnZXN0ZWQg
YnkNCj4+IAkgICAiUm9iIEhlcnJpbmciDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+IAkxLiBD
b3JyZWN0ZWQgdGhlIERvY3VtZW50YXRpb24gYXMgc3VnZ2VzdGVkIGJ5ICJWaXZlayBHYXV0YW0i
DQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IAkxLiBGaXhlZCB0aGUgY29tcGlsYXRpb24gZXJy
b3Igd2hlbiBjb21waWxlZCBwaHktenlucW1wLmMgYXMgYSBtb2R1bGUNCj4+IAkyLiBBZGRlZCBD
T05GSUdfUE0gbWFjcm8gaW4gcGh5LXp5bnFtcC5jIGRyaXZlcg0KPj4gLS0tDQo+PiAgZHJpdmVy
cy9waHkvS2NvbmZpZyAgICAgICAgICAgIHwgICAgOCArDQo+PiAgZHJpdmVycy9waHkvTWFrZWZp
bGUgICAgICAgICAgIHwgICAgMSArDQo+PiAgZHJpdmVycy9waHkvcGh5LXp5bnFtcC5jICAgICAg
IHwgMTU4Mg0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBp
bmNsdWRlL2xpbnV4L3BoeS9waHktenlucW1wLmggfCAgIDUyICsrDQo+PiAgNCBmaWxlcyBjaGFu
Z2VkLCAxNjQzIGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9w
aHkvcGh5LXp5bnFtcC5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+IGluY2x1ZGUvbGludXgvcGh5
L3BoeS16eW5xbXAuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9LY29uZmlnIGIv
ZHJpdmVycy9waHkvS2NvbmZpZyBpbmRleA0KPj4gNjBmOTQ5ZS4uN2EzYzkwMCAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvcGh5L0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMvcGh5L0tjb25maWcN
Cj4+IEBAIC00MCw2ICs0MCwxNCBAQCBjb25maWcgUEhZX1hHRU5FDQo+PiAgCWhlbHANCj4+ICAJ
ICBUaGlzIG9wdGlvbiBlbmFibGVzIHN1cHBvcnQgZm9yIEFQTSBYLUdlbmUgU29DIG11bHRpLXB1
cnBvc2UgUEhZLg0KPj4NCj4+ICtjb25maWcgUEhZX1hJTElOWF9aWU5RTVANCj4+ICsJdHJpc3Rh
dGUgIlhpbGlueCBaeW5xTVAgUEhZIGRyaXZlciINCj4+ICsJZGVwZW5kcyBvbiBBUkNIX1pZTlFN
UA0KPj4gKwlzZWxlY3QgR0VORVJJQ19QSFkNCj4+ICsJaGVscA0KPj4gKwkgIEVuYWJsZSB0aGlz
IHRvIHN1cHBvcnQgWnlucU1QIEhpZ2ggU3BlZWQgR2lnYWJpdCBUcmFuc2NlaXZlcg0KPj4gKwkg
IHRoYXQgaXMgcGFydCBvZiBaeW5xTVAgU29DLg0KPj4gKw0KPj4gIHNvdXJjZSAiZHJpdmVycy9w
aHkvYWxsd2lubmVyL0tjb25maWciDQo+PiAgc291cmNlICJkcml2ZXJzL3BoeS9hbWxvZ2ljL0tj
b25maWciDQo+PiAgc291cmNlICJkcml2ZXJzL3BoeS9icm9hZGNvbS9LY29uZmlnIg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGh5L01ha2VmaWxlIGIvZHJpdmVycy9waHkvTWFrZWZpbGUgaW5k
ZXgNCj4+IDAzMDFlMjUuLjIzMzVlODUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3BoeS9NYWtl
ZmlsZQ0KPj4gKysrIGIvZHJpdmVycy9waHkvTWFrZWZpbGUNCj4+ICsvKioNCj4+ICsNCj4+ICsv
KioNCj4+ICsgKiB4cHNndHJfb3ZlcnJpZGVfZGVlbXBoIC0gb3ZlcnJpZGUgUElQRSBUWCBkZS1l
bXBoYXNpcw0KPj4gKyAqIEBwaHk6IHBvaW50ZXIgdG8gcGh5DQo+PiArICogQHBsdmw6IHByZS1l
bXBoYXNpcyBsZXZlbA0KPj4gKyAqIEB2bHZsOiB2b2x0YWdlIHN3aW5nIGxldmVsDQo+PiArICoN
Cj4+ICsgKiBSZXR1cm46IE5vbmUNCj4+ICsgKi8NCj4+ICt2b2lkIHhwc2d0cl9vdmVycmlkZV9k
ZWVtcGgoc3RydWN0IHBoeSAqcGh5LCB1OCBwbHZsLCB1OCB2bHZsKSB7DQo+PiArCXN0cnVjdCB4
cHNndHJfcGh5ICpndHJfcGh5ID0gcGh5X2dldF9kcnZkYXRhKHBoeSk7DQo+PiArCXN0cnVjdCB4
cHNndHJfZGV2ICpndHJfZGV2ID0gZ3RyX3BoeS0+ZGF0YTsNCj4+ICsJc3RhdGljIHU4IHBlWzRd
WzRdID0geyB7IDB4MiwgMHgyLCAweDIsIDB4MiB9LA0KPj4gKwkJCSAgICAgICB7IDB4MSwgMHgx
LCAweDEsIDB4RkYgfSwNCj4+ICsJCQkgICAgICAgeyAweDAsIDB4MCwgMHhGRiwgMHhGRiB9LA0K
Pj4gKwkJCSAgICAgICB7IDB4RkYsIDB4RkYsIDB4RkYsIDB4RkYgfSB9Ow0KPj4gKw0KPj4gKwl3
cml0ZWwocGVbcGx2bF1bdmx2bF0sDQo+PiArCSAgICAgICBndHJfZGV2LT5zZXJkZXMgKyBndHJf
cGh5LT5sYW5lICogTDBfVFhfQU5BX1RNXzE4X09GRlNFVCArDQo+PiArCSAgICAgICBMMF9UWF9B
TkFfVE1fMTgpOw0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTCh4cHNndHJfb3ZlcnJpZGVf
ZGVlbXBoKTsNCj4NCj5JIHRob3VnaHQgSSBnYXZlIGEgZmVlZGJhY2sgdG8gZ2V0IHJpZCBvZiBl
eHBvcnQgc3ltYm9sLiBUaGlzIHdpbGwgbWFrZSB0aGUgY29uc3VtZXINCj5kcml2ZXIgdGllZCB0
byB0aGlzIFBIWSBkcml2ZXIuDQo+DQoNClRoYW5rcyBhIGxvdCBmb3Igc3BlbmRpbmcgeW91ciB0
aW1lIGluIHJldmlld2luZyB0aGlzIHBhdGNoLiBXaXRoIHRoZSBjdXJyZW50IGltcGxlbWVudGF0
aW9uLA0KaWYgcGh5LXp5bnFtcC5jIGRyaXZlciBpcyBub3QgY29tcGlsZWQgYW5kIGNvbnN1bWVy
IGRyaXZlciBjYWxscyB4cHNndHJfb3ZlcnJpZGVfZGVlbXBoKCkNCnJvdXRpbmUsIHN0YXRpYyBp
bmxpbmUgZnVuY3Rpb24gaW4gcGh5LXp5bnFtcC5oIGdldHMgY2FsbGVkIGFuZCBlcnJvciAtRU5P
REVWIGlzIHJldHVybmVkLiBTbywNCndpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gdGhl
IGNvbnN1bWVyIGRyaXZlciBpcyBhbHJlYWR5IGRlcGVuZGluZyBvbiBwaHktenlucW1wLmMNCmRy
aXZlci4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgIG15IHVuZGVyc3RhbmRpbmcgaXMgd3JvbmcNCg0K
QmVzdCBSZWdhcmRzLA0KQW51cmFnIEt1bWFyIFZ1bGlzaGENCg==
