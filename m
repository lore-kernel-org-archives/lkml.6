Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778A3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273F221480
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="mgKxMokg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273F221480
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbeGFQfU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:35:20 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:6670 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeGFQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1532; q=dns/txt; s=iport;
  t=1530894918; x=1532104518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JbAF8QRYFruJbSpt1DTpc1uVn0D1jpKuizEgVXU8vsI=;
  b=mgKxMokgyvFyTBtkyIjDO5IL6h8VcTxo9y03+d27wYVGkRgnZzLpnavY
   re98FH46+Asiflu1hL+xqd5mox3sCtB7Y14Opl7zyRQZ2g7Rd+CSNPM95
   cevW6FtPxkDKc1aptS/HsLa6bnTL91kLJ616EAkRFtJn8pbG4ksjy6j9O
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AcAgDM+T5b/4MNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNJgWEoCoNwiASMNYIHgziReIF6C4RsAheCFiE0GAECAQE?=
 =?us-ascii?q?CAQECbSiFNwEFIxFFEAIBCBIGAgImAgICMBUCDgIEDgWDIIIAqSSCHIhPgTq?=
 =?us-ascii?q?BC4digVY/gQ8ngmiEeoMBMYIkAplPCQKPIIFAhAyIDJFkAhETAYEkHTiBUnA?=
 =?us-ascii?q?VZQGCPpBSb444gRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,316,1526342400"; 
   d="scan'208";a="420247076"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 16:35:17 +0000
Received: from XCH-RTP-001.cisco.com (xch-rtp-001.cisco.com [64.101.220.141])
        by alln-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id w66GZH2U002511
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 6 Jul 2018 16:35:17 GMT
Received: from xch-rtp-001.cisco.com (64.101.220.141) by XCH-RTP-001.cisco.com
 (64.101.220.141) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 6 Jul
 2018 12:35:16 -0400
Received: from xch-rtp-001.cisco.com ([64.101.220.141]) by
 XCH-RTP-001.cisco.com ([64.101.220.141]) with mapi id 15.00.1320.000; Fri, 6
 Jul 2018 12:35:16 -0400
From:   "Nikunj Kela (nkela)" <nkela@cisco.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: add ARM64-specific support for flatmem
Thread-Topic: [PATCH] arm64: add ARM64-specific support for flatmem
Thread-Index: AQHUFUHnWLcbx+3zo06GyhcniH7XnqSCnY2AgAAJoAA=
Date:   Fri, 6 Jul 2018 16:35:16 +0000
Message-ID: <86D2343D-83C6-4E96-83A5-55C617EF7687@cisco.com>
References: <20180706155627.23937-1-nkela@cisco.com>
 <20180706160049.GA27483@arm.com>
In-Reply-To: <20180706160049.GA27483@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.41.48.64]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9D96562FD1F1D4BA9F4276D52B72132@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2lsbCBtb2RpZnkgdGhlIHBhdGNoIHRvIHJlbW92ZSBBUk02NC4gRXZlcnkgb3RoZXIgYXJjaGl0
ZWN0dXJlIGtlcHQgZGVmX2Jvb2wgeSBmb3IgaXQgc28gSSBmb2xsb3dlZCB0aGUgc2FtZSBmb3Ig
QVJNNjQgdG9vLiANCg0KVGhhbmtzLA0KLU5pa3Vuag0KDQpPbiA3LzYvMTgsIDk6MDAgQU0sICJX
aWxsIERlYWNvbiIgPHdpbGwuZGVhY29uQGFybS5jb20+IHdyb3RlOg0KDQogICAgUGxlYXNlIHdy
aXRlIGEgY29tbWl0IG1lc3NhZ2UgZm9yIHlvdXIgcGF0Y2guDQogICAgDQogICAgT24gRnJpLCBK
dWwgMDYsIDIwMTggYXQgMDg6NTY6MjdBTSAtMDcwMCwgTmlrdW5qIEtlbGEgd3JvdGU6DQogICAg
PiBDYzogeGUta2VybmVsQGV4dGVybmFsLmNpc2NvLmNvbQ0KICAgID4gQ2M6IE5pa3VuaiBLZWxh
IDxua2VsYUBjaXNjby5jb20+DQogICAgPiBTaWduZWQtb2ZmLWJ5OiBOaWt1bmogS2VsYSA8bmtl
bGFAY2lzY28uY29tPg0KICAgID4gLS0tDQogICAgPiAgYXJjaC9hcm02NC9LY29uZmlnIHwgNCAr
KysrDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KICAgID4gDQogICAg
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9LY29uZmlnIGIvYXJjaC9hcm02NC9LY29uZmlnDQog
ICAgPiBpbmRleCA0MmMwOTBjLi41ZTc5MWYwIDEwMDY0NA0KICAgID4gLS0tIGEvYXJjaC9hcm02
NC9LY29uZmlnDQogICAgPiArKysgYi9hcmNoL2FybTY0L0tjb25maWcNCiAgICA+IEBAIC03NzUs
NiArNzc1LDEwIEBAIGNvbmZpZyBBUkNIX1NQQVJTRU1FTV9ERUZBVUxUDQogICAgPiAgY29uZmln
IEFSQ0hfU0VMRUNUX01FTU9SWV9NT0RFTA0KICAgID4gIAlkZWZfYm9vbCBBUkNIX1NQQVJTRU1F
TV9FTkFCTEUNCiAgICA+ICANCiAgICA+ICtjb25maWcgQVJDSF9GTEFUTUVNX0VOQUJMRQ0KICAg
ID4gKwlkZWZfYm9vbCB5DQogICAgPiArCWRlcGVuZHMgb24gQVJNNjQgJiYgIU5VTUENCiAgICAN
CiAgICBXZSBkb24ndCBuZWVkIEFSTTY0IGhlcmUuIEknbSBhbHNvIG5vdCBzdXJlIGFib3V0IHRo
ZSBkZWZfYm9vbCB5LCB0aGlzIHNlZW1zDQogICAgbGlrZSBhIHByZXR0eSBuaWNoZSB0aGluZyB0
byBlbmFibGUuDQogICAgDQogICAgV2lsbA0KICAgIA0KDQo=
