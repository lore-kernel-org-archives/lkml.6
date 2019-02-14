Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F474C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E8B222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437613AbfBNItD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:49:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:36698 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388475AbfBNItC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:49:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 00:49:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="143370729"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2019 00:49:01 -0800
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 14 Feb 2019 00:49:01 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 14 Feb 2019 00:49:01 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.110]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 16:48:59 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'Nitesh Narayan Lal' <nitesh@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "david@redhat.com" <david@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Topic: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Index: AQHUvMb57IQCd72gCkOm4okDUKYrcaXdemAg//+vEwCAAWxXYA==
Date:   Thu, 14 Feb 2019 08:48:59 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF6F0E3@shsmsx102.ccr.corp.intel.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com>
 <f9516222-793a-a169-c18a-728ca0256cd3@redhat.com>
In-Reply-To: <f9516222-793a-a169-c18a-728ca0256cd3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjE2NmU1M2MtYzg1NC00YTVmLWE4ZWItZWM4ZWNmNWU1Y2JlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibStaa2tXSVNJYmRsVHJCRmQ0VEZxbjNabUpcL1BaUXM5MXoySWQwVGo0R01LNXBTejRZaWFaa2pQYzFOY21ITEUifQ==
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

T24gV2VkbmVzZGF5LCBGZWJydWFyeSAxMywgMjAxOSA4OjA3IFBNLCBOaXRlc2ggTmFyYXlhbiBM
YWwgd3JvdGU6DQo+IE9uY2UgdGhlIGhvc3QgZnJlZSB0aGUgcGFnZXMuIEFsbCB0aGUgaXNvbGF0
ZWQgcGFnZXMgYXJlIHJldHVybmVkIGJhY2sgDQo+IHRvIHRoZSBidWRkeS4gKFRoaXMgaXMgaW1w
bGVtZW50ZWQgaW4gaHlwZXJsaXN0X3JlYWR5KCkpDQoNClRoaXMgYWN0dWFsbHkgaGFzIHRoZSBz
YW1lIGlzc3VlOiB0aGUgaXNvbGF0ZWQgcGFnZXMgaGF2ZSB0byB3YWl0IHRvIHJldHVybiB0byB0
aGUgYnVkZHkNCmFmdGVyIHRoZSBob3N0IGhhcyBkb25lIHdpdGggbWFkdmlzZShET05UTkVFRCku
IE90aGVyd2lzZSwgYSBwYWdlIGNvdWxkIGJlIHVzZWQgYnkNCmEgZ3Vlc3QgdGhyZWFkIGFuZCB0
aGUgbmV4dCBtb21lbnQgdGhlIGhvc3QgdGFrZXMgaXQgdG8gb3RoZXIgaG9zdCB0aHJlYWRzLg0K
DQpCZXN0LA0KV2VpDQo=
