Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019FAC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB640213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB640213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeJLXpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:45:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:13528 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeJLXpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:45:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 09:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="98677527"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2018 09:11:57 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.129]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 09:11:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038 Mailman List" <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>
Subject: RE: [PATCH v3 0/7] ia64: system call table generation support
Thread-Topic: [PATCH v3 0/7] ia64: system call table generation support
Thread-Index: AQHUYRpxMk/jYFmpo0+6EeqVZVTKtKUaTMGAgAEm5QCAAExw8A==
Date:   Fri, 12 Oct 2018 16:11:56 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D410C05@ORSMSX107.amr.corp.intel.com>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <3908561D78D1C84285E8C5FCA982C28F7D40F9DD@ORSMSX107.amr.corp.intel.com>
 <CALxhOngtGNP7MATzwtMZd_Xw+rqvdhP9NMtTxwCEgmzayZshOQ@mail.gmail.com>
In-Reply-To: <CALxhOngtGNP7MATzwtMZd_Xw+rqvdhP9NMtTxwCEgmzayZshOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjU3ZWY1MTktYTA4OC00MmI2LThhN2EtZTkzOGY2OGQ2NGNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWGFGUXk1eWQ4eEpyMmJtVm81ank2MzVZNGpBdEhrYTlvZGxVZWVuRGRlXC9CYm9hcTU0T1ljZUxwSldLQ3dXbjgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHN1c3BlY3QgdGhlIG9mZnNldCBsb2dpYyBpbiB0aGUgc3lzdGVtIGNhbGwgZ2VuZXJhdGlv
biBzY3JpcHQgaGFkIGEgYnVnLiBUaGF0DQo+IEkgZml4ZWQgaXQgaW4gdGhpcyBwYXRjaCBzZXJp
ZXMuDQo+DQo+IEFybmQgYW5kIEV1Z2VuZSBoYWQgc2hhcmVkIGZldyBjb21tZW50cyBvbiBhZGRp
bmcgbmV3IHN5c3RlbSBjYWxsIGVudHJ5IGluIHRoZQ0KPiB0YWJsZSBhbmQgc29tZSBvdGhlciB0
aGluZ3MuIEFwcHJlY2lhdGUgaWYgeW91IGNhbiByZXZpZXcgdGhpcyBwYXRjaA0KPiBzZXJpZXMg
c28gSSBjYW4NCj4gZmluYWxpemUgc3lzdGVtIGNhbGwgdGFibGUgaW1wbGVtZW50YXRpb24gZm9y
IGlhNjQgYXJjaGl0ZWN0dXJlLg0KDQpUaGUgbmV0IGVmZmVjdCBvZiB0aGVzZSBpcyBqdXN0IHRv
IG1ha2UgaXQgZWFzaWVyIHRvIGFkZCBuZXcgc3lzdGVtIGNhbGxzLiBKdXN0DQplZGl0IHRoZSB0
YWJsZSwgaW5zdGVhZCBvZiBlZGl0aW5nIGVudHJ5LlMgYW5kIHVuaXN0ZC5oIHBpY2tpbmcgdGhl
IG5leHQgbnVtYmVyDQooYW5kIHJlbWVtYmVyaW5nIHRvIGluY3JlYXNlICB0aGUgTlJfc3lzY2Fs
bHMpLiBSaWdodD8NCg0KSSdtIGN1cnJlbnRseSBiYWZmbGVkIGF0IHdoaWNoIGxpbmtlciBtYWdp
YyBtYWtlcyB0aGUgdW5zdXBwb3J0ZWQgc3lzdGVtDQpjYWxscyBhbGlhcyB0byBzeXNfbmlfc3lz
Y2FsbC4NCg0KSSdtIGFsc28gdW5jZXJ0YWluIHdoZXRoZXIgYWxsb2NhdGluZyBzeXN0ZW0gY2Fs
bCBudW1iZXJzIGFuZCBjcmVhdGluZw0KZW50cnkgcG9pbnRzIGZvciBhbGwgdGhlIHVuc3VwcG9y
dGVkIHN5c2NhbGxzIGlzIHRoZSByaWdodCB0aGluZyB0byBkby4gTWlnaHQNCnRoYXQgcHV6emxl
IGFuZCBmcnVzdHJhdGUgZm9sa3Mgd2hvc2UgYXBwbGljYXRpb25zIGJ1aWxkLCBidXQgdGhlbiBm
YWlsIGF0DQpydW4tdGltZSB3aXRoIC1FTk9TWVMuDQoNCi1Ub255DQo=
