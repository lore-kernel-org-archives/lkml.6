Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BB7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B85E208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B85E208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGNC6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 22:58:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:42533 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbeGNC6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 22:58:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 19:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,350,1526367600"; 
   d="scan'208";a="245164041"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2018 19:40:50 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 13 Jul 2018 19:40:49 -0700
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.163]) by
 FMSMSX109.amr.corp.intel.com ([169.254.15.66]) with mapi id 14.03.0319.002;
 Fri, 13 Jul 2018 19:40:49 -0700
From:   "Brown, Len" <len.brown@intel.com>
To:     patrickg <patrickg@supermicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "Du, Alek" <alek.du@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>
Subject: RE: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
Thread-Topic: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
Thread-Index: AQHUGt5htRi9dsw3dkarzzAgmMqxCqSN/45w
Date:   Sat, 14 Jul 2018 02:40:48 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94849A1AACF@FMSMSX126.amr.corp.intel.com>
References: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
In-Reply-To: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTVjZjAzYWItZmQxMy00ZDU2LTkzNWQtOTA3MGZkNTFjNzNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ2hCZjlmdWV1RFR0XC9FMVpLaEZ3SklMQnVnUEFzakZvWU5mWjNmSzFFeDBxY1FjVXZVRkJVRWF1dXJYM3U3NVIifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2UgZGlzYWJsZWQgQ1BVSUQtYmFzZWQgVFNDIGNhbGlicmF0aW9uIG9uIFNLWCBpbiBEZWNlbWJl
ciBmb3Igc2V2ZXJhbCByZWFzb25zLg0KSWYgeW91IHN0aWxsIGhhdmUgaXQgZW5hYmxlZCwgeW91
IG5lZWQgdGhpcyBwYXRjaDoNCg0KY29tbWl0IGI1MTEyMDMwOTM0ODllYjE4MjljYjRkZTg2ZTgy
MTQ3NTIyMDVhYzYNCiAgICB4ODYvdHNjOiBGaXggZXJyb25lb3VzIFRTQyByYXRlIG9uIFNreWxh
a2UgWGVvbg0KDQpJZiB5b3UgYXJlIHJlZmVycmluZyB0byBhbm90aGVyIHBsYXRmb3JtIHRoYXQg
aGFzIENQVUlELVRTQyBjYWxpYnJhdGlvbi4uLg0KaXQgc2hvdWxkIHN0aWxsIHdvcmsgb24gYW4g
b3Zlci1jbG9ja2VkIHN5c3RlbS4gIE92ZXItY2xvY2tlZCBwbGF0Zm9ybXMgc2hvdWxkDQp1c2Ug
ZXhhY3RseSB0aGUgc2FtZSByZWZlcmVuY2UgY3J5c3RhbCBhcyBub24tb3ZlcmNsb2NrZWQgcGxh
dGZvcm1zLCBidXQgc2hvdWxkDQptb2RpZnkgdGhlIGNyeXN0YWwvY29yZSBtdWx0aXBsaWVyLiAg
IElmIHlvdSBhcmUgY2hhbmdpbmcgdGhlIHJlZmVyZW5jZQ0KY3J5c3RhbCwgdGhlbiBJIGJlbGll
dmUgeW91IGFyZSB1c2luZyBhbiB1bi1zdXBwb3J0ZWQgaGFyZHdhcmUgY29uZmlndXJhdGlvbiwN
CmFuZCBteSBhYmlsaXR5IHRvIHN1cHBvcnQgeW91IGlzIGxpbWl0ZWQuDQoNCi1MZW4NCg0K
