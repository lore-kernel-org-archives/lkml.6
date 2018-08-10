Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D3C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3E21A5E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF3E21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHJXnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:43:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:30262 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbeHJXnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:43:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 14:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,221,1531810800"; 
   d="scan'208";a="75625653"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2018 14:12:20 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 10 Aug 2018 14:12:20 -0700
Received: from fmsmsx105.amr.corp.intel.com ([169.254.4.225]) by
 FMSMSX119.amr.corp.intel.com ([169.254.14.38]) with mapi id 14.03.0319.002;
 Fri, 10 Aug 2018 14:12:20 -0700
From:   "Harris, James R" <james.r.harris@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Walker, Benjamin" <benjamin.walker@intel.com>,
        "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>
Subject: Problems with uio_pci_generic in v4.18-rc8
Thread-Topic: Problems with uio_pci_generic in v4.18-rc8
Thread-Index: AQHUMO7SwxMawBIKhkiUrrUq8hybgA==
Date:   Fri, 10 Aug 2018 21:12:19 +0000
Message-ID: <21BF98B1-0EA5-46BC-BC68-196190880087@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/f.21.0.170409
x-originating-ip: [143.182.136.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1B8AE34FE27FF4B83AB015E72204255@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQrCoA0KVXNpbmcgTGludXgga2VybmVsIHY0LjE4LXJjOCwgSSBhbSB1bmFibGUgdG8gYmlu
ZCBhIFBDSSBkZXZpY2UgdG8gdWlvX3BjaV9nZW5lcmljLsKgwqBUaGlzIHdvcmtzIGZpbmUgd2l0
aCB2NC4xOC1yYzQuwqDCoGRtZXNnIHNob3dzOg0KwqANClvCoMKgMzM2LjIyMTU4NV0gZ2VuaXJx
OiBUaHJlYWRlZCBpcnEgcmVxdWVzdGVkIHdpdGggaGFuZGxlcj1OVUxMIGFuZCAhT05FU0hPVCBm
b3IgaXJxIDMzDQpbwqDCoDMzNi4yMjE2ODFdIHVpb19wY2lfZ2VuZXJpYzogcHJvYmUgb2YgMDAw
MDowNDowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0yMg0KwqANClRoaXMgcHJvYmxlbSBoYXMgYmVl
biByZXByb2R1Y2VkIG9uIG11bHRpcGxlIHN5c3RlbXMuDQrCoA0KVGhpcyBzZWVtcyB0byBiZSBy
ZWxhdGVkIHRvIGNvbW1pdCA5NDIxZTQ1ZjUgKOKAnHVpbzogdXNlIHJlcXVlc3RfdGhyZWFkZWRf
aXJxIGluc3RlYWTigJ0pIHdoaWNoIHdhcyBtZXJnZWQgaW4gLXJjNS7CoMKgUmV2ZXJ0aW5nIHRo
aXMgY29tbWl0IGZpeGVzIHRoZSBpc3N1ZSAoSSBhbHNvIHJldmVydGVkIDU0M2FmNTg2MWYgYW5k
IDU3YzVmNGRmMGEgd2hpY2ggYWxzbyB0b3VjaCB1aW8uYyAtIGp1c3QgdG8gYmUgc2FmZSkuDQrC
oA0KVGhpcyBzZWVtcyBsaWtlIGEgc2VyaW91cyByZWdyZXNzaW9uIHRvIHVpb19wY2lfZ2VuZXJp
YywgYnV0IGFueSB0aXBzIG9yIHBvaW50ZXJzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KwqANClRo
YW5rcywNCsKgDQpKaW0gSGFycmlzDQoNCg==
