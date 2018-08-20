Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA32C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B798921473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B798921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeHTUQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:16:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:47598 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbeHTUQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:16:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 09:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="67661355"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2018 09:59:43 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 09:59:43 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.106]) with mapi id 14.03.0319.002;
 Mon, 20 Aug 2018 09:59:43 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>
Subject: RE: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
Thread-Topic: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
Thread-Index: AQHUNnfzi3NO3xojlUaFqSZKkXNAjaTJRumA//+XoTA=
Date:   Mon, 20 Aug 2018 16:59:42 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732143F80E@ORSMSX107.amr.corp.intel.com>
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-6-casey.schaufler@intel.com>
 <6e70b7c7-d932-91c8-35d1-70bd6cef16a5@tycho.nsa.gov>
In-Reply-To: <6e70b7c7-d932-91c8-35d1-70bd6cef16a5@tycho.nsa.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTE1ZDBmNGItNmRiZC00MWY5LThhN2EtMzlkM2QyMTEwM2VhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWTArM1JHUEhaRnRDclUwUkNnODZ2NXd6ZjZEMkwrQUZ6ZUw1MysyaGRTcVpRWkVRSWhYVjQ2UDM3VWcrK2E3SiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIFNtYWxsZXkgW21h
aWx0bzpzZHNAdHljaG8ubnNhLmdvdl0NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjAsIDIwMTgg
OTowMyBBTQ0KPiBUbzogU2NoYXVmbGVyLCBDYXNleSA8Y2FzZXkuc2NoYXVmbGVyQGludGVsLmNv
bT47IGtlcm5lbC0NCj4gaGFyZGVuaW5nQGxpc3RzLm9wZW53YWxsLmNvbTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtc2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5lbC5v
cmc7IHNlbGludXhAdHljaG8ubnNhLmdvdjsgSGFuc2VuLCBEYXZlDQo+IDxkYXZlLmhhbnNlbkBp
bnRlbC5jb20+OyBEb2NrLCBEZW5lZW4gVCA8ZGVuZWVuLnQuZG9ja0BpbnRlbC5jb20+Ow0KPiBr
cmlzdGVuQGxpbnV4LmludGVsLmNvbTsgYXJqYW5AbGludXguaW50ZWwuY29tDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggUkZDIHYyIDUvNV0gU0VMaW51eDogU3VwcG9ydCBTRUxpbnV4IGRldGVybWlu
YXRpb24gb2YNCj4gc2lkZS1jaGFubmVsIHZ1bG5lcmFiaWxpdHkNCj4gDQo+IE9uIDA4LzE3LzIw
MTggMDY6MTYgUE0sIENhc2V5IFNjaGF1ZmxlciB3cm90ZToNCj4gPiBTRUxpbnV4IGNvbnNpZGVy
cyB0YXNrcyB0byBiZSBzaWRlLWNoYW5uZWwgc2FmZSBpZiB0aGV5DQo+ID4gaGF2ZSBQUk9DRVNT
X1NIQVJFIGFjY2Vzcy4NCj4gDQo+IE5vdyB0aGUgZGVzY3JpcHRpb24gYW5kIHRoZSBjb2RlIG5v
IGxvbmdlciBtYXRjaC4NCg0KWW91J3JlIHJpZ2h0Lg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBDYXNleSBTY2hhdWZsZXIgPGNhc2V5LnNjaGF1ZmxlckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+
ID4gICBzZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMgfCA5ICsrKysrKysrKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5
L3NlbGludXgvaG9va3MuYyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPiA+IGluZGV4IGE4
YmYzMjQxMzBmNS4uN2ZiZDdkN2FjMWNiIDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L3NlbGlu
dXgvaG9va3MuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPiA+IEBAIC00
MjE5LDYgKzQyMTksMTQgQEAgc3RhdGljIHZvaWQgc2VsaW51eF90YXNrX3RvX2lub2RlKHN0cnVj
dA0KPiB0YXNrX3N0cnVjdCAqcCwNCj4gPiAgIAlzcGluX3VubG9jaygmaXNlYy0+bG9jayk7DQo+
ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzZWxpbnV4X3Rhc2tfc2FmZV9zaWRlY2hhbm5l
bChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhdl9kZWNpc2lv
biBhdmQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGF2Y19oYXNfcGVybV9ub2F1ZGl0KCZzZWxpbnV4
X3N0YXRlLCBjdXJyZW50X3NpZCgpLA0KPiB0YXNrX3NpZChwKSwNCj4gPiArCQkJCSAgICBTRUND
TEFTU19GSUxFLCBGSUxFX19SRUFELCAwLCAmYXZkKTsNCj4gPiArfQ0KPiANCj4gQW5kIG15IHF1
ZXN0aW9uIGZyb20gYmVmb3JlIHN0aWxsIHN0YW5kczogIHdoeSBkbyB3ZSBuZWVkIGEgbmV3IGhv
b2sgYW5kDQo+IG5ldyBzZWN1cml0eSBtb2R1bGUgaW5zdGVhZCBvZiBqdXN0IHVzaW5nIHB0cmFj
ZV9tYXlfYWNjZXNzKCk/DQoNCkxvY2tpbmcuIFRoZSBTRUxpbnV4IGNoZWNrLCBmb3IgZXhhbXBs
ZSwgd2lsbCBsb2NrIHVwIHNvbGlkIHdoaWxlIHRyeWluZw0KdG8gZ2VuZXJhdGUgYW4gYXVkaXQg
cmVjb3JkLiBUaGVyZSBpcyBubyBnb29kIHJlYXNvbiBhc2lkZSBmcm9tIGNvZGluZw0KY29udmVu
aWVuY2UgdG8gYXNzdW1lIHRoYXQgdGhlIHNhbWUgcmVzdHJpY3Rpb25zIHdpbGwgYXBwbHkgZm9y
IHNpZGUtY2hhbm5lbA0KYXMgYXBwbHkgdG8gcHRyYWNlLiBJJ20gYWN0dWFsbHkgYSB0b3VjaCBz
dXJwcmlzZWQgeW91J3JlIG5vdCBzdWdnZXN0aW5nIGENCnNlcGFyYXRlIFNFQ0NMQVNTIG9yIGFj
Y2VzcyBtb2RlIGZvciB0aGUgU0VMaW51eCBob29rLg0KDQo+IA0KPiA+ICsNCj4gPiAgIC8qIFJl
dHVybnMgZXJyb3Igb25seSBpZiB1bmFibGUgdG8gcGFyc2UgYWRkcmVzc2VzICovDQo+ID4gICBz
dGF0aWMgaW50IHNlbGludXhfcGFyc2Vfc2tiX2lwdjQoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4g
PiAgIAkJCXN0cnVjdCBjb21tb25fYXVkaXRfZGF0YSAqYWQsIHU4ICpwcm90bykNCj4gPiBAQCAt
NzAwMiw2ICs3MDEwLDcgQEAgc3RhdGljIHN0cnVjdCBzZWN1cml0eV9ob29rX2xpc3Qgc2VsaW51
eF9ob29rc1tdDQo+IF9fbHNtX3JvX2FmdGVyX2luaXQgPSB7DQo+ID4gICAJTFNNX0hPT0tfSU5J
VCh0YXNrX21vdmVtZW1vcnksIHNlbGludXhfdGFza19tb3ZlbWVtb3J5KSwNCj4gPiAgIAlMU01f
SE9PS19JTklUKHRhc2tfa2lsbCwgc2VsaW51eF90YXNrX2tpbGwpLA0KPiA+ICAgCUxTTV9IT09L
X0lOSVQodGFza190b19pbm9kZSwgc2VsaW51eF90YXNrX3RvX2lub2RlKSwNCj4gPiArCUxTTV9I
T09LX0lOSVQodGFza19zYWZlX3NpZGVjaGFubmVsLA0KPiBzZWxpbnV4X3Rhc2tfc2FmZV9zaWRl
Y2hhbm5lbCksDQo+ID4NCj4gPiAgIAlMU01fSE9PS19JTklUKGlwY19wZXJtaXNzaW9uLCBzZWxp
bnV4X2lwY19wZXJtaXNzaW9uKSwNCj4gPiAgIAlMU01fSE9PS19JTklUKGlwY19nZXRzZWNpZCwg
c2VsaW51eF9pcGNfZ2V0c2VjaWQpLA0KPiA+DQoNCg==
