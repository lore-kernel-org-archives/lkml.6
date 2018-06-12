Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 18A55C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D0B208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D0B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934866AbeFLBa4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:30:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:61408 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933350AbeFLBay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:30:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 18:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,212,1526367600"; 
   d="scan'208";a="236335551"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2018 18:30:53 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 11 Jun 2018 18:30:53 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 11 Jun 2018 18:30:53 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.70]) with mapi id 14.03.0319.002;
 Tue, 12 Jun 2018 09:30:51 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "bp@suse.de" <bp@suse.de>, "Liang, Kan" <kan.liang@intel.com>,
        "Janakarajan.Natarajan@amd.com" <Janakarajan.Natarajan@amd.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v9 09/12] KVM: x86: Introduce a function to initialize
 the PT configuration
Thread-Topic: [PATCH v9 09/12] KVM: x86: Introduce a function to initialize
 the PT configuration
Thread-Index: AQHT8XjSLLwXysx4vEGD1TmP05zIF6RUZbMAgAIkH6CAA/+CgIAAiGWQ
Date:   Tue, 12 Jun 2018 01:30:50 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E16802AF01@SHSMSX101.ccr.corp.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-10-git-send-email-luwei.kang@intel.com>
 <20180607135648.mkciyfrd2wgvdxze@um.fi.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167FF0140@SHSMSX101.ccr.corp.intel.com>
 <c3a25e58-cb4e-f3f7-bbd5-559bc763bb26@redhat.com>
In-Reply-To: <c3a25e58-cb4e-f3f7-bbd5-559bc763bb26@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjUyNDZjYWYtY2YzMS00MzU1LWIzMjctMTNjNWFhZjNmNTdmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR2NFVCs0UWlCaEVCUWpERW1DQ0Z1eHJSQkdBbzV2ZEkyWWRZVUJJT2hZWDQ0Sk9IcmFNQWF3bUtaZmtkNEFWNCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gKwkvKiBJbml0aWFsaXplIGFuZCBjbGVhciB0aGUgbm8gZGVwZW5kZW5jeSBiaXRzICov
DQo+ID4+PiArCXZteC0+cHRfZGVzYy5jdGxfYml0bWFzayA9IH4wVUxMOw0KPiA+PiBUaGlzIGxv
b2tzIHJlZHVuZGFudCwgZG9lc24ndCBpdD8NCj4gPiBUaGlzIGlzIGEgYml0IG1hc2sgZm9yIFJU
SVRfQ1RMIE1TUiBhbmQgaXQgd2lsbCBtYWtlICYgd2l0aCB0aGUgdmFsdWUgb2YgUlRJVF9DTFQg
ZnJvbSBndWVzdC4NCj4gPiBUaGUgcmVzZXJ2ZWQgYml0cyB3aWxsIGJlIDEgaW4gdGhpcyBiaXQg
bWFzayBhbmQgdGhlIHNldGFibGUgIGJpdHMgYXJlIDAuDQo+ID4NCj4gPj4+ICsJdm14LT5wdF9k
ZXNjLmN0bF9iaXRtYXNrID0gfihSVElUX0NUTF9UUkFDRUVOIHwgUlRJVF9DVExfT1MgfA0KPiA+
Pj4gKwkJCVJUSVRfQ1RMX1VTUiB8IFJUSVRfQ1RMX1RTQ19FTiB8DQo+ID4+IFJUSVRfQ1RMX0RJ
U1JFVEMpOw0KPiANCj4gQnV0IGl0J3Mgc2V0IHR3aWNlLCBzbyB0aGUgZmlyc3QgYXNzaWdubWVu
dCBpcyBzdXBlcmZsdW91cy4NCg0KT2gsIEkgc2VlLiBXaWxsIHJlbW92ZSBpdC4NCg0KVGhhbmtz
LA0KTHV3ZWkgS2FuZw0K
