Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-287146-1526673492-3-10351867103064827887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526673491; b=nftu0zUP9whMBPKiiPXzK1Bqel01pDNnjIwB9aPVlM+4hTWv4K
    aRngs1S5sZeP7QlqvcvtNU8Gc1oFx3doYu/TomKJVKi/n5mGP9EPZjymTzZTDAhe
    5d5ZqXMJ9PZXZEhzOg+ttmz44zAzK1L+vwBbO/ACioM9jqPC0XH5b+kBAcJErUI3
    kmRPiWGzWCS4VYWFT3uKoMYR4pz6P9WKeO6Kj4Vh7FwqDiHTAcr5tS3iR1LCgQ8i
    R5h5hdUZOSLRyEGAzFSHwp9Uw7q5s3Bk0YOkBK0CGDb71tTPSOKhw2FIZWLISGCy
    hOddWDMOJcn4h/n9YRAbiLum8qtQGAhby8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526673491; bh=On0pEQK+gYhg4iCXB2eCs7nPWv+x1so/UNGSSZoyGj0=; b=
    hXssDxinmGJlKm34N/9k9RvzeRDTnwxqzrZisFR8Hzx52OzWzt4b5iSlT76ocUgk
    Ad9G+oSY+2uLaT4buEB71p7WzCymFll1MiyDMKHO0Y7yJyWhcH9zMIXTz25cVHqk
    4YPV8usJyt6apYM/iKTJcQxVu1X3EiEkG65FOCTJMEl4nAGO6EupcCPqibvN4kFZ
    HvhqP88N/3DoAu9hLaJ2BnySs9AeMEYuMaxXFm61/TVTDx3r4RfAXmbzyMmRmO5r
    KhlBq7HvCAIUD03BApq8bl/Kxy2HLbbInwVrYEFxTU+KnRPqS/Lz2AGdkvpH9DQ3
    sikq+GkDcSQe4EjBxBs6Yw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
    header.i=@synopsys.com header.b=KDni1qVE x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=synopsys.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
      header.i=@synopsys.com header.b=KDni1qVE x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=synopsys.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOklcW2IV0ie3wC0Zy1CHe9OGDoaXwTnjfhHEfhMLP7hlnLqASnIgpoJAZhWlRY1LMHOxKYEUDj0uOj+6X813O7iSm1KQjLGdHmEHJyJ2G2J1qAJMkUE
    9Nj6lTrTVLCyA9YNOfC4wpr24ezvUCQ5p2fgnvjJ0aQF9puI+V8UH9NDYPnudn3G32OWl4QMLM3yr8GJMUSa+uNMWc0qwORSR0s3v0s+4uJB+Py6ienBCj1l
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Txe96qlrJlgA:10 a=IkcTkHD0fZMA:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=M51weO-P3PUO5DhBxmwA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeERT6H (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 15:58:07 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:59035 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeERT6F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 15:58:05 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH
 02/20] dma-mapping: provide a generic dma-noncoherent implementation)
Thread-Topic: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH
 02/20] dma-mapping: provide a generic dma-noncoherent implementation)
Thread-Index: AQHT7syARpPy7xKYC0y2vN79/LqnSaQ1oi0AgAAjnoA=
Date: Fri, 18 May 2018 19:57:34 +0000
Message-ID: <182840dedb4890a88c672b1c5d556920bf89a8fb.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
         <20180511075945.16548-3-hch@lst.de>
         <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
         <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
         <20180518175004.GF17671@n2100.armlinux.org.uk>
In-Reply-To: <20180518175004.GF17671@n2100.armlinux.org.uk>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBDD463EE3FC3543A056335FD62CF42C@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgUnVzc2VsLA0KDQpPbiBGcmksIDIwMTgtMDUtMTggYXQgMTg6NTAgKzAxMDAsIFJ1c3NlbGwg
S2luZyAtIEFSTSBMaW51eCB3cm90ZToNCj4gSXQncyBuZWNlc3NhcnkuICBUYWtlIGEgbW9tZW50
IHRvIHRoaW5rIGNhcmVmdWxseSBhYm91dCB0aGlzOg0KPiANCj4gICAgICAgICBkbWFfbWFwX3Np
bmdsZSgsIGRpcikNCj4gDQo+ICAgICAgICAgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoLCBkaXIp
DQo+IA0KPiAgICAgICAgIGRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKCwgZGlyKQ0KPiANCj4g
ICAgICAgICBkbWFfdW5tYXBfc2luZ2xlKCwgZGlyKQ0KPiANCj4gSW4gdGhlIGNhc2Ugb2YgYSBE
TUEtaW5jb2hlcmVudCBhcmNoaXRlY3R1cmUsIHRoZSBvcGVyYXRpb25zIGRvbmUgYXQgZWFjaA0K
PiBzdGFnZSBkZXBlbmQgb24gdGhlIGRpcmVjdGlvbiBhcmd1bWVudDoNCj4gDQo+ICAgICAgICAg
bWFwICAgICAgICAgICAgIGZvcl9jcHUgICAgICAgICBmb3JfZGV2aWNlICAgICAgdW5tYXANCj4g
VE9fREVWICB3cml0ZWJhY2sgICAgICAgbm9uZSAgICAgICAgICAgIHdyaXRlYmFjayAgICAgICBu
b25lDQo+IFRPX0NQVSAgaW52YWxpZGF0ZSAgICAgIGludmFsaWRhdGUqICAgICBpbnZhbGlkYXRl
ICAgICAgaW52YWxpZGF0ZSoNCj4gQklESVIgICB3cml0ZWJhY2sgICAgICAgaW52YWxpZGF0ZSAg
ICAgIHdyaXRlYmFjayAgICAgICBpbnZhbGlkYXRlDQo+IA0KPiAqIC0gb25seSBuZWNlc3Nhcnkg
aWYgdGhlIENQVSBzcGVjdWxhdGl2ZWx5IHByZWZldGNoZXMuDQoNCkkgdGhpbmsgaW52YWxpZGF0
aW9uIG9mIERNQSBidWZmZXIgaXMgcmVxdWlyZWQgb24gZm9yX2NwdShUT19DUFUpIGV2ZW4NCmlm
IENQVSBkb2Vzbid0IHByZWZlcmNoIC0gd2hhdCBpZiB3ZSByZXVzZSB0aGUgc2FtZSBidWZmZXIg
Zm9yIG11bHRpcGxlDQpyZWFkcyBmcm9tIERNQSBkZXZpY2U/DQoNCj4gVGhlIG11bHRpcGxlIGlu
dmFsaWRhdGlvbnMgZm9yIHRoZSBUT19DUFUgY2FzZSBoYW5kbGVzIGRpZmZlcmVudA0KPiBjb25k
aXRpb25zIHRoYXQgY2FuIHJlc3VsdCBpbiBkYXRhIGNvcnJ1cHRpb24sIGFuZCBmb3Igc29tZSBD
UFVzLCBhbGwNCj4gZm91ciBhcmUgbmVjZXNzYXJ5Lg0KDQpJIHdvdWxkIGFncmVlIHRoYXQgbWFw
KCkvdW5tYXAoKSBhIHF1aXRlIGEgc3BlY2lhbCBjYXNlcyBhbmQgc28gZGVwZW5kaW5nDQpvbiBk
aXJlY3Rpb24gd2UgbmVlZCB0byBleGVjdXRlIGluIHRoZW0gZWl0aGVyIGZvcl9jcHUoKSBvciBm
b3JfZGV2aWNlKCkNCmNhbGwtYmFja3MgZGVwZW5kaW5nIG9uIGRpcmVjdGlvbi4NCg0KQXMgZm9y
IGludmFsaWRhdGlvbiBpbiBjYXNlIG9mIGZvcl9kZXZpY2UoVE9fQ1BVKSBJIHN0aWxsIGRvbid0
IHNlZQ0KYSByYXRpb25hbGUgYmVoaW5kIGl0LiBXb3VsZCBiZSBpbnRlcmVzdGluZyB0byBzZWUg
YSByZWFsIGV4YW1wbGUgd2hlcmUNCndlIGJlbmVmaXQgZnJvbSB0aGlzLg0KDQo+IFRoaXMgaXMg
d2hhdCBpcyBpbXBsZW1lbnRlZCBmb3IgMzItYml0IEFSTSwgZGVwZW5kaW5nIG9uIHRoZSBDUFUN
Cj4gY2FwYWJpbGl0aWVzLCBhcyB3ZSBoYXZlIERNQSBpbmNvaGVyZW50IGRldmljZXMgYW5kIHdl
IGhhdmUgQ1BVcyB0aGF0DQo+IHNwZWN1bGF0aXZlbHkgcHJlZmV0Y2ggZGF0YSwgYW5kIHNvIG1h
eSBsb2FkIGRhdGEgaW50byB0aGUgY2FjaGVzIHdoaWxlDQo+IERNQSBpcyBpbiBvcGVyYXRpb24u
DQo+IA0KPiANCj4gVGhpbmdzIGdldCBtb3JlIGludGVyZXN0aW5nIGlmIHRoZSBpbXBsZW1lbnRh
dGlvbiBiZWhpbmQgdGhlIERNQSBBUEkgaGFzDQo+IHRvIGNvcHkgZGF0YSBiZXR3ZWVuIHRoZSBi
dWZmZXIgc3VwcGxpZWQgdG8gdGhlIG1hcHBpbmcgYW5kIHNvbWUgRE1BDQo+IGFjY2Vzc2libGUg
YnVmZmVyOg0KPiANCj4gICAgICAgICBtYXAgICAgICAgICAgICAgZm9yX2NwdSAgICAgICAgIGZv
cl9kZXZpY2UgICAgICB1bm1hcA0KPiBUT19ERVYgIGNvcHkgdG8gZG1hICAgICBub25lICAgICAg
ICAgICAgY29weSB0byBkbWEgICAgIG5vbmUNCj4gVE9fQ1BVICBub25lICAgICAgICAgICAgY29w
eSB0byBjcHUgICAgIG5vbmUgICAgICAgICAgICBjb3B5IHRvIGNwdQ0KPiBCSURJUiAgIGNvcHkg
dG8gZG1hICAgICBjb3B5IHRvIGNwdSAgICAgY29weSB0byBkbWEgICAgIGNvcHkgdG8gY3B1DQo+
IA0KPiBTbywgaW4gYm90aCBjYXNlcywgdGhlIHZhbHVlIG9mIHRoZSBkaXJlY3Rpb24gYXJndW1l
bnQgZGVmaW5lcyB3aGF0IHlvdQ0KPiBuZWVkIHRvIGRvIGluIGVhY2ggY2FsbC4NCg0KSW50ZXJl
c3RpbmcgZW5vdWdoIGluIHlvdXIgc2VvbmQgdGFibGUgKHdoaWNoIGRlc2NyaWJlcyBtb3JlIGNv
bXBsaWNhdGVkDQpjYXNlIGluZGVlZCkgeW91IHNldCAibm9uZSIgZm9yIGZvcl9kZXZpY2UoVE9f
Q1BVKSB3aGljaCBsb29rcyBsb2dpY2FsDQp0byBtZS4NCg0KU28gSU1ITyB0aGF0J3Mgd2hhdCBt
YWtlIHNlbnNlOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCiAgICAgICAgbWFwICAgICAgICAgICAgIGZvcl9jcHUgICAgICAgICBm
b3JfZGV2aWNlICAgICAgdW5tYXANClRPX0RFViAgd3JpdGViYWNrICAgICAgIG5vbmUgICAgICAg
ICAgICB3cml0ZWJhY2sgICAgICAgbm9uZQ0KVE9fQ1BVICBub25lICAgICAgICAgICAgaW52YWxp
ZGF0ZSAgICAgIG5vbmUgICAgICAgICAgICBpbnZhbGlkYXRlKg0KQklESVIgICB3cml0ZWJhY2sg
ICAgICAgaW52YWxpZGF0ZSAgICAgIHdyaXRlYmFjayAgICAgICBpbnZhbGlkYXRlKg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0K
KiBpcyB0aGUgY2FzZSBmb3IgcHJlZmV0Y2hpbmcgQ1BVLg0KDQotQWxleGV5
