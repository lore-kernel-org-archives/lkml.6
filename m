Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1144387-1518688011-2-1570604609053070662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518688011; b=iB/v4/7jcN8Wbx1g7YDwzpEDnYjgxp47Z6ld9Z03pZUm7BT
    rUGXZ6hHSyQ9AYWTxtw/f1xpiDhqBHko3DHS7r767/z3ramoQYmrAsq7qqxhFh6T
    oXKx1YiPU2cPVsN+JyG9J2YVVMKKlq902ptAnCyC3W4QLyN9vGp0TRqq6cEEHOSU
    /+JURdNUATn+k9a7Ns2rqDnjfvYiB6K8enpTqVCCKi8KvvBgkhlLLJScVKllak3U
    2e9BmBWJBWhp+v5GR6HsGMgzBOh48r+6YB3rWV93USwbYLyTaqXVnqoggQS8oOsa
    zKkbMPgvygx+qoktAp2ziPfMrtAkWIyyMAZOI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1518688011; bh=Dn9SJt
    bSnaZsLnAr/VYmz11B/TVnv8H8TyLBs0i8UWQ=; b=QZ1WuTs5P22niX6gc9MaHt
    kRR1k2EAZZRXhZwxCTkZ7CS/sDDybqC/kshPTSl2cBNlpS3j9zDC8zQnHC3rn6C0
    39E3gwhEEtAWMq+2BtCQpxEhhOHRBfkCjjYYze/Ar3wUlQ/VUks+DarqZgFW0yZF
    IurDr0+fUD17Pjdox4YQqtmHZ+W+N/5cpWy9l8d4lFGl0uCUQoFHnoiWeaJDxzy6
    eWxKYd7wWOCV10tNBYqn3j8VxWnR2cGbbu7uEc85sZiVv0hlnSY3Kigb+RNauIWk
    D/I+NGZx0Q1l5mUhEN+bY8HZV9yVBeqkozzq4lkooH/M7CBXyObmFglvJC+CGk/g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755186AbeBOJqs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 04:46:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:49890 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755165AbeBOJqq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 15 Feb 2018 04:46:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,516,1511856000";
   d="scan'208";a="175389028"
From: "Wu, Hao" <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
CC: Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        "Whisonant, Tim" <tim.whisonant@intel.com>,
        "Luebbers, Enno" <enno.luebbers@intel.com>,
        "Rao, Shiva" <shiva.rao@intel.com>,
        "Rauer, Christopher" <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: RE: [PATCH v4 06/24] fpga: dfl: adds fpga_cdev_find_port
Thread-Topic: [PATCH v4 06/24] fpga: dfl: adds fpga_cdev_find_port
Thread-Index: AQHTpK4BoH9bcmg6A0K9/8el40XWhKOjkTCAgAGobxA=
Date: Thu, 15 Feb 2018 09:46:42 +0000
Message-ID: <BE8371DA886269458E0220A16DC1F8277E154E4F@SHSMSX104.ccr.corp.intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-7-git-send-email-hao.wu@intel.com>
 <CANk1AXQgeeQm_ncn+17nrjr+YTCKvpc=PVZEsaZVOjRb3aHTQQ@mail.gmail.com>
In-Reply-To: <CANk1AXQgeeQm_ncn+17nrjr+YTCKvpc=PVZEsaZVOjRb3aHTQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWFjNzNlNjktZTg2OC00ZGFmLWI4YjEtNTBjMDQ0NDU4ZmE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJHUHV0dGdSK2RhZHNxQjRwMWJwQ09iS2VZQjloMkFUc0VsXC9tZmFjeVdmUUppcHRCeXNYYXAza1wva1wveXpJcDFXIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBPbiBUdWUsIEZlYiAxMywgMjAxOCBhdCAzOjI0IEFNLCBXdSBIYW8gPGhhby53dUBpbnRlbC5j
b20+IHdyb3RlOg0KPiANCj4gSGkgSGFvLA0KPiANCj4gPiBGb3IgZmVhdHVyZSBkZXZpY2VzLCB3
ZSBuZWVkIGEgbWV0aG9kIHRvIGZpbmQgdGhlIHBvcnQgZGVkaWNhdGVkDQo+ID4gdG8gdGhlIGRl
dmljZS4gVGhpcyBwYXRjaCBhZGRzIGEgZnVuY3Rpb24gZnBnYV9jZGV2X2ZpbmRfcG9ydA0KPiA+
IGZvciB0aGlzIHB1cnBvc2UuIGUuZyBGUEdBIE1hbmFnZW1lbnQgRW5naW5lIChGTUUpIFBhcnRp
YWwNCj4gPiBSZWNvbmZpZ3VyYXRpb24gc3ViIGZlYXR1cmUsIGl0IHVzZXMgdGhpcyBmdW5jdGlv
biB0byBmaW5kDQo+ID4gZGVkaWNhdGVkIHBvcnQgb24gdGhlIGRldmljZSBmb3IgUFIgZnVuY3Rp
b24gaW1wbGVtZW50YXRpb24uDQo+IA0KPiBPSywgdGhhdCBpcyB2ZXJ5IGNsZWFyIG5vdywgdGhh
bmtzISAgQWNrIHdpdGggdGhlIG1pbm9yIGRvYyBjaGFuZ2VzIGJlbG93Lg0KPiANCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFRpbSBXaGlzb25hbnQgPHRpbS53aGlzb25hbnRAaW50ZWwuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEVubm8gTHVlYmJlcnMgPGVubm8ubHVlYmJlcnNAaW50ZWwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaXZhIFJhbyA8c2hpdmEucmFvQGludGVsLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlciBSYXVlciA8Y2hyaXN0b3BoZXIucmF1ZXJAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW8gR3Vhbmdyb25nIDxndWFuZ3JvbmcueGlh
b0BsaW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV3UgSGFvIDxoYW8ud3VAaW50
ZWwuY29tPg0KPiBBY2tlZC1ieTogQWxhbiBUdWxsIDxhdHVsbEBrZXJuZWwub3JnPg0KPiANCj4g
PiAtLS0NCj4gPiB2Mzogcy9mcGdhX2Zvcl9lYWNoX3BvcnQvZnBnYV9jZGV2X2ZpbmRfcG9ydC8N
Cj4gPiAgICAgbW92ZSBmcGdhX2NkZXZfZmluZF9wb3J0IHRvIGZwZ2EtZGZsIG1vZHVsZS4NCj4g
PiB2NDogaW1wcm92ZSBkZXNjcmlwdGlvbiBpbiBjb21taXQgbWVzc2FnZS4NCj4gPiAgICAgYWRk
IGNvbW1lbnRzIHRvIHJlbWluZCB1c2VyIHRvIHB1dF9kZXZpY2UgYWZ0ZXIgdXNlIHRoaXMgZnVu
Y3Rpb24uDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwuYyB8IDM0ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9mcGdhL2RmbC5oIHwgMjAgKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC5jIGIvZHJpdmVycy9mcGdh
L2RmbC5jDQo+ID4gaW5kZXggZGNmZTVhYi4uMzhkYzgxOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2ZwZ2EvZGZsLmMNCj4gPiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPiBAQCAtNzgz
LDYgKzc4Myw0MCBAQCB2b2lkIGZwZ2FfcmVtb3ZlX2ZlYXR1cmVfZGV2cyhzdHJ1Y3QgZnBnYV9j
ZGV2DQo+ICpjZGV2KQ0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKGZwZ2FfcmVtb3Zl
X2ZlYXR1cmVfZGV2cyk7DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIF9fZnBnYV9jZGV2X2ZpbmRf
cG9ydCAtIGZpbmQgYSBwb3J0IHVuZGVyIGdpdmVuIGNvbnRhaW5lciBkZXZpY2UNCj4gPiArICoN
Cj4gPiArICogQGNkZXY6IGNvbnRhaW5lciBkZXZpY2UNCj4gPiArICogQGRhdGE6IGRhdGEgcGFz
c2VkIHRvIG1hdGNoIGZ1bmN0aW9uDQo+ID4gKyAqIEBtYXRjaDogbWF0Y2ggZnVuY3Rpb24gdXNl
ZCB0byBmaW5kIHNwZWNpZmljIHBvcnQgZnJvbSB0aGUgcG9ydCBkZXZpY2UgbGlzdA0KPiA+ICsg
Kg0KPiA+ICsgKiBGaW5kIGEgcG9ydCBkZXZpY2UgdW5kZXIgY29udGFpbmVyIGRldmljZS4gVGhp
cyBmdW5jdGlvbiBuZWVkcyB0byBiZQ0KPiA+ICsgKiBpbnZva2VkIHdpdGggbG9jayBoZWxkLg0K
PiA+ICsgKg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIHJldHVybnMgTlVMTCBpZiB0aGUgZGV2aWNl
IGRvZXNuJ3QgbWF0Y2ggYW5kIG5vbi16ZXJvIGlmIGl0DQo+ID4gKyAqIGRvZXMuDQo+IA0KPiBH
b29kIGJ1dCB0aGlzIHdvdWxkIGJlIG1vcmUgYnJpZWYgYW5kIG1vcmUgc3BlY2lmaWMgYW5kIG1v
cmUgaW4gbGluZQ0KPiB3aXRoIHJlY29tbWVuZGVkIGZvcm1hdCBpbiBEb2N1bWVudGF0aW9uL2tl
cm5lbC1kb2MtbmFuby1IT1dUTy50eHQ6DQo+IA0KPiAgKiBSZXR1cm46IHBvaW50ZXIgdG8gcG9y
dCdzIHBsYXRmb3JtIGRldmljZSBpZiBzdWNjZXNzZnVsLCBOVUxMIG90aGVyd2lzZS4NCj4gDQo+
ID4gSWYgdGhpcyBmdW5jdGlvbiByZXR1cm5zIG5vbi16ZXJvIGFuZCBhIHJlZmVyZW5jZSB0byB0
aGUgcGxhdGZvcm0NCj4gPiArICogZGV2aWNlIG9mIHBvcnQgY2FuIGJlIG9idGFpbmVkLg0KPiAN
Cj4gVGhpcyBpZi4udGhlbiB0eXBlIHNlbnRlbmNlIGlzIG5vdCBjb21wbGV0ZSAobWlzc2luZyB0
aGUgJ3RoZW4nIHBhcnQpLg0KPiBJIHNlZSB3aGVyZSB5b3UgbWlnaHQgaGF2ZSBnb3R0ZW4gaW5z
cGlyYXRpb24gZm9yIGl0IGZyb20gY29yZS5jLg0KPiBQcm9iYWJseSB5b3UgY291bGQganVzdCBk
ZWxldGUgdGhlIHNlbnRlbmNlIGFuZCBhbGwgd291bGQgYmUgY2xlYXIuDQoNClRoYW5rcyBmb3Ig
dGhlIHJldmlldyBhbmQgdGhlIHN1Z2dlc3Rpb24gb24gdGhpcywgd2lsbCB1cGRhdGUgdGhlDQpj
b21tZW50cyB0byBmaXggaXQuDQoNCkhhbw0KDQo+IA0KPiA+ICsgKg0KPiA+ICsgKiBOT1RFOiB5
b3Ugd2lsbCBuZWVkIHRvIGRyb3AgdGhlIGRldmljZSByZWZlcmVuY2Ugd2l0aCBwdXRfZGV2aWNl
KCkgYWZ0ZXINCj4gdXNlLg0KPiA+ICsgKi8NCj4gDQo+IEdvb2QNCj4gDQo+IFRoYW5rcywNCj4g
QWxhbg0KPiANCj4gPiArc3RydWN0IHBsYXRmb3JtX2RldmljZSAqDQo+ID4gK19fZnBnYV9jZGV2
X2ZpbmRfcG9ydChzdHJ1Y3QgZnBnYV9jZGV2ICpjZGV2LCB2b2lkICpkYXRhLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBpbnQgKCptYXRjaCkoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqLCB2
b2lkICopKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZmVhdHVyZV9wbGF0Zm9ybV9kYXRh
ICpwZGF0YTsNCj4gPiArICAgICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBvcnRfZGV2Ow0K
PiA+ICsNCj4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkocGRhdGEsICZjZGV2LT5wb3J0
X2Rldl9saXN0LCBub2RlKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBvcnRfZGV2ID0gcGRhdGEt
PmRldjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChtYXRjaChwb3J0X2RldiwgZGF0
YSkgJiYgZ2V0X2RldmljZSgmcG9ydF9kZXYtPmRldikpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHBvcnRfZGV2Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAg
IHJldHVybiBOVUxMOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKF9fZnBnYV9jZGV2
X2ZpbmRfcG9ydCk7DQo+ID4gKw0KPiA+ICBpbnQgZnBnYV9wb3J0X2lkKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAgICAgICAgIHZvaWQgX19pb21lbSAqYmFzZSA9
IGdldF9mZWF0dXJlX2lvYWRkcl9ieV9pZCgmcGRldi0+ZGV2LA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2ZwZ2EvZGZsLmggYi9kcml2ZXJzL2ZwZ2EvZGZsLmgNCj4gPiBpbmRleCA5YjE5Mzk5
Li5kNmVjZGExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwuaA0KPiA+ICsrKyBi
L2RyaXZlcnMvZnBnYS9kZmwuaA0KPiA+IEBAIC0zNTYsNCArMzU2LDI0IEBAIHN0cnVjdCBmcGdh
X2NkZXYgew0KPiA+ICBzdHJ1Y3QgZnBnYV9jZGV2ICpmcGdhX2VudW1lcmF0ZV9mZWF0dXJlX2Rl
dnMoc3RydWN0IGZwZ2FfZW51bV9pbmZvDQo+ICppbmZvKTsNCj4gPiAgdm9pZCBmcGdhX3JlbW92
ZV9mZWF0dXJlX2RldnMoc3RydWN0IGZwZ2FfY2RldiAqY2Rldik7DQo+ID4NCj4gPiArLyoNCj4g
PiArICogbmVlZCB0byBkcm9wIHRoZSBkZXZpY2UgcmVmZXJlbmNlIHdpdGggcHV0X2RldmljZSgp
IGFmdGVyIHVzZSBwb3J0DQo+IHBsYXRmb3JtDQo+ID4gKyAqIGRldmljZSByZXR1cm5lZCBieSBf
X2ZwZ2FfY2Rldl9maW5kX3BvcnQgYW5kIGZwZ2FfY2Rldl9maW5kX3BvcnQNCj4gZnVuY3Rpb25z
Lg0KPiA+ICsgKi8NCj4gPiArc3RydWN0IHBsYXRmb3JtX2RldmljZSAqDQo+ID4gK19fZnBnYV9j
ZGV2X2ZpbmRfcG9ydChzdHJ1Y3QgZnBnYV9jZGV2ICpjZGV2LCB2b2lkICpkYXRhLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBpbnQgKCptYXRjaCkoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
LCB2b2lkICopKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqDQo+ID4gK2ZwZ2FfY2Rldl9maW5kX3BvcnQoc3RydWN0IGZwZ2FfY2RldiAqY2Rldiwg
dm9pZCAqZGF0YSwNCj4gPiArICAgICAgICAgICAgICAgICAgIGludCAoKm1hdGNoKShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICosIHZvaWQgKikpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXY7DQo+ID4gKw0KPiA+ICsgICAgICAgbXV0ZXhfbG9jaygmY2Rl
di0+bG9jayk7DQo+ID4gKyAgICAgICBwZGV2ID0gX19mcGdhX2NkZXZfZmluZF9wb3J0KGNkZXYs
IGRhdGEsIG1hdGNoKTsNCj4gPiArICAgICAgIG11dGV4X3VubG9jaygmY2Rldi0+bG9jayk7DQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHBkZXY7DQo+ID4gK30NCj4gPiAgI2VuZGlmIC8qIF9f
RlBHQV9ERkxfSCAqLw0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
