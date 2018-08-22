Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F89C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA43208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA43208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeHVXtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:49:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:42169 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeHVXtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:49:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 13:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,275,1531810800"; 
   d="scan'208";a="85578957"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 22 Aug 2018 13:22:37 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 22 Aug 2018 13:22:37 -0700
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.210]) by
 FMSMSX110.amr.corp.intel.com ([169.254.14.76]) with mapi id 14.03.0319.002;
 Wed, 22 Aug 2018 13:22:37 -0700
From:   "Jiang, Dave" <dave.jiang@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [GIT PULL]: libnvdimm updates for 4.19-rc1 v2 [1/2]
Thread-Topic: [GIT PULL]: libnvdimm updates for 4.19-rc1 v2 [1/2]
Thread-Index: AQHUOlXdakBqom0iI0C+m0k9eFj0Zg==
Date:   Wed, 22 Aug 2018 20:22:36 +0000
Message-ID: <05a8a38a69c0f2650d25b9f1fca4a8cff7a62142.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.182.136.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7BE12451AA81469349F3AF124930C9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClBsZWFzZSBwdWxsIHRvIHJlY2VpdmUgbGlibnZkaW1tIGNvbnRyaWJ1dGlv
bnMgZm9yIHY0LjE5LXJjMS4gSSBoYXZlIHNlcGFyYXRlZCBvdXQgdGhlIHRvcGljIGJyYW5jaGVz
IGFuZA0Kd2lsbCBiZSBzZW5kaW5nIHB1bGwgcmVxdWVzdHMgZm9yIHRoZW0gaW5kaXZpZHVhbGx5
Lg0KVGhpcyBicmFuY2ggY29udGFpbnMgYWxsIHRoZSBvcmlnaW5hbCBwYXRjaGVzIGZyb20gdGhl
IGZpcnN0IHB1bGwgcmVxdWVzdCB3aXRob3V0IHRoZSBkYXgtbWVtb3J5LWZhaWx1cmUgc2VyaWVz
Lg0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDEyNzNjMjUzYzMyYjlhMDcz
YTRkODkyMWVkMDc5MTc3Y2NjN2M4YWY6DQoNCiAgdG9vbHMvdGVzdGluZy9udmRpbW06IGFkdmVy
dGlzZSBhIHdyaXRlIGNhY2hlIGZvciBuZml0X3Rlc3QgKDIwMTgtMDYtMzAgMTA6NDU6NDggLTA3
MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdEBn
aXRvbGl0ZS5rZXJuZWwub3JnOnB1Yi9zY20vbGludXgva2VybmVsL2dpdC9udmRpbW0vbnZkaW1t
LmdpdCB0YWdzL2xpYm52ZGltbS1mb3ItNC4xOV9taXNjDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hh
bmdlcyB1cCB0byAyODZlODc3MTgxMDNhY2RmODVmNGVkMzIzYTM3ZTQ4MzlhOGE3YzA1Og0KDQog
IGxpYm52ZGltbTogZml4IGFyc19zdGF0dXMgb3V0cHV0IGxlbmd0aCBjYWxjdWxhdGlvbiAoMjAx
OC0wOC0yMCAwODo1NjozOCAtMDcwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbGlibnZkaW1tLWZvci00LjE5X21p
c2MNCg0KQ29sbGVjdGlvbiBvZiBtaXNjIGxpYm52ZGltbSBwYXRjaGVzIGZvciA0LjE5IHN1Ym1p
c3Npb24NCiogQWRkaW5nIHN1cHBvcnQgdG8gcmVhZCBsb2NrZWQgbnZkaW1tIGNhcGFjaXR5Lg0K
DQoqIENoYW5nZSB0ZXN0IGNvZGUgdG8gbWFrZSBEU00gZmFpbHVyZSBjb2RlIGluamVjdGlvbiBh
biBvdmVycmlkZS4NCg0KKiBBZGQgc3VwcG9ydCBmb3IgY2FsY3VsYXRlIG1heGltdW0gY29udGln
dW91cyBhcmVhIGZvciBuYW1lc3BhY2UuDQoNCiogQWRkIHN1cHBvcnQgZm9yIHF1ZXVlaW5nIGEg
c2hvcnQgQVJTIHdoZW4gdGhlcmUgaXMgb24gZ29pbmcgQVJTIGZvcg0KICBudmRpbW0uDQoNCiog
QWxsb3cgTlVMTCB0byBiZSBwYXNzZWQgaW4gdG8gLT5kaXJlY3RfYWNjZXNzKCkgZm9yIGthZGRy
IGFuZA0KICBwZm4gcGFyYW1zLg0KDQoqIEltcHJvdmUgc21hcnQgaW5qZWN0aW9uIHN1cHBvcnQg
Zm9yIG52ZGltbSBlbXVsYXRpb24gdGVzdGluZy4NCg0KKiBGaXggdGVzdCBjb2RlIHRoYXQgc3Vw
cG9ydHMgZm9yIGVtdWxhdGluZyBjb250cm9sbGVyIHRlbXBlcmF0dXJlLg0KDQoqIEZpeCBoYW5n
IG9uIGVycm9yIGJlZm9yZSBkZXZtX21lbXJlbWFwX3BhZ2VzKCkNCg0KKiBGaXggYSBidWcgdGhh
dCBjYXVzZXMgdXNlciBtZW1vcnkgY29ycnVwdGlvbiB3aGVuIGRhdGEgcmV0dXJuZWQNCiAgdG8g
dXNlciBmb3IgYXJzX3N0YXR1cy4NCg0KKiBNYWludGFpbmVyIHVwZGF0ZXMgZm9yIFJvc3MgWndp
c2xlciBlbWFpbHMgYW5kIGFkZGluZyBKYW4gS2FyYSB0byBmc2RheC4NCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KRGFu
IFdpbGxpYW1zICg0KToNCiAgICAgIGxpYm52ZGltbTogSW50cm9kdWNlIGxvY2tlZCBESU1NIGNh
cGFjaXR5IHN1cHBvcnQNCiAgICAgIGFjcGksIG5maXQ6IFByZWZlciBfRFNNIG92ZXIgX0xTUiBm
b3IgbmFtZXNwYWNlIGxhYmVsIHJlYWRzDQogICAgICB0b29scy90ZXN0aW5nL252ZGltbTogTWFr
ZSBEU00gZmFpbHVyZSBjb2RlIGluamVjdGlvbiBhbiBvdmVycmlkZQ0KICAgICAgdG9vbHMvdGVz
dGluZy9udmRpbW06IEZpeCBzdXBwb3J0IGZvciBlbXVsYXRpbmcgY29udHJvbGxlciB0ZW1wZXJh
dHVyZQ0KDQpEYXZlIEppYW5nICgxKToNCiAgICAgIGFjcGkvbmZpdDogcXVldWUgaXNzdWluZyBv
ZiBhcnMgd2hlbiBhbiB1YyBlcnJvciBub3RpZmljYXRpb24gY29tZXMgaW4NCg0KSHVhaXNoZW5n
IFllICg2KToNCiAgICAgIGxpYm52ZGltbSwgcG1lbToga2FkZHIgYW5kIHBmbiBjYW4gYmUgTlVM
TCB0byAtPmRpcmVjdF9hY2Nlc3MoKQ0KICAgICAgczM5MCwgZGNzc2Jsazoga2FkZHIgYW5kIHBm
biBjYW4gYmUgTlVMTCB0byAtPmRpcmVjdF9hY2Nlc3MoKQ0KICAgICAgdG9vbHMvdGVzdGluZy9u
dmRpbW06IGthZGRyIGFuZCBwZm4gY2FuIGJlIE5VTEwgdG8gLT5kaXJlY3RfYWNjZXNzKCkNCiAg
ICAgIGRheC9zdXBlcjogRG8gbm90IHJlcXVlc3QgYSBwb2ludGVyIGthZGRyIHdoZW4gbm90IHJl
cXVpcmVkDQogICAgICBtZC9kbS13cml0ZWNhY2hlOiBEb24ndCByZXF1ZXN0IHBvaW50ZXIgZHVt
bXlfYWRkciB3aGVuIG5vdCByZXF1aXJlZA0KICAgICAgZmlsZXN5c3RlbS1kYXg6IERvIG5vdCBy
ZXF1ZXN0IGthZGRyIGFuZCBwZm4gd2hlbiBub3QgcmVxdWlyZWQNCg0KS2VpdGggQnVzY2ggKDIp
Og0KICAgICAgbGlibnZkaW1tOiBVc2UgbWF4IGNvbnRpZ3VvdXMgYXJlYSBmb3IgbmFtZXNwYWNl
IHNpemUNCiAgICAgIGxpYm52ZGltbTogRXhwb3J0IG1heCBhdmFpbGFibGUgZXh0ZW50DQoNClJv
c3MgWndpc2xlciAoMik6DQogICAgICBNQUlOVEFJTkVSUzogdXBkYXRlIFJvc3MgWndpc2xlcidz
IGVtYWlsIGFkZHJlc3MNCiAgICAgIE1BSU5UQUlORVJTOiBBZGQgSmFuIEthcmEgZm9yIGZpbGVz
eXN0ZW0gREFYDQoNClN0ZWZhbiBIYWpub2N6aSAoMSk6DQogICAgICBkZXZpY2UtZGF4OiBhdm9p
ZCBoYW5nIG9uIGVycm9yIGJlZm9yZSBkZXZtX21lbXJlbWFwX3BhZ2VzKCkNCg0KVmlzaGFsIFZl
cm1hICgyKToNCiAgICAgIHRvb2xzL3Rlc3RpbmcvbnZkaW1tOiBpbXByb3ZlIGVtdWxhdGlvbiBv
ZiBzbWFydCBpbmplY3Rpb24NCiAgICAgIGxpYm52ZGltbTogZml4IGFyc19zdGF0dXMgb3V0cHV0
IGxlbmd0aCBjYWxjdWxhdGlvbg0KDQogLm1haWxtYXAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDEgKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsrLS0NCiBk
cml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgICAgICAgICB8ICAyNCArKysrKystLQ0KIGRyaXZlcnMv
YWNwaS9uZml0L25maXQuaCAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL2RheC9wbWVtLmMgICAg
ICAgICAgICAgICB8ICAxMiArKy0tDQogZHJpdmVycy9kYXgvc3VwZXIuYyAgICAgICAgICAgICAg
fCAgIDMgKy0NCiBkcml2ZXJzL21kL2RtLXdyaXRlY2FjaGUuYyAgICAgICB8ICAgMyArLQ0KIGRy
aXZlcnMvbnZkaW1tL2J1cy5jICAgICAgICAgICAgIHwgICA0ICstDQogZHJpdmVycy9udmRpbW0v
ZGltbS5jICAgICAgICAgICAgfCAgMjQgKysrKysrKy0NCiBkcml2ZXJzL252ZGltbS9kaW1tX2Rl
dnMuYyAgICAgICB8ICAzMSArKysrKysrKysrDQogZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2Rl
dnMuYyAgfCAgMjkgKysrKysrKystDQogZHJpdmVycy9udmRpbW0vbmQtY29yZS5oICAgICAgICAg
fCAgIDggKysrDQogZHJpdmVycy9udmRpbW0vbmQuaCAgICAgICAgICAgICAgfCAgIDEgKw0KIGRy
aXZlcnMvbnZkaW1tL3BtZW0uYyAgICAgICAgICAgIHwgICA3ICsrLQ0KIGRyaXZlcnMvbnZkaW1t
L3JlZ2lvbl9kZXZzLmMgICAgIHwgIDQwICsrKysrKysrKysrKysNCiBkcml2ZXJzL3MzOTAvYmxv
Y2svZGNzc2Jsay5jICAgICB8ICAgOCArKy0NCiBmcy9kYXguYyAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxMyArKy0tDQogdG9vbHMvdGVzdGluZy9udmRpbW0vcG1lbS1kYXguYyAgfCAgMTIg
KystLQ0KIHRvb2xzL3Rlc3RpbmcvbnZkaW1tL3Rlc3QvbmZpdC5jIHwgMTI2ICsrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KIDE5IGZpbGVzIGNoYW5nZWQsIDI3MCBpbnNl
cnRpb25zKCspLCA5MCBkZWxldGlvbnMoLSkNCg==
