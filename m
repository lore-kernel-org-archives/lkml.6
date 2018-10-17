Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE673ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F99A2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BqCFt4Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F99A2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJQWhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:37:00 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:12438
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbeJQWhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znCXfe+AP1y8MJBkp02Ypx+p0mO1rMPsE9foG8Uxur8=;
 b=BqCFt4Wx3taFwQ/Rv0XRGPq06wr3hoZoyPQT7ABxZwzSvYpQ1SWA8vhExoqh8tibdydys7BJXw6cVIWfBrxW9Y77O+VKhEzj9VKluiBCBkwlPPc79dYdEdvGYFkQDLhH9XRgJP4P6VnvNmw7RgWsx5Ffwb9dxHEpSiW44hoaKVM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1932.namprd12.prod.outlook.com (10.175.89.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 17 Oct 2018 14:40:42 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 14:40:40 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUZXHOqsT656eCL0G131BxPAQCYqUhz9GAgACE8N+AAS8VgA==
Date:   Wed, 17 Oct 2018 14:40:40 +0000
Message-ID: <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
 <20181016203215.GA39177@romley-ivt3.sc.intel.com>
In-Reply-To: <20181016203215.GA39177@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:805:3e::43) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1932;20:Y1wM8S/59LXcWBiaXzhkATSkVQkHNkW9EPTOaKbo6AUwB+MotmWCtiFEZCg23b3x/2UV/o9sNF0BtstLmQcfnTLdoSXKCcbpshnFCJ3cSxWKllsw4b5fLFp6bglhCjveQj4nIKw4QGdvd59BIciVaUcPQu/LJ7NZnMXaA1aNxylZownMGDQEGVbFlEl4OFr5NyoFhRB1KsT8F1djnLPIIpH6a2/zPoDL+kOQSB6JgODockRPFLGFYXuTLt7ogyrc
x-ms-office365-filtering-correlation-id: 9568b870-5f35-4279-a7fb-08d6343e81e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1932;
x-ms-traffictypediagnostic: DM5PR12MB1932:
x-microsoft-antispam-prvs: <DM5PR12MB1932C973C2004A82C2E96DDC95FF0@DM5PR12MB1932.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(166708455590820)(788757137089)(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1932;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1932;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(14454004)(31696002)(52116002)(966005)(105586002)(305945005)(106356001)(72206003)(6116002)(3846002)(86362001)(2906002)(7416002)(7736002)(99286004)(31686004)(66066001)(54906003)(478600001)(316002)(93886005)(5660300001)(486006)(8936002)(8676002)(71190400001)(6916009)(11346002)(476003)(71200400001)(446003)(2616005)(5250100002)(6436002)(81166006)(6512007)(97736004)(4326008)(36756003)(6306002)(6246003)(229853002)(14444005)(256004)(6486002)(386003)(53546011)(2900100001)(6506007)(26005)(102836004)(76176011)(68736007)(81156014)(53936002)(25786009)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1932;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xEEKiKVtWDYmVnuqBY0fZH1Gq43bJlcOUSBbskb+7gEyXR2+jh6hPTJOoRF/xvk+qhOid29qvzihWu/md0UFqaGWvnTN+itdjf8izUykmg2E1lgTwAx1a2wPtvykid8C3UTAHjnHU3WHh78tXsFXbSb/O65ay3VReC/lrLIGja70YBZ27vqfbpjAMRENKpLuWkZK4NXvpfnbnzhPazadTPhPMDyVnrtwoOBTV19/m7AoLas6A8GS6uVh6So4mf6UXLp6Lq6V3AVW/cxXH5QXHxwZlwQFk208dTMzDkTGxgcqoiFcAY5F8IYPjkCC/VYh1SVn2LXGHb3Uog+PNtZoCTnIaVrvi1+PQ2nwoXyFZOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9D247315937A746B84CCF9E5A142394@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9568b870-5f35-4279-a7fb-08d6343e81e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 14:40:40.3957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzE2LzIwMTggMDM6MzIgUE0sIEZlbmdodWEgWXUgd3JvdGU6DQo+PiBGcm9tOiBN
b2dlciwgQmFidSBbbWFpbHRvOkJhYnUuTW9nZXJAYW1kLmNvbV0gDQo+PiBPbiAxMC8xNi8yMDE4
IDExOjU2IEFNLCBGZW5naHVhIFl1IHdyb3RlOg0KPj4+IFdpdGggbW9yZSBhbmQgbW9yZSByZXNj
dHJsIGZlYXR1cmVzIGFyZSBiZWluZyBhZGRlZCBieSBJbnRlbCwgQU1EIGFuZCANCj4+PiBBUk0s
IGEgdGVzdCB0b29sIGlzIGJlY29taW5nIG1vcmUgYW5kIG1vcmUgdXNlZnVsIHRvIHZhbGlkYXRl
IHRoYXQgDQo+Pj4gYm90aCBoYXJkd2FyZSBhbmQgc29mdHdhcmUgZnVuY3Rpb25hbGl0aWVzIHdv
cmsgYXMgZXhwZWN0ZWQuDQo+Pg0KPj4gSSBsaWtlIHRoZSBpbml0aWF0aXZlIGhlcmUuIEl0IGlz
IGFsd2F5cyBnb29kIHRvIGhhdmUgYSBzaW5nbGUgY29kZSBiYXNlLg0KPj4NCj4+IE9uZSBxdWVz
dGlvbi4gSSBzZWUgdGhhdCB0aGVyZSBpcyBhIHRvb2wgYXQgaHR0cHM6Ly9naXRodWIuY29tL2lu
dGVsL2ludGVsLWNtdC1jYXQgdG8gdGVzdCBhbmQgdmVyaWZ5IHRoZSBmdW5jdGlvbmFsaXR5IG9m
IHJlc2N0cmwgZmVhdHVyZS4gSSBhbHNvIHNlZSBzb21lIG9mIHRoZSBkaXN0cm9zIGhhdmUgdGhp
cyB0b29sIGFscmVhZHkuDQo+PiBJcyB0aGlzIHRvb2wgZ29pbmcgdG8gcmVwbGFjZSBpbnRlbC1j
bXQtY2F0PyBJIGhhdmUgbm90IGxvb2tlZCBhdCB0aGUNCj4+IHBhdGNoZXMgY2xvc2VseSB5ZXQu
DQo+IA0KPiBObywgdGhlIHNlbGZ0ZXN0IGluIHRoaXMgcGF0Y2ggc2V0IHdpbGwgbm90IHJlcGxh
Y2UgaW50ZWwtY210LWNhdCBvcg0KPiB2aWNlIHZlcnNhLg0KPiANCj4gVGhlIHNlbGZ0ZXN0IGlu
IHRoaXMgcGF0Y2ggc2V0IGhhcyBhIGRpZmZlcmVudCBwdXJwb3NlIGZyb20gaW50ZWwtY210LWNh
dDoNCj4gdGhlIHNlbGZ0ZXN0IGlzIGEgdGVzdCB0b29sIHdoaWNoIHZhbGlkYXRlcyByZXNjdHJs
IGZ1bmN0aW9uYWxpdGllcyB3aGlsZQ0KPiBpbnRlbC1jbXQtY2F0IGlzIG1haW5seSBhIHV0aWxp
dHkgdGhhdCBwcm92aWRlcyBiYXNlIGxpYnJhcnkgZm9yIGhpZ2hlcg0KPiBsZXZlbCBhcHBsaWNh
dGlvbnMgaW5jbHVkaW5nIHBlcmZvcm1hbmNlIGFuYWx5c2lzIHRvb2xzLCBiZW5jaG1hcmsgbWVh
c3VyZW1lbnQNCj4gdG9vbHMsIGFuZCBwb3RlbnRpYWwgcmVzY3RybCB0ZXN0cy4gRm9yIGV4YW1w
bGUsIHJ1bm5pbmcgTUJBIHRlc3QgaW4gdGhlDQo+IHNlbGZ0ZXN0cyB0ZWxscyBNQkEgd29ya2lu
ZyBvciBub3Qgd29ya2luZyAoZmFpbC9wYXNzKSByaWdodCB3YXkuIFRoZQ0KDQpPay4gU3VyZS4g
TGV0IG1lIHRha2UgYSBsb29rIGF0IHNlbGZ0ZXN0IGNsb3NlbHkuIFdpbGwgc2VuZCBteSBmZWVk
YmFjayBzb29uLg0KDQo+IGludGVsLWNtdC1jYXQgZG9lc24ndCBoYXZlIHRoaXMgdGVzdGluZyBj
YXBhYmlsaXR5IHVubGVzcyB3ZSBleHRlbmQgdGhlDQo+IHRvb2wuDQo+IA0KPiBBbmQgaW50ZWwt
Y210LWNhdCBpcyBtYWludGFpbmVkIGFuZCBkZXZlbG9wZWQgYnkgSW50ZWwuIEkgZG9uJ3QgdGhp
bmsgaXQncw0KPiBlYXN5IHRvIGV4dGVuZCBpdCB0byBBTUQgYW5kIEFSTSBmZWF0dXJlcy4gVGhl
IHNlbGZ0ZXN0IHdpbGwgYmUgbWFpbnRhaW5lZA0KDQpXZTFsLi4gV2Ugd2VyZSBob3BpbmcgdG8g
aGF2ZSBhIGNvbW1vbiB0b29sIGFjcm9zcy4gSXQgbWFrZXMgaXQgZWFzeSBmb3INCmRpc3Ryb3Mu
IFByb2JhYmx5LCB3ZSBjYW4gaGF2ZSBhIHNlcGFyYXRlIGRpc2N1c3Npb24gb24gdGhpcy4NCg0K
PiBhbmQgZGV2ZWxvcGVkIGJ5IHRoZSBjb21tdW5pdHkgYW5kIHdpbGwgaG9wZWZ1bGx5IGNvdmVy
IGFsbCBhcmNoaXRlY3R1cmVzLg0KPiANCj4gV2UgaGF2ZSBzZWVuIGEgZmV3IGlzc3VlcyByZWNl
bnRseSBpbiByZXNjdHJsIGFuZCBtYXkgc2VlIG1vcmUgaXNzdWVzDQo+IHdoaWxlIGV4cGVuZGlu
ZyB0aGUgZmVhdHVyZXMuIEEgY29udmV2aWVudCBzZWxmdGVzdCBtYXkgYmUgdXNlZnVsIHRvIGhl
bHANCj4gaWRlbnRpZnkgYW5kIGZpeCB0aG9zZSBwb3RlbnRpYWwgaXNzdWVzLg0KPiANCj4gVGhh
bmtzLg0KPiANCj4gLUZlbmdodWEgDQo+ICANCj4gDQo=
