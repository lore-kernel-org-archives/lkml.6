Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BAC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3F218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bt8R0Icq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GvCTi5DG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAZBlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:41:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbfAZBlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:41:45 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0Q1a2D6015312;
        Fri, 25 Jan 2019 17:41:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=s9ysb9p7FtoGVSZgQomcsivhUmASooGQCwtxL9McI28=;
 b=bt8R0IcqMZ6G0VLq3K6EbB/5B2WniJ2Z6Y6Uz+qpPjyv1yGwLXOX+LtgYGUP0kH4iHG2
 csXFtvSlwpROGI8Ac5ciGNqYYbTe1Uovm4X/ZC4JsoMAz7HW6Qb0POlZVmgx7HiXsQOe
 aL2pLUr+jEQcRf39/08SzhPatqiYxh3dZus= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2q8ct286f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Jan 2019 17:41:08 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 17:41:07 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 17:41:07 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 25 Jan 2019 17:41:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9ysb9p7FtoGVSZgQomcsivhUmASooGQCwtxL9McI28=;
 b=GvCTi5DGNvQsoyx8Bd+MEdIHiXOzDdZQTeXBtqMh1b3/9g4z7McQuce2nwsJDq+NTQbvdD1KWaIOub58KgLgP+oRzcP+rkdb/KbADu1NIIIqJutKUqh/GGBYsNUiHjKN5bsRFRylwzsbzYJ/do42qhpfygDx9VnWWGfCEJ2oHng=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2247.namprd15.prod.outlook.com (52.135.197.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Sat, 26 Jan 2019 01:41:04 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a%6]) with mapi id 15.20.1558.016; Sat, 26 Jan 2019
 01:41:04 +0000
From:   Roman Gushchin <guro@fb.com>
To:     =?utf-8?B?QXJrYWRpdXN6IE1pxZtraWV3aWN6?= <a.miskiewicz@gmail.com>
CC:     Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pids.current with invalid value for hours [5.0.0 rc3 git]
Thread-Topic: pids.current with invalid value for hours [5.0.0 rc3 git]
Thread-Index: AQHUtILphW75YnfIXke18J5LekrmLKXAL4KAgAA1NYCAAGKjgA==
Date:   Sat, 26 Jan 2019 01:41:04 +0000
Message-ID: <20190126014055.GA25864@castle.DHCP.thefacebook.com>
References: <df806a77-3327-9db5-8be2-976fde1c84e5@gmail.com>
 <20190117122535.njcbqhlmzozdkncw@mikami>
 <1d36b181-cbaf-6694-1a31-2f7f55d15675@gmail.com>
 <96ef6615-a5df-30af-b4dc-417a18ca63f1@gmail.com>
 <1cdbef13-564d-61a6-95f4-579d2cad243d@gmail.com>
 <20190125163731.GJ50184@devbig004.ftw2.facebook.com>
 <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
In-Reply-To: <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0040.namprd14.prod.outlook.com
 (2603:10b6:300:12b::26) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:686]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2247;20:RDz7O3vOece2s+DR3wbDMtpgpNi/Smih/Chk69Mi+sgrR9VWJRFpr0FPaB6Xpr2OrFVszm4O0wD2nGF6FYxD7qaByKQCQ8/dD72Gdfvofp4Ap93iHogZrCZKJsx2CMBDQqYJRsiXk67mF89/uboiQy0k3g0uJUrOERRVCz30Ofg=
x-ms-office365-filtering-correlation-id: bc7265fa-edbc-437b-c3f2-08d6832f559c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2247;
x-ms-traffictypediagnostic: BYAPR15MB2247:
x-microsoft-antispam-prvs: <BYAPR15MB2247FFE6E21737CB586BAA47BE940@BYAPR15MB2247.namprd15.prod.outlook.com>
x-forefront-prvs: 0929F1BAED
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(2906002)(102836004)(446003)(25786009)(11346002)(386003)(186003)(33656002)(6506007)(14454004)(33896004)(6486002)(6436002)(53936002)(97736004)(4326008)(46003)(478600001)(53546011)(76176011)(8936002)(71190400001)(71200400001)(305945005)(8676002)(81156014)(5024004)(81166006)(68736007)(14444005)(52116002)(316002)(106356001)(66574012)(6512007)(229853002)(54906003)(1076003)(6116002)(93886005)(6246003)(256004)(476003)(486006)(39060400002)(7736002)(99286004)(105586002)(86362001)(9686003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2247;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: stIi0bfbyqTen+f73ycJ0pTgUziyG9go0VUAhb2h84SBO8KpjUZJiYx6cvzouXcMaEOMuaCqNvkV/fKmH7xJiOtjl9y4ZcclrGtZw7zN4KSeQm8NjgcHplCnNPMHtELgSjF5PpnTaD7Ihn9UjKnCYFOMiUJYWDMZ9JLWkvLh8wYrlsF3unNjeztkDwNtG8+fEa2jl9XZlWrZmvrshpWwKir7UzS23Up0tiRf+r3IdzNE/wYjZGxy0eYgo7s5Kivv2eQuUf8eeovVl2qKSJH56z/N5hdnpSK94KxbE2EszyBYwu8axFhXmnzM4mw2ZyQeOrnzK5Jnq2EcnaVUQCypdaXc8yF+DW3s7VxB6naodzwcUK/aO+6xCa1IzQLLSJYa6T0rFZFmYJiNq+9FElViOlwU2NlcLyRwcPmn6zdJE6U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45EA340A70ADF044AFF0F3C3F0EBB07F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7265fa-edbc-437b-c3f2-08d6832f559c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2019 01:41:03.5017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2247
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-26_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMDg6NDc6NTdQTSArMDEwMCwgQXJrYWRpdXN6IE1pxZtr
aWV3aWN6IHdyb3RlOg0KPiBPbiAyNS8wMS8yMDE5IDE3OjM3LCBUZWp1biBIZW8gd3JvdGU6DQo+
ID4gT24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMDg6NTI6MTFBTSArMDEwMCwgQXJrYWRpdXN6IE1p
xZtraWV3aWN6IHdyb3RlOg0KPiA+PiBPbiAyNC8wMS8yMDE5IDEyOjIxLCBBcmthZGl1c3ogTWnF
m2tpZXdpY3ogd3JvdGU6DQo+ID4+PiBPbiAxNy8wMS8yMDE5IDE0OjE3LCBBcmthZGl1c3ogTWnF
m2tpZXdpY3ogd3JvdGU6DQo+ID4+Pj4gT24gMTcvMDEvMjAxOSAxMzoyNSwgQWxla3NhIFNhcmFp
IHdyb3RlOg0KPiA+Pj4+PiBPbiAyMDE5LTAxLTE3LCBBcmthZGl1c3ogTWnFm2tpZXdpY3ogPGEu
bWlza2lld2ljekBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4gVXNpbmcga2VybmVsIDQuMTku
MTMuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gRm9yIG9uZSBjZ3JvdXAgSSBub3RpY2VkIHdlaXJkIGJl
aGF2aW91cjoNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAjIGNhdCBwaWRzLmN1cnJlbnQNCj4gPj4+Pj4+
IDYwDQo+ID4+Pj4+PiAjIGNhdCBjZ3JvdXAucHJvY3MNCj4gPj4+Pj4+ICMNCj4gPj4+Pj4NCj4g
Pj4+Pj4gQXJlIHRoZXJlIGFueSB6b21iaWVzIGluIHRoZSBjZ3JvdXA/IHBpZHMuY3VycmVudCBp
cyBsaW5rZWQgdXAgZGlyZWN0bHkNCj4gPj4+Pj4gdG8gX19wdXRfdGFza19zdHJ1Y3QgKHNvIGV4
aXQoMikgd29uJ3QgZGVjcmVhc2UgaXQsIG9ubHkgdGhlIHRhc2tfc3RydWN0DQo+ID4+Pj4+IGFj
dHVhbGx5IGJlaW5nIGZyZWVkIHdpbGwgZGVjcmVhc2UgaXQpLg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+
ID4+Pj4gVGhlcmUgYXJlIG5vIHpvbWJpZSBwcm9jZXNzZXMuDQo+ID4+Pj4NCj4gPj4+PiBJbiBt
ZWFuIHRpbWUgdGhlIHByb2JsZW0gc2hvd3Mgb24gbXVsdGlwbGUgc2VydmVycyBhbmQgc28gZmFy
IHNhdyBpdA0KPiA+Pj4+IG9ubHkgaW4gY2dyb3VwcyB0aGF0IHdlcmUgT09NZWQuDQo+ID4+Pj4N
Cj4gPj4+PiBXaGF0IGhhcyBjaGFuZ2VkIG9uIHRoZXNlIHNlcnZlcnMgKHllc3RlcmRheSkgaXMg
dHVybmluZyBvbg0KPiA+Pj4+IG1lbW9yeS5vb20uZ3JvdXA9MSBmb3IgYWxsIGNncm91cHMgYW5k
IGNoYW5naW5nIG1lbW9yeS5oaWdoIGZyb20gMUcgdG8NCj4gPj4+PiAibWF4IiAobGVhdmluZyBt
ZW1vcnkubWF4PTJHIGxpbWl0IG9ubHkpLg0KPiA+Pj4+DQo+ID4+Pj4gUHJldmlvdXNseSB0aGVy
ZSB3YXMgbm8gc3VjaCBwcm9ibGVtLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSSdtIGF0dGFjaGlu
ZyByZXByb2R1Y2VyLiBUaGlzIHRpbWUgdHJpZWQgb24gZGlmZmVyZW50IGRpc3RyaWJ1dGlvbg0K
PiA+Pj4ga2VybmVsIChhcmNoIGxpbnV4KS4NCj4gPj4+DQo+ID4+PiBBZnRlciA2MHMgcGlkcy5j
dXJyZW50IHN0aWxsIHNob3dzIDM3IHByb2Nlc3NlcyBldmVuIGlmIHRoZXJlIGFyZSBubw0KPiA+
Pj4gcHJvY2Vzc2VzIHJ1bm5pbmcgKGFjY29yZGluZyB0byBwcyBhdXgpLg0KPiA+Pg0KPiA+Pg0K
PiA+PiBUaGUgc2FtZSB0ZXN0IG9uIDUuMC4wLXJjMy0wMDEwNC1nYzA0ZTJhNzgwY2FmIGFuZCBp
dCdzIGVhc3kgdG8NCj4gPj4gcmVwcm9kdWNlIGJ1Zy4gTm8gcHJvY2Vzc2VzIGluIGNncm91cCBi
dXQgcGlkcy5jdXJyZW50IHJlcG9ydHMgOTEuDQo+ID4gDQo+ID4gQ2FuIHlvdSBwbGVhc2Ugc2Vl
IHdoZXRoZXIgdGhlIHByb2JsZW0gY2FuIGJlIHJlcHJvZHVjZWQgb24gdGhlDQo+ID4gY3VycmVu
dCBsaW51eC1uZXh0Pw0KPiA+IA0KPiA+ICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdA0KPiANCj4gSSBjYW4gcmVwcm9kdWNl
IG9uIG5leHQgKDUuMC4wLXJjMy1uZXh0LTIwMTkwMTI1KSwgdG9vOg0KDQpIb3cgcmVsaWFibHkg
eW91IGNhbiByZXByb2R1Y2UgaXQ/IEkndmUgdHJpZWQgdG8gcnVuIHlvdXIgcmVwcm9kdWNlcg0K
c2V2ZXJhbCB0aW1lcyB3aXRoIGRpZmZlcmVudCBwYXJhbWV0ZXJzLCBidXQgd2Fzbid0IGx1Y2t5
IHNvIGZhci4NCldoYXQncyB5b3VycyBjcHUgbnVtYmVyIGFuZCB0b3RhbCByYW0gc2l6ZT8NCg0K
Q2FuIHlvdSwgcGxlYXNlLCBwcm92aWRlIHRoZSBjb3JyZXNwb25kaW5nIGRtZXNnIG91dHB1dD8N
Cg0KSSd2ZSBjaGVja2VkIHRoZSBjb2RlIGFnYWluLCBhbmQgbXkgd2lsZCBndWVzcyBpcyB0aGF0
IHRoZXNlIG1pc3NpbmcNCnRhc2tzIGFyZSB3YWl0aW5nIChtYXliZSBob3BlbGVzc2x5KSBmb3Ig
dGhlIE9PTSByZWFwZXIuIERtZXNnIG91dHB1dA0KbWlnaHQgYmUgdmVyeSB1c2VmdWwgaGVyZS4N
Cg0KVGhhbmtzIQ0K
