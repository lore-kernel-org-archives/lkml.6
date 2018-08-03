Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2CDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34A82177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34A82177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeHCTI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:08:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:29517 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbeHCTI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 10:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,439,1526367600"; 
   d="scan'208";a="245797206"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 03 Aug 2018 10:11:42 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 3 Aug 2018 10:11:42 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.163]) with mapi id 14.03.0319.002;
 Fri, 3 Aug 2018 10:11:41 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "hehy1@lenovo.com" <hehy1@lenovo.com>
Subject: Re: [PATCH] ACPI: nfit: return -ENODEV if fail to find NFIT at
 startup
Thread-Topic: [PATCH] ACPI: nfit: return -ENODEV if fail to find NFIT at
 startup
Thread-Index: AQHUKw9W31TJeaGVuEmcv5V4mRjBQqSuuU+A
Date:   Fri, 3 Aug 2018 17:11:41 +0000
Message-ID: <1533316299.8557.71.camel@intel.com>
References: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
In-Reply-To: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE939AF9BD0A30438FEC5A12E3B27967@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTgtMDgtMDMgYXQgMDU6MzkgLTA0MDAsIE9jZWFuIEhlIHdyb3RlOg0KPiBG
cm9tOiBPY2VhbiBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gDQo+IEluIHRoZSBiZWdpbm5pbmcg
b2YgYWNwaV9uZml0X2FkZCwgaWYgZmFpbCB0byBmaW5kIE5GSVQgdGFibGUgdGhlbg0KPiBzaG91
bGQNCj4gcmV0dXJuIC1FTk9ERVYsIGluc3RlYWQgb2YgMC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE9jZWFuIEhlIDxoZWh5MUBsZW5vdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvYWNwaS9uZml0
L2NvcmUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyBiL2Ry
aXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiBpbmRleCA3YzQ3OTAwLi4xNzkwZDdjIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL25m
aXQvY29yZS5jDQo+IEBAIC0zMzU1LDcgKzMzNTUsNyBAQCBzdGF0aWMgaW50IGFjcGlfbmZpdF9h
ZGQoc3RydWN0IGFjcGlfZGV2aWNlDQo+ICphZGV2KQ0KPiAgCWlmIChBQ1BJX0ZBSUxVUkUoc3Rh
dHVzKSkgew0KPiAgCQkvKiBUaGlzIGlzIG9rLCB3ZSBjb3VsZCBoYXZlIGFuIG52ZGltbSBob3Rw
bHVnZ2VkDQo+IGxhdGVyICovDQo+ICAJCWRldl9kYmcoZGV2LCAiZmFpbGVkIHRvIGZpbmQgTkZJ
VCBhdCBzdGFydHVwXG4iKTsNCj4gLQkJcmV0dXJuIDA7DQo+ICsJCXJldHVybiAtRU5PREVWOw0K
DQpIbSwgdGhlIGNvbW1lbnQgZGlyZWN0bHkgYWJvdmUgdGhpcyBzYXlzIHRoaXMgaXMgb2suLg0K
SGFzIHRoaXMgY2F1c2VkIGFueSBwcm9ibGVtcyBpbiBwcmFjdGljZT8NCg0KPiAgCX0NCj4gIA0K
PiAgCXJjID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgYWNwaV9uZml0X3B1dF90YWJs
ZSwNCj4gdGJsKTsNCg==
