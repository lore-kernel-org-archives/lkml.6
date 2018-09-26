Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803CEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2184221546
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2184221546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeI0FJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:09:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:1308 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeI0FJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:09:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 15:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="83536744"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2018 15:53:28 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.122]) with mapi id 14.03.0319.002;
 Wed, 26 Sep 2018 15:53:28 -0700
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
Subject: RE: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
Thread-Topic: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
Thread-Index: AQHUVdhjZDMKkozcwkOfhbUJcJANhqUDifqA//+gYmA=
Date:   Wed, 26 Sep 2018 22:53:27 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC673214625EA@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-3-casey.schaufler@intel.com>
 <CAG48ez3_XJYCURiCurDeCousGguGUdPego30j5+UF8FebWxUtA@mail.gmail.com>
In-Reply-To: <CAG48ez3_XJYCURiCurDeCousGguGUdPego30j5+UF8FebWxUtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWU3NzVjODEtYWE2YS00YmQ4LTk3NTUtYThmMzc3NDBhNjBkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic0JxTnV0NXdEZkMyZm1uYVNzMlV2WjdIMzNGUmNFYWxDQ0JyM3ZkMzl5aFJ5QlwvS2JpRkRxdnNPNGxWQ0x1d1UifQ==
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
OjMxIFBNDQo+IFRvOiBTY2hhdWZsZXIsIENhc2V5IDxjYXNleS5zY2hhdWZsZXJAaW50ZWwuY29t
Pg0KPiBDYzogS2VybmVsIEhhcmRlbmluZyA8a2VybmVsLWhhcmRlbmluZ0BsaXN0cy5vcGVud2Fs
bC5jb20+OyBrZXJuZWwgbGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxp
bnV4LXNlY3VyaXR5LW1vZHVsZSA8bGludXgtc2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5l
bC5vcmc+OyBzZWxpbnV4QHR5Y2hvLm5zYS5nb3Y7IEhhbnNlbiwgRGF2ZQ0KPiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPjsgRG9jaywgRGVuZWVuIFQgPGRlbmVlbi50LmRvY2tAaW50ZWwuY29tPjsN
Cj4ga3Jpc3RlbkBsaW51eC5pbnRlbC5jb207IEFyamFuIHZhbiBkZSBWZW4gPGFyamFuQGxpbnV4
LmludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAyLzVdIFNtYWNrOiBQcmVwYXJl
IGZvciBQVFJBQ0VfTU9ERV9TQ0hFRA0KPiANCj4gT24gV2VkLCBTZXAgMjYsIDIwMTggYXQgMTA6
MzUgUE0gQ2FzZXkgU2NoYXVmbGVyDQo+IDxjYXNleS5zY2hhdWZsZXJAaW50ZWwuY29tPiB3cm90
ZToNCj4gPiBBIHB0cmFjZSBhY2Nlc3MgY2hlY2sgd2l0aCBtb2RlIFBUUkFDRV9NT0RFX1NDSEVE
IGdldHMgY2FsbGVkDQo+ID4gZnJvbSBwcm9jZXNzIHN3aXRjaGluZyBjb2RlLiBUaGlzIHByZWNs
dWRlcyB0aGUgdXNlIG9mIGF1ZGl0LA0KPiA+IGFzIHRoZSBsb2NraW5nIGlzIGluY29tcGF0aWJs
ZS4gRG9uJ3QgZG8gYXVkaXQgaW4gdGhlIFBUUkFDRV9NT0RFX1NDSEVEDQo+ID4gY2FzZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IENhc2V5IFNjaGF1ZmxlciA8Y2FzZXkuc2NoYXVmbGVyQGlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgc2VjdXJpdHkvc21hY2svc21hY2tfbHNtLmMgfCAzICsr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc21hY2svc21hY2tfbHNtLmMgYi9zZWN1cml0
eS9zbWFjay9zbWFja19sc20uYw0KPiA+IGluZGV4IDM0MGZjMzBhZDg1ZC4uZmZhOTViY2FiNTk5
IDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L3NtYWNrL3NtYWNrX2xzbS5jDQo+ID4gKysrIGIv
c2VjdXJpdHkvc21hY2svc21hY2tfbHNtLmMNCj4gPiBAQCAtNDIyLDcgKzQyMiw4IEBAIHN0YXRp
YyBpbnQgc21rX3B0cmFjZV9ydWxlX2NoZWNrKHN0cnVjdCB0YXNrX3N0cnVjdA0KPiAqdHJhY2Vy
LA0KPiA+ICAgICAgICAgc3RydWN0IHRhc2tfc21hY2sgKnRzcDsNCj4gPiAgICAgICAgIHN0cnVj
dCBzbWFja19rbm93biAqdHJhY2VyX2tub3duOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoKG1vZGUg
JiBQVFJBQ0VfTU9ERV9OT0FVRElUKSA9PSAwKSB7DQo+ID4gKyAgICAgICBpZiAoKG1vZGUgJiBQ
VFJBQ0VfTU9ERV9OT0FVRElUKSA9PSAwICYmDQo+ID4gKyAgICAgICAgICAgKG1vZGUgJiBQVFJB
Q0VfTU9ERV9TQ0hFRCkgPT0gMCkgew0KPiANCj4gSWYgeW91IE9SZWQgUFRSQUNFX01PREVfTk9B
VURJVCBpbnRvIHRoZSBmbGFncyB3aGVuIGNhbGxpbmcgdGhlDQo+IHNlY3VyaXR5IGhvb2ssIHlv
dSBjb3VsZCBkcm9wIHRoaXMgcGF0Y2gsIHJpZ2h0Pw0KDQpZZXMuIFNpbmNlIHRoZSBQVFJBQ0Vf
TU9ERV9OT0FVRElUIHdhcyBpbiBQVFJBQ0VfTU9ERV9JQlBCDQppbiBKaXJpJ3MgcHJldmlvdXMg
cGF0Y2ggc2V0IGFuZCBub3QgaW4gUFRSQUNFX01PREVfU0NIRUQgaW4gdGhpcyBvbmUNCkkgYXNz
dW1lZCB0aGF0IHRoZXJlIHdhcyBhIGdvb2QgcmVhc29uIGZvciBpdC4NCg0K
