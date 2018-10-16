Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D39C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDF321476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gq6ydHs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDF321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJQBbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:31:39 -0400
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:22287
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbeJQBbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vjLUj8zVSY6CvGLplwwx1w+0y1p3Mm6SuHehLT4cvw=;
 b=Gq6ydHs02InmnSDQ1fd7Y4xlIDBaxiA15VE1fokLaFS2uRCeUdW+g6N74TDUOp9iF7NQptbDM2kyEQsSKT5ZBBJYBNdGIzcl0oslSk4vqxWFYbVX3W4fQiKNarYy5ReXr9fMvhggKQYXyH9G/qhV9HlY+LwDYZ3xIFqRF2roIX0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1292.namprd12.prod.outlook.com (10.168.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Tue, 16 Oct 2018 17:40:03 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.020; Tue, 16 Oct 2018
 17:40:03 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUZXHOqsT656eCL0G131BxPAQCYqUiI6OA
Date:   Tue, 16 Oct 2018 17:40:03 +0000
Message-ID: <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1292;20:JmDLc6Q89UcqrHddzhKs+Twh8/bao7ToYliU8Jp6YDod5OuCAIABzwXFHN9VLYAaQ7wLdgQtdZSMhVXu5yougg68zRj5+3OLdR3gZdzQmfVYYtl7ts8VchPH73ACHlPEkLIx2OUa0ZG3MGiCA1Vq6966NW7+ErA3Bo5PEEHhy0odr8z6EwoPw0bu/nTJXmiFGbLiyqToMWjcPsWlJHwkqHYXEcffCZ9VF9dr1olEeNmp6IMHMfHWBL0juZKzf25e
x-ms-office365-filtering-correlation-id: a02525f9-bc60-4d5f-3282-08d6338e677e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1292;
x-ms-traffictypediagnostic: DM5PR12MB1292:
x-microsoft-antispam-prvs: <DM5PR12MB1292FE89943F1500B70E945F95FE0@DM5PR12MB1292.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(788757137089)(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1292;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1292;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(8936002)(81156014)(6512007)(14454004)(52116002)(106356001)(105586002)(26005)(2900100001)(5660300001)(66066001)(76176011)(36756003)(186003)(97736004)(256004)(8676002)(99286004)(966005)(72206003)(478600001)(7736002)(476003)(305945005)(5250100002)(3846002)(446003)(6246003)(6116002)(71190400001)(53936002)(2616005)(71200400001)(11346002)(316002)(81166006)(110136005)(31686004)(486006)(7416002)(386003)(31696002)(25786009)(4326008)(6486002)(6306002)(6506007)(6436002)(68736007)(14444005)(2906002)(53546011)(102836004)(86362001)(229853002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1292;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UUH+IMLSHbN29nUp8zZZLrFaMk/G2+OxhQt0CdoM6b/eds2ot+gO3GEW5CWZ5Qg4PMbb/Ei+2Neik6rN/PcnTiicSt0F8T+jYDhVx7jxE+NF+SqT9dF8oZFMTwzM/Ny6VlxdXO6JFrWKE3RbEtcl+28nByn0N5CGwm0txLym1DIK6Z/4FjaoGubBXod/L4kZVag0HyqQni6kFhZ83+daYh4b3IWPW+F588gEK1/583R4KuR/Putg2L0KuOsMHPpFu2pgCBQxQC46uxmEIYDRjP4X//czkYMcPEN7M5JYhlOOVFpyFEz8x8Cstr63NgJog0UxTju5otzLFuLOJrK60Fxgwptk6D6I2i3XnfvOZqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <301AE80228682A46A3E6349FB46B91FE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02525f9-bc60-4d5f-3282-08d6338e677e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 17:40:03.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVuZ2h1YSwNCg0KDQpPbiAxMC8xNi8yMDE4IDExOjU2IEFNLCBGZW5naHVhIFl1IHdyb3Rl
Og0KPiBXaXRoIG1vcmUgYW5kIG1vcmUgcmVzY3RybCBmZWF0dXJlcyBhcmUgYmVpbmcgYWRkZWQg
YnkgSW50ZWwsIEFNRA0KPiBhbmQgQVJNLCBhIHRlc3QgdG9vbCBpcyBiZWNvbWluZyBtb3JlIGFu
ZCBtb3JlIHVzZWZ1bCB0byB2YWxpZGF0ZQ0KPiB0aGF0IGJvdGggaGFyZHdhcmUgYW5kIHNvZnR3
YXJlIGZ1bmN0aW9uYWxpdGllcyB3b3JrIGFzIGV4cGVjdGVkLg0KDQpJIGxpa2UgdGhlIGluaXRp
YXRpdmUgaGVyZS4gSXQgaXMgYWx3YXlzIGdvb2QgdG8gaGF2ZSBhIHNpbmdsZSBjb2RlIGJhc2Uu
DQoNCk9uZSBxdWVzdGlvbi4gSSBzZWUgdGhhdCB0aGVyZSBpcyBhIHRvb2wgYXQNCmh0dHBzOi8v
Z2l0aHViLmNvbS9pbnRlbC9pbnRlbC1jbXQtY2F0IHRvIHRlc3QgYW5kIHZlcmlmeSB0aGUNCmZ1
bmN0aW9uYWxpdHkgb2YgcmVzY3RybCBmZWF0dXJlLiBJIGFsc28gc2VlIHNvbWUgb2YgdGhlIGRp
c3Ryb3MgaGF2ZSB0aGlzDQp0b29sIGFscmVhZHkuIElzIHRoaXMgdG9vbCBnb2luZyB0byByZXBs
YWNlIGludGVsLWNtdC1jYXQ/IEkgaGF2ZSBub3QNCmxvb2tlZCBhdCB0aGUgcGF0Y2hlcyBjbG9z
ZWx5IHlldC4NCg0KPiANCj4gV2UgaW50cm9kdWNlIHJlc2N0cmwgc2VsZnRlc3QgdG8gY292ZXIg
cmVzY3RybCBmZWF0dXJlcyBvbiBib3RoDQo+IFg4NiBhbmQgQVJNIGFyY2hpdGVjdHVyZXMuIEl0
IGZpcnN0IGltcGxlbWVudHMgTUJNIChNZW1vcnkgQmFuZHdpZHRoDQo+IE1vbml0b3JpbmcpIGFu
ZCBNQkEgKE1lbW9yeSBCYW5kd2lkdGggQWxsb2NhdGlvbikgdGVzdHMuIFdlIGNhbiBlbmhhbmNl
DQo+IHRoZSBzZWxmdGVzdCB0b29sIHRvIGluY2x1ZGUgbW9yZSBmdW5jdGlvbmFsaXR5IHRlc3Rz
IGluIGZ1dHVyZS4NCj4gDQo+IFRoZSB0ZXN0cyBhcmUgaW4gdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvcmVzY3RybCBpbiBvcmRlciB0byBoYXZlDQo+IGdlbmVyaWMgdGVzdCBjb2RlIGZvciBhbGwg
YXJjaGl0ZWN0dXJlcy4NCj4gDQo+IEFyc2hpeWEgSGF5YXRraGFuIFBhdGhhbiAoMik6DQo+ICAg
c2VsZnRlc3RzL3Jlc2N0cmw6IEFkZCBtYm0gdGVzdA0KPiAgIHNlbGZ0ZXN0cy9yZXNjdHJsOiBB
ZGQgbWJhIHRlc3QNCj4gDQo+IEZlbmdodWEgWXUgKDEpOg0KPiAgIHNlbGZ0ZXN0cy9yZXNjdHJs
OiBBZGQgdGhlIHRlc3QgaW4gTUFJTlRBSU5FUlMNCj4gDQo+IFNhaSBQcmFuZWV0aCBQcmFraHlh
ICg0KToNCj4gICBzZWxmdGVzdHMvcmVzY3RybDogQWRkIGJhc2ljIHJlc2N0cmwgZmlsZSBzeXN0
ZW0gb3BlcmF0aW9ucyBhbmQgZGF0YQ0KPiAgIHNlbGZ0ZXN0cy9yZXNjdHJsOiBSZWFkIG1lbW9y
eSBiYW5kd2lkdGggZnJvbSBwZXJmIElNQyBjb3VudGVyIGFuZA0KPiAgICAgZnJvbSByZXNjdHJs
IGZpbGUgc3lzdGVtDQo+ICAgc2VsZnRlc3RzL3Jlc2N0cmw6IEFkZCBjYWxsYmFjayB0byBzdGFy
dCBhIGJlbmNobWFyaw0KPiAgIHNlbGZ0ZXN0cy9yZXNjdHJsOiBBZGQgYnVpbHQgaW4gYmVuY2ht
YXJrDQo+IA0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9NYWtlZmlsZSAg
ICAgICAgfCAgMTYgKysNCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9i
dWYuYyAgICAgIHwgMTc4ICsrKysrKysrKysrKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9tYmEuYyAgICAgICAgICAgfCAxNDQgKysrKysrKysrKw0KPiAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9tYm0uYyAgICAgICAgICAgfCAxMTMgKysrKysrKysNCj4gIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybC5jICAgICAgIHwgMzY3ICsrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9y
ZXNjdHJsLmggICAgICAgfCAxMDcgKysrKysrKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9yZXNjdHJsX21lbWJ3LmMgfCAzMjggKysrKysrKysrKysrKysrKysrKysrDQo+ICB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfbWVtYncuaCB8ICA0OSArKysr
DQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYyB8IDEw
NCArKysrKysrDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdmFs
LmMgICB8IDE5MiArKysrKysrKysrKysrDQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCAxNTk5IGluc2Vy
dGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
ZXNjdHJsL01ha2VmaWxlDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYmEuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvbWJtLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmwuYw0KPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybC5oDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX21l
bWJ3LmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNj
dHJsL3Jlc2N0cmxfbWVtYncuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybF90ZXN0cy5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3ZhbC5jDQo+IA0K
