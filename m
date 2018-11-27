Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1786C214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OGRp/jXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1786C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeK1Bej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:34:39 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:43176 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeK1Bei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:34:38 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7F4DF10C0B4D;
        Tue, 27 Nov 2018 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543329391; bh=2kfpblKQ9H0YKDqaL65Ci7kNhpFq/Lk7EITNw+GNp8c=;
        h=From:To:CC:Subject:Date:From;
        b=OGRp/jXgRP/ZdfKQKZ87zCjQOyPicnk28kVdIoIOILzKSm+hDJ+NFj76Yg+2lXJmx
         dhBPFvywM5quMa4xUntRrzSrFt7si5PX0lMQW/7ZBIrLkxG9CbT7Npbba3ND+JNF7O
         SpbW+sfUFhQrad0T0JCkx9uMseCwyYAgXLS5Cf2mUF129PabmewoaTQ+nveN/GRXKE
         unr3bBtW2REPK4YEtoWnY2232Y9NumGBpmKx0KAlkZC8ZIL7A/lo4qRP4D4HqI6iO8
         KZDIRBqeahjkOQaEIWDsxXwXYtocLr7OZHNAXnvxNGPfrapuCLdEmTYEwBr3iT4Uf1
         hSzpbyDQ/1+1w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 04F7B5B42;
        Tue, 27 Nov 2018 06:36:31 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 27 Nov 2018 06:36:30 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 27 Nov 2018 15:36:28 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: 'branches' perf event mapping differs on ARC and ARM
Thread-Topic: 'branches' perf event mapping differs on ARC and ARM
Thread-Index: AQHUhl6UMI9IICATOUqAlhDukujZmA==
Date:   Tue, 27 Nov 2018 14:36:27 +0000
Message-ID: <1543329386.13651.13.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7E00467B57EB4EBAF227FB890D0391@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldoaWxlIHBsYXlpbmcgd2l0aCBwZXJmIHRvb2wgb24gQVJNdjcgYW5kIEFSQ3YyIHBy
b2Nlc3NvcnMgYW5kIHByb2ZpbGluZyB0aGUNCnNhbWUgYXBwbGljYXRpb24gSSBnb3QgaW50ZXJl
c3RpbmcgcmVzdWx0cy4gRXZlbiBpZiB3ZSBnb3QgcHJldHR5DQpzaW1pbGFyIHRvdGFsDQpleGVj
dXRpb24gdGltZSBhbmQgaW5zdHJ1Y3Rpb25zIG51bWJlciB0aGUgbnVtYmVyIG9mIGJyYW5jaGVz
IG9uIEFSQyBpcyBhYm91dA0KdGhyZWUgdGltZXMgbW9yZSB0aGVuIG9uIEFSTS4NCg0KSSBkdWcg
aW50byBhcmNoaXRlY3R1cmUNCnNwZWNpZmljIHBlcmYgc291cmNlcyBhbmQgZm91bmQgdGhhdCB3
ZSBtYXAgZGlmZmVyZW50DQpIVyBjb3VudGVycyBpbnRvIGdlbmVyaWMgJ2JyYW5jaGVzJyBldmVu
dCBvbiBBUkMgYW5kIEFSTS4NCi0gV2UgdXNlICJpam1wIiBldmVudCBvbiBBUkMgd2hpY2gNCmNv
dW50cyBhbGwganVtcCBhbmQgYnJhbmNoIGluc3RydWN0aW9ucyAocmVnYXJkbGVzcw0Kb2YgcmVh
bCBleGVjdXRpb24gZmxvdyAtIGV2ZW4gaWYgbm8gcmVhbCBqdW1wIGhhcHBlbnMpDQotIFdlIHVz
ZSAicGNfd3JpdGVfcmV0aXJlZCIgZXZlbnQgb24gQVJNDQp3aGljaCBjb3VudHMgb25seSB0YWtl
biBicmFuY2hlcyAoSW5zdHJ1Y3Rpb24NCmFyY2hpdGVjdHVyYWxseSBleGVjdXRlZCwgY29uZGl0
aW9uIGNoZWNrIHBhc3MgLSBzb2Z0d2FyZSBjaGFuZ2Ugb2YgdGhlIFBDKQ0KDQpTbyBJIHdhcyB3
b25kZXJpbmcgZG8geW91IGtub3cNCndoaWNoIGFwcHJvYWNoIGlzIGNvcnJlY3Q/DQoNCg0KDQpJ
IGd1ZXNzIGNvdW50aW5nIGFsbCBqdW1wIGFuZCBicmFuY2ggaW5zdHJ1Y3Rpb25zIGlzIGNvcnJl
Y3QgYmVjYXVzZSB3ZSB1c2UNCidicmFuY2hlcycgZXZlbnQgdmFsdWUgdG8gY2FsY3VsYXRlIHJl
bGF0aXZlIHZhbHVlIG9mICdicmFuY2gtbWlzc2VzJyB1c2luZw0KDQpmb2xsb3dpbmcgZm9ybXVs
YToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS04LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KYnJhbmNoLW1pc3Nlcy1yYXRpb24gPSAnYnJhbmNoLW1pc3NlcycgLyAnYnJhbmNoZXMn
ICogMTAwLjANCi0tLS0tLS0tLS0tLS0tLS0NCi0tLS0tLS0tLS0tLTgtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpBbmQgdXNpbmcgb25seSB0YWtlbiBicmFuY2hlcyBoZXJlIGlzIGluY29y
cmVjdCBJTUhPLiBTbyBJIGd1ZXNzIHdlIHNob3VsZA0KbWFwICdicl9pbW1lZF9yZXRpcmVkJyBp
bnN0ZWFkIG9mDQoicGNfd3JpdGVfcmV0aXJlZCIgaW50byBnZW5lcmljICdicmFuY2hlcycNCmV2
ZW50IG9uIEFSTS4NCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
