Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0045ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C9C2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="afebDwnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C9C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeJRCAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:00:06 -0400
Received: from mail-by2nam03on0051.outbound.protection.outlook.com ([104.47.42.51]:27472
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbeJRCAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPDFff37hl1SIDWxqklwNDonCO8ZRkPMoBkvUWeu8Rg=;
 b=afebDwnH+PFejxKjmXQPCKdasVoo68O2BNX2bZWm29Vh8MFb9TyiRYNfwPNcI8zTGClCHKhzIk4JXHpoB+2pd5iGo/p60dFV8/OMufPx4an1oCVFQxeoSDrgWVtVw0WKKcDsm/itT6r2cj7QkVaqCuTQZSAVuAxGd2Pc6/wFnbw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2470.namprd12.prod.outlook.com (52.132.141.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 17 Oct 2018 18:03:13 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 18:03:13 +0000
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
Thread-Index: AQHUZXHOqsT656eCL0G131BxPAQCYqUhz9GAgACE8N+AANtDgIAAjGwA
Date:   Wed, 17 Oct 2018 18:03:13 +0000
Message-ID: <9c99a95d-de9a-6b33-a4c4-074b31515a7e@amd.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
 <20181016203215.GA39177@romley-ivt3.sc.intel.com>
 <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
In-Reply-To: <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR1501CA0016.namprd15.prod.outlook.com
 (2603:10b6:805::29) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2470;20:gIYQd7cvKd4l/KnmoZWPTbQ1Cc+TDn8mELXzFb1zYJwqbSVv8M9aFWJoP0oTmnnXmJw7BAeEwpXf9GusZFcbx8tzuLfM8VP/JJiJUDQ3D1VUz67Q0Xv0Ojd8bGybK84ynOuNplkivI+KOUjPnZWYQW4Aw0QXr+Ja0CWQQE+zGkoOvUw6Kq9Sha3UC64BmYANqAozttyMjGNMIbKSdPxvEcdUsESppBOOV9vOXhdQz5tSoxeM8iRp7PG1/SvkSPh6
x-ms-office365-filtering-correlation-id: 99d50ebf-0335-4c2a-745d-08d6345ace45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2470;
x-ms-traffictypediagnostic: DM5PR12MB2470:
x-microsoft-antispam-prvs: <DM5PR12MB2470CA6F6E509EA4C0EBCFBD95FF0@DM5PR12MB2470.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(166708455590820)(788757137089)(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2470;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2470;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(366004)(396003)(199004)(189003)(57704003)(52116002)(3846002)(6916009)(5660300001)(229853002)(99286004)(2900100001)(36756003)(6512007)(66066001)(6306002)(6436002)(53936002)(7416002)(6116002)(31686004)(76176011)(105586002)(54906003)(53546011)(106356001)(386003)(6506007)(966005)(316002)(478600001)(81156014)(81166006)(72206003)(31696002)(26005)(86362001)(256004)(14444005)(5250100002)(14454004)(8936002)(8676002)(93886005)(97736004)(4326008)(71190400001)(25786009)(2906002)(7736002)(305945005)(71200400001)(6246003)(6486002)(186003)(102836004)(486006)(446003)(11346002)(68736007)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2470;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cPkJlzRwB0DF+GUwNqs5002operLpXa465SXq+sscyCeBYM70QH5eoyS7UNctftJuKwGPxPqoB6OYyhLBxJHlzzJQlB52TvxHbsMCWwka+AUkvQRTaUUvNczblJ2wmyOklrVDI/URussAMRxBRvNyjfq/xzYaF3lewAE5584tl0bQmA3SAOEsmNHRNtrhwsX+L5jxr7igutFevLRK6zdz+qz6Zrvwnd4pdVtrXcC3uwaGYgPfBfDAOfUi7Ax/ySsVgCpP66gxJEOlSIsUkB7rk2E0jI3mQKbbkLnbNV7gjnD5FPhc6m0/bZVxIl4l5/Qsv/kLfGI2GOQSWqJI3VmRmd67WWpwkbESU2n46Yf5Io=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B59E79A92F29B4E94383E066017EA34@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d50ebf-0335-4c2a-745d-08d6345ace45
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 18:03:13.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVuZ2h1YSwNCiBNeSBmZXcgY29tbWVudHMuDQoNCk9uIDEwLzE3LzIwMTggMDk6NDAgQU0s
IE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEwLzE2LzIwMTggMDM6MzIgUE0sIEZl
bmdodWEgWXUgd3JvdGU6DQo+Pj4gRnJvbTogTW9nZXIsIEJhYnUgW21haWx0bzpCYWJ1Lk1vZ2Vy
QGFtZC5jb21dIA0KPj4+IE9uIDEwLzE2LzIwMTggMTE6NTYgQU0sIEZlbmdodWEgWXUgd3JvdGU6
DQo+Pj4+IFdpdGggbW9yZSBhbmQgbW9yZSByZXNjdHJsIGZlYXR1cmVzIGFyZSBiZWluZyBhZGRl
ZCBieSBJbnRlbCwgQU1EIGFuZCANCj4+Pj4gQVJNLCBhIHRlc3QgdG9vbCBpcyBiZWNvbWluZyBt
b3JlIGFuZCBtb3JlIHVzZWZ1bCB0byB2YWxpZGF0ZSB0aGF0IA0KPj4+PiBib3RoIGhhcmR3YXJl
IGFuZCBzb2Z0d2FyZSBmdW5jdGlvbmFsaXRpZXMgd29yayBhcyBleHBlY3RlZC4NCj4+Pg0KPj4+
IEkgbGlrZSB0aGUgaW5pdGlhdGl2ZSBoZXJlLiBJdCBpcyBhbHdheXMgZ29vZCB0byBoYXZlIGEg
c2luZ2xlIGNvZGUgYmFzZS4NCj4+Pg0KPj4+IE9uZSBxdWVzdGlvbi4gSSBzZWUgdGhhdCB0aGVy
ZSBpcyBhIHRvb2wgYXQgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2ludGVsLWNtdC1jYXQgdG8g
dGVzdCBhbmQgdmVyaWZ5IHRoZSBmdW5jdGlvbmFsaXR5IG9mIHJlc2N0cmwgZmVhdHVyZS4gSSBh
bHNvIHNlZSBzb21lIG9mIHRoZSBkaXN0cm9zIGhhdmUgdGhpcyB0b29sIGFscmVhZHkuDQo+Pj4g
SXMgdGhpcyB0b29sIGdvaW5nIHRvIHJlcGxhY2UgaW50ZWwtY210LWNhdD8gSSBoYXZlIG5vdCBs
b29rZWQgYXQgdGhlDQo+Pj4gcGF0Y2hlcyBjbG9zZWx5IHlldC4NCj4+DQo+PiBObywgdGhlIHNl
bGZ0ZXN0IGluIHRoaXMgcGF0Y2ggc2V0IHdpbGwgbm90IHJlcGxhY2UgaW50ZWwtY210LWNhdCBv
cg0KPj4gdmljZSB2ZXJzYS4NCj4+DQo+PiBUaGUgc2VsZnRlc3QgaW4gdGhpcyBwYXRjaCBzZXQg
aGFzIGEgZGlmZmVyZW50IHB1cnBvc2UgZnJvbSBpbnRlbC1jbXQtY2F0Og0KPj4gdGhlIHNlbGZ0
ZXN0IGlzIGEgdGVzdCB0b29sIHdoaWNoIHZhbGlkYXRlcyByZXNjdHJsIGZ1bmN0aW9uYWxpdGll
cyB3aGlsZQ0KPj4gaW50ZWwtY210LWNhdCBpcyBtYWlubHkgYSB1dGlsaXR5IHRoYXQgcHJvdmlk
ZXMgYmFzZSBsaWJyYXJ5IGZvciBoaWdoZXINCj4+IGxldmVsIGFwcGxpY2F0aW9ucyBpbmNsdWRp
bmcgcGVyZm9ybWFuY2UgYW5hbHlzaXMgdG9vbHMsIGJlbmNobWFyayBtZWFzdXJlbWVudA0KPj4g
dG9vbHMsIGFuZCBwb3RlbnRpYWwgcmVzY3RybCB0ZXN0cy4gRm9yIGV4YW1wbGUsIHJ1bm5pbmcg
TUJBIHRlc3QgaW4gdGhlDQo+PiBzZWxmdGVzdHMgdGVsbHMgTUJBIHdvcmtpbmcgb3Igbm90IHdv
cmtpbmcgKGZhaWwvcGFzcykgcmlnaHQgd2F5LiBUaGUNCj4gDQo+IE9rLiBTdXJlLiBMZXQgbWUg
dGFrZSBhIGxvb2sgYXQgc2VsZnRlc3QgY2xvc2VseS4gV2lsbCBzZW5kIG15IGZlZWRiYWNrIHNv
b24uDQo+IA0KPj4gaW50ZWwtY210LWNhdCBkb2Vzbid0IGhhdmUgdGhpcyB0ZXN0aW5nIGNhcGFi
aWxpdHkgdW5sZXNzIHdlIGV4dGVuZCB0aGUNCj4+IHRvb2wuDQo+Pg0KPj4gQW5kIGludGVsLWNt
dC1jYXQgaXMgbWFpbnRhaW5lZCBhbmQgZGV2ZWxvcGVkIGJ5IEludGVsLiBJIGRvbid0IHRoaW5r
IGl0J3MNCj4+IGVhc3kgdG8gZXh0ZW5kIGl0IHRvIEFNRCBhbmQgQVJNIGZlYXR1cmVzLiBUaGUg
c2VsZnRlc3Qgd2lsbCBiZSBtYWludGFpbmVkDQo+IA0KPiBXZTFsLi4gV2Ugd2VyZSBob3Bpbmcg
dG8gaGF2ZSBhIGNvbW1vbiB0b29sIGFjcm9zcy4gSXQgbWFrZXMgaXQgZWFzeSBmb3INCj4gZGlz
dHJvcy4gUHJvYmFibHksIHdlIGNhbiBoYXZlIGEgc2VwYXJhdGUgZGlzY3Vzc2lvbiBvbiB0aGlz
Lg0KPiANCj4+IGFuZCBkZXZlbG9wZWQgYnkgdGhlIGNvbW11bml0eSBhbmQgd2lsbCBob3BlZnVs
bHkgY292ZXIgYWxsIGFyY2hpdGVjdHVyZXMuDQo+Pg0KPj4gV2UgaGF2ZSBzZWVuIGEgZmV3IGlz
c3VlcyByZWNlbnRseSBpbiByZXNjdHJsIGFuZCBtYXkgc2VlIG1vcmUgaXNzdWVzDQo+PiB3aGls
ZSBleHBlbmRpbmcgdGhlIGZlYXR1cmVzLiBBIGNvbnZldmllbnQgc2VsZnRlc3QgbWF5IGJlIHVz
ZWZ1bCB0byBoZWxwDQo+PiBpZGVudGlmeSBhbmQgZml4IHRob3NlIHBvdGVudGlhbCBpc3N1ZXMu
DQoNCkkgZG9uJ3Qga25vdyB0aGUgcnVsZXMgZm9yIHNlbGZ0ZXN0LiBIZXJlIGFyZSBteSBnZW5l
cmFsIGNvbW1lbnRzLg0KDQogMS4gRmlsZSBuYW1lcyBhcmUgbm90IGNvbnNpc3RlbnQuDQogICMg
bHMgKi5jDQogICBmaWxsX2J1Zi5jICBtYmEuYyAgbWJtLmMgIHJlc2N0cmwuYyAgcmVzY3RybF9t
ZW1idy5jICByZXNjdHJsX3Rlc3RzLmMNCiAgRmV3IGZpbGVzIHN0YXJ0IHdpdGggcmVzY3RybF8g
cHJlZml4IGFuZCBvdGhlcnMgZG9uJ3QuDQoNCiAyLiBEbyB3ZSBuZWVkIFJFQURNRShvciBVU0FH
RSkgaGVyZT8gSSBoYWQgdG9vDQoNCiAzLiBJIHNhdyBsb3RzIG9mIHRoZXNlIGVycm9ycy4NCiAg
ICAibWJhLmM6MTExOjI6IGVycm9yOiDigJhmb3LigJkgbG9vcCBpbml0aWFsIGRlY2xhcmF0aW9u
cyBhcmUgb25seSBhbGxvd2VkDQppbiBDOTkgbW9kZSINCiAgZm9yIChpbnQgaSA9IDA7IGkgPCAx
MDsgaSsrKSB7DQogIF4NCg0KICBJIGhhZCB0byBjaGFuZ2UgaXQgdG8NCiAgIGludCBpOw0KICAg
Zm9yIChpID0gMDsgaSA8IDEwOyBpKyspIHsNCg0KDQoNCj4+DQo+PiBUaGFua3MuDQo+Pg0KPj4g
LUZlbmdodWEgDQo+PiAgDQo+Pg0K
