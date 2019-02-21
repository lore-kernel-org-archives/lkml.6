Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F7C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984882083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfBUR0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:26:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:56898 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUR0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:26:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 09:26:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,396,1544515200"; 
   d="scan'208";a="322305787"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2019 09:26:11 -0800
Received: from irsmsx108.ger.corp.intel.com ([169.254.11.28]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.72]) with mapi id 14.03.0415.000;
 Thu, 21 Feb 2019 17:26:10 +0000
From:   "Mehrtens, Hauke" <hauke.mehrtens@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "hauke@hauke-m.de" <hauke@hauke-m.de>
Subject: RE: [PATCH 4.9 04/20] net: Fix for_each_netdev_feature on Big endian
Thread-Topic: [PATCH 4.9 04/20] net: Fix for_each_netdev_feature on Big
 endian
Thread-Index: AQHUyfMqX/+WjOVxyU2WE1gETUpSPqXqf40A
Date:   Thu, 21 Feb 2019 17:26:10 +0000
Message-ID: <9231D502B07C5E4A8B32D5115C9F19991F89EFB4@IRSMSX108.ger.corp.intel.com>
References: <20190221125242.153179182@linuxfoundation.org>
 <20190221125242.858818453@linuxfoundation.org>
In-Reply-To: <20190221125242.858818453@linuxfoundation.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYThmYmFjMjItOTdkNC00YmVhLTllZGUtYjg0OGVmMzk5ZTkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVzVSRURrRjl2WUp0RUJtNW8zUU1ncUdYQlhNY05DbW9WcTFnemdjbWpYTEJvYk5wWlNvbHZyaFllMW9hQWJ3UyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEdyZWcgS3JvYWgtSGFydG1hbiBbbWFp
bHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXSANClNlbnQ6IFRodXJzZGF5LCBGZWJydWFy
eSAyMSwgMjAxOSAzOjM2IFBNDQpUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KQ2M6
IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBzdGFibGVA
dmdlci5rZXJuZWwub3JnOyBNZWhydGVucywgSGF1a2UgPGhhdWtlLm1laHJ0ZW5zQGludGVsLmNv
bT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NClN1YmplY3Q6IFtQQVRD
SCA0LjkgMDQvMjBdIG5ldDogRml4IGZvcl9lYWNoX25ldGRldl9mZWF0dXJlIG9uIEJpZyBlbmRp
YW4NCg0KNC45LXN0YWJsZSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFzIGFueSBvYmplY3Rp
b25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpGcm9tOiBI
YXVrZSBNZWhydGVucyA8aGF1a2UubWVocnRlbnNAaW50ZWwuY29tPg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCAzYjg5ZWE5YzU5MDJhY2NjZGJiZGVjMzA3Yzg1ZWRkMWJmNTI1MTVlIF0NCg0KVGhlIGZl
YXR1cmVzIGF0dHJpYnV0ZSBpcyBvZiB0eXBlIHU2NCBhbmQgc3RvcmVkIGluIHRoZSBuYXRpdmUg
ZW5kaWFuZXMgb24gdGhlIHN5c3RlbS4gVGhlIGZvcl9lYWNoX3NldF9iaXQoKSBtYWNybyB0YWtl
cyBhIHBvaW50ZXIgdG8gYSAzMiBiaXQgYXJyYXkgYW5kIGdvZXMgb3ZlciB0aGUgYml0cyBpbiB0
aGlzIGFyZWEuIE9uIGxpdHRsZSBFbmRpYW4gc3lzdGVtcyB0aGlzIGFsc28gd29ya3Mgd2l0aCBh
biB1NjQgYXMgdGhlIG1vc3Qgc2lnbmlmaWNhbnQgYml0IGlzIG9uIHRoZSBoaWdoZXN0IGFkZHJl
c3MsIGJ1dCBvbiBiaWcgZW5kaWFuIHRoZSB3b3JkcyBhcmUgc3dhcHBlZC4gV2hlbiB3ZSBleHBl
Y3QgYml0IDE1IGhlcmUgd2UgZ2V0IGJpdCA0NyAoMTUgKyAzMikuDQoNClRoaXMgcGF0Y2ggY29u
dmVydHMgaXQgbW9yZSBvciBsZXNzIHRvIGl0cyBvd24gZm9yX2VhY2hfc2V0X2JpdCgpIGltcGxl
bWVudGF0aW9uIHdoaWNoIHdvcmtzIG9uIDY0IGJpdCBpbnRlZ2VycyBkaXJlY3RseS4gVGhpcyBp
cyB0aGVuIGNvbXBsZXRlbHkgaW4gaG9zdCBlbmRpYW5uZXNzIGFuZCBzaG91bGQgd29yayBsaWtl
IGV4cGVjdGVkLg0KDQpGaXhlczogZmQ4NjdkNTFmICgibmV0L2NvcmU6IGdlbmVyaWMgc3VwcG9y
dCBmb3IgZGlzYWJsaW5nIG5ldGRldiBmZWF0dXJlcyBkb3duIHN0YWNrIikNClNpZ25lZC1vZmYt
Ynk6IEhhdWtlIE1laHJ0ZW5zIDxoYXVrZS5tZWhydGVuc0BpbnRlbC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQpTaWduZWQtb2ZmLWJ5
OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KLS0tDQog
aW5jbHVkZS9saW51eC9uZXRkZXZfZmVhdHVyZXMuaCB8ICAgMjMgKysrKysrKysrKysrKysrKysr
KysrLS0NCiBuZXQvY29yZS9kZXYuYyAgICAgICAgICAgICAgICAgIHwgICAgNCArKy0tDQogMiBm
aWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpIaSBHcmVn
LA0KDQpUaGlzIGNvbW1pdCBhZGRzIGEgbWlzc2luZyBpbmNsdWRlLCBJIGRvIG5vdCBrbm93IGlm
IHRoaXMgcmVhbGx5IGNhdXNlcyBhIGNvbXBpbGUgcHJvYmxlbToNCmh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvbGludXMvODY4MWVmMWYzZDI5NWJkMzYwMDMxNTMyNWYzYjMzOTZkNzZkMDJmNg0KDQpJ
dCB3YXMgYWxzbyBzdWdnZXN0ZWQgdG8gdXNlIGEgbG9uZ2VyIGNvbW1pdCBJRCBpbiB0aGUgRml4
ZXMgdGFnIGxpa2UgdGhpczoNCkZpeGVzOiBmZDg2N2Q1MWY4ODkgKCJuZXQvY29yZTogZ2VuZXJp
YyBzdXBwb3J0IGZvciBkaXNhYmxpbmcgbmV0ZGV2IGZlYXR1cmVzIGRvd24gc3RhY2siKQ0KDQpI
YXVrZQ0K
