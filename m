Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6B5ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E2921476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E2921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeJRC2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:28:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:44212 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRC2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:28:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="266532508"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga005.jf.intel.com with ESMTP; 17 Oct 2018 11:31:46 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 11:31:45 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.194]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.138]) with mapi id 14.03.0319.002;
 Wed, 17 Oct 2018 11:31:45 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUZXHTdy//XOZ5t0mcNlOvTkq3/6UimP6A//+v20CAAIBCgIABMBkA//+1Y4CAAIpFAP//i2+Q
Date:   Wed, 17 Oct 2018 18:31:44 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485D4DB7@ORSMSX114.amr.corp.intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
 <20181016203215.GA39177@romley-ivt3.sc.intel.com>
 <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D4D41@ORSMSX114.amr.corp.intel.com>
 <feb572ec-4495-c52c-0127-213417a67c3c@amd.com>
In-Reply-To: <feb572ec-4495-c52c-0127-213417a67c3c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTliNDFmZjYtZWNlMi00ZmIyLTliNjQtMzM5MWU5MDA4NjNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMXBoVlU4MnpJb21pSFwvazdvRTYyTUpxSUhOeldTdmVBaGpKejlQV3JROXcrTDF5YitZQXFBS3M3QnVkaFd1OU8ifQ==
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

PiA+IEZvciAoSW50ZWwpIE1lbW9yeSBCYW5kd2lkdGggZmVhdHVyZXMgbGlrZSBNQkEgYW5kIE1C
TSwgcGVyZiBpTUMNCj4gPiAoSW50ZWdyYXRlZCBNZW1vcnkgQ29udHJvbGxlcikgaXMgdXNlZCBm
b3IgdmFsaWRhdGlvbi4gQXMgYSBwYXJ0IG9mDQo+ID4gdGVzdCwgd2UgcnVuIGEgYmVuY2htYXJr
IChlZzogZmlsbF9idWYpIGFuZCBnZXQgbWVtb3J5IGJhbmR3aWR0aA0KPiA+IHZhbHVlcyBmcm9t
IE1CTSBhbmQgaU1DIGFuZCB2ZXJpZnkgaWYgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBib3RoIHRo
ZQ0KPiByZXBvcnRlZCB2YWx1ZXMgYXJlIGluIGEgcmVhc29uYWJsZSByYW5nZS4NCj4gPg0KPiA+
IFRvIG1ha2UgdGhpcyBjb21tb24gYWNyb3NzIHg4NiwgY291bGQgeW91IHBsZWFzZSBsZXQgdXMg
a25vdyBpZg0KPiA+IHNpbWlsYXIgdGhpbmdzIChpLmUuIHBlcmYgaU1DKSBleGlzdCBvbiBBTUQ/
IElmIHNvLCB5b3UgY291bGQgYWRkIGl0IGluLiBUaGUgc2FtZQ0KPiBhcHBsaWVzIGZvciBBUk0u
DQo+IA0KPiBXZSBkb250IGhhdmUgaU1DLiBZb3UgY2FuIGdvIGFoZWFkIHdpdGggd2hhdCB5b3Ug
aGF2ZSByaWdodCBub3cuIFdlIGNhbg0KPiBhZGQgdGhvc2UgZGV0YWlscyBsYXRlciBpZiByZXF1
aXJlZC4NCg0KU3VyZSEgTWFrZXMgc2Vuc2UgdG8gbWUuDQoNClJlZ2FyZHMsDQpTYWkNCg==
