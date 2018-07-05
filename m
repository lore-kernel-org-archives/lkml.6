Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE69C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E34B23FE9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="F+ak0z+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E34B23FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeGESOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:14:21 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:56044 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbeGESOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2920; q=dns/txt; s=iport;
  t=1530814459; x=1532024059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jLq6GODE4tz44we2obfPARcaRB6bbB1Pu4VJCEeqqwc=;
  b=F+ak0z+Huaw++j26beSKcwDvBw4Lt8Ljy75FlheXFPwrffEDJdG0knBg
   o7tqj6vhfbPqfhX9yQzLxKoarFyPUKhcHqAazwbpdMCdhvSWl/SIaDrUY
   Sk8qt9s3KuLZUdkqLdBp64bYxtjjmA8268S7wOXsBc9qKnr4k1RtB6Kut
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BZAgCKXz5b/4sNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNJgWEoCoNwiASMNIIHgziReIF6CyyEQAIXghYhNBgBAgE?=
 =?us-ascii?q?BAgEBAm0ohTcBBAEjEUUQAgEIDgwCJgICAjAVEAIEDgWDIIF4CKkxghyIS4E?=
 =?us-ascii?q?6FHeHYoIVgTaCaIURgmoxgiQCgSMBkEOHI0IGAwKPHo1XkWICERMBgSQdOIF?=
 =?us-ascii?q?ScHoBcoFMkFJvgRWOIwGBGQEB?=
X-IronPort-AV: E=Sophos;i="5.51,313,1526342400"; 
   d="scan'208";a="201700896"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 18:14:19 +0000
Received: from XCH-ALN-014.cisco.com (xch-aln-014.cisco.com [173.36.7.24])
        by alln-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id w65IEIPg012055
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 5 Jul 2018 18:14:19 GMT
Received: from xch-rcd-014.cisco.com (173.37.102.24) by XCH-ALN-014.cisco.com
 (173.36.7.24) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 5 Jul
 2018 13:14:17 -0500
Received: from xch-rcd-014.cisco.com ([173.37.102.24]) by
 XCH-RCD-014.cisco.com ([173.37.102.24]) with mapi id 15.00.1320.000; Thu, 5
 Jul 2018 13:14:17 -0500
From:   "Christian Hansen (chansen3)" <chansen3@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: adding support for idle page tracking to tool
Thread-Topic: [PATCH] tools: adding support for idle page tracking to tool
Thread-Index: AQHUCB5afJHKzKHiRkKmxkdLnzpm56SBGH+A
Date:   Thu, 5 Jul 2018 18:14:17 +0000
Message-ID: <5F15F2EE-61F9-4E6F-99B2-B417B02C0F19@cisco.com>
References: <20180612153223.13174-1-chansen3@cisco.com>
 <20180619153911.bd835e2a7f0a4d2d3cddf348@linux-foundation.org>
In-Reply-To: <20180619153911.bd835e2a7f0a4d2d3cddf348@linux-foundation.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.44.192.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4AE7FC1A8AD514290F9BF22BCB8A3D3@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBJIHdhc24ndCBzdXJlIHdoaWNoIG9uZSB3ZW50IGluIGZpcnN0LiAgSSBjYW4gbWFrZSB0
aGlzIG9uZSBkZXBlbmRlbnQgb24gdGhlIG90aGVyLg0KDQrvu79PbiAyMDE4LTA2LTE5LCA2OjM5
IFBNLCAiQW5kcmV3IE1vcnRvbiIgPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0K
DQogICAgT24gVHVlLCAxMiBKdW4gMjAxOCAxMTozMjoyMyAtMDQwMCBDaHJpc3RpYW4gSGFuc2Vu
IDxjaGFuc2VuM0BjaXNjby5jb20+IHdyb3RlOg0KICAgIA0KICAgID4gQWRkaW5nIGEgZmxhZyB3
aGljaCB3aWxsIHVzZSB0aGUga2VybmVscydzIGlkbGUNCiAgICA+IHBhZ2UgdHJhY2tpbmcgdG8g
bWFyayBwYWdlcyBpZGxlLiAgQXMgdGhlIHRvb2wgYWxyZWFkeQ0KICAgID4gcHJpbnRzIHRoZSBp
ZGxlIGZsYWcgaWYgc2V0LCBzdWJzZXF1ZW50IHJ1bnMgd2lsbCBzaG93DQogICAgPiB3aGljaCBw
YWdlcyBoYXZlIGJlZW4gYWNjZXNzZWQgc2luY2UgbGFzdCBydW4uDQogICAgDQogICAgVGhhdCBz
b3VuZHMgdXNlZnVsLg0KICAgIA0KICAgIFRoaXMgcGF0Y2ggc2VlbXMgdG8gaGF2ZSBiZWVuIHBy
ZXBhcmVkIGFnYWluc3QgdGhlIG1haW5saW5lIGtlcm5lbCwgc28NCiAgICBpdCBjb25mbGljdHMg
d2l0aCB5b3VyICJ0b29sczogbW9kaWZ5aW5nIHBhZ2UtdHlwZXMgdG8gaW5jbHVkZSBzaGFyZWQN
CiAgICBtYXAgY291bnRzIiBwYXRjaC4gIEF3a3dhcmQsIGJ1dCBJIHNlZW0gdG8gaGF2ZSBnb3Qg
aXQgZml4ZWQgdXAuDQogICAgDQogICAgPiAuLi4NCiAgICA+DQogICAgPiBAQCAtNTY2LDYgKzU3
MCwzMCBAQCBzdGF0aWMgaW50IHVucG9pc29uX3BhZ2UodW5zaWduZWQgbG9uZyBvZmZzZXQpDQog
ICAgPiAgCXJldHVybiAwOw0KICAgID4gIH0NCiAgICA+ICANCiAgICA+ICtzdGF0aWMgaW50IG1h
cmtfcGFnZV9pZGxlKHVuc2lnbmVkIGxvbmcgb2Zmc2V0KQ0KICAgID4gK3sNCiAgICA+ICsJc3Rh
dGljIHVuc2lnbmVkIGxvbmcgb2ZmOw0KICAgID4gKwlzdGF0aWMgdWludDY0X3QgYnVmOw0KICAg
ID4gKwlpbnQgbGVuOw0KICAgID4gKw0KICAgID4gKwlpZiAoKG9mZnNldCAvIDY0ID09IG9mZiAv
IDY0KSB8fCBidWYgPT0gMCkgew0KICAgID4gKwkJYnVmIHw9IDFVTCA8PCAob2Zmc2V0ICUgNjQp
Ow0KICAgID4gKwkJb2ZmID0gb2Zmc2V0Ow0KICAgID4gKwkJcmV0dXJuIDA7DQogICAgPiArCX0N
CiAgICA+ICsNCiAgICA+ICsJbGVuID0gcHdyaXRlKHBhZ2VfaWRsZV9mZCwgJmJ1ZiwgOCwgOCAq
IChvZmYgLyA2NCkpOw0KICAgID4gKwlpZiAobGVuIDwgMCkgew0KICAgID4gKwkJcGVycm9yKCJt
YXJrIHBhZ2UgaWRsZSIpOw0KICAgID4gKwkJcmV0dXJuIGxlbjsNCiAgICA+ICsJfQ0KICAgID4g
Kw0KICAgID4gKwlidWYgPSAxVUwgPDwgKG9mZnNldCAlIDY0KTsNCiAgICA+ICsJb2ZmID0gb2Zm
c2V0Ow0KICAgID4gKw0KICAgID4gKwlyZXR1cm4gMDsNCiAgICA+ICt9DQogICAgDQogICAgVGhp
cyBpcyBhIGJpdCBjdW1iZXJzb21lLiAgV2h5IG5vdCB0aGlzIHdheToNCiAgICANCiAgICBzdGF0
aWMgaW50IG1hcmtfcGFnZV9pZGxlKHVuc2lnbmVkIGxvbmcgb2Zmc2V0KQ0KICAgIHsNCiAgICAJ
c3RhdGljIHVuc2lnbmVkIGxvbmcgb2ZmOw0KICAgIAlzdGF0aWMgdWludDY0X3QgYnVmOw0KICAg
IAlpbnQgbGVuOw0KICAgIA0KICAgIAlpZiAoKG9mZnNldCAvIDY0ICE9IG9mZiAvIDY0KSAmJiBi
dWYgIT0gMCkgew0KICAgIAkJbGVuID0gcHdyaXRlKHBhZ2VfaWRsZV9mZCwgJmJ1ZiwgOCwgOCAq
IChvZmYgLyA2NCkpOw0KICAgIAkJaWYgKGxlbiA8IDApIHsNCiAgICAJCQlwZXJyb3IoIm1hcmsg
cGFnZSBpZGxlIik7DQogICAgCQkJcmV0dXJuIGxlbjsNCiAgICAJCX0NCiAgICAJfQ0KICAgIAli
dWYgPSAxVUwgPDwgKG9mZnNldCAlIDY0KTsNCiAgICAJb2ZmID0gb2Zmc2V0Ow0KICAgIAlyZXR1
cm4gMDsNCiAgICB9DQogICAgDQogICAgQWxzbywgaXQncyBub3QgdmVyeSBjbGVhciB3aGF0J3Mg
Z29pbmcgb24gaGVyZSAtIHRoZSBoYW5kbGluZyBvZg0KICAgIG9mZnNldCwgb2ZmIGFuZCBidWYu
ICBTb21lIHdlbGwtY3JhZnRlZCBjb21tZW50cyB3b3VsZCBoZWxwLg0KICAgIA0KICAgID4NCiAg
ICA+IC4uLg0KICAgID4NCiAgICANCg0K
