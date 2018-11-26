Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEBBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C52720672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C52720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeK0D5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:57:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:36964 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbeK0D5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:57:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 09:02:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="277082080"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2018 09:02:36 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 26 Nov 2018 09:02:36 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.128]) with mapi id 14.03.0415.000;
 Mon, 26 Nov 2018 09:02:36 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v4 1/2] bpf: add __weak hook for allocating executable
 memory
Thread-Topic: [PATCH v4 1/2] bpf: add __weak hook for allocating executable
 memory
Thread-Index: AQHUg3p0pdlF1jqOdkG7K/5RD+/L4KVi018A
Date:   Mon, 26 Nov 2018 17:02:35 +0000
Message-ID: <a16dc0bb806d6a0685978bb94c2e3f19588c063f.camel@intel.com>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
         <20181123221804.440-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20181123221804.440-2-ard.biesheuvel@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.128]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D4DEFCD0DC85A438F76D14B836A2B14@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTExLTIzIGF0IDIzOjE4ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gQnkgZGVmYXVsdCwgQlBGIHVzZXMgbW9kdWxlX2FsbG9jKCkgdG8gYWxsb2NhdGUgZXhlY3V0
YWJsZSBtZW1vcnksDQo+IGJ1dCB0aGlzIGlzIG5vdCBuZWNlc3Nhcnkgb24gYWxsIGFyY2hlcyBh
bmQgcG90ZW50aWFsbHkgdW5kZXNpcmFibGUNCj4gb24gc29tZSBvZiB0aGVtLg0KPiANCj4gU28g
YnJlYWsgb3V0IHRoZSBtb2R1bGVfYWxsb2MoKSBhbmQgbW9kdWxlX21lbWZyZWUoKSBjYWxscyBp
bnRvIF9fd2Vhaw0KPiBmdW5jdGlvbnMgdG8gYWxsb3cgdGhlbSB0byBiZSBvdmVycmlkZGVuIGlu
IGFyY2ggY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmll
c2hldXZlbEBsaW5hcm8ub3JnPg0KPiAtLS0NCg0KSXQgbG9va3MgbGlrZSBzb21lIG9mIHRoZSBh
cmNoaXRlY3R1cmVzIGNhbGwgbW9kdWxlX2FsbG9jIGRpcmVjdGx5IGluIHRoZWlyDQpicGZfaml0
X2NvbXBpbGUgaW1wbGVtZW50YXRpb25zIGFzIHdlbGwuDQoNClJpY2sNCg==
