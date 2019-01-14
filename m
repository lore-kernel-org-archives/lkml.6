Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A39C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BA920873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfANRxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:53:17 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:49485 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfANRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:53:17 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x0EHqduL031134
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 02:52:39 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0EHqd30025776;
        Tue, 15 Jan 2019 02:52:39 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x0EHqd76031839;
        Tue, 15 Jan 2019 02:52:39 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-1426923; Tue, 15 Jan 2019 02:48:49 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Tue,
 15 Jan 2019 02:48:49 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, Lianbo Jiang <lijiang@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "anderson@redhat.com" <anderson@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Thread-Topic: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Thread-Index: AQHUqanRWrQHojgMdkmYmMqmVCp2bqWvBVMw
Date:   Mon, 14 Jan 2019 17:48:48 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic>
In-Reply-To: <20190111123300.GE4729@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.135.126]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xMS8yMDE5IDc6MzMgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBK
YW4gMTAsIDIwMTkgYXQgMDg6MTk6NDNQTSArMDgwMCwgTGlhbmJvIEppYW5nIHdyb3RlOg0KPj4g
K2luaXRfdXRzX25zLm5hbWUucmVsZWFzZQ0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gKw0KPj4gK1RoZSB2ZXJzaW9uIG9mIHRoZSBMaW51eCBrZXJuZWwuIFVzZWQgdG8gZmluZCB0
aGUgY29ycmVzcG9uZGluZyBzb3VyY2UNCj4+ICtjb2RlIGZyb20gd2hpY2ggdGhlIGtlcm5lbCBo
YXMgYmVlbiBidWlsdC4NCj4+ICsNCj4gDQo+IC4uLg0KPiANCj4+ICsNCj4+ICtpbml0X3V0c19u
cw0KPj4gKy0tLS0tLS0tLS0tDQo+PiArDQo+PiArVGhpcyBpcyB0aGUgVVRTIG5hbWVzcGFjZSwg
d2hpY2ggaXMgdXNlZCB0byBpc29sYXRlIHR3byBzcGVjaWZpYw0KPj4gK2VsZW1lbnRzIG9mIHRo
ZSBzeXN0ZW0gdGhhdCByZWxhdGUgdG8gdGhlIHVuYW1lKDIpIHN5c3RlbSBjYWxsLiBUaGUgVVRT
DQo+PiArbmFtZXNwYWNlIGlzIG5hbWVkIGFmdGVyIHRoZSBkYXRhIHN0cnVjdHVyZSB1c2VkIHRv
IHN0b3JlIGluZm9ybWF0aW9uDQo+PiArcmV0dXJuZWQgYnkgdGhlIHVuYW1lKDIpIHN5c3RlbSBj
YWxsLg0KPj4gKw0KPj4gK1VzZXItc3BhY2UgdG9vbHMgY2FuIGdldCB0aGUga2VybmVsIG5hbWUs
IGhvc3QgbmFtZSwga2VybmVsIHJlbGVhc2UNCj4+ICtudW1iZXIsIGtlcm5lbCB2ZXJzaW9uLCBh
cmNoaXRlY3R1cmUgbmFtZSBhbmQgT1MgdHlwZSBmcm9tIGl0Lg0KPiANCj4gQWxyZWFkeSBhc2tl
ZCB0aGlzIGJ1dCBubyByZXBseSBzbyBsZW1tZSBwYXN0ZSBteSBxdWVzdGlvbiBhZ2FpbjoNCj4g
DQo+ICJBbmQgdGhpcyBkb2N1bWVudCBhbHJlYWR5IGZ1bGZpbGxzIGl0cyBwdXJwb3NlIC0gdGhv
c2UgdHdvIHZtY29yZWluZm8NCj4gZXhwb3J0cyBhcmUgcmVkdW5kYW50IGFuZCB0aGUgZmlyc3Qg
b25lIGNhbiBiZSByZW1vdmVkLg0KPiANCj4gQW5kIG5vdyB0aGF0IHdlIGFncmVlZCB0aGF0IFZN
Q09SRUlORk8gaXMgbm90IGFuIEFCSSBhbmQgaXMgdmVyeSB0aWdodGx5DQo+IGNvdXBsZWQgdG8g
dGhlIGtlcm5lbCB2ZXJzaW9uLCBpbml0X3V0c19ucy5uYW1lLnJlbGVhc2UgY2FuIGJlIHJlbW92
ZWQsDQo+IHllcz8NCj4gDQo+IE9yIGlzIHRoZXJlIGFueXRoaW5nIHNwZWFraW5nIGFnYWluc3Qg
dGhhdD8iDQoNCkFzIGZvciBtYWtlZHVtcGZpbGUsIGl0IHdpbGwgYmUgbm90IGltcG9zc2libGUg
dG8gcmVtb3ZlIHRoZQ0KaW5pdF91dHNfbnMubmFtZS5yZWxhc2UgKE9TUkVMRUFTRSksIGJ1dCBz
b21lIGZpeGVzIGFyZSBuZWVkZWQuDQpCZWNhdXNlIGhpc3RvcmljYWxseSBPU1JFTEVBU0UgaGFz
IGJlZW4gYSBraW5kIG9mIGEgbWFuZGF0b3J5IGVudHJ5DQppbiB2bWNvcmVpbmZvIGZyb20gdGhl
IGJlZ2lubmluZyBvZiB2bWNvcmVpbmZvLCBzbyBtYWtlZHVtcGZpbGUgdXNlcw0KaXRzIGV4aXN0
ZW5jZSB0byBjaGVjayB3aGV0aGVyIGEgdm1jb3JlaW5mbyBpcyBzYW5lLg0KDQpBbHNvLCBJIHRo
aW5rIGNyYXNoIGFsc28gd2lsbCBuZWVkIHRvIGJlIGZpeGVkIGlmIGl0IGlzIHJlbW92ZWQuDQpT
byBJIGhvcGUgaXQgd2lsbCBiZSBsZWZ0IGFzIGl0IGlzLg0KDQpUaGFua3MsDQpLYXp1DQoNCg==

