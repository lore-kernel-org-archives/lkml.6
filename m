Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59777C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D3B2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HOMPB/Mg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Vlm3ngnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D3B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbeKGJyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:54:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39562 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387612AbeKGJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:54:49 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA70OKd4023894;
        Tue, 6 Nov 2018 16:26:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RRcUyhvfvRmwOQ/jRFLt1W6ixHubOesnnRBYEnU7hfc=;
 b=HOMPB/MgnKNoUU6pdhfkKp9nyHx+AAxtXm6BPM05lRr23L9yT487NS5HDg1gIILmnUKB
 koafLe+qbkpJjNFR13FGtiDjJ+4ANS26MNH/+BhQF9FGTW8TnArsp6iq/Y4AWO6CDH2n
 iGpx394aC/1svxAYJpqHLgwOmG5dAaSs+u8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkmypg328-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 16:26:19 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 6 Nov 2018 16:26:18 -0800
Received: from PRN-CHUB11.TheFacebook.com (2620:10d:c081:35::20) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 6 Nov 2018 16:26:18 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 6 Nov 2018 16:26:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRcUyhvfvRmwOQ/jRFLt1W6ixHubOesnnRBYEnU7hfc=;
 b=Vlm3ngnJfVpddxaRwxZBc/VYbPvTLa/7iIyXPEh1FGMV0di2ZhHwzaAkChsz2WaoHxANbg93OKHyy9BI8kvNKMC0BFhFY7rtNZftgYj+YMPA5DqBQ3dFnxmmtH2rOyIxte961e94u1xFKvTMbC53CHHyV6IAHuID/liULQfVqOE=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2261.namprd15.prod.outlook.com (52.135.197.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 00:26:16 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::ed40:7ac9:3043:5bc1%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 00:26:16 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     David Ahern <dsahern@gmail.com>, David Miller <davem@davemloft.net>
CC:     Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Topic: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
Thread-Index: AQHUdhL1gT1g6kXc4U+H9DJqSIZu3qVDSleAgAAXY4CAAAMiAIAAAiiAgAAKXoCAAAKqgIAAAMIA
Date:   Wed, 7 Nov 2018 00:26:16 +0000
Message-ID: <82745121-339e-2751-c9db-d1fca02d0b33@fb.com>
References: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
 <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
 <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
 <20181106.153647.1701013551426767213.davem@davemloft.net>
 <39fe6abc-5c3e-bac3-0c0b-cf68bea23ab0@fb.com>
 <0a05a14c-3a79-e894-ae48-cbe1df4feb91@gmail.com>
In-Reply-To: <0a05a14c-3a79-e894-ae48-cbe1df4feb91@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:301:3a::36) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:62d8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2261;20:c20TcaFaJyacK5mp+IoUykOplmZduRzQAYWcbflE6C/IpZcw+vtTFu69J5zNeXpg2NAdosoLaBdcr4D8BfQPqAw4blAHJWFdZnJ0fhhvvq7AFoDIa7PkaWIQ5Aq5hAB5SQ3hVXMZpTRSMQTpwVNU12fGB9a8sdniKdt7xkPrwnk=
x-ms-office365-filtering-correlation-id: 66d1bc90-e081-4110-bde4-08d64447a155
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2261;
x-ms-traffictypediagnostic: BYAPR15MB2261:
x-microsoft-antispam-prvs: <BYAPR15MB2261BBDC5F38FF6E62A440C8D7C40@BYAPR15MB2261.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2261;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2261;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(199004)(189003)(229853002)(46003)(86362001)(256004)(81166006)(8936002)(478600001)(81156014)(99286004)(102836004)(14454004)(76176011)(52116002)(6506007)(386003)(53546011)(2900100001)(106356001)(6436002)(53936002)(6116002)(6486002)(6246003)(5660300001)(2906002)(36756003)(8676002)(6512007)(68736007)(105586002)(31686004)(486006)(7736002)(476003)(71190400001)(71200400001)(305945005)(39060400002)(54906003)(110136005)(97736004)(31696002)(186003)(93886005)(25786009)(4326008)(11346002)(316002)(2616005)(446003)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2261;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KUINSkU3mAX/0kdOwV54QCSsgP11DacXtjTlfyiIO2Ky5U/yuu6ujg2WhsXcGGhRzvHwPF3aVVDjl7vQokXts9Kty7wGSM+oCr2CVIZQ7jQbJKUoWtKmZO2gDVBIH2cDT+DAzhshygsg6ip5YO6DDkQkSaWRs/6ZVnPlx8Q4G93Dx3lIw1xYsoV66AeBLdWlPzI4/mUn41LT8kdylPUcvPjeLmfS3wPUf42AQVQdAijaMpPO6o3dDbCCW1CiWQdhYePg4zGr0ML7Gkw5di13MAY1prgXsErYMWzM7NFj2SWfqSD9rTkBOd6GkVd2o8PcidtXp/j2a/Sq+6Q3weXNJuyoDVztuAAfrLkqLbfD+CE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9872DBA7D3BBF418F3779E5EF7A660D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d1bc90-e081-4110-bde4-08d64447a155
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 00:26:16.4575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2261
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNi8xOCA0OjIzIFBNLCBEYXZpZCBBaGVybiB3cm90ZToNCj4gT24gMTEvNi8xOCA1OjEz
IFBNLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+PiBPbiAxMS82LzE4IDM6MzYgUE0sIERh
dmlkIE1pbGxlciB3cm90ZToNCj4+PiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBmYi5j
b20+DQo+Pj4gRGF0ZTogVHVlLCA2IE5vdiAyMDE4IDIzOjI5OjA3ICswMDAwDQo+Pj4NCj4+Pj4g
SSB0aGluayBjb25jZXJucyB3aXRoIHBlcmYgb3ZlcmhlYWQgZnJvbSBjb2xsZWN0aW5nIGJwZiBl
dmVudHMNCj4+Pj4gYXJlIHVuZm91bmRlZC4NCj4+Pj4gSSB3b3VsZCBwcmVmZXIgZm9yIHRoaXMg
ZmxhZyB0byBiZSBvbiBieSBkZWZhdWx0Lg0KPj4+DQo+Pj4gSSB3aWxsIHNpdCBpbiB1c2Vyc3Bh
Y2UgbG9vcGluZyBvdmVyIGJwZiBsb2FkL3VubG9hZCBhbmQgc2VlIGhvdyB0aGUNCj4+PiBwZXJz
b24gdHJ5aW5nIHRvIG1vbml0b3Igc29tZXRoaW5nIGVsc2Ugd2l0aCBwZXJmIGZlZWxzIGFib3V0
IHRoYXQuDQo+Pj4NCj4+PiBSZWFsbHksIGl0IGlzIGluYXBwcm9wcmlhdGUgdG8gdHVybiB0aGlz
IG9uIGJ5IGRlZmF1bHQsIEkgY29tcGxldGVseQ0KPj4+IGFncmVlIHdpdGggRGF2aWQgQWhlcm4u
DQo+Pj4NCj4+PiBJdCdzIGhhcmQgZW5vdWdoLCBfQVMgSVNfLCBmb3IgbWUgdG8gZmlnaHQgYmFj
ayBhbGwgb2YgdGhlIGJsb2F0IHRoYXQNCj4+PiBpcyBpbiBwZXJmIHJpZ2h0IG5vdyBhbmQgZ2V0
IGl0IGJhY2sgdG8gYmVpbmcgYWJsZSB0byBoYW5kbGUgc2ltcGxlDQo+Pj4gZnVsbCB3b3JrbG9h
ZHMgd2l0aG91dCBkcm9wcGluZyBldmVudHMuLg0KPj4NCj4+IEl0J3MgYSBzZXBhcmF0ZSBwZXJm
IHRocmVhZCBhbmQgc2VwYXJhdGUgZXZlbnQgd2l0aCBpdHMgb3duIGVwb2xsLg0KPj4gSSBkb24n
dCBzZWUgaG93IGl0IGNhbiBhZmZlY3QgbWFpbiBldmVudCBjb2xsZWN0aW9uLg0KPj4gTGV0J3Mg
cHV0IGl0IHRoaXMgd2F5LiBJZiBpdCBkb2VzIGFmZmVjdCBzb21laG93LCB0aGVuIHllcywNCj4+
IGl0IHNob3VsZCBub3QgYmUgb24uIElmIGl0IGlzIG5vdCwgdGhlcmUgaXMgbm8gZG93bnNpZGUg
dG8ga2VlcCBpdCBvbi4NCj4+IFR5cGljYWwgdXNlciBleHBlY3RzIHRvIHR5cGUgJ3BlcmYgcmVj
b3JkJyBhbmQgc2VlIGV2ZXJ5dGhpbmcgdGhhdA0KPj4gaXMgaGFwcGVuaW5nIG9uIHRoZSBzeXN0
ZW0uIFJpZ2h0IG5vdyBzaG9ydCBsaXZlZCBicGYgcHJvZ3JhbXMNCj4+IHdpbGwgbm90IGJlIHNl
ZW4uIEhvdyB1c2VyIHN1cHBvc2UgdG8gZXZlbiBrbm93IHdoZW4gdG8gdXNlIHRoZSBmbGFnPw0K
PiANCj4gVGhlIGRlZmF1bHQgaXMgcHJvZmlsaW5nIHdoZXJlIHBlcmYgcmVjb3JkIGNvbGxlY3Rz
IHRhc2sgZXZlbnRzIGFuZA0KPiBwZXJpb2RpYyBzYW1wbGVzLiBTbyBmb3IgdGhlIGRlZmF1bHQg
cmVjb3JkL3JlcG9ydCwgdGhlIGJwZiBsb2FkIC8NCj4gdW5sb2FkIGV2ZW50cyBhcmUgbm90IHJl
bGV2YW50Lg0KDQpFeGFjdGx5IHRoZSBvcHBvc2l0ZS4NCkl0J3MgZm9yIGRlZmF1bHQgJ3BlcmYg
cmVjb3JkJyBjb2xsZWN0aW9uIG9mIHBlcmlvZGljIHNhbXBsZXMuDQpJdCBjYW4gYmUgb2ZmIGZv
ciAtZSBjb2xsZWN0aW9uLiBUaGF0J3MgZWFzeS4NCg==
