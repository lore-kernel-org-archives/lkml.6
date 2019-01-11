Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D081FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B4720872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfAKIaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:30:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:17079 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfAKIaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:30:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 00:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,464,1539673200"; 
   d="scan'208";a="266323981"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2019 00:30:15 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 11 Jan 2019 00:30:14 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.150]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.46]) with mapi id 14.03.0415.000;
 Fri, 11 Jan 2019 16:30:13 +0800
From:   "Tang, Haoyu" <haoyu.tang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/fpu/init: Add __setup() functions back to fpu/init.c
Thread-Topic: [PATCH] x86/fpu/init: Add __setup() functions back to
 fpu/init.c
Thread-Index: AQHUqVdjebesJLvhEkm1KSR1xC5NqaWpMdGAgACJTqA=
Date:   Fri, 11 Jan 2019 08:30:13 +0000
Message-ID: <62C1CF205A679448ACBEE7C5EDA2DE3716365B2A@SHSMSX103.ccr.corp.intel.com>
References: <1547174753-31180-1-git-send-email-haoyu.tang@intel.com>
 <20190111081150.lpgwjpwx24kdl7yb@linutronix.de>
In-Reply-To: <20190111081150.lpgwjpwx24kdl7yb@linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzk4MGIzNjMtMGVmMC00MDFlLWFkMDktYjU5YWNkMWRmYTA0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid3QwZ0V4RWlpVjlGTFlcL2NKYlwvVzF0dDVTTTNHSVlQQ2Jtbldidnk4cnU3XC83alpIcWwyNTFmbjlMVHJySXRzSyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXQgZG9lc24ndCBjb25zaXN0ZW50IHdpdGggZG9jdW1lbnQ6IGh0dHBzOi8vd3d3Lmtlcm5lbC5v
cmcvZG9jL2h0bWwvbGF0ZXN0L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLmh0bWwgDQpJ
IG1ldCBhbiBpbml0IHdoaWNoIGRpZG4ndCBhY2NlcHQgdW5rbm93biBhcmd1bWVudHMuDQoNCkhh
b3l1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTZWJhc3RpYW4gQW5kcnpl
aiBTaWV3aW9yIFttYWlsdG86YmlnZWFzeUBsaW51dHJvbml4LmRlXSANClNlbnQ6IEZyaWRheSwg
SmFudWFyeSAxMSwgMjAxOSA0OjEyIFBNDQpUbzogVGFuZywgSGFveXUgPGhhb3l1LnRhbmdAaW50
ZWwuY29tPg0KQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47
IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEFuZHkgTHV0
b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPjsgTmljb2xhaSBTdGFuZ2UgPG5zdGFuZ2VAc3VzZS5k
ZT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHg4
Ni9mcHUvaW5pdDogQWRkIF9fc2V0dXAoKSBmdW5jdGlvbnMgYmFjayB0byBmcHUvaW5pdC5jDQoN
Ck9uIDIwMTktMDEtMTEgMTA6NDU6NTMgWyswODAwXSwgSGFveXUgVGFuZyB3cm90ZToNCj4gX19z
ZXR1cCgpIGZ1bmN0aW9ucyB3ZXJlIHJlbW92ZWQgaW46DQo+IA0KPiAgIGNvbW1pdCA0ZjgxY2Jh
ZmNjZTIgKCJ4ODYvZnB1OiBGaXggZWFybHkgRlBVIGNvbW1hbmQtbGluZSBwYXJzaW5nIikNCj4g
DQo+IGNhdXNlZCB0aGF0IEZQVSBwYXJhbWV0ZXIgaXMgcGFzc2VkIGFzIGFuIGFyZ3VtZW50IHRv
IGluaXQsIHRoZSBkdW1teQ0KPiBfX3NldHVwKCkgZnVuY3Rpb25zIGNhbiBhdm9pZCB0aGlzLg0K
DQp3aHkgaXMgdGhhdCBiYWQ/DQoNClNlYmFzdGlhbg0K
