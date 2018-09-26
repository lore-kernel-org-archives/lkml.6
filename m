Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA42C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBBB21536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBBB21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeI0Ejv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:39:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:49310 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeI0Ejv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:39:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 15:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="86860953"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2018 15:24:39 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 26 Sep 2018 15:24:39 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.58]) with mapi id 14.03.0319.002;
 Wed, 26 Sep 2018 15:24:35 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: RE: [PATCH v5 4/5] Capability: Complete PTRACE_MODE_SCHED
Thread-Topic: [PATCH v5 4/5] Capability: Complete PTRACE_MODE_SCHED
Thread-Index: AQHUVdhjP/87TC64iE2Vl5spY0HK/KUDiLqA//+YZ8A=
Date:   Wed, 26 Sep 2018 22:24:34 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732146256E@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-5-casey.schaufler@intel.com>
 <CAG48ez1NqoW8bByrYe30MdyCn2th3X+tth=VhMHA2MA-PoaQVw@mail.gmail.com>
In-Reply-To: <CAG48ez1NqoW8bByrYe30MdyCn2th3X+tth=VhMHA2MA-PoaQVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWNiNTMxMzAtYzAxYi00MDRkLThlYmEtZGRjYTM1MjFkZGZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9ITDl0bjN5SlVJN2wzMENucEEreHJET0dTSWdEc1IzY0VjQ3VOYnU4QUlESXZvK3hnNk01YnBRTGxkXC9OcGpHIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW5uIEhvcm4gW21haWx0bzpq
YW5uaEBnb29nbGUuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNiwgMjAxOCAy
OjI2IFBNDQo+IFRvOiBTY2hhdWZsZXIsIENhc2V5IDxjYXNleS5zY2hhdWZsZXJAaW50ZWwuY29t
Pg0KPiBDYzogS2VybmVsIEhhcmRlbmluZyA8a2VybmVsLWhhcmRlbmluZ0BsaXN0cy5vcGVud2Fs
bC5jb20+OyBrZXJuZWwgbGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxp
bnV4LXNlY3VyaXR5LW1vZHVsZSA8bGludXgtc2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5l
bC5vcmc+OyBzZWxpbnV4QHR5Y2hvLm5zYS5nb3Y7IEhhbnNlbiwgRGF2ZQ0KPiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPjsgRG9jaywgRGVuZWVuIFQgPGRlbmVlbi50LmRvY2tAaW50ZWwuY29tPjsN
Cj4ga3Jpc3RlbkBsaW51eC5pbnRlbC5jb207IEFyamFuIHZhbiBkZSBWZW4gPGFyamFuQGxpbnV4
LmludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA0LzVdIENhcGFiaWxpdHk6IENv
bXBsZXRlIFBUUkFDRV9NT0RFX1NDSEVEDQo+IA0KPiBPbiBXZWQsIFNlcCAyNiwgMjAxOCBhdCAx
MDozNSBQTSBDYXNleSBTY2hhdWZsZXINCj4gPGNhc2V5LnNjaGF1ZmxlckBpbnRlbC5jb20+IHdy
b3RlOg0KPiA+IEFsbG93IGEgY29tcGxldGUgcHRyYWNlIGFjY2VzcyBjaGVjayB3aXRoIG1vZGUg
UFRSQUNFX01PREVfU0NIRUQuDQo+ID4gRGlzYWJsZSB0aGUgaW5hcHByb3ByaWF0ZSBwcml2aWxl
Z2UgY2hlY2sgaW4gdGhlIGNhcGFiaWxpdHkgY29kZQ0KPiA+IHRoYXQgZG9lcyBpbmNvbXBhdGli
bGUgbG9ja2luZy4NCj4gDQo+IFdoYXQncyB0aGF0IGxvY2tpbmcgeW91J3JlIHRhbGtpbmcgYWJv
dXQ/DQoNCm5zX2NhcGFibGUoKSBldmVudHVhbGx5IGdldHMgeW91IHRvIGFuIGF1ZGl0IGNhbGwu
IFRoZSBhdWRpdCBjb2RlDQppcyBnb2luZyB0byBkbyB0aGUgbG9ja2luZy4gRm9ydHVuYXRlbHks
IHRoZSBwcmVjZWRpbmcgY2FwX2lzc3Vic2V0KCkNCmlzIHRoZSBjaGVjayB0aGF0IHdlIHJlYWxs
eSBuZWVkIGhlcmUuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2FzZXkgU2NoYXVmbGVyIDxj
YXNleS5zY2hhdWZsZXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBrZXJuZWwvcHRyYWNlLmMg
ICAgICB8IDIgLS0NCj4gPiAgc2VjdXJpdHkvY29tbW9uY2FwLmMgfCAyICsrDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9wdHJhY2UuYyBiL2tlcm5lbC9wdHJhY2UuYw0KPiA+IGluZGV4IDk5
Y2ZkZGRlNmE1NS4uMGI2YTlkZjUxYzNiIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9wdHJhY2Uu
Yw0KPiA+ICsrKyBiL2tlcm5lbC9wdHJhY2UuYw0KPiA+IEBAIC0zMzEsOCArMzMxLDYgQEAgc3Rh
dGljIGludCBfX3B0cmFjZV9tYXlfYWNjZXNzKHN0cnVjdCB0YXNrX3N0cnVjdA0KPiAqdGFzaywg
dW5zaWduZWQgaW50IG1vZGUpDQo+ID4gICAgICAgICAgICAgICFwdHJhY2VfaGFzX2NhcChtbS0+
dXNlcl9ucywgbW9kZSkpKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRVBFUk07DQo+ID4NCj4g
PiAtICAgICAgIGlmIChtb2RlICYgUFRSQUNFX01PREVfU0NIRUQpDQo+ID4gLSAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPiA+ICAgICAgICAgcmV0dXJuIHNlY3VyaXR5X3B0cmFjZV9hY2Nlc3Nf
Y2hlY2sodGFzaywgbW9kZSk7DQo+ID4gIH0NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0
eS9jb21tb25jYXAuYyBiL3NlY3VyaXR5L2NvbW1vbmNhcC5jDQo+ID4gaW5kZXggMmU0ODlkNmEz
YWM4Li5lNzc0NTcxMTBkMDUgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvY29tbW9uY2FwLmMN
Cj4gPiArKysgYi9zZWN1cml0eS9jb21tb25jYXAuYw0KPiA+IEBAIC0xNTIsNiArMTUyLDggQEAg
aW50IGNhcF9wdHJhY2VfYWNjZXNzX2NoZWNrKHN0cnVjdCB0YXNrX3N0cnVjdA0KPiAqY2hpbGQs
IHVuc2lnbmVkIGludCBtb2RlKQ0KPiA+ICAgICAgICAgaWYgKGNyZWQtPnVzZXJfbnMgPT0gY2hp
bGRfY3JlZC0+dXNlcl9ucyAmJg0KPiA+ICAgICAgICAgICAgIGNhcF9pc3N1YnNldChjaGlsZF9j
cmVkLT5jYXBfcGVybWl0dGVkLCAqY2FsbGVyX2NhcHMpKQ0KPiA+ICAgICAgICAgICAgICAgICBn
b3RvIG91dDsNCj4gPiArICAgICAgIGlmIChtb2RlICYgUFRSQUNFX01PREVfU0NIRUQpDQo+ID4g
KyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiANCj4gU28gZm9yIFBUUkFDRV9NT0RFX1NDSEVE
LCB0aGlzIGZ1bmN0aW9uIGFsd2F5cyByZXR1cm5zIDAsIHJpZ2h0PyANCg0KVGhhdCBjYW4ndCBi
ZSByaWdodCwgY2FuIGl0PyBEZXRlcm1pbmluZyB0aGF0IHdlIGhhdmUgUFRSQUNFX01PREVfU0NI
RUQNCmF0IHRoaXMgcG9pbnQgc2hvdWxkIHJlc3VsdCBpbiAtRVBFUk0uIEkgbXVja2VkIHVwIG9u
IHRoZSBsb2dpYyBmbG93LiBUaGUNCm5leHQgcmV2aXNpb24gd2lsbCBmaXggdGhpcy4NCg0KPiBJ
ZiB0aGF0J3MgaW50ZW50aW9uYWwsIHBlcmhhcHMgeW91IHNob3VsZCBpbnN0ZWFkIGp1c3QgcHV0
ICJpZiAobW9kZSAmDQo+IFBUUkFDRV9NT0RFX1NDSEVEKSByZXR1cm4gMDsiIGF0IHRoZSBzdGFy
dCBvZiB0aGUgZnVuY3Rpb24sIHRvIGF2b2lkDQo+IHRha2luZyB0aGUgUkNVIHJlYWQgbG9jayBp
biB0aGlzIGNhc2UuDQo+IA0KPiA+ICAgICAgICAgaWYgKG5zX2NhcGFibGUoY2hpbGRfY3JlZC0+
dXNlcl9ucywgQ0FQX1NZU19QVFJBQ0UpKQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4gPiAgICAgICAgIHJldCA9IC1FUEVSTTsNCg==
