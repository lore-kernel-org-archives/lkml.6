Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1313ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AC52146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AC52146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeIRD7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:59:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:48229 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbeIRD7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:59:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 15:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,387,1531810800"; 
   d="scan'208";a="75093269"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga006.jf.intel.com with ESMTP; 17 Sep 2018 15:29:19 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 17 Sep 2018 15:29:19 -0700
Received: from orsmsx151.amr.corp.intel.com ([169.254.7.211]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.73]) with mapi id 14.03.0319.002;
 Mon, 17 Sep 2018 15:29:19 -0700
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
To:     "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "Howell, Seth" <seth.howell@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Topic: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Index: AQHUNB7X7okyqfuXp0e3kpEuk2f+WqTB4cuAgAAKaQCAATczAIAGhGQAgCvyAwCAAAhxAIAAFpgA
Date:   Mon, 17 Sep 2018 22:29:18 +0000
Message-ID: <0df4e4958250fd6cdb978005ace970c877269535.camel@intel.com>
References: <20180814223303.83556-1-seth.howell@intel.com>
         <20180815225021.GB31799@ziepe.ca>
         <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
         <20180816180126.GB10507@ziepe.ca>
         <EA913ED399BBA34AA4EAC2EDC24CDD0086118B12@FMSMSX105.amr.corp.intel.com>
         <11f85f780435a5ded567bc8559d7c770d3bc4464.camel@intel.com>
         <20180917210824.GF11367@ziepe.ca>
In-Reply-To: <20180917210824.GF11367@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.18.124.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC10D2F9C618D64C8BE902C1CBC3771D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTE3IGF0IDE1OjA4IC0wNjAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIE1vbiwgU2VwIDE3LCAyMDE4IGF0IDA4OjM4OjE2UE0gKzAwMDAsIFdhbGtlciwgQmVu
amFtaW4gd3JvdGU6DQo+ID4gV2UndmUgcmVjZW50bHkgcnVuIGludG8gdGhpcyBzYW1lIGlzc3Vl
IG9uIGk0MGl3LCB3aGljaCBhcHBlYXJzIHRvIG1ha2UgdGhlDQo+ID4gc2FtZQ0KPiA+IG1pc3Rh
a2Ugb2YgdXNpbmcgdGhlIGtlcm5lbCB2ZXJzaW9uIG9mIHRoZSBlbnVtIGluc3RlYWQgb2YgdGhl
IHVzZXJzcGFjZQ0KPiA+IHZlcnNpb24uIA0KPiANCj4gQ29uZnVzZWQgYnkgdGhpcz8/IGk0MGl3
X3Vwb3N0X3NlbmQgZG9lcyBub3QgaGFuZGxlIHRoZSBrZXJuZWwgbnVtYmVycw0KPiBhdCBhbGws
IGFzIGZhciBhcyBJIGNhbiBzZWU/IEhvdyBkb2VzIGl0IGRldmVsb3AgYSBrZXJuZWwgZGVwZW5k
ZW5jeT8/DQo+IA0KPiA+IFdoYXQncyB0aGUgY3VycmVudCBzdGF0dXMgaGVyZT8gQ2FuIGl0IGJl
IG1lcmdlZD8gSSBqdXN0IGNoZWNrZWQgYW5kDQo+ID4gZG8gbm90IHNlZSBpdCBtZXJnZWQgdG8g
TGludXggbWFzdGVyLg0KPiANCj4gT2ghIFRoaXMgYXBwYXJlbnRseSBnb3QgbG9zdCwgdGhhbmtz
IGZvciBicmluZ2luZyBpdCB1cCBhZ2Fpbi4NCj4gDQo+ID4gUnVubmluZyBhIHVzZXItc3BhY2Ug
TlZNZS1vRiB0YXJnZXQgd2l0aCBSRE1BIGFuZCBhIHJlY2VudCBMaW51eCBrZXJuZWwNCj4gPiBp
bml0aWF0b3IgaXMgbm90IGN1cnJlbnRseSBwb3NzaWJsZSBvbiByeGUgb3IgaTQwaXcgYmVjYXVz
ZSBpdCByZXF1aXJlcyBzZW5kDQo+ID4gd2l0aCBpbnZhbGlkYXRlIHN1cHBvcnQuDQo+IA0KPiBP
a2F5LCBidXQgaTQwaXcgZG9lc24ndCBzZWVtIHRvIHN1cHBvcnQgc2VuZCB3aXRoIGludmFsaWRh
dGUgYXQgYWxsIGluDQo+IHVzZXJzcGFjZT8NCj4gDQo+IGk0MGl3X3Vwb3N0X3NlbmQoKSBzd2l0
aGNlcyBvbiBvcGNvZGUsIGRvZXNuJ3QgaGFuZGxlIFNFTkRfSU5WIGFuZA0KPiB0aGVuIGJsb3dz
IHVwIGluIHRoZSBkZWZhdWx0IGNsYXVzZSAtIGhvdyBkb2VzIHRoaXMgcGF0Y2ggbWFrZSBhbnkN
Cj4gZGlmZmVyZW5jZT8/Pw0KDQpJdCBhcHBlYXJzIEkndmUgcmVhZCB0aGUgZXJyb3IgbWVzc2Fn
ZSBpbmNvcnJlY3RseSBhbmQgd2FzIGxvb2tpbmcgYXQgdGhlIGtlcm5lbA0KdmVyc2lvbiAoaTQw
aXdfcG9zdF9zZW5kKSBhcyBvcHBvc2VkIHRvIHRoZSB1c2VyIHZlcnNpb24gKGk0MGl3X3Vwb3N0
X3NlbmQpLg0KSW5kZWVkLCB0aGUgTklDIGRvZXMgbm90IHN1cHBvcnQgU0VORF9XVElIX0lOVkFM
IGF0IGFsbCBpbiB0aGF0IGZ1bmN0aW9uLiBUaGUNCk5JQyBkb2VzIHN1cHBvcnQgU0VORF9XSVRI
X0lOVkFMIGluIHRoZSBrZXJuZWwgaTQwaXdfcG9zdF9zZW5kLg0KDQpXaGF0IGlzIHRoZSBjb3Jy
ZWN0IHdheSBmb3IgYSB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIHRvIGNoZWNrIHdoZXRoZXIgYSBO
SUMNCnN1cHBvcnRzIFNFTkRfV0lUSF9JTlZBTD8gV2UgYXJlIGN1cnJlbnRseSBleGFtaW5pbmcg
dGhlIGRldmljZV9jYXBfZmxhZ3MgaW4gdGhlDQpzdHJ1Y3R1cmUgcmV0dXJuZWQgYnkgaWJ2X3F1
ZXJ5X2RldmljZS4gU3BlY2lmaWNhbGx5LCB3ZSdyZSBsb29raW5nIGF0DQpJQlZfREVWSUNFX01F
TV9NR1RfRVhURU5TSU9OUy4gSG93ZXZlciwgZm9yIGk0MGl3LCB0aGF0IGZsYWcgaXMgc2V0LiBJ
J20NCmNvbmNlcm5lZCB0aGF0IHRoZSBmZWF0dXJlIHN1cHBvcnQgZmxhZ3MgYXJlIGNvbW1vbiBi
ZXR3ZWVuIHVzZXIgc3BhY2UgYW5kIHRoZQ0Ka2VybmVsLCBidXQgdGhlIGFjdHVhbCBzdXBwb3J0
IGRpZmZlcnMgaW4gdGhpcyBjYXNlLg0KDQpUaGFua3MsDQpCZW4NCg0KPiANCj4gSmFzb24NCg0K
