Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE86CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF7F2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF7F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeLEOIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:08:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:54159 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727475AbeLEOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:08:49 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-115-kE-c18F_PX6wZlo8sD-HNg-1; Wed, 05 Dec 2018 14:08:45 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 5 Dec 2018 14:08:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 5 Dec 2018 14:08:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Hubbard' <jhubbard@nvidia.com>,
        "'john.hubbard@gmail.com'" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Jan Kara <jack@suse.cz>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 0/2] put_user_page*(): start converting the call sites
Thread-Topic: [PATCH 0/2] put_user_page*(): start converting the call sites
Thread-Index: AQHUi2bDGCD6zYfsq0K8yN3qDVFoEKVu0VeAgACFHQCAANmkEA==
Date:   Wed, 5 Dec 2018 14:08:54 +0000
Message-ID: <e7cac96b06664c46bde3abe72ecab2ee@AcuMS.aculab.com>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <b31c7b3359344e778fc525013eeece64@AcuMS.aculab.com>
 <cfba998a-8217-bf03-f0d0-c95708aea03d@nvidia.com>
In-Reply-To: <cfba998a-8217-bf03-f0d0-c95708aea03d@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: kE-c18F_PX6wZlo8sD-HNg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9obiBIdWJiYXJkDQo+IFNlbnQ6IDA1IERlY2VtYmVyIDIwMTggMDE6MDYNCj4gT24g
MTIvNC8xOCA5OjEwIEFNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogam9obi5odWJi
YXJkQGdtYWlsLmNvbQ0KPiA+PiBTZW50OiAwNCBEZWNlbWJlciAyMDE4IDAwOjE3DQo+ID4+DQo+
ID4+IFN1bW1hcnk6IEknZCBsaWtlIHRoZXNlIHR3byBwYXRjaGVzIHRvIGdvIGludG8gdGhlIG5l
eHQgY29udmVuaWVudCBjeWNsZS4NCj4gPj4gSSAqdGhpbmsqIHRoYXQgbWVhbnMgNC4yMS4NCj4g
Pj4NCj4gPj4gRGV0YWlscw0KPiA+Pg0KPiA+PiBBdCB0aGUgTGludXggUGx1bWJlcnMgQ29uZmVy
ZW5jZSwgd2UgdGFsa2VkIGFib3V0IHRoaXMgYXBwcm9hY2ggWzFdLCBhbmQNCj4gPj4gdGhlIHBy
aW1hcnkgbGluZ2VyaW5nIGNvbmNlcm4gd2FzIG92ZXIgcGVyZm9ybWFuY2UuIFRvbSBUYWxwZXkg
aGVscGVkIG1lDQo+ID4+IHRocm91Z2ggYSBtdWNoIG1vcmUgYWNjdXJhdGUgcnVuIG9mIHRoZSBm
aW8gcGVyZm9ybWFuY2UgdGVzdCwgYW5kIG5vdw0KPiA+PiBpdCdzIGxvb2tpbmcgbGlrZSBhbiB1
bmRlciAxJSBwZXJmb3JtYW5jZSBjb3N0LCB0byBhZGQgYW5kIHJlbW92ZSBwYWdlcw0KPiA+PiBm
cm9tIHRoZSBMUlUgKHRoaXMgaXMgb25seSBwYWlkIHdoZW4gZGVhbGluZyB3aXRoIGdldF91c2Vy
X3BhZ2VzKSBbMl0uIFNvDQo+ID4+IHdlIHNob3VsZCBiZSBmaW5lIHRvIHN0YXJ0IGNvbnZlcnRp
bmcgY2FsbCBzaXRlcy4NCj4gPj4NCj4gPj4gVGhpcyBwYXRjaHNldCBnZXRzIHRoZSBjb252ZXJz
aW9uIHN0YXJ0ZWQuIEJvdGggcGF0Y2hlcyBhbHJlYWR5IGhhZCBhIGZhaXINCj4gPj4gYW1vdW50
IG9mIHJldmlldy4NCj4gPg0KPiA+IFNob3VsZG4ndCB0aGUgY29tbWl0IG1lc3NhZ2UgY29udGFp
biBhY3R1YWwgZGV0YWlscyBvZiB0aGUgY2hhbmdlPw0KPiA+DQo+IA0KPiBIaSBEYXZpZCwNCj4g
DQo+IFRoaXMgInBhdGNoIDAwMDAiIGlzIG5vdCBhIGNvbW1pdCBtZXNzYWdlLCBhcyBpdCBuZXZl
ciBzaG93cyB1cCBpbiBnaXQgbG9nLg0KPiBFYWNoIG9mIHRoZSBmb2xsb3ctdXAgcGF0Y2hlcyBk
b2VzIGhhdmUgZGV0YWlscyBhYm91dCB0aGUgY2hhbmdlcyBpdCBtYWtlcy4NCg0KSSB0aGluayB5
b3Ugc2hvdWxkIHN0aWxsIGRlc2NyaWJlIHRoZSBjaGFuZ2UgLSBhdCBsZWFzdCBpbiBzdW1tYXJ5
Lg0KDQpUaGUgcGF0Y2ggSSBsb29rZWQgYXQgZGlkbid0IHJlYWxseS4uLg0KSUlSQyBpdCBzdGls
bCByZWZlcnJlZCB0byBleHRlcm5hbCBsaW5rcy4NCg0KPiBCdXQgbWF5YmUgeW91IGFyZSByZWFs
bHkgYXNraW5nIGZvciBtb3JlIGJhY2tncm91bmQgaW5mb3JtYXRpb24sIHdoaWNoIEkNCj4gc2hv
dWxkIGhhdmUgYWRkZWQgaW4gdGhpcyBjb3ZlciBsZXR0ZXIuIEhlcmUncyBhIHN0YXJ0Og0KPiAN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDE4MTExMDA4NTA0MS4xMDA3MS0xLWpodWJi
YXJkQG52aWRpYS5jb20NCg0KWWVzLCBidXQgbGlua3MgZ28gc3RhbGUuLi4uDQoNCj4gLi4uYW5k
IGl0IGxvb2tzIGxpa2UgdGhpcyBzbWFsbCBwYXRjaCBzZXJpZXMgaXMgbm90IGdvaW5nIHRvIHdv
cmsgb3V0LS1JJ20NCj4gZ29pbmcgdG8gaGF2ZSB0byBmYWxsIGJhY2sgdG8gYW5vdGhlciBSRkMg
c3Bpbi4gU28gSSdsbCBiZSBzdXJlIHRvIGluY2x1ZGUNCj4geW91IGFuZCBldmVyeW9uZSBvbiB0
aGF0LiBIb3BlIHRoYXQgaGVscHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

