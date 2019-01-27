Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582BDC282CB
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BCF2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FdMFfNkG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dVwdkH2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfA0XBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 18:01:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbfA0XBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 18:01:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0RMw9Wt000400;
        Sun, 27 Jan 2019 15:00:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cqn4lUZ0GZ0C35kB+nvDbeMzj7/pNK3L36oi8SVCGms=;
 b=FdMFfNkGH1JlZ6TkHQdliLusgoXqNVAoTi0GQXZc3fbK6qvtEamo+l7b9ZdTbJXT54lE
 0qXN6umEwkE116226c/q2dSRofwxxN6NrQ4v9jZCY1VgDYbhw/N04XKXNJvplin23n0j
 pddyMrjgthBBnwWGe76KB4beOKK0J0sKQv4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q9h2n0j6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 27 Jan 2019 15:00:58 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sun, 27 Jan 2019 15:00:57 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sun, 27 Jan 2019 15:00:57 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Sun, 27 Jan 2019 15:00:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqn4lUZ0GZ0C35kB+nvDbeMzj7/pNK3L36oi8SVCGms=;
 b=dVwdkH2uyhTgfA695oKi/nS9diiAztBiFBDqx7+Lw58izu7BrvPER4QjJJHJF3hhTIjX9u8uTaF6JqYt5TxpospNIlSC+KERtosohtK2/ooNG4t4qBQU9QXpjA3AchgpHi1AiamiVCkyDzzvtOg0Q6weeMipRIN9StZc4Wjd8NM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3112.namprd15.prod.outlook.com (20.178.239.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Sun, 27 Jan 2019 23:00:38 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a%6]) with mapi id 15.20.1558.023; Sun, 27 Jan 2019
 23:00:38 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Michal Hocko <mhocko@kernel.org>,
        =?utf-8?B?QXJrYWRpdXN6IE1pxZtraWV3aWN6?= <a.miskiewicz@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tejun Heo" <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] oom, oom_reaper: do not enqueue same task twice
Thread-Topic: [PATCH v3] oom, oom_reaper: do not enqueue same task twice
Thread-Index: AQHUtlCyl8Igx5NeBkqdNzY6wBGPzKXDu5YA
Date:   Sun, 27 Jan 2019 23:00:38 +0000
Message-ID: <20190127230031.GA26788@castle.DHCP.thefacebook.com>
References: <6da6ca69-5a6e-a9f6-d091-f89a8488982a@gmail.com>
 <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
 <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
 <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
 <2b0c7d6c-c58a-da7d-6f0a-4900694ec2d3@gmail.com>
 <1d161137-55a5-126f-b47e-b2625bd798ca@i-love.sakura.ne.jp>
 <20190127083724.GA18811@dhcp22.suse.cz>
 <ec0d0580-a2dd-f329-9707-0cb91205a216@i-love.sakura.ne.jp>
 <20190127114021.GB18811@dhcp22.suse.cz>
 <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
In-Reply-To: <e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:7bf1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3112;20:tRNstdVnz1TL95r/YKyXpOrdkI0hDhfDCRIxJhndejFhuZJ3jobyTEuM/xQ16AKYENVPlPaA83+l3eSYK1l3RgGURelqUbV6Cw2CriELvF1YOStnsRcgrxOHAKg20TuW2o3w4MOe+Zx3euX1mLzpnGEXhr2dh9atM9q+qwUduzU=
x-ms-office365-filtering-correlation-id: 3a6b1e35-21d7-4100-b05f-08d684ab40e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3112;
x-ms-traffictypediagnostic: BYAPR15MB3112:
x-microsoft-antispam-prvs: <BYAPR15MB31126F0237927E0BC0F999DBBE950@BYAPR15MB3112.namprd15.prod.outlook.com>
x-forefront-prvs: 0930AAFAD9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(199004)(189003)(51914003)(97736004)(11346002)(6116002)(446003)(476003)(93886005)(7736002)(86362001)(4326008)(52116002)(305945005)(81166006)(33896004)(25786009)(478600001)(76176011)(81156014)(229853002)(14444005)(256004)(8676002)(68736007)(316002)(14454004)(386003)(105586002)(186003)(486006)(106356001)(6436002)(6246003)(6506007)(6512007)(9686003)(33656002)(54906003)(66574012)(2906002)(102836004)(8936002)(99286004)(6916009)(7416002)(6486002)(46003)(71190400001)(53546011)(71200400001)(53936002)(1076003)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3112;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sq9EzPw5FhYNTVkVP+ZSRLgo9y8CynkNk5BWh7b7zNmXyhdeeH5RMaEXP1R0mVQ1ZVbvF2tHslVpMTosET4+iq6/9NmWxfFY5hf2eSiWlFAV9nwjM8pl6X1HiFyFcyN4r7eM2+qlvMvYXLyv4s7cSOhmBuNMP5fFuuHSVLUZV+W0tlh5JlqKH0XKt7QE8oZ+al5v2GAwnMeVHuJCSr5i568Jpu4+MxkKOt6okIm/GzibPXfa9CgUwrB3erT1XW4pnqpjl2S6HH9hZblKaMWmLFzp292N5NJBvjk4EtheI9KlO6bH+Rgrw/fhmcWATfpMoat62RLEQpog/qK4CdVXyewmNQJIoE8rqqoN3pWNBfg26FbAiAubGPT2+14H9zA0oiEvPniyHauSCxP125noU95ymq2i3+HWWsxhE0Hu9XU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D64E8DBC380FFE44B2DE5A50D3C073B9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6b1e35-21d7-4100-b05f-08d684ab40e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2019 23:00:37.4496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3112
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-27_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBKYW4gMjcsIDIwMTkgYXQgMTE6NTc6MzhQTSArMDkwMCwgVGV0c3VvIEhhbmRhIHdy
b3RlOg0KPiBPbiAyMDE5LzAxLzI3IDIwOjQwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+ID4gT24g
U3VuIDI3LTAxLTE5IDE5OjU2OjA2LCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+ID4+IE9uIDIwMTkv
MDEvMjcgMTc6MzcsIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gPj4+IFRoYW5rcyBmb3IgdGhlIGFu
YWx5c2lzIGFuZCB0aGUgcGF0Y2guIFRoaXMgc2hvdWxkIHdvcmssIEkgYmVsaWV2ZSBidXQNCj4g
Pj4+IEkgYW0gbm90IHJlYWxseSB0aHJpbGxlZCB0byBvdmVybG9hZCB0aGUgbWVhbmluZyBvZiB0
aGUgTU1GX1VOU1RBQkxFLg0KPiA+Pj4gVGhlIGZsYWcgaXMgbWVhbnQgdG8gc2lnbmFsIGFjY2Vz
c2luZyBhZGRyZXNzIHNwYWNlIGlzIG5vdCBzdGFibGUgYW5kIGl0DQo+ID4+PiBpcyBub3QgYWlt
ZWQgdG8gc3luY2hyb25pemUgb29tIHJlYXBlciB3aXRoIHRoZSBvb20gcGF0aC4NCj4gPj4+DQo+
ID4+PiBDYW4gd2UgbWFrZSB1c2UgbWFya19vb21fdmljdGltIGRpcmVjdGx5PyBJIGRpZG4ndCBn
ZXQgdG8gdGhpbmsgdGhhdA0KPiA+Pj4gdGhyb3VnaCByaWdodCBub3cgc28gSSBtaWdodCBiZSBt
aXNzaW5nIHNvbWV0aGluZyBidXQgdGhpcyBzaG91bGQNCj4gPj4+IHByZXZlbnQgcmVwZWF0aW5n
IHF1ZXVlaW5nIGFzIHdlbGwuDQo+ID4+DQo+ID4+IFllcywgVElGX01FTURJRSB3b3VsZCB3b3Jr
LiBCdXQgeW91IGFyZSBwbGFubmluZyB0byByZW1vdmUgVElGX01FTURJRS4gQWxzbywNCj4gPj4g
VElGX01FTURJRSBjYW4ndCBhdm9pZCBlbnF1ZXVpbmcgbWFueSB0aHJlYWRzIHNoYXJpbmcgbW1f
c3RydWN0IHRvIHRoZSBPT00NCj4gPj4gcmVhcGVyLiBUaGVyZSBpcyBubyBuZWVkIHRvIGVucXVl
dWUgbWFueSB0aHJlYWRzIHNoYXJpbmcgbW1fc3RydWN0IGJlY2F1c2UNCj4gPj4gdGhlIE9PTSBy
ZWFwZXIgYWN0cyBvbiBtbV9zdHJ1Y3QgcmF0aGVyIHRoYW4gdGFza19zdHJ1Y3QuIFRodXMsIGVu
cXVldWluZw0KPiA+PiBiYXNlZCBvbiBwZXIgbW1fc3RydWN0IGZsYWcgc291bmRzIGJldHRlciwg
YnV0IE1NRl9PT01fVklDVElNIGNhbm5vdCBiZQ0KPiA+PiBzZXQgZnJvbSB3YWtlX29vbV9yZWFw
ZXIodmljdGltKSBiZWNhdXNlIHZpY3RpbSdzIG1tIG1pZ2h0IGJlIGFscmVhZHkgaW5zaWRlDQo+
ID4+IGV4aXRfbW1hcCgpIHdoZW4gd2FrZV9vb21fcmVhcGVyKHZpY3RpbSkgaXMgY2FsbGVkIGFm
dGVyIHRhc2tfdW5sb2NrKHZpY3RpbSkuDQo+ID4+DQo+ID4+IFdlIGNvdWxkIHJlaW50cm9kdWNl
IE1NRl9PT01fS0lMTEVEIGluIGNvbW1pdCA4NTViMDE4MzI1NzM3Zjc2DQo+ID4+ICgib29tLCBv
b21fcmVhcGVyOiBkaXNhYmxlIG9vbV9yZWFwZXIgZm9yIG9vbV9raWxsX2FsbG9jYXRpbmdfdGFz
ayIpDQo+ID4+IGlmIHlvdSBkb24ndCBsaWtlIG92ZXJsb2FkaW5nIHRoZSBtZWFuaW5nIG9mIHRo
ZSBNTUZfVU5TVEFCTEUuIEJ1dCBzaW5jZQ0KPiA+PiBNTUZfVU5TVEFCTEUgaXMgYXZhaWxhYmxl
IGluIExpbnV4IDQuOSsga2VybmVscyAod2hpY2ggY292ZXJzIGFsbCBMVFMgc3RhYmxlDQo+ID4+
IHZlcnNpb25zIHdpdGggdGhlIE9PTSByZWFwZXIgc3VwcG9ydCksIHdlIGNhbiB0ZW1wb3Jhcmls
eSB1c2UgTU1GX1VOU1RBQkxFDQo+ID4+IGZvciBlYXNlIG9mIGJhY2twb3J0aW5nLg0KPiA+IA0K
PiA+IEkgYWdyZWUgdGhhdCBhIHBlci1tbSBzdGF0ZSBpcyBtb3JlIG9wdGltYWwgYnV0IEkgd291
bGQgcmF0aGVyIGZpeCB0aGUNCj4gPiBpc3N1ZSBpbiBhIGNsZWFyIHdheSBmaXJzdCBhbmQgb25s
eSB0aGVuIHRoaW5rIGFib3V0IGFuIG9wdGltaXphdGlvbiBvbg0KPiA+IHRvcC4gUXVldWVpbmcg
YmFzZWQgb24gbWFya19vb21fdmljdGltICh3aGF0ZXZlciB0aGF0IHVzZXMgdG8gZ3VhcmFudGVl
DQo+ID4gdGhlIHZpY3RpbSBpcyBtYXJrZWQgYXRvbWljYWxseSBhbmQgb25seSBvbmNlKSBtYWtl
cyBzZW5zZSBmcm9tIHRoZQ0KPiA+IGNvbmNlcHR1YWwgcG9pbnQgb2YgdmlldyBhbmQgaXQgbWFr
ZXMgYSBsb3Qgb2Ygc2Vuc2UgdG8gc3RhcnQgZnJvbQ0KPiA+IHRoZXJlLiBNTUZfVU5TVEFCTEUg
aGFzIGEgY29tcGxldGVseSBkaWZmZXJlbnQgcHVycG9zZS4gU28gdW5sZXNzIHlvdQ0KPiA+IHNl
ZSBhIGNvcnJlY3RuZXNzIGlzc3VlIHdpdGggdGhhdCB0aGVuIEkgd291bGQgcmF0aGVyIGdvIHRo
YXQgd2F5Lg0KPiA+IA0KPiANCj4gVGhlbiwgYWRkaW5nIGEgcGVyIG1tX3N0cnVjdCBmbGFnIGlz
IGJldHRlci4gSSBkb24ndCBzZWUgdGhlIGRpZmZlcmVuY2UNCj4gYmV0d2VlbiByZXVzaW5nIE1N
Rl9VTlNUQUJMRSBhcyBhIGZsYWcgZm9yIHdoZXRoZXIgd2FrZV9vb21fcmVhcGVyKCkgZm9yDQo+
IHRoYXQgdmljdGltJ3MgbWVtb3J5IHdhcyBhbHJlYWR5IGNhbGxlZCAod2hhdCB5b3UgdGhpbmsg
YXMgYW4gb3ZlcmxvYWQpDQo+IGFuZCByZXVzaW5nIFRJRl9NRU1ESUUgYXMgYSBmbGFnIGZvciB3
aGV0aGVyIHdha2Vfb29tX3JlYXBlcigpIGZvciB0aGF0DQo+IHZpY3RpbSB0aHJlYWQgY2FuIGJl
IGNhbGxlZCAod2hhdCBJIHRoaW5rIGFzIGFuIG92ZXJsb2FkKS4gV2Ugd2FudCB0bw0KPiByZW1v
dmUgVElGX01FTURJRSwgYW5kIHdlIGNhbiBhY3R1YWxseSByZW1vdmUgVElGX01FTURJRSBpZiB5
b3Ugc3RvcA0KPiB3aGFjay1hLW1vbGUgImNhbiB5b3Ugb2JzZXJ2ZSBpdCBpbiByZWFsIHdvcmts
b2FkL3Byb2dyYW0/IiBnYW1lLg0KPiBJIGRvbid0IHNlZSBhIGNvcnJlY3RuZXNzIGlzc3VlIHdp
dGggVElGX01FTURJRSBidXQgSSBkb24ndCB3YW50IHRvIGdvDQo+IFRJRl9NRU1ESUUgd2F5Lg0K
PiANCj4gDQo+IA0KPiBGcm9tIDljOWU5MzVmYzAzODM0MmM0ODQ2MWFhYmNhNjY2ZjFiNTQ0ZTMy
YjEgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+IEZyb206IFRldHN1byBIYW5kYSA8cGVuZ3Vp
bi1rZXJuZWxASS1sb3ZlLlNBS1VSQS5uZS5qcD4NCj4gRGF0ZTogU3VuLCAyNyBKYW4gMjAxOSAy
Mzo1MTozNyArMDkwMA0KPiBTdWJqZWN0OiBbUEFUQ0ggdjNdIG9vbSwgb29tX3JlYXBlcjogZG8g
bm90IGVucXVldWUgc2FtZSB0YXNrIHR3aWNlDQo+IA0KPiBBcmthZGl1c3ogcmVwb3J0ZWQgdGhh
dCBlbmFibGluZyBtZW1jZydzIGdyb3VwIG9vbSBraWxsaW5nIGNhdXNlcw0KPiBzdHJhbmdlIG1l
bWNnIHN0YXRpc3RpY3Mgd2hlcmUgdGhlcmUgaXMgbm8gdGFzayBpbiBhIG1lbWNnIGRlc3BpdGUN
Cj4gdGhlIG51bWJlciBvZiB0YXNrcyBpbiB0aGF0IG1lbWNnIGlzIG5vdCAwLiBJdCB0dXJuZWQg
b3V0IHRoYXQgdGhlcmUNCj4gaXMgYSBidWcgaW4gd2FrZV9vb21fcmVhcGVyKCkgd2hpY2ggYWxs
b3dzIGVucXVldWluZyBzYW1lIHRhc2sgdHdpY2UNCj4gd2hpY2ggbWFrZXMgaW1wb3NzaWJsZSB0
byBkZWNyZWFzZSB0aGUgbnVtYmVyIG9mIHRhc2tzIGluIHRoYXQgbWVtY2cNCj4gZHVlIHRvIGEg
cmVmY291bnQgbGVhay4NCj4gDQo+IFRoaXMgYnVnIGV4aXN0ZWQgc2luY2UgdGhlIE9PTSByZWFw
ZXIgYmVjYW1lIGludm9rYWJsZSBmcm9tDQo+IHRhc2tfd2lsbF9mcmVlX21lbShjdXJyZW50KSBw
YXRoIGluIG91dF9vZl9tZW1vcnkoKSBpbiBMaW51eCA0LjcsDQo+IGJ1dCBtZW1jZydzIGdyb3Vw
IG9vbSBraWxsaW5nIG1hZGUgaXQgZWFzaWVyIHRvIHRyaWdnZXIgdGhpcyBidWcgYnkNCj4gY2Fs
bGluZyB3YWtlX29vbV9yZWFwZXIoKSBvbiB0aGUgc2FtZSB0YXNrIGZyb20gb25lIG91dF9vZl9t
ZW1vcnkoKQ0KPiByZXF1ZXN0Lg0KPiANCj4gRml4IHRoaXMgYnVnIHVzaW5nIGFuIGFwcHJvYWNo
IHVzZWQgYnkgY29tbWl0IDg1NWIwMTgzMjU3MzdmNzYNCj4gKCJvb20sIG9vbV9yZWFwZXI6IGRp
c2FibGUgb29tX3JlYXBlciBmb3Igb29tX2tpbGxfYWxsb2NhdGluZ190YXNrIikuDQo+IEFzIGEg
c2lkZSBlZmZlY3Qgb2YgdGhpcyBwYXRjaCwgdGhpcyBwYXRjaCBhbHNvIGF2b2lkcyBlbnF1ZXVp
bmcNCj4gbXVsdGlwbGUgdGhyZWFkcyBzaGFyaW5nIG1lbW9yeSB2aWEgdGFza193aWxsX2ZyZWVf
bWVtKGN1cnJlbnQpIHBhdGguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUZXRzdW8gSGFuZGEgPHBl
bmd1aW4ta2VybmVsQEktbG92ZS5TQUtVUkEubmUuanA+DQo+IFJlcG9ydGVkLWJ5OiBBcmthZGl1
c3ogTWnFm2tpZXdpY3ogPGFyZWttQG1hdmVuLnBsPg0KPiBUZXN0ZWQtYnk6IEFya2FkaXVzeiBN
acWba2lld2ljeiA8YXJla21AbWF2ZW4ucGw+DQo+IEZpeGVzOiBhZjhlMTVjYzg1YTI1MzE1ICgi
b29tLCBvb21fcmVhcGVyOiBkbyBub3QgZW5xdWV1ZSB0YXNrIGlmIGl0IGlzIG9uIHRoZSBvb21f
cmVhcGVyX2xpc3QgaGVhZCIpDQoNClRoYW5rIHlvdSwgVGV0c3VvIQ0KDQpBY2tlZC1ieTogUm9t
YW4gR3VzaGNoaW4gPGd1cm9AZmIuY29tPg0K
