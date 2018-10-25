Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DCEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAE82083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAE82083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJZA2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:28:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50479 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727350AbeJZA17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:27:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-180-L-rkvJ8BPW-MRMR4QGAbbQ-1; Thu, 25 Oct 2018 16:54:35 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 25 Oct 2018 16:54:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 25 Oct 2018 16:54:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'James Bottomley' <jejb@linux.vnet.ibm.com>,
        Colin King <colin.king@canonical.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: aic7xxx: Fix unintended sign extension issue
Thread-Topic: [PATCH] scsi: aic7xxx: Fix unintended sign extension issue
Thread-Index: AQHUbHgO9MgUOGstgUqTCovE+/PvzqUwG1Fg
Date:   Thu, 25 Oct 2018 15:54:38 +0000
Message-ID: <483f04b2ad5a4858b56c2be52cea625e@AcuMS.aculab.com>
References: <20181025151334.15622-1-colin.king@canonical.com>
 <1540481569.3006.5.camel@linux.vnet.ibm.com>
In-Reply-To: <1540481569.3006.5.camel@linux.vnet.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: L-rkvJ8BPW-MRMR4QGAbbQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFtZXMgQm90dG9tbGV5DQo+IFNlbnQ6IDI1IE9jdG9iZXIgMjAxOCAxNjozMw0KPiAN
Cj4gT24gVGh1LCAyMDE4LTEwLTI1IGF0IDE2OjEzICswMTAwLCBDb2xpbiBLaW5nIHdyb3RlOg0K
PiA+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+ID4N
Cj4gPiBJbiB0aGUgZXhwcmVzc2lvbiAiYWhjX2luYihhaGMsIHBvcnQrMykgPDwgMjQiLCB0aGUg
aW5pdGlhbCB2YWx1ZSBpcw0KPiA+IGEgdTgsIGJ1dCBpcyBwcm9tb3RlZCB0byBhIHNpZ25lZCBp
bnQsIHRoZW4gc2lnbi1leHRlbmRlZCB0bw0KPiA+IHVpbnQ2NF90Lg0KPiANCj4gV2h5IGlzIHRo
aXMsIHRoYXQncyBoaWdobHkgbm9uIGludHVpdGl2ZT8gIFRoZSBjb21waWxlciBpcyBzdXBwb3Nl
ZCB0bw0KPiBwcm9tb3RlIHRvIHRoZSBiaWdnZXN0IHR5cGUsIHdoaWNoIGlzIHVpbnQ2NF90IGFu
ZCB0aGVuIGRvIHRoZQ0KPiBjYWxjdWxhdGlvbg0KDQpEbyBub3QgZG91YnQgdGhlIHdpc2RvbSBv
biB0aGUgQU5TSSBDIGNvbW1pdHRlZSB0aGF0IGRlY2lkZWQgdG8gZG8NCid2YWx1ZSBwcmVzZXJ2
aW5nJyBpbnRlZ2VyIHByb21vdGlvbnMgaW5zdGVhZCBvZiB0aGUgJ3NpZ24gcHJlc2VydmluZycN
Cm9uZXMgb2YgSyZSIEMuDQoNClNvICd1bnNpZ25lZCBjaGFyJyBpcyBwcm9tb3RlZCB0byAnaW50
JyBhbG1vc3QgZXZlcnl3aGVyZSBpdCBpcyB1c2VkDQoodW5sZXNzIHRoZXkgYXJlIGJvdGggdGhl
IHNhbWUgc2l6ZSAtIHdoaWNoIGlzIGFsbG93ZWQpLg0KVGhpcyBtZWFucyB0aGF0IGFoY19pbmIo
KSA8PCAyNCBpcyBhY3R1YWxseSB1bmRlZmluZWQgKHNpZ25lZCBpbnRlZ2VyDQpvdmVyZmxvdyBj
YW4gZG8gYW55dGhpbmcgaXQgbGlrZXMpLg0KDQpCeSBmYXIgdGhlIGJlc3QgZml4IGlzIHRvIGNo
YW5nZSB0aGUgcmV0dXJuIHR5cGUgb2YgYWhjX2luYigpIHRvDQpiZSAndW5zaWduZWQgaW50Jy4N
Ck9uIHN5c3RlbXMgd2l0aG91dCBieXRlIHNpemVkIHJlZ2lzdGVycyAoYWJvdXQgZXZlcnl0aGlu
ZyBleGNlcHQgeDg2KQ0KdGhpcyB3aWxsIGFsbW9zdCBjZXJ0YWlubHkgZ2VuZXJhdGUgYmV0dGVy
IGNvZGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

