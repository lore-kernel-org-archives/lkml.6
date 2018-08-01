Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D4DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395D8208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395D8208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbeHARqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:46:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:44692 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389643AbeHARqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:46:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 08:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="77862810"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2018 08:59:44 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 08:59:44 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.212]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Wed, 1 Aug 2018 08:59:44 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     Prarit Bhargava <prarit@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sironi@amazon.de" <sironi@amazon.de>
Subject: RE: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Thread-Topic: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Thread-Index: AQHUKWI4Ny+YidBCkkuBRrbHOHa/AqSrOtaAgAAsSACAABRugP//keCQ
Date:   Wed, 1 Aug 2018 15:59:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D38B681@ORSMSX110.amr.corp.intel.com>
References: <d8ac835211e5649b5494141a0decc3bc@natalenko.name>
 <b84518d4-fc78-ca2a-7bde-ad6b5f6a7d83@redhat.com>
 <0a4c663887ecc1672d9927ed7256485b@natalenko.name>
 <20180801152926.GB13988@nazgul.tnic>
In-Reply-To: <20180801152926.GB13988@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2NlNzhiOWYtOTYyOS00M2QwLTljNzctNGY3YzM1ZWNiZTEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieTliQUFcL255YjlXTldKRGhWS25nYmczaU5IRzd4TFQwUklLM0hlbzJZOUFpdjFuYVVXUm9KZzUrRmtMMVJxSDAifQ==
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

PiBUaGVyZSdzIG5vIHJlbGlhYmxlIHdheSB0byBnZXQgdGhlIG9sZCBtaWNyb2NvZGUgcmV2aXNp
b24gd2hpY2ggd2FzDQo+IG92ZXJ3cml0dGVuIGR1cmluZyB0aGUgdXBncmFkZS4gSWYgZG1lc2cg
Z2V0cyBvdmVyd3JpdHRlbiB5b3UgbG9zZSwgbGlrZQ0KPiBpbiBhbGwgdGhlIG90aGVyIGdhemls
bGlvbiBjYXNlcyB3aGVyZSB5b3UgbG9zZSBpbmZvcm1hdGlvbiBkdWUgdG8gdGhhdC4NCg0KVGhl
IHByaW1hcnkgcmVxdWlyZW1lbnQgaGVyZSBpcyB0aGF0IHdlIHJlcG9ydCB0aGUgdmVyc2lvbiBv
ZiB0aGUgbWljcm9jb2RlDQppbiB1c2UgYXQgdGhlIHRpbWUgb2YgYSBjcmFzaC4gS2VlcGluZyBo
aXN0b3J5IG9mIGFsbCB1cGRhdGVzIHNlZW1zIHRvIG1lIHRvDQpiZXlvbmQgdGhlIHNjb3BlIG9m
IHRoZSBrZXJuZWwncyByZXNwb25zaWJpbGl0aWVzLg0KDQpJdCdzIG5vdCBsaWtlIHRoZXNlIHVw
ZGF0ZXMgYXBwZWFyIG91dCBvZiB0aGUgZXRoZXIuIFlvdSBoYXZlIHRvIGdvIG91dCBhbmQNCmdy
YWIgYSBuZXcgcGFja2FnZSBhbmQgaW5zdGFsbCBpdC4gIFVzZXIgbGFuZCBjYW4ga2VlcCB0cmFj
ayBvZiB0aGlzIG11Y2gNCm1vcmUgZWFzaWx5IHRoYW4gdGhlIGtlcm5lbC4NCg0KLVRvbnkNCg0K
