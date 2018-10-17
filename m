Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDC0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE84521473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BE9kjpHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE84521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeJRCUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:20:12 -0400
Received: from mail-bl2nam02on0076.outbound.protection.outlook.com ([104.47.38.76]:49769
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727672AbeJRCUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOX420WCATd+o9CkwgZ63CLlmMG7BSZcoEL0y8Ifu5o=;
 b=BE9kjpHBkXFkVP3E2/2Wk/TCi40XtMtb74ykev9PSziSmdPhUv2WWuoQ4xeJtvTz/8QTULSH341ycpISnHKj8rnlUn/73J0KAZusJIoN3MsjFLEbYU/o1rhjWp08geNOTx45S/dX4BrBH11i4tP2i4Pm/jQsn3UfSiY7tJ43ykw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1290.namprd12.prod.outlook.com (10.168.237.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 17 Oct 2018 18:23:14 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 18:23:14 +0000
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
Thread-Index: AQHUZXHOqsT656eCL0G131BxPAQCYqUhz9GAgACE8N+AANtDgIAAOJoAgABZaYA=
Date:   Wed, 17 Oct 2018 18:23:14 +0000
Message-ID: <64115578-930b-e9a6-6908-921ba27ca066@amd.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
 <20181016203215.GA39177@romley-ivt3.sc.intel.com>
 <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
 <9c99a95d-de9a-6b33-a4c4-074b31515a7e@amd.com>
In-Reply-To: <9c99a95d-de9a-6b33-a4c4-074b31515a7e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0003.namprd07.prod.outlook.com
 (2603:10b6:803:28::13) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1290;20:vet0++AmaX8c0T6g/MND3NlAS+3epx6c/BysV1jwZui6kuXPkupYieTiKXsLtd5yMMKngFBFHhxuBKotdbIl9d4RY4jpSWvh+DVqCHviCCoEu0wWUcR1IxPWtObNE3w8nmBosBXr/C3RurlekwtOsTY+AZWO7312/ICRymqGbfHV6q1CEF2a5xmZjQnn3fAeER58QfD/w4cQLqCX6Sd2BlF03FgD9ghyDJG5wejSLjszAEvquJUvI6Cbi6crX5ib
x-ms-office365-filtering-correlation-id: 7279a6ca-2930-441b-946f-08d6345d9a13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1290;
x-ms-traffictypediagnostic: DM5PR12MB1290:
x-microsoft-antispam-prvs: <DM5PR12MB12900CE40D4795BF84B9FDFC95FF0@DM5PR12MB1290.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(166708455590820)(788757137089)(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1290;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1290;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(57704003)(199004)(189003)(5660300001)(966005)(486006)(7416002)(86362001)(68736007)(446003)(6916009)(476003)(2616005)(11346002)(31696002)(99286004)(4326008)(76176011)(97736004)(54906003)(52116002)(14454004)(7736002)(93886005)(2900100001)(66066001)(305945005)(71200400001)(8676002)(2906002)(105586002)(36756003)(3846002)(71190400001)(106356001)(316002)(31686004)(102836004)(6116002)(6246003)(81156014)(53936002)(6506007)(6306002)(72206003)(256004)(14444005)(6486002)(186003)(6512007)(6436002)(81166006)(229853002)(8936002)(478600001)(53546011)(386003)(26005)(25786009)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1290;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uQet6qabhnjXoH79iF1MSdZQ9W0u8vaFGo4+e+9ojOVroCO4WPbJvloTY8U4c9ps9qJLZmoQvFABujLQfJhWXGb2q/KyAYU19K0+1nISbQQbJUJDy7fZdayukHPPzwx+1phHLZfdT0bYOq2yWRokF2IgByrYziQy6dlVZRFLFdNdOz+WelRbpWOZFnazQkKJwVTxYCG8Hu1VWloewk/hR8TJ2dkr+VuL/PyytuHt+2fOslL0YTEUGnoB/4Nk/30py4tCUSPtTjMg33rXlBOGQNtEjMu2V0ozQo76DB7QdyVvAsxJz3psMn9A1MhjSXjxbIQtBL4je0GaB6hj8nS8Fw8foHdVxZD9JNoGTsJ+ens=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D6EA586C08F142B721AFE84CFBEA4D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7279a6ca-2930-441b-946f-08d6345d9a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 18:23:14.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzE3LzIwMTggMDE6MDMgUE0sIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPiBIaSBGZW5n
aHVhLA0KPiAgTXkgZmV3IGNvbW1lbnRzLg0KPiANCj4gT24gMTAvMTcvMjAxOCAwOTo0MCBBTSwg
TW9nZXIsIEJhYnUgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEwLzE2LzIwMTggMDM6MzIgUE0sIEZl
bmdodWEgWXUgd3JvdGU6DQo+Pj4+IEZyb206IE1vZ2VyLCBCYWJ1IFttYWlsdG86QmFidS5Nb2dl
ckBhbWQuY29tXSANCj4+Pj4gT24gMTAvMTYvMjAxOCAxMTo1NiBBTSwgRmVuZ2h1YSBZdSB3cm90
ZToNCj4+Pj4+IFdpdGggbW9yZSBhbmQgbW9yZSByZXNjdHJsIGZlYXR1cmVzIGFyZSBiZWluZyBh
ZGRlZCBieSBJbnRlbCwgQU1EIGFuZCANCj4+Pj4+IEFSTSwgYSB0ZXN0IHRvb2wgaXMgYmVjb21p
bmcgbW9yZSBhbmQgbW9yZSB1c2VmdWwgdG8gdmFsaWRhdGUgdGhhdCANCj4+Pj4+IGJvdGggaGFy
ZHdhcmUgYW5kIHNvZnR3YXJlIGZ1bmN0aW9uYWxpdGllcyB3b3JrIGFzIGV4cGVjdGVkLg0KPj4+
Pg0KPj4+PiBJIGxpa2UgdGhlIGluaXRpYXRpdmUgaGVyZS4gSXQgaXMgYWx3YXlzIGdvb2QgdG8g
aGF2ZSBhIHNpbmdsZSBjb2RlIGJhc2UuDQo+Pj4+DQo+Pj4+IE9uZSBxdWVzdGlvbi4gSSBzZWUg
dGhhdCB0aGVyZSBpcyBhIHRvb2wgYXQgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2ludGVsLWNt
dC1jYXQgdG8gdGVzdCBhbmQgdmVyaWZ5IHRoZSBmdW5jdGlvbmFsaXR5IG9mIHJlc2N0cmwgZmVh
dHVyZS4gSSBhbHNvIHNlZSBzb21lIG9mIHRoZSBkaXN0cm9zIGhhdmUgdGhpcyB0b29sIGFscmVh
ZHkuDQo+Pj4+IElzIHRoaXMgdG9vbCBnb2luZyB0byByZXBsYWNlIGludGVsLWNtdC1jYXQ/IEkg
aGF2ZSBub3QgbG9va2VkIGF0IHRoZQ0KPj4+PiBwYXRjaGVzIGNsb3NlbHkgeWV0Lg0KPj4+DQo+
Pj4gTm8sIHRoZSBzZWxmdGVzdCBpbiB0aGlzIHBhdGNoIHNldCB3aWxsIG5vdCByZXBsYWNlIGlu
dGVsLWNtdC1jYXQgb3INCj4+PiB2aWNlIHZlcnNhLg0KPj4+DQo+Pj4gVGhlIHNlbGZ0ZXN0IGlu
IHRoaXMgcGF0Y2ggc2V0IGhhcyBhIGRpZmZlcmVudCBwdXJwb3NlIGZyb20gaW50ZWwtY210LWNh
dDoNCj4+PiB0aGUgc2VsZnRlc3QgaXMgYSB0ZXN0IHRvb2wgd2hpY2ggdmFsaWRhdGVzIHJlc2N0
cmwgZnVuY3Rpb25hbGl0aWVzIHdoaWxlDQo+Pj4gaW50ZWwtY210LWNhdCBpcyBtYWlubHkgYSB1
dGlsaXR5IHRoYXQgcHJvdmlkZXMgYmFzZSBsaWJyYXJ5IGZvciBoaWdoZXINCj4+PiBsZXZlbCBh
cHBsaWNhdGlvbnMgaW5jbHVkaW5nIHBlcmZvcm1hbmNlIGFuYWx5c2lzIHRvb2xzLCBiZW5jaG1h
cmsgbWVhc3VyZW1lbnQNCj4+PiB0b29scywgYW5kIHBvdGVudGlhbCByZXNjdHJsIHRlc3RzLiBG
b3IgZXhhbXBsZSwgcnVubmluZyBNQkEgdGVzdCBpbiB0aGUNCj4+PiBzZWxmdGVzdHMgdGVsbHMg
TUJBIHdvcmtpbmcgb3Igbm90IHdvcmtpbmcgKGZhaWwvcGFzcykgcmlnaHQgd2F5LiBUaGUNCj4+
DQo+PiBPay4gU3VyZS4gTGV0IG1lIHRha2UgYSBsb29rIGF0IHNlbGZ0ZXN0IGNsb3NlbHkuIFdp
bGwgc2VuZCBteSBmZWVkYmFjayBzb29uLg0KPj4NCj4+PiBpbnRlbC1jbXQtY2F0IGRvZXNuJ3Qg
aGF2ZSB0aGlzIHRlc3RpbmcgY2FwYWJpbGl0eSB1bmxlc3Mgd2UgZXh0ZW5kIHRoZQ0KPj4+IHRv
b2wuDQo+Pj4NCj4+PiBBbmQgaW50ZWwtY210LWNhdCBpcyBtYWludGFpbmVkIGFuZCBkZXZlbG9w
ZWQgYnkgSW50ZWwuIEkgZG9uJ3QgdGhpbmsgaXQncw0KPj4+IGVhc3kgdG8gZXh0ZW5kIGl0IHRv
IEFNRCBhbmQgQVJNIGZlYXR1cmVzLiBUaGUgc2VsZnRlc3Qgd2lsbCBiZSBtYWludGFpbmVkDQo+
Pg0KPj4gV2UxbC4uIFdlIHdlcmUgaG9waW5nIHRvIGhhdmUgYSBjb21tb24gdG9vbCBhY3Jvc3Mu
IEl0IG1ha2VzIGl0IGVhc3kgZm9yDQo+PiBkaXN0cm9zLiBQcm9iYWJseSwgd2UgY2FuIGhhdmUg
YSBzZXBhcmF0ZSBkaXNjdXNzaW9uIG9uIHRoaXMuDQo+Pg0KPj4+IGFuZCBkZXZlbG9wZWQgYnkg
dGhlIGNvbW11bml0eSBhbmQgd2lsbCBob3BlZnVsbHkgY292ZXIgYWxsIGFyY2hpdGVjdHVyZXMu
DQo+Pj4NCj4+PiBXZSBoYXZlIHNlZW4gYSBmZXcgaXNzdWVzIHJlY2VudGx5IGluIHJlc2N0cmwg
YW5kIG1heSBzZWUgbW9yZSBpc3N1ZXMNCj4+PiB3aGlsZSBleHBlbmRpbmcgdGhlIGZlYXR1cmVz
LiBBIGNvbnZldmllbnQgc2VsZnRlc3QgbWF5IGJlIHVzZWZ1bCB0byBoZWxwDQo+Pj4gaWRlbnRp
ZnkgYW5kIGZpeCB0aG9zZSBwb3RlbnRpYWwgaXNzdWVzLg0KPiANCj4gSSBkb24ndCBrbm93IHRo
ZSBydWxlcyBmb3Igc2VsZnRlc3QuIEhlcmUgYXJlIG15IGdlbmVyYWwgY29tbWVudHMuDQo+IA0K
PiAgMS4gRmlsZSBuYW1lcyBhcmUgbm90IGNvbnNpc3RlbnQuDQo+ICAgIyBscyAqLmMNCj4gICAg
ZmlsbF9idWYuYyAgbWJhLmMgIG1ibS5jICByZXNjdHJsLmMgIHJlc2N0cmxfbWVtYncuYyAgcmVz
Y3RybF90ZXN0cy5jDQo+ICAgRmV3IGZpbGVzIHN0YXJ0IHdpdGggcmVzY3RybF8gcHJlZml4IGFu
ZCBvdGhlcnMgZG9uJ3QuDQo+IA0KPiAgMi4gRG8gd2UgbmVlZCBSRUFETUUob3IgVVNBR0UpIGhl
cmU/IEkgaGFkIHRvbw0KPiANCg0KQ29ycmVjdGlvbi4uDQoNCjIuIERvIHdlIG5lZWQgUkVBRE1F
KG9yIFVTQUdFKSBoZXJlPyBJIGhhZCB0b28gbG9vayBhdCB0aGUgY29kZSB0byBjaGVjaw0Kb24g
InVzYWdlIG9wdGlvbnMiIHRvIHJ1biB0aGlzIHV0aWxpdHkuDQoNCj4gIDMuIEkgc2F3IGxvdHMg
b2YgdGhlc2UgZXJyb3JzLg0KPiAgICAgIm1iYS5jOjExMToyOiBlcnJvcjog4oCYZm9y4oCZIGxv
b3AgaW5pdGlhbCBkZWNsYXJhdGlvbnMgYXJlIG9ubHkgYWxsb3dlZA0KPiBpbiBDOTkgbW9kZSIN
Cj4gICBmb3IgKGludCBpID0gMDsgaSA8IDEwOyBpKyspIHsNCj4gICBeDQo+IA0KPiAgIEkgaGFk
IHRvIGNoYW5nZSBpdCB0bw0KPiAgICBpbnQgaTsNCj4gICAgZm9yIChpID0gMDsgaSA8IDEwOyBp
KyspIHsNCj4gDQo+IA0KPiANCj4+Pg0KPj4+IFRoYW5rcy4NCj4+Pg0KPj4+IC1GZW5naHVhIA0K
Pj4+ICANCj4+Pg0K
