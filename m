Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072CC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E323423F07
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="lxFhTTti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E323423F07
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeGEXkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:40:42 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:6093 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeGEXkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1064; q=dns/txt; s=iport;
  t=1530834041; x=1532043641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1JdTgjadIMzt2bt+7ZPcThwudeiUqjZjpFTubpljdPs=;
  b=lxFhTTtijrZ24UJGhNTBIUvlPbBJqXuTgwMXExsCJlvCKSv069EhRcXB
   C3X1sQTBSZRn7nAG1eETxeQGPVHN/WZIaXAvBu3M34ekF7fsz+nUjrsfh
   ukaDE238Qe7R4iMmtD+cW3Kjrlxz0uiwbSTJhxEyNRP/MxuskwncLdD7m
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AEAwB4qz5b/4QNJK1bGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNJgWEoCoNwiASMNYIHgziReIF6C4RsAheCFiE0GAECAQE?=
 =?us-ascii?q?CAQECbSiFNwEFIxFFEAIBCBgCAiYCAgIwFRACBA4FgyCCAKl3ghyIUIE6gQu?=
 =?us-ascii?q?HYoFWP4E2gmiEeoMBMYIkAplMCQKPHo1XkWICERMBgSQdOIFScBVlAYI+kFJ?=
 =?us-ascii?q?vjiKBGgEB?=
X-IronPort-AV: E=Sophos;i="5.51,314,1526342400"; 
   d="scan'208";a="423019719"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 23:40:40 +0000
Received: from XCH-RTP-004.cisco.com (xch-rtp-004.cisco.com [64.101.220.144])
        by alln-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id w65Nees4007893
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 5 Jul 2018 23:40:40 GMT
Received: from xch-rtp-001.cisco.com (64.101.220.141) by XCH-RTP-004.cisco.com
 (64.101.220.144) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 5 Jul
 2018 19:40:39 -0400
Received: from xch-rtp-001.cisco.com ([64.101.220.141]) by
 XCH-RTP-001.cisco.com ([64.101.220.141]) with mapi id 15.00.1320.000; Thu, 5
 Jul 2018 19:40:39 -0400
From:   "Nikunj Kela (nkela)" <nkela@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: add support for 43bit physical address
Thread-Topic: [PATCH 2/2] arm64: add support for 43bit physical address
Thread-Index: AQHUEkhUYrA/ILOIpk+9pyia5fOeYaR92oaA///4KMaAA2mJgIAAVW+A
Date:   Thu, 5 Jul 2018 23:40:39 +0000
Message-ID: <9FA2F50C-F4C8-460C-B6BF-B9DF38C95111@cisco.com>
References: <20180702210451.16057-2-nkela@cisco.com>
 <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
 <1530642932209.57184@cisco.com>
 <20180705183452.vaaxjsrus6lnqyzt@armageddon.cambridge.arm.com>
In-Reply-To: <20180705183452.vaaxjsrus6lnqyzt@armageddon.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.41.48.59]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F38A4908BB4F40822034D65F3B1399@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBkaWRu4oCZdCB0cnkgRkxBVE1FTS4gVGhhbmtzIGZvciBhZHZpc2luZywgSSBlbmFibGVkIEZM
QVRNRU0gZm9yIEFSTTY0IGFuZCBhbSBhYmxlIHRvIHNhdmUgfjE0TS4gV2lsbCBwb3N0IGEgbmV3
IHBhdGNoIGZvciBLY29uZmlnIGNoYW5nZXMuDQoNClRoYW5rcywNCi1OaWt1bmoNCg0KT24gNy81
LzE4LCAxMTozNSBBTSwgIkNhdGFsaW4gTWFyaW5hcyIgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
PiB3cm90ZToNCg0KICAgIE9uIFR1ZSwgSnVsIDAzLCAyMDE4IGF0IDA2OjM1OjMyUE0gKzAwMDAs
IE5pa3VuaiBLZWxhIChua2VsYSkgd3JvdGU6DQogICAgPiBXZSBhcmUgdHJ5aW5nIHRvIHJlZHVj
ZSB0aGUgbWVtb3J5IGFsbG9jYXRpb24gbmVlZGVkIGZvciBrZHVtcCBrZXJuZWwuDQogICAgPiBX
ZSB3YW50IHRvIHJlc2VydmUgbGVzcyB0aGFuIDMyTSBmb3Iga2R1bXAga2VybmVsIGlmIHBvc3Np
YmxlLiBXZSBhcmUNCiAgICA+IGFibGUgdG8gZ2V0IH4xNE0gc2F2aW5nIGJ5IHRoZSBwcm9wb3Nl
ZCBjaGFuZ2UuDQogICAgDQogICAgSGF2ZSB5b3UgdHJpZWQgZGlzYWJsaW5nIFNQQVJTRU1FTSBh
bmQgdXNpbmcgRkxBVE1FTSBmb3IgdGhpcyBjYXNlPyBXaXRoDQogICAgMzJNIHlvdSB3b3VsZG4n
dCBuZWVkIG1vcmUgdGhhbiBhIHNlY3Rpb24gYW55d2F5LiBJdCBuZWVkcyBzb21lIHR3ZWFraW5n
DQogICAgb2YgdGhlIGFybTY0IEtjb25maWcgYW5kIHByb2JhYmx5IGZhaWwgdG8gYnVpbGQuDQog
ICAgDQogICAgLS0gDQogICAgQ2F0YWxpbg0KICAgIA0KDQo=
