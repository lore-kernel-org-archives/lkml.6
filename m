Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C32CC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE6A2173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE6A2173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeHNIre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:47:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:41945 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbeHNIre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:47:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 23:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,237,1531810800"; 
   d="scan'208";a="83178224"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2018 23:01:48 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 13 Aug 2018 23:01:26 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.143]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Tue, 14 Aug 2018 14:00:41 +0800
From:   "Zhang, Ning A" <ning.a.zhang@intel.com>
To:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: question about v4l2_i2c_new_subdev_board
Thread-Topic: question about v4l2_i2c_new_subdev_board
Thread-Index: AQHUM5Qg2y5F1CzjYkyCJrDzp+ATnA==
Date:   Tue, 14 Aug 2018 06:00:40 +0000
Message-ID: <1534226439.2854.37.camel@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D0E4A1AB8F2AA4BBA98229EA0B625C7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sIEhhbnMsIE1hdXJvDQoNCkkgZmluZCBpbiBzb3VyY2UgY29kZTogdjRsMi1jb21tb24u
YzogdjRsMl9pMmNfbmV3X3N1YmRldl9ib2FyZCgpLA0KdGhlcmUgaXMgYSBjb21tZW50Og0KDQoJ
LyogTm90ZTogYnkgbG9hZGluZyB0aGUgbW9kdWxlIGZpcnN0IHdlIGFyZSBjZXJ0YWluIHRoYXQg
Yy0NCj5kcml2ZXINCgnCoMKgwqB3aWxsIGJlIHNldCBpZiB0aGUgZHJpdmVyIHdhcyBmb3VuZC4g
SWYgdGhlIG1vZHVsZSB3YXMgbm90DQpsb2FkZWQNCgnCoMKgwqBmaXJzdCwgdGhlbiB0aGUgaTJj
IGNvcmUgdHJpZXMgdG8gZGVsYXktbG9hZCB0aGUgbW9kdWxlIGZvcg0KdXMsDQoJwqDCoMKgYW5k
IHRoZW4gYy0+ZHJpdmVyIGlzIHN0aWxsIE5VTEwgdW50aWwgdGhlIG1vZHVsZSBpcyBmaW5hbGx5
DQoJwqDCoMKgbG9hZGVkLiBUaGlzIGRlbGF5LWxvYWQgbWVjaGFuaXNtIGRvZXNuJ3Qgd29yayBp
ZiBvdGhlcg0KZHJpdmVycw0KCcKgwqDCoHdhbnQgdG8gdXNlIHRoZSBpMmMgZGV2aWNlLCBzbyBl
eHBsaWNpdGx5IGxvYWRpbmcgdGhlIG1vZHVsZQ0KCcKgwqDCoGlzIHRoZSBiZXN0IGFsdGVybmF0
aXZlLiAqLw0KDQpJIGZpbmQgaXQgYWRkZWQgYnkgY29tbWl0OiBmMDIyMmM3ZDg2MGYwOWE2MWJl
YzVlNTAwNTM5ZjI4ZGIwMTg0YjM4IA0KDQppdCB3YXMgYWRkZWQgYXQgeWVhciAyMDA5LCBpcyB0
aGlzIHN0aWxsIGFuIGlzc3VlIGluIG5ld2VyIGtlcm5lbCwgbGlrZQ0KNC4xND8NCg0KQlIuDQpO
aW5nLg==
