Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0AFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94B8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94B8206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbeKMSef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:34:35 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:19519 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbeKMSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:34:35 -0500
X-Greylist: delayed 1107 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 13:34:33 EST
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id wAD8ETvg035339
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:14:29 +0800 (GMT-8)
        (envelope-from yc_chen@aspeedtech.com)
Received: from mail.aspeedtech.com (twmbx02.aspeed.com [192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id wAD8E7j7035294;
        Tue, 13 Nov 2018 16:14:07 +0800 (GMT-8)
        (envelope-from yc_chen@aspeedtech.com)
Received: from TWMBX01.aspeed.com (192.168.0.23) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.620.29; Tue, 13 Nov
 2018 16:18:50 +0800
Received: from TWMBX01.aspeed.com (192.168.0.23) by TWMBX01.aspeed.com
 (192.168.0.23) with Microsoft SMTP Server (TLS) id 15.0.620.29; Tue, 13 Nov
 2018 16:19:47 +0800
Received: from TWMBX01.aspeed.com ([fe80::157a:4af5:bbf4:5dbb]) by
 TWMBX01.aspeed.com ([fe80::157a:4af5:bbf4:5dbb%12]) with mapi id
 15.00.0620.020; Tue, 13 Nov 2018 16:19:46 +0800
From:   YC Chen <yc_chen@aspeedtech.com>
To:     Jean Delvare <jdelvare@suse.de>, Dave Airlie <airlied@redhat.com>
CC:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YC Chen <yc_chen@aspeedtech.com>
Subject: RE: Performance regression in ast drm driver
Thread-Topic: Performance regression in ast drm driver
Thread-Index: AQHUcsWCAPEYZ+nEyEW+4+fd/pHG06VFSu+AgAghUUA=
Date:   Tue, 13 Nov 2018 08:19:46 +0000
Message-ID: <985f3dff65744a1899cb012cbb3d4156@TWMBX01.aspeed.com>
References: <20181101162707.598c1718@endymion>
 <20181108130509.3b2d42ff@endymion>
In-Reply-To: <20181108130509.3b2d42ff@endymion>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.0.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com wAD8E7j7035294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2lyLA0KV2UgZm91bmQgdGhlIHBlcmZvcm1hbmNlIHdpbGwgYmUgYmFkIG9uIGRlc2t0b3AgZW52
aXJvbm1lbnQgd2l0aCBPcGVuU1VTRTE1IFVFRkkgaW5zdGFsbGF0aW9uIGlmIHJlbW92ZSAiYXJj
aF9pb19yZXNlcnZlX21lbXR5cGVfd2MiLg0KDQpSZWdhcmRzLA0KDQpZLkMuIENoZW4NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGRyaS1kZXZlbCBbbWFpbHRvOmRyaS1kZXZl
bC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmIE9mIEplYW4gRGVsdmFy
ZQ0KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDA4LCAyMDE4IDg6MDUgUE0NClRvOiBEYXZlIEFp
cmxpZSA8YWlybGllZEByZWRoYXQuY29tPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT47IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBQZXJmb3JtYW5jZSByZWdyZXNz
aW9uIGluIGFzdCBkcm0gZHJpdmVyDQoNCk9uIFRodSwgMSBOb3YgMjAxOCAxNjoyNzowNyArMDEw
MCwgSmVhbiBEZWx2YXJlIHdyb3RlOg0KPiBIaSBEYXZpZCwNCj4gDQo+IFRoZSBmb2xsb3dpbmcg
Y29tbWl0Og0KPiANCj4gY29tbWl0IDdjZjMyMWQxMThhODI1YzE1NDFiNDNjYTQ1Mjk0MTI2ZmQ0
NzRlZmENCj4gQXV0aG9yOiBEYXZlIEFpcmxpZQ0KPiBEYXRlOiAgIE1vbiBPY3QgMjQgMTU6Mzc6
NDggMjAxNiArMTAwMA0KPiANCj4gICAgIGRybS9kcml2ZXJzOiBhZGQgc3VwcG9ydCBmb3IgdXNp
bmcgdGhlIGFyY2ggd2MgbWFwcGluZyBBUEkuDQo+IA0KPiBpcyBjYXVzaW5nIGEgaHVnZSBwZXJm
b3JtYW5jZSByZWdyZXNzaW9uIGZvciB0aGUgYXN0IGRybSBkcml2ZXIuIEluIGEgDQo+IHRleHQg
Y29uc29sZSwgaWYgSSBjYWxsICJjYXQiIG9uIGEgbGFyZ2UgdGV4dCBmaWxlLCBpdCB0YWtlcyBh
bG1vc3QgDQo+IHR3aWNlIGFzIG11Y2ggdGltZSB0byBiZSBkaXNwbGF5ZWQgYW5kIHNjcm9sbGVk
IGNvbXBsZXRlbHkuDQo+IA0KPiBDYW4geW91IHBsZWFzZSBjaGVjayB0aGF0IHRoZSBhc3QgZHJp
dmVyIHBvcnRpb24gb2YgdGhhdCBjb21taXQgaXMgDQo+IGJvdGggY29ycmVjdCBhbmQgY29tcGxl
dGU/DQoNCkFuZCBpbiB0aGUgbWVhbnRpbWUsIHdoYXQgYmFkIHdpbGwgaGFwcGVuIGlmIHdlIGp1
c3QgcmV2ZXJ0IHRoZSBhc3QgcG9ydGlvbiBvZiB0aGF0IGNvbW1pdD8NCg0KVGhhbmtzLA0KLS0N
CkplYW4gRGVsdmFyZQ0KU1VTRSBMMyBTdXBwb3J0DQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KZHJpLWRldmVsIG1haWxpbmcgbGlzdA0KZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwNCg==
