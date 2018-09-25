Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44836C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99612145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a2TeFooB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99612145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeIYHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:47:09 -0400
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:25992
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbeIYHrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 03:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1FSbOYQ0lNY0M2eoyFkHb4f+BCxhfvXDlEM4k4r9Js=;
 b=a2TeFooBjY29J4AOut9+TuAlcQCmIK/apPlg4Tv7XyBnnsJv0fLISomdfGrvw383a9074onRzqDYBNBh5huzmb/9/HCg8hHj/cAmhbyaTg6DT5TIOvkRMfJe8XIDd6tIVQYtt2PIg32/57hk3li+BOxB4KmMMMJ0PfwFs6WNXug=
Received: from AM6PR08MB3253.eurprd08.prod.outlook.com (52.135.164.146) by
 AM6PR08MB2966.eurprd08.prod.outlook.com (52.135.163.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Tue, 25 Sep 2018 01:42:02 +0000
Received: from AM6PR08MB3253.eurprd08.prod.outlook.com
 ([fe80::1925:9709:7f18:6ad0]) by AM6PR08MB3253.eurprd08.prod.outlook.com
 ([fe80::1925:9709:7f18:6ad0%3]) with mapi id 15.20.1143.017; Tue, 25 Sep 2018
 01:42:02 +0000
From:   Andrey Vagin <avagin@virtuozzo.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
Thread-Topic: [RFC 00/20] ns: Introduce Time Namespace
Thread-Index: AQHUUFpuovisR+B/R0ChKHU4yyCZyaT6rFafgATOTICAAIlk1oAAPSGA
Date:   Tue, 25 Sep 2018 01:42:02 +0000
Message-ID: <20180925014150.GA6302@outlook.office365.com>
References: <20180919205037.9574-1-dima@arista.com>
 <874lej6nny.fsf@xmission.com> <20180924205119.GA14833@outlook.office365.com>
 <874leezh8n.fsf@xmission.com>
In-Reply-To: <874leezh8n.fsf@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.0 (2018-05-17)
x-originating-ip: [73.140.212.29]
x-clientproxiedby: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB2966;20:RiHrQTodQkdwWDuzKyqwLXBYiaUBT59kaNZ4WKNa6GEefn7ERfn5FsTfVMRFfK9Q3Z8PMuz87sqBrInlOD/AP1Pm9Qw6eR40FIO+DVVmh43euzD9lsV5qxlhG/IYOdPjNEbYD1A41moiYdnp9nRxArwKe0UbGQeCTYNGeeN9q0U=
x-ms-office365-filtering-correlation-id: 840dfba0-232a-4647-9088-08d622881766
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB2966;
x-ms-traffictypediagnostic: AM6PR08MB2966:
x-microsoft-antispam-prvs: <AM6PR08MB29665ABE3976EBBA29F0A4A0CF160@AM6PR08MB2966.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR08MB2966;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB2966;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39850400004)(199004)(189003)(6506007)(52116002)(486006)(76176011)(33896004)(86362001)(106356001)(6246003)(4326008)(25786009)(2906002)(99286004)(476003)(8676002)(39060400002)(33656002)(345774005)(2900100001)(105586002)(81156014)(81166006)(8936002)(6916009)(54906003)(446003)(11346002)(93886005)(102836004)(3846002)(14454004)(6116002)(7416002)(186003)(6436002)(53936002)(71190400001)(9686003)(14444005)(6512007)(305945005)(5660300001)(7736002)(256004)(316002)(478600001)(97736004)(71200400001)(5250100002)(26005)(386003)(1076002)(66066001)(68736007)(229853002)(58126008)(6486002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB2966;H:AM6PR08MB3253.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gMc7AF/NYr7yC9gRnKcuPF+KdSU1E0eg5Pyzn5b5E/FJkf8cBccfR/RbQVG87WpwwkqaE01GPnxYXItrsF65SP8XfBU9HoUHUAVRsH+93fYDjTBc8jbR8IRWUEWCdSeuUYIklgJRkYXqo9f8mnCABA16wgODKkPWg302t/SZ3M2wOMnVlDXcC8Fe5kLHBx+3ebJeCz0GDJ8m50RQ2ScLM/qc0lAFUoaLloBfY2uO6MOHguFEth52X9MiWZu8W1XYsP+9OR70eUJOdFMl77zyk8WBsGwnL1FD29xrwnqUSxcIxyd0MLh7Fm05O4aADTZ8kwCHQVduhh4WUAc5E3Z0/sSCvdndzELkRHr5TC6X5TQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <875B41794BA40B45ABD259AFFEE4729B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840dfba0-232a-4647-9088-08d622881766
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 01:42:02.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMjUsIDIwMTggYXQgMTI6MDI6MzJBTSArMDIwMCwgRXJpYyBXLiBCaWVkZXJt
YW4gd3JvdGU6DQo+IEFuZHJleSBWYWdpbiA8YXZhZ2luQHZpcnR1b3p6by5jb20+IHdyaXRlczoN
Cj4gDQo+ID4gT24gRnJpLCBTZXAgMjEsIDIwMTggYXQgMDI6Mjc6MjlQTSArMDIwMCwgRXJpYyBX
LiBCaWVkZXJtYW4gd3JvdGU6DQo+ID4+IERtaXRyeSBTYWZvbm92IDxkaW1hQGFyaXN0YS5jb20+
IHdyaXRlczoNCj4gPj4gDQo+ID4+ID4gRGlzY3Vzc2lvbnMgYXJvdW5kIHRpbWUgdmlydHVhbGl6
YXRpb24gYXJlIHRoZXJlIGZvciBhIGxvbmcgdGltZS4NCj4gPj4gPiBUaGUgZmlyc3QgYXR0ZW1w
dCB0byBpbXBsZW1lbnQgdGltZSBuYW1lc3BhY2Ugd2FzIGluIDIwMDYgYnkgSmVmZiBEaWtlLg0K
PiA+PiA+IEZyb20gdGhhdCB0aW1lLCB0aGUgdG9waWMgYXBwZWFycyBvbiBhbmQgb2ZmIGluIHZh
cmlvdXMgZGlzY3Vzc2lvbnMuDQo+ID4+ID4NCj4gPj4gPiBUaGVyZSBhcmUgdHdvIG1haW4gdXNl
IGNhc2VzIGZvciB0aW1lIG5hbWVzcGFjZXM6DQo+ID4+ID4gMS4gY2hhbmdlIGRhdGUgYW5kIHRp
bWUgaW5zaWRlIGEgY29udGFpbmVyOw0KPiA+PiA+IDIuIGFkanVzdCBjbG9ja3MgZm9yIGEgY29u
dGFpbmVyIHJlc3RvcmVkIGZyb20gYSBjaGVja3BvaW50Lg0KPiA+PiA+DQo+ID4+ID4g4oCcSXQg
c2VlbXMgbGlrZSB0aGlzIG1pZ2h0IGJlIG9uZSBvZiB0aGUgbGFzdCBtYWpvciBvYnN0YWNsZXMg
a2VlcGluZw0KPiA+PiA+IG1pZ3JhdGlvbiBmcm9tIGJlaW5nIHVzZWQgaW4gcHJvZHVjdGlvbiBz
eXN0ZW1zLCBnaXZlbiB0aGF0IG5vdCBhbGwNCj4gPj4gPiBjb250YWluZXJzIGFuZCBjb25uZWN0
aW9ucyBjYW4gYmUgbWlncmF0ZWQgYXMgbG9uZyBhcyBhIHRpbWUgZGVwZW5kZW5jeQ0KPiA+PiA+
IGlzIGNhcGFibGUgb2YgbWVzc2luZyBpdCB1cC7igJ0gKGJ5IGdpdGh1Yi5jb20vZGF2LWVsbCkN
Cj4gPj4gPg0KPiA+PiA+IFRoZSBrZXJuZWwgcHJvdmlkZXMgYWNjZXNzIHRvIHNldmVyYWwgY2xv
Y2tzOiBDTE9DS19SRUFMVElNRSwNCj4gPj4gPiBDTE9DS19NT05PVE9OSUMsIENMT0NLX0JPT1RU
SU1FLiBMYXN0IHR3byBjbG9ja3MgYXJlIG1vbm90b25vdXMsIGJ1dCB0aGUNCj4gPj4gPiBzdGFy
dCBwb2ludHMgZm9yIHRoZW0gYXJlIG5vdCBkZWZpbmVkIGFuZCBhcmUgZGlmZmVyZW50IGZvciBl
YWNoIHJ1bm5pbmcNCj4gPj4gPiBzeXN0ZW0uIFdoZW4gYSBjb250YWluZXIgaXMgbWlncmF0ZWQg
ZnJvbSBvbmUgbm9kZSB0byBhbm90aGVyLCBhbGwNCj4gPj4gPiBjbG9ja3MgaGF2ZSB0byBiZSBy
ZXN0b3JlZCBpbnRvIGNvbnNpc3RlbnQgc3RhdGVzOyBpbiBvdGhlciB3b3JkcywgdGhleQ0KPiA+
PiA+IGhhdmUgdG8gY29udGludWUgcnVubmluZyBmcm9tIHRoZSBzYW1lIHBvaW50cyB3aGVyZSB0
aGV5IGhhdmUgYmVlbg0KPiA+PiA+IGR1bXBlZC4NCj4gPj4gPg0KPiA+PiA+IFRoZSBtYWluIGlk
ZWEgYmVoaW5kIHRoaXMgcGF0Y2ggc2V0IGlzIGFkZGluZyBwZXItbmFtZXNwYWNlIG9mZnNldHMg
Zm9yDQo+ID4+ID4gc3lzdGVtIGNsb2Nrcy4gV2hlbiBhIHByb2Nlc3MgaW4gYSBub24tcm9vdCB0
aW1lIG5hbWVzcGFjZSByZXF1ZXN0cw0KPiA+PiA+IHRpbWUgb2YgYSBjbG9jaywgYSBuYW1lc3Bh
Y2Ugb2Zmc2V0IGlzIGFkZGVkIHRvIHRoZSBjdXJyZW50IHZhbHVlIG9mDQo+ID4+ID4gdGhpcyBj
bG9jayBvbiBhIGhvc3QgYW5kIHRoZSBzdW0gaXMgcmV0dXJuZWQuDQo+ID4+ID4NCj4gPj4gPiBB
bGwgb2Zmc2V0cyBhcmUgcGxhY2VkIG9uIGEgc2VwYXJhdGUgcGFnZSwgdGhpcyBhbGxvd3MgdXAg
dG8gbWFwIGl0IGFzIA0KPiA+PiA+IHBhcnQgb2YgdnZhciBpbnRvIHVzZXIgcHJvY2Vzc2VzIGFu
ZCB1c2Ugb2Zmc2V0cyBmcm9tIHZkc28gY2FsbHMuDQo+ID4+ID4NCj4gPj4gPiBOb3cgb2Zmc2V0
cyBhcmUgaW1wbGVtZW50ZWQgZm9yIENMT0NLX01PTk9UT05JQyBhbmQgQ0xPQ0tfQk9PVFRJTUUN
Cj4gPj4gPiBjbG9ja3MuDQo+ID4+ID4NCj4gPj4gPiBRdWVzdGlvbnMgdG8gZGlzY3VzczoNCj4g
Pj4gPg0KPiA+PiA+ICogQ2xvbmUgZmxhZ3MgZXhoYXVzdGlvbi4gQ3VycmVudGx5IHRoZXJlIGlz
IG9ubHkgb25lIHVudXNlZCBjbG9uZSBmbGFnDQo+ID4+ID4gYml0IGxlZnQsIGFuZCBpdCBtYXkg
YmUgd29ydGggdG8gdXNlIGl0IHRvIGV4dGVuZCBhcmd1bWVudHMgb2YgdGhlIGNsb25lDQo+ID4+
ID4gc3lzdGVtIGNhbGwuDQo+ID4+ID4NCj4gPj4gPiAqIFJlYWx0aW1lIGNsb2NrIGltcGxlbWVu
dGF0aW9uIGRldGFpbHM6DQo+ID4+ID4gICBJcyBoYXZpbmcgYSBzaW1wbGUgb2Zmc2V0IGVub3Vn
aD8NCj4gPj4gPiAgIFdoYXQgdG8gZG8gd2hlbiBkYXRlIGFuZCB0aW1lIGlzIGNoYW5nZWQgb24g
dGhlIGhvc3Q/DQo+ID4+ID4gICBJcyB0aGVyZSBhIG5lZWQgdG8gYWRqdXN0IHZmcyBtb2RpZmlj
YXRpb24gYW5kIGNyZWF0aW9uIHRpbWVzPyANCj4gPj4gPiAgIEltcGxlbWVudGF0aW9uIGZvciBh
ZGp0aW1lKCkgc3lzY2FsbC4NCj4gPj4gDQo+ID4+IE92ZXJhbGwgSSBzdXBwb3J0IHRoaXMgZWZm
b3J0LiAgSW4gbXkgcXVpY2sgc2tpbSB0aGlzIGNvZGUgbG9va2VkIGdvb2QuDQo+ID4NCj4gPiBI
aSBFcmljLA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2suDQo+ID4NCj4gPj4g
DQo+ID4+IE15IGZlZWxpbmcgaXMgdGhhdCB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gc3VwcG9ydCBy
dW5uaW5nIG50cGQgYW5kDQo+ID4+IHN1cHBvcnQgb25lIG5hbWVzcGFjZSBkb2luZyBnb29nbGVz
IHNtb290aGluZyBvZiBsZWFwIHNlY29uZHMgd2hpbGUNCj4gPj4gYW5vdGhlciBuYW1lc3BhY2Ug
dGFrZXMgdGhlIGxlYXAgc2Vjb25kLg0KPiA+PiANCj4gPj4gV2hhdCBJIHdhcyBpbWFnaW5pbmcg
d2hlbiBJIHdhcyBsYXN0IHRoaW5raW5nIGFib3V0IHRoaXMgd2FzIG9uZQ0KPiA+PiBpbnN0YW5j
ZSBvZiBzdHJ1Y3QgdGltZWtlZXBlciBha2EgdGtfY29yZSBwZXIgdGltZSBuYW1lc3BhY2UuICBU
aGF0DQo+ID4+IHN0cnVjdHVyZSBhbHJlYWR5IGtlZXBzIG9mZnNldHMgZm9yIGFsbCBvZiB0aGUg
dmFyaW91cyBjbG9ja3MgZnJvbQ0KPiA+PiB0aGUga2VybmUgaW50ZXJuYWwgdGltZSBzb3VyY2Vz
LiAgV2hhdCB3b3VsZCBiZSBuZWVkZWQgd291bGQgYmUgdG8NCj4gPj4gcGFzcyBpbiBhbiBhcHBy
b3ByaWF0ZSB0aW1lIG5hbWVzcGFjZSBwb2ludGVyLg0KPiA+PiANCj4gPj4gSSBjb3VsZCBiZSBj
b21wbGV0ZWx5IHdyb25nIGFzIEkgaGF2ZSBub3QgdGFrZSB0aGUgdGltZSB0byBjb21wbGV0ZWx5
DQo+ID4+IHRyYWNlIHRocm91Z2ggdGhlIGNvZGUuICBIYXZlIHlvdSBsb29rZWQgYXQgcHVzaGlu
ZyB0aGUgdGltZSBuYW1lc3BhY2UNCj4gPj4gZG93biBhcyBmYXIgYXMgdGtfY29yZT8NCj4gPj4g
DQo+ID4+IFdoYXQgSSB0aGluayB3b3VsZCBiZSB0aGUgYmlnIGFkdmFudGFnZSAoYmVzaWRlcyBu
dHAgd29ya2luZykgaXMgdGhhdA0KPiA+PiB0aGUgYnVsayBvZiB0aGUgY29kZSBjb3VsZCBiZSBy
ZXVzZWQuICBBbGxvd2luZyB0ZXN0aW5nIG9mIHRoZSBrZXJuZWwncw0KPiA+PiB0aW1lIGNvZGUg
Ynkgc2V0dGluZyB1cCBhIG5ldyB0aW1lIG5hbWVzcGFjZS4gIFNvIGEgcGVyc29uIGluIHByb2R1
Y3Rpb24NCj4gPj4gY291bGQgc2V0dXAgYSB0aW1lIG5hbWVzcGFjZSB3aXRoIHRoZSB0aW1lIHNl
dCBhaGVhZCBhIGxpdHRsZSAgYml0IGFuZA0KPiA+PiBiZSBhYmxlIHRvIHZlcmlmeSB0aGF0IHRo
ZSBrZXJuZWwgaGFuZGxlcyB0aGUgdXBjb21pbmcgbGVhcCBzZWNvbmQNCj4gPj4gcHJvcGVybHku
DQo+ID4+DQo+ID4NCj4gPiBJdCBpcyBhbiBpbnRlcmVzdGluZyBpZGVhLCBidXQgSSBoYXZlIGEg
ZmV3IHF1ZXN0aW9uczoNCj4gPg0KPiA+IDEuIERvZXMgaXQgbWVhbiB0aGF0IHRpbWVrZWVwaW5n
X3VwZGF0ZSgpIHdpbGwgYmUgY2FsbGVkIGZvciBlYWNoDQo+ID4gbmFtZXNwYWNlPyBUaGlzIGZ1
bmN0aW9ucyBpcyBjYWxsZWQgcGVyaW9kaWNhbGx5LCBpdCB1cGRhdGVzIHRpbWVzIG9uIHRoZQ0K
PiA+IHRpbWVrZWVwZXIgc3RydWN0dXJlLCB1cGRhdGVzIHZzeXNjYWxsX2d0b2RfZGF0YSwgZXRj
LiBXaGF0IHdpbGwgYmUgYW4NCj4gPiBvdmVyaGVhZCBvZiB0aGlzPw0KPiANCj4gSSBkb24ndCBr
bm93IGlmIHBlcmlvZGljYWxseSBpcyBhIHByb3BlciBjaGFyYWN0ZXJpemF0aW9uLiAgVGhlcmUg
bWF5IGJlDQo+IGEgY29kZSBwYXRoIHRoYXQgZG9lcyB0aGF0LiAgQnV0IGZyb20gd2hhdCBJIGNh
biBzZWUgdGltZWtlZXBpbmdfdXBkYXRlDQo+IGlzIHRoZSBndXRzIG9mIHNldHRpbWVvZmRheSAo
YW5kIGEgZmV3IHJlbGF0ZWQgZnVuY3Rpb25zKS4NCj4gDQo+IFNvIGl0IGFwcGVhcnMgdG8gbWFr
ZSBzZW5zZSBmb3IgdGltZWtlZXBpbmdfdXBkYXRlIHRvIGJlIHBlciBuYW1lc3BhY2UuDQo+IA0K
PiBIbW0uICBMb29raW5nIGF0IHdoYXQgaXMgdXBkYXRlZCBpbiB0aGUgdnN5c2NhbGxfZ3RvZF9k
YXRhIGl0IGRvZXMNCj4gbG9vayBsaWtlIHlvdSB3b3VsZCBoYXZlIHRvIHBlcmlvZGljYWxseSB1
cGRhdGUgdGhpbmdzLCBidXQgSSBkb24ndCBrbm93DQo+IGJpZyB0aGF0IHBlcmlvZCB3b3VsZCBi
ZS4gIEFzIGxvbmcgYXMgdGhlIHBlcmlvZCBpcyByZWFzb25hYmx5IGxhcmdlLA0KPiBvciB0aGUg
dGltZSBuYW1lc3BhY2VzIHdlcmUgc3VmZmljaWVudGx5IGRlc2Nocm9uaXplZCBpdCBzaG91bGQg
bm90DQo+IGJlIGEgcHJvYmxlbS4gIEJ1dCB0aGF0IGlzIHRoZSBjbGFzcyBvZiBwcm9ibGVtIHRo
YXQgY291bGQgbWFrZQ0KPiBteSBpZGVhbCBpbXByYWN0aWNhbCBpZiB0aGVyZSBpcyBtZWFzdWFy
YWJsZSBvdmVyaGVhZC4NCj4gDQo+IFdoZXJlIHdlcmUgeW91IHNlZWluZyB0aW1la2VlcGluZ191
cGRhdGUgYmVpbmcgY2FsbGVkIHBlcmlvZGljYWxseT8NCg0KdGltZWtlZXBpbmdfdXBkYXRlKCkg
aXMgY2FsbGVkIEhaIHRpbWVzIHBlci1zZWNvbmQ6DQoNClsgICA2Ny45MTI4NThdICB0aW1la2Vl
cGluZ191cGRhdGUuY29sZC4yNisweDUvMHhhDQpbICAgNjcuOTEzMzMyXSAgdGltZWtlZXBpbmdf
YWR2YW5jZSsweDM2MS8weDVjMA0KWyAgIDY3LjkxMzg1N10gID8gdGlja19zY2hlZF9kb190aW1l
cisweDU1LzB4NzANClsgICA2Ny45MTQ0MDldICA/IHRpY2tfc2NoZWRfZG9fdGltZXIrMHg3MC8w
eDcwDQpbICAgNjcuOTE0OTQ3XSAgdGlja19zY2hlZF9kb190aW1lcisweDU1LzB4NzANClsgICA2
Ny45MTU1MDVdICB0aWNrX3NjaGVkX3RpbWVyKzB4MjcvMHg3MA0KWyAgIDY3LjkxNjA0Ml0gIF9f
aHJ0aW1lcl9ydW5fcXVldWVzKzB4MTBmLzB4NDQwDQpbICAgNjcuOTE2NjM5XSAgaHJ0aW1lcl9p
bnRlcnJ1cHQrMHgxMDAvMHgyMjANClsgICA2Ny45MTczMDVdICBzbXBfYXBpY190aW1lcl9pbnRl
cnJ1cHQrMHg3OS8weDIyMA0KWyAgIDY3LjkxODAzMF0gIGFwaWNfdGltZXJfaW50ZXJydXB0KzB4
Zi8weDIwDQoNCj4gDQo+ID4gMi4gV2hhdCB3aWxsIHdlIGRvIHdpdGggdmRzbz8gSXQgbG9va3Mg
bGlrZSB3ZSB3aWxsIGhhdmUgdG8gaGF2ZSBhDQo+ID4gc2VwYXJhdGUgdnN5c2NhbGxfZ3RvZF9k
YXRhIGZvciBlYWNoIG5zIGFuZCB1cGRhdGUgZWFjaCBvZiB0aGVtDQo+ID4gc2VwYXJhdGVseS4N
Cj4gDQo+IFllcy4gIEJ1dCB5b3UgZG9uJ3QgaGF2ZSB0byBoYXZlIGludHJvZHVjZSBhbm90aGVy
IHZhcmlhYmxlIGp1c3QgbWFrZQ0KPiBjZXJ0YWluIHZzeXNjYWxsX2d0b2RfZGF0YSBpcyBhIHBh
Z2UgYWxpZ25lZCB0aGluZyBwZXIgdGltZSBuYW1lc3BhY2UuDQo+IA0KPiBJZiBJIHJlYWQgdGhl
IHN1bW1hcnkgb2YgdGhlIGV4aXN0aW5nIHBhdGNoc2V0IHNvbWV0aGluZyB2ZXJ5IHNpbWlsaWFy
DQo+IGlzIGFscmVhZHkgZ29pbmcgb24uDQoNCkkgbWVhbiB2c3lzY2FsbF9ndG9kX2RhdGEgaGFz
IHNvbWUgZGF0YSB3aGljaCBhcmUgb2Z0ZW4gdXBkYXRlZC4gVGhlcmUNCmFyZSB0aW1lc3RhbXBz
IGZvciBtb25vdG9uaWMgYW5kIHdhbGwgY2xvY2tzLiBjbG9ja19nZXR0aW1lKCkgcmVhZHMgYQ0K
dGltZSBzdGFtcCBmcm9tIHZzeXNjYWxsX2d0b2RfZGF0YSBhbmQgdGhlbiB1c2UgdHNjIHRvIGFw
cHJveGltYXRlIHRoZQ0KY3VycmVudCB2YWx1ZSBvZiBhIGNsb2NrLg0KDQpBY3R1YWxseSwgdGhp
cyBpcyBub3QgdGhlIHNlY29uZCBxdWVzdGlvbiwgaXQgaXMgYSBwYXJ0IG9mIHRoZSBmaXJzdA0K
cXVlc3Rpb24uIHVwZGF0ZV92c3lzY2FsbCgpIGlzIGNhbGxlZCBmcm9tIHRpbWVrZWVwaW5nX3Vw
ZGF0ZSgpLg0KDQo+IA0KPiBFYWNoIHByb2Nlc3Mgd291bGQgb25seSBtYXAgb25lLiAgQW5kIHVu
c2hhcmUgb2YgdGhlIHRpbWUgbmFtZXNwYWNlDQo+IHdvdWxkIG5lZWQgdG8gYWN0IGxpa2UgdGhl
IHBpZCBuYW1lc3BhY2Ugb3IgYmUgbGltaXRlZCB0byBvbmx5IGJlaW5nDQo+IGFsbG93ZWQgd2hl
biB0aGVyZSBpcyBvbmx5IGEgc2luZ2xlIHRhc2sgdXNpbmcgdGhlIG1tLg0KPiANCj4gRXJpYw0K
