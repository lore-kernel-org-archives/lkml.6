Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F550ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038D321477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038D321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJRBZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:25:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:33896 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJRBZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:25:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 10:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82235807"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2018 10:28:44 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 10:28:44 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.194]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.228]) with mapi id 14.03.0319.002;
 Wed, 17 Oct 2018 10:28:43 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUZXHTdy//XOZ5t0mcNlOvTkq3/6UimP6A//+v20CAAIBCgIABMBkA//+1Y4A=
Date:   Wed, 17 Oct 2018 17:28:43 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485D4D41@ORSMSX114.amr.corp.intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
 <20181016203215.GA39177@romley-ivt3.sc.intel.com>
 <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
In-Reply-To: <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTRmMDRhNzEtMjQ1NC00MGU1LWEzYmYtODc5OTBmNjY5YjkwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK2MyeFp4aWNFT0N5VHVBTmxRZmVkNFFnK2dLR3I0QTdqSmxkaGVpeFwvb2loRWxIM0Q4TnFYWFVUNzNQUENDNFkifQ==
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

PiA+IE5vLCB0aGUgc2VsZnRlc3QgaW4gdGhpcyBwYXRjaCBzZXQgd2lsbCBub3QgcmVwbGFjZSBp
bnRlbC1jbXQtY2F0IG9yDQo+ID4gdmljZSB2ZXJzYS4NCj4gPg0KPiA+IFRoZSBzZWxmdGVzdCBp
biB0aGlzIHBhdGNoIHNldCBoYXMgYSBkaWZmZXJlbnQgcHVycG9zZSBmcm9tIGludGVsLWNtdC1j
YXQ6DQo+ID4gdGhlIHNlbGZ0ZXN0IGlzIGEgdGVzdCB0b29sIHdoaWNoIHZhbGlkYXRlcyByZXNj
dHJsIGZ1bmN0aW9uYWxpdGllcw0KPiA+IHdoaWxlIGludGVsLWNtdC1jYXQgaXMgbWFpbmx5IGEg
dXRpbGl0eSB0aGF0IHByb3ZpZGVzIGJhc2UgbGlicmFyeSBmb3INCj4gPiBoaWdoZXIgbGV2ZWwg
YXBwbGljYXRpb25zIGluY2x1ZGluZyBwZXJmb3JtYW5jZSBhbmFseXNpcyB0b29scywNCj4gPiBi
ZW5jaG1hcmsgbWVhc3VyZW1lbnQgdG9vbHMsIGFuZCBwb3RlbnRpYWwgcmVzY3RybCB0ZXN0cy4g
Rm9yIGV4YW1wbGUsDQo+ID4gcnVubmluZyBNQkEgdGVzdCBpbiB0aGUgc2VsZnRlc3RzIHRlbGxz
IE1CQSB3b3JraW5nIG9yIG5vdCB3b3JraW5nDQo+ID4gKGZhaWwvcGFzcykgcmlnaHQgd2F5LiBU
aGUNCj4gDQo+IE9rLiBTdXJlLiBMZXQgbWUgdGFrZSBhIGxvb2sgYXQgc2VsZnRlc3QgY2xvc2Vs
eS4gV2lsbCBzZW5kIG15IGZlZWRiYWNrIHNvb24uDQoNCkdyZWF0IQ0KDQo+IA0KPiA+IGludGVs
LWNtdC1jYXQgZG9lc24ndCBoYXZlIHRoaXMgdGVzdGluZyBjYXBhYmlsaXR5IHVubGVzcyB3ZSBl
eHRlbmQNCj4gPiB0aGUgdG9vbC4NCj4gPg0KPiA+IEFuZCBpbnRlbC1jbXQtY2F0IGlzIG1haW50
YWluZWQgYW5kIGRldmVsb3BlZCBieSBJbnRlbC4gSSBkb24ndCB0aGluaw0KPiA+IGl0J3MgZWFz
eSB0byBleHRlbmQgaXQgdG8gQU1EIGFuZCBBUk0gZmVhdHVyZXMuIFRoZSBzZWxmdGVzdCB3aWxs
IGJlDQo+ID4gbWFpbnRhaW5lZA0KPiANCj4gV2UxbC4uIFdlIHdlcmUgaG9waW5nIHRvIGhhdmUg
YSBjb21tb24gdG9vbCBhY3Jvc3MuIEl0IG1ha2VzIGl0IGVhc3kgZm9yDQo+IGRpc3Ryb3MuIFBy
b2JhYmx5LCB3ZSBjYW4gaGF2ZSBhIHNlcGFyYXRlIGRpc2N1c3Npb24gb24gdGhpcy4NCj4NCg0K
VGhlIG1haW4gZ29hbCBvZiB0aGlzIHRlc3Qgc3VpdGUgaXMgdG8gdmFsaWRhdGUgdmFsdWVzIHJl
cG9ydGVkIGJ5IHJlc2N0cmwgZmVhdHVyZXMgDQppLmUuIHdlIG5lZWQgX3NvbWVfd2F5XyB0byBj
aGVjayBpZiB2YWx1ZXMgcmVwb3J0ZWQgYnkgcmVzY3RybCBmZWF0dXJlcyBhcmUgDQpjb3JyZWN0
IG9yIG5vdC4NCg0KRm9yIChJbnRlbCkgTWVtb3J5IEJhbmR3aWR0aCBmZWF0dXJlcyBsaWtlIE1C
QSBhbmQgTUJNLCBwZXJmIGlNQyANCihJbnRlZ3JhdGVkIE1lbW9yeSBDb250cm9sbGVyKSBpcyB1
c2VkIGZvciB2YWxpZGF0aW9uLiBBcyBhIHBhcnQgb2YgdGVzdCwgd2UgcnVuIGEgDQpiZW5jaG1h
cmsgKGVnOiBmaWxsX2J1ZikgYW5kIGdldCBtZW1vcnkgYmFuZHdpZHRoIHZhbHVlcyBmcm9tIE1C
TSBhbmQgaU1DIA0KYW5kIHZlcmlmeSBpZiB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGJvdGggdGhl
IHJlcG9ydGVkIHZhbHVlcyBhcmUgaW4gYSByZWFzb25hYmxlIHJhbmdlLg0KDQpUbyBtYWtlIHRo
aXMgY29tbW9uIGFjcm9zcyB4ODYsIGNvdWxkIHlvdSBwbGVhc2UgbGV0IHVzIGtub3cgaWYgc2lt
aWxhciB0aGluZ3MgDQooaS5lLiBwZXJmIGlNQykgZXhpc3Qgb24gQU1EPyBJZiBzbywgeW91IGNv
dWxkIGFkZCBpdCBpbi4gVGhlIHNhbWUgYXBwbGllcyBmb3IgQVJNLg0KDQpSZWdhcmRzLA0KU2Fp
DQo=
