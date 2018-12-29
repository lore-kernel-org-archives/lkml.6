Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D723F218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeL2Cpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:45:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:42419 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeL2Cpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:45:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 18:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,412,1539673200"; 
   d="scan'208";a="104067203"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 28 Dec 2018 18:45:51 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 28 Dec 2018 18:45:51 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 28 Dec 2018 18:45:50 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.63]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.44]) with mapi id 14.03.0415.000;
 Sat, 29 Dec 2018 10:45:49 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: RE: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Thread-Topic: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Thread-Index: AQHUnlmk6JahV5tUvEStaso2AfS7RqWTQxYAgAG9uIA=
Date:   Sat, 29 Dec 2018 02:45:49 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
 <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
In-Reply-To: <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTE2NjllMzktNzI1Yy00YjQ0LTg5YmItMmM4MTllODAyZTFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYUViYkU2dHEzQjJVV3p4U1ZnNGJFeVBFOFdnR0VTK1RDbG9CbWY0a1VDYTZLNDRxK01pRWZFV3oweVBmTlF6NCJ9
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

T24gRnJpZGF5LCBEZWNlbWJlciAyOCwgMjAxOCAzOjU3IFBNLCBDaHJpc3RpYW4gQm9ybnRyYWVn
ZXIgd3JvdGU6DQo+IE9uIDI4LjEyLjIwMTggMDM6MjYsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IFNv
bWUgdnFzIGRvbid0IG5lZWQgdG8gYmUgYWxsb2NhdGVkIHdoZW4gdGhlIHJlbGF0ZWQgZmVhdHVy
ZSBiaXRzIGFyZQ0KPiA+IGRpc2FibGVkLiBDYWxsZXJzIG5vdGljZSB0aGUgdnEgYWxsb2NhdGlv
biBsYXllciBieSBzZXR0aW5nIHRoZQ0KPiA+IHJlbGF0ZWQgbmFtZXNbaV0gdG8gYmUgTlVMTC4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIHRoZSBmaW5kX3ZxcyBpbXBsZW1lbnRh
dGlvbnMgdG8gaGFuZGxlIHRoaXMgY2FzZS4NCj4gDQo+IFNvIHRoZSByYW5kb20gY3Jhc2hlcyBk
dXJpbmcgYm9vdCBhcmUgZ29uZS4NCj4gV2hhdCBzdGlsbCBkb2VzIG5vdCB3b3JrIGlzIGFjdHVh
bGx5IHVzaW5nIHRoZSBiYWxsb29uLg0KPiANCj4gU28gaW4gdGhlIHFlbXUgbW9uaXRvciB1c2lu
ZyBsZXRzIHNheSAiYmFsbG9vbiAxMDAwIiAgd2lsbCBoYW5nIHRoZSBndWVzdC4NCj4gU2VlbXMg
dG8gYmUgYSBkZWFkbG9jayBpbiB0aGUgdmlydGlvLWNjdyBjb2RlLiAgV2Ugc2VlbSB0byBjYWxs
IHRoZSBjb25maWcNCj4gY29kZSBpbiB0aGUgaW50ZXJydXB0IGhhbmRsZXIuDQoNClllcy4gSXQg
cmVhZHMgYSBjb25maWcgcmVnaXN0ZXIgZnJvbSB0aGUgaW50ZXJydXB0IGhhbmRsZXIuIERvIHlv
dSBrbm93IHdoeSBjY3cgZG9lc24ndCBzdXBwb3J0IGl0IGFuZCBoYXMgc29tZSBpbnRlcm5hbCBs
b2NrIHRoYXQgY2F1c2VkIHRoZSBkZWFkbG9jayBpc3N1ZT8NCiANCkJlc3QsDQpXZWkNCg==
