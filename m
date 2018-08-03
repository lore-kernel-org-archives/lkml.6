Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24035C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FD62177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FD62177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeHCTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:10:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:28704 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbeHCTKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:10:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 10:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,439,1526367600"; 
   d="scan'208";a="80307029"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2018 10:13:39 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 3 Aug 2018 10:13:39 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.207]) with mapi id 14.03.0319.002;
 Fri, 3 Aug 2018 10:13:39 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "hehy1@lenovo.com" <hehy1@lenovo.com>
Subject: Re: [PATCH] libnvdimm, bus: check id immediately following
 ida_simple_get
Thread-Topic: [PATCH] libnvdimm, bus: check id immediately following
 ida_simple_get
Thread-Index: AQHUKyLEcZHHgxcVEUuunj+xgF7dd6SuubSA
Date:   Fri, 3 Aug 2018 17:13:39 +0000
Message-ID: <1533316417.8557.72.camel@intel.com>
References: <1533298113-17495-1-git-send-email-oceanhehy@gmail.com>
In-Reply-To: <1533298113-17495-1-git-send-email-oceanhehy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F108586DC8F90E448DF4CB33713BFEE6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTgtMDgtMDMgYXQgMDg6MDggLTA0MDAsIE9jZWFuIEhlIHdyb3RlOg0KPiBG
cm9tOiBPY2VhbiBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gDQo+IFRoZSBpZCBjaGVjayB3YXMg
bm90IGV4ZWN1dGVkIGltbWVkaWF0ZWx5IGZvbGxvd2luZyBpZGFfc2ltcGxlX2dldC4NCj4gSnVz
dA0KPiBjaGFuZ2UgdGhlIGNvZGVzIHBvc2l0aW9uLCB3aXRob3V0IGZ1bmN0aW9uIGNoYW5nZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9jZWFuIEhlIDxoZWh5MUBsZW5vdm8uY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbnZkaW1tL2J1cy5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpMb29rcyBnb29kLCBmZWVsIGZyZWUgdG8g
YWRkDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+
DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9idXMuYyBiL2RyaXZlcnMvbnZk
aW1tL2J1cy5jDQo+IGluZGV4IDI3OTAyYTguLmFiMjhlN2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbnZkaW1tL2J1cy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL2J1cy5jDQo+IEBAIC0zNTAs
MTIgKzM1MCwxMiBAQCBzdHJ1Y3QgbnZkaW1tX2J1cyAqbnZkaW1tX2J1c19yZWdpc3RlcihzdHJ1
Y3QNCj4gZGV2aWNlICpwYXJlbnQsDQo+ICAJSU5JVF9MSVNUX0hFQUQoJm52ZGltbV9idXMtPm1h
cHBpbmdfbGlzdCk7DQo+ICAJaW5pdF93YWl0cXVldWVfaGVhZCgmbnZkaW1tX2J1cy0+cHJvYmVf
d2FpdCk7DQo+ICAJbnZkaW1tX2J1cy0+aWQgPSBpZGFfc2ltcGxlX2dldCgmbmRfaWRhLCAwLCAw
LCBHRlBfS0VSTkVMKTsNCj4gLQltdXRleF9pbml0KCZudmRpbW1fYnVzLT5yZWNvbmZpZ19tdXRl
eCk7DQo+IC0JYmFkcmFuZ2VfaW5pdCgmbnZkaW1tX2J1cy0+YmFkcmFuZ2UpOw0KPiAgCWlmIChu
dmRpbW1fYnVzLT5pZCA8IDApIHsNCj4gIAkJa2ZyZWUobnZkaW1tX2J1cyk7DQo+ICAJCXJldHVy
biBOVUxMOw0KPiAgCX0NCj4gKwltdXRleF9pbml0KCZudmRpbW1fYnVzLT5yZWNvbmZpZ19tdXRl
eCk7DQo+ICsJYmFkcmFuZ2VfaW5pdCgmbnZkaW1tX2J1cy0+YmFkcmFuZ2UpOw0KPiAgCW52ZGlt
bV9idXMtPm5kX2Rlc2MgPSBuZF9kZXNjOw0KPiAgCW52ZGltbV9idXMtPmRldi5wYXJlbnQgPSBw
YXJlbnQ7DQo+ICAJbnZkaW1tX2J1cy0+ZGV2LnJlbGVhc2UgPSBudmRpbW1fYnVzX3JlbGVhc2U7
DQo=
