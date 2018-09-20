Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49476C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DB721525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DB721525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbeIUEnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:43:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:48214 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeIUEnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:43:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 15:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,282,1534834800"; 
   d="scan'208";a="234659201"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2018 15:56:43 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 20 Sep 2018 15:56:43 -0700
Received: from fmsmsx101.amr.corp.intel.com ([169.254.1.66]) by
 fmsmsx124.amr.corp.intel.com ([169.254.8.135]) with mapi id 14.03.0319.002;
 Thu, 20 Sep 2018 15:56:42 -0700
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] vfio/pci: Mask buggy SR-IOV VF INTx support
Thread-Topic: [PATCH v2] vfio/pci: Mask buggy SR-IOV VF INTx support
Thread-Index: AQHUURz5EGbtYdWy70+WiXMB8NQV0KT5xIIQ
Date:   Thu, 20 Sep 2018 22:56:41 +0000
Message-ID: <9184057F7FC11744A2107296B6B8EB1E44721E41@fmsmsx101.amr.corp.intel.com>
References: <153747346143.7344.14634545723456004489.stgit@gimli.home>
In-Reply-To: <153747346143.7344.14634545723456004489.stgit@gimli.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2I5OWYwZWYtOTdhNy00ODRhLWI2ZjQtMmJjZTBkOGFkNDc5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSUxFMk0yc2ZZY1VcL29wVnhrU1RUZG13dUZnekpnWkNVenozckJjbkNyMVVmcUw0eFJ6ZXhpUW1pRjRsNjJkMGwifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleCwNCg0KVGhpcyBwYXRjaCBwYXNzZXMgdGVzdGluZyB3aXRoIHRoZSAweDI3MGMgZGV2
aWNlLCBhbmQgKHdoZW4gSSBjb21tZW50IG91dCBpdHMga25vd25fYm9ndXNfdmZfaW50eF9waW4g
ZW50cnkpIHRoZSB3YXJuaW5nIGlzIHRyaWdnZXJlZCBieSBRRU1VLg0KDQpUaGFua3MsDQpHYWdl
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBXaWxsaWFtc29u
IFttYWlsdG86YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBT
ZXB0ZW1iZXIgMjAsIDIwMTggMzowMyBQTQ0KPiBUbzoga3ZtQHZnZXIua2VybmVsLm9yZzsgUmFq
LCBBc2hvayA8YXNob2sucmFqQGludGVsLmNvbT47IEVhZHMsIEdhZ2UNCj4gPGdhZ2UuZWFkc0Bp
bnRlbC5jb20+DQo+IENjOiBnbm9tZXNAbHhvcmd1ay51a3V1Lm9yZy51azsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHZmaW8vcGNpOiBNYXNrIGJ1
Z2d5IFNSLUlPViBWRiBJTlR4IHN1cHBvcnQNCj4gDQo+IFRoZSBTUi1JT1Ygc3BlYyByZXF1aXJl
cyB0aGF0IFZGcyBtdXN0IHJlcG9ydCB6ZXJvIGZvciB0aGUgSU5UeCBwaW4gcmVnaXN0ZXIgYXMN
Cj4gVkZzIGFyZSBwcmVjbHVkZWQgZnJvbSBJTlR4IHN1cHBvcnQuICBJdCdzIG11Y2ggZWFzaWVy
IGZvciB0aGUgaG9zdCBrZXJuZWwgdG8NCj4gdW5kZXJzdGFuZCB3aGV0aGVyIGEgZGV2aWNlIGlz
IGEgVkYgYW5kIHRoZXJlZm9yZSB3aGV0aGVyIGEgbm9uLXplcm8gcGluDQo+IHJlZ2lzdGVyIHZh
bHVlIGlzIGJvZ3VzIHRoYW4gaXQgaXMgdG8gZG8gdGhlIHNhbWUgaW4gdXNlcnNwYWNlLiAgT3Zl
cnJpZGUgdGhlIElOVHgNCj4gY291bnQgZm9yIHN1Y2ggZGV2aWNlcyBhbmQgdmlydHVhbGl6ZSB0
aGUgcGluIHJlZ2lzdGVyIHRvIHByb3ZpZGUgYSBjb25zaXN0ZW50IHZpZXcNCj4gb2YgdGhlIGRl
dmljZSB0byB0aGUgdXNlci4NCj4gDQo+IEFzIHRoaXMgaXMgY2xlYXJseSBhIHNwZWMgdmlvbGF0
aW9uLCB3YXJuIGFib3V0IGl0IHRvIHN1cHBvcnQgaGFyZHdhcmUgdmFsaWRhdGlvbiwNCj4gYnV0
IGFsc28gcHJvdmlkZSBhIGtub3duIHdoaXRlbGlzdCBhcyBpdCBkb2Vzbid0IGRvIG11Y2ggZ29v
ZCB0byBjb250aW51ZQ0KPiBjb21wbGFpbmluZyBpZiB0aGUgaGFyZHdhcmUgdmVuZG9yIGRvZXNu
J3QgcGxhbiB0byBmaXggaXQuDQo+IA0KPiBLbm93biBkZXZpY2VzIHdpdGggdGhpcyBpc3N1ZTog
ODA4NjoyNzBjDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2ls
bGlhbXNvbkByZWRoYXQuY29tPg0KDQpUZXN0ZWQtYnk6IEdhZ2UgRWFkcyA8Z2FnZS5lYWRzQGlu
dGVsLmNvbT4NCg==
