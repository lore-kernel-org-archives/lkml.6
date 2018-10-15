Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B9CC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D702064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D702064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeJOTDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:03:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:17533 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeJOTDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:03:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 04:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="78856109"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2018 04:18:46 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 15 Oct 2018 04:18:46 -0700
Received: from hasmsx105.ger.corp.intel.com (10.184.198.19) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 15 Oct 2018 04:18:45 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 HASMSX105.ger.corp.intel.com ([169.254.1.191]) with mapi id 14.03.0319.002;
 Mon, 15 Oct 2018 14:18:43 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Thread-Topic: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Thread-Index: AQHUYJ6p/SuLBw4aaUml2bYnZz2LwqUYUWMAgAFvawCAADdeYIAF+64AgAAJJ4A=
Date:   Mon, 15 Oct 2018 11:18:43 +0000
Message-ID: <1539602081.11953.4.camel@intel.com>
References: <20181010133817.GA11485@embeddedor.com>
         <20181010140638.GA3894@ziepe.ca> <20181011120140.GA15767@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D9EEC12@hasmsx109.ger.corp.intel.com>
         <20181015104156.GA13408@linux.intel.com>
In-Reply-To: <20181015104156.GA13408@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.91.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A400B18EABD574FBBD9251DA627B4A7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTEwLTE1IGF0IDEzOjQxICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIFRodSwgT2N0IDExLCAyMDE4IGF0IDAxOjI3OjU4UE0gKzAwMDAsIFdpbmtsZXIsIFRv
bWFzIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBXZWQsIE9jdCAxMCwgMjAxOCBhdCAwODowNjoz
OEFNIC0wNjAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgT2N0IDEw
LCAyMDE4IGF0IDAzOjM4OjE3UE0gKzAyMDAsIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+
ID4gPiA+ID4gQ3VycmVudGx5LCB0aGVyZSBhcmUgc29tZSB2YWx1ZXMgYXNzaWduZWQgdG8gdmFy
aWFibGUgKnJjKiwgd2hpY2gNCj4gPiA+ID4gPiBhcmUgbmV2ZXIgYWN0dWFsbHkgdXNlZCBpbiBh
bnkgY29tcHV0YXRpb24sIGJlY2F1c2Ugc3VjaCB2YXJpYWJsZSBpcw0KPiA+ID4gPiA+IHVwZGF0
ZWQgYXQgbGluZSA1NTAsIGJlZm9yZSB0aGV5IGNhbiBiZSB1c2VkOg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IDU0OW91dDoNCj4gPiA+ID4gPiA1NTAgICAgICAgIHJjID0gdHBtX2dvX2lkbGUoY2hp
cCwgZmxhZ3MpOw0KPiA+ID4gPiA+IDU1MSAgICAgICAgaWYgKHJjKQ0KPiA+ID4gPiA+IDU1MiAg
ICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGaXggdGhpcyBi
eSByZW1vdmluZyBzdWNoIGFzc2lnbm1lbnRzLg0KPiA+ID4gPiANCj4gPiA+ID4gU2hvdWxkIHRo
aXMgYmUgZG9uZSBieSBub3QgcXVhc2hpbmcgcmMgZHVyaW5nIHRoZSBlcnJvciB1bndpbmQgcmF0
aGVyDQo+ID4gPiA+IHRoYW4gZHJvcHBpbmcgdGhlIGVycm9ycz8NCj4gPiA+IA0KPiA+ID4gWWVh
aC5gDQo+ID4gPiANCj4gPiA+IFdvbmRlcmluZyBpZiB0cG1fZ29faWRsZSgpIHNob3VsZCBzaW1w
bHkgYmUgYSB2b2lkLWZ1bmN0aW9uIGkuZS4gaXNzdWUganVzdCBhDQo+ID4gPiB3YXJuaW5nIGlu
c2lkZSAoZGlzY2xhaW1lcjogZGlkIG5vdCByZXZpc2l0IGl0cyBjb2RlIHdoZW4gd3JpdGluZyB0
aGlzKS4NCj4gPiANCj4gPiBXZSBkaWQgaGF2ZSByYXRoZXIgYSBsb25nIGRpc2N1c3Npb24gYWJv
dXQgaXQgd2hlbiBpdCB3YXMgbWVyZ2VkLg0KPiA+IFRoZXJlIGFyZSB0d28gZmxvd3MgdGhhdCBt
YXkgY3Jhc2ggDQo+ID4gcmMgPSB0cG0yX2NvbW1pdF9zcGFjZSgpDQo+ID4gDQo+ID4gYnV0IHlv
dSBzdGlsbCBjYW4gbmVlZCB0byANCj4gPiANCj4gPiByYyAgPSBnb19pZGxlKCkgIA0KPiA+IA0K
PiA+IHdoaWNoIGFsc28gbWF5IGNyYXNoIHdoaWNoIG1heSBvdmVycmlkZSB0aGUgcHJldmlvdXMg
dmFsdWUuIA0KPiA+IA0KPiA+IEZyYW5rbHkgdGhlIHNlY29uZCBvbmUgaXMgZmF0YWwsIHRoZSBz
dGFjayB3aWxsIGdvIG91dCBvZiBzeW5jLg0KPiA+IFdlIG1heSBkbyB2b2lkIGhlcmUgYXMgdGhl
IHN0YWNrIHdpbGwgY3Jhc2ggaW4gYSBzdWJzZXF1ZW50IGNvbW1hbmQuIA0KPiA+IA0KPiA+IFRo
ZSAnZ290byBvdXQnIGlzIHF1aXRlIGEgIGJ1ZywgcHJvYmFibHkgY2F1c2VkIGJ5IGNvZGUgbW92
ZW1lbnQuDQo+IA0KPiBJIGp1c3QgbG9va2VkIGF0IHRoZSBjb2RlIHByb3Blcmx5IGFuZCBub3Rp
Y2VkIHRoYXQgdGhlcmUgaXMgYSByZWdyZXNzaW9uDQo+IGNhdXNlZCBieSA2Mjc0NDhlODVjNzYg
KCJ0cG06IHNlcGFyYXRlIGNtZF9yZWFkeS9nb19pZGxlIGZyb20NCj4gcnVudGltZV9wbSIpIGku
ZS4gd2hlbiB0cG1fZ29faWRsZSgpIGZhaWxzIGl0IGxvb3BzIGJhY2sgYW5kIHJldHJpZXMNCj4g
dHBtX2dvX2lkbGUoKS4NClllcywgdGhhdCdzIHdoYXQgSSBzYWlkLCB0aGlzIHBhcnQgY29kZSB3
YXMgbW92ZWQgZm9ydGggYnV0IG5vIHRoZQ0KbGFiZWwuDQpUb21hcw0K
