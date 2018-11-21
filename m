Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E399EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD15E2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD15E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbeKVK3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:29:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:24830 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeKVK3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:29:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 15:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="93021370"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2018 15:52:41 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 21 Nov 2018 15:52:41 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.106]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.136]) with mapi id 14.03.0415.000;
 Wed, 21 Nov 2018 15:52:40 -0800
From:   "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/8] selftests/resctrl: Add callback to start a
 benchmark
Thread-Topic: [PATCH v3 4/8] selftests/resctrl: Add callback to start a
 benchmark
Thread-Index: AQHUcV26Z6mrdi6+3UeGPOQlPAfDK6VNPIkAgA3KRfA=
Date:   Wed, 21 Nov 2018 23:52:39 +0000
Message-ID: <A452FAC4F7CA284ABAC2C8FAB7160B2F3239AF@ORSMSX115.amr.corp.intel.com>
References: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
 <1541019754-192204-5-git-send-email-fenghua.yu@intel.com>
 <0634d990-d25c-49a9-a1ae-ad7cded35fce@amd.com>
In-Reply-To: <0634d990-d25c-49a9-a1ae-ad7cded35fce@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGQ1ZGRhYTAtM2JkZC00NWNhLWE0YTQtNzU4NzEwNzk5MjNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTUh2bUs0XC9WTHpOQVwvVElqZjdIR2wwcEV6ZzdNYkJkRlJodXVSZFFBYkZrVno4WjRVYll1c3lXelJYWWJCMVZXIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdGF0aWMgaW50DQo+ID4gK21lYXN1cmVfdmFscyhzdHJ1Y3QgcmVzY3RybF92YWxfcGFy
YW0gKnBhcmFtLCB1bnNpZ25lZCBsb25nDQo+ID4gKypid19yZXNjX3N0YXJ0KSB7DQo+ID4gKwl1
bnNpZ25lZCBsb25nIGJ3X2ltYywgYndfcmVzYywgYndfcmVzY19lbmQ7DQo+ID4gKwlpbnQgcmV0
Ow0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBNZWFzdXJlIG1lbW9yeSBiYW5kd2lkdGggZnJv
bSByZXNjdHJsIGFuZCBmcm9tDQo+ID4gKwkgKiBhbm90aGVyIHNvdXJjZSB3aGljaCBpcyBwZXJm
IGltYyB2YWx1ZSBvciBjb3VsZA0KPiA+ICsJICogYmUgc29tZXRoaW5nIGVsc2UgaWYgcGVyZiBp
bWMgZXZlbnQgaXMgbm90IGF2YWlsYWJsZS4NCj4gPiArCSAqIENvbXBhcmUgdGhlIHR3byB2YWx1
ZXMgdG8gdmFsaWRhdGUgcmVzY3RybCB2YWx1ZS4NCj4gPiArCSAqIEl0IHRha2VzIDFzZWMgdG8g
bWVhc3VyZSB0aGUgZGF0YS4NCj4gPiArCSAqLw0KPiA+ICsJYndfaW1jID0gZ2V0X21lbV9id19p
bWMocGFyYW0tPmNwdV9ubywgcGFyYW0tPmJ3X3JlcG9ydCk7DQo+ID4gKwlpZiAoYndfaW1jIDwg
MCkNCj4gDQo+IEkgdGhpbmsgdGhpcyBjb25kaXRpb24gc2hvdWxkIGJlICI8PSIuIElmIHRoZSB2
YWx1ZSBpcyB6ZXJvLCBpdCBzaG91bGQgZXhpdC4NCg0KWWVzLCBpdCBzaG91bGQgYmUgY2hhbmdl
ZC4gV2lsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsJCXJldHVybiBid19p
bWM7DQo+ID4gKw0KPiA+ICsJYndfcmVzY19lbmQgPSBnZXRfbWVtX2J3X3Jlc2N0cmwoKTsNCj4g
PiArCWlmIChid19yZXNjX2VuZCA8IDApDQo+IA0KPiBJIGFtIG5vdCB2ZXJ5IHN1cmUgYWJvdXQg
dGhpcy4gUGxlYXNlIGNoZWNrIGlmIGl0IHNob3VsZCBiZSAiPD0iIDAuDQoNClRoaXMgb25lIHNo
b3VsZCBhbHNvIGJlIGNoYW5nZWQuIFdpbGwgZml4IGl0IHRvby4NCg0KPiANCj4gPiArCQlyZXR1
cm4gYndfcmVzY19lbmQ7DQo+ID4gKw0KPiA+ICsJYndfcmVzYyA9IChid19yZXNjX2VuZCAtICpi
d19yZXNjX3N0YXJ0KSAvIE1COw0KPiA+ICsJcmV0ID0gcHJpbnRfcmVzdWx0c19idyhwYXJhbS0+
ZmlsZW5hbWUsIGJtX3BpZCwgYndfaW1jLCBid19yZXNjKTsNCj4gPiArCWlmIChyZXQpDQo+ID4g
KwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkqYndfcmVzY19zdGFydCA9IGJ3X3Jlc2NfZW5k
Ow0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQoNClRoYW5rcyBhbmQgUmVnYXJkcywN
CkFyc2hpeWENCg==
