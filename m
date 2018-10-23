Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA907C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E0A20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gw9q/ncs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E0A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJWTYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:24:14 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:42722 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:24:14 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F2A7410C004C;
        Tue, 23 Oct 2018 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540292477; bh=sUTpXJKzXQGEEpbi2snLPJL8KIRXnSt46K3HiowY7og=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gw9q/ncs4U4a0tlaK4uBVDW8ylrEo64Ul/K6Y1t+abV9eij3BhoWkN35rHs2QcIUD
         EXrTsCuSRvj1ARJ+gUg0szaoRU6EIYBXgFg0VjLSr+QIXXSq2sw8cVBMvjTJCJ2vpb
         04Od4buYSiVVC528ibGuWd6mHW6enbgSfj4pbEKfWgoDrd1MztF8hYTYC2BCSdYhI1
         /mRSNpM/uhxcUQjIQ/VZ4ghCYnW8CQIaQ+HphhqqZqMj8ZEvSBJRTVy7vReHVS3djf
         1aH4Kz6/VIQtTsZNd/s7j7ODr9gx5wfXPCEB+xAA0C+UlAgmahcAbMd2N1tyHjmZiS
         qbe6KZLQLZnlA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6B5B841F6;
        Tue, 23 Oct 2018 04:01:16 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 23 Oct 2018 04:01:16 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 23 Oct 2018 13:01:14 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "marcheu@chromium.org" <marcheu@chromium.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [PATCH] DRM: UDL: get rid of useless vblank initialization
Thread-Topic: [PATCH] DRM: UDL: get rid of useless vblank initialization
Thread-Index: AQHUVzlc7plYFPK1K0KyqBNFqtz0mKUsr3EA
Date:   Tue, 23 Oct 2018 11:01:14 +0000
Message-ID: <1540292472.19916.13.camel@synopsys.com>
References: <20180928144126.21598-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180928144126.21598-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD3EFEBA808C7E4CAB663AA20B35A2AE@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCk1heWJlIHlvdSBoYXZlIGFueSBjb21tZW50cyBvciByZW1hcmtzIGFib3V0
IHRoaXMgcGF0Y2g/DQpBbmQgaWYgeW91IGRvbid0IGNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgaXQu
IFRoYW5rcyENCg0KT24gRnJpLCAyMDE4LTA5LTI4IGF0IDE3OjQxICswMzAwLCBFdWdlbml5IFBh
bHRzZXYgd3JvdGU6DQo+IFVETCBkb2Vzbid0IHN1cHBvcnQgdmJsYW5rIGZ1bmN0aW9uYWxpdHkg
c28gd2UgZG9uJ3QgbmVlZCB0bw0KPiBpbml0aWFsaXplIHZibGFuayBoZXJlICh3ZSBhcmUgYWJs
ZSB0byBzZW5kIHBhZ2UgZmxpcA0KPiBjb21wbGV0aW9uIGV2ZW50cyBldmVuIHdpdGhvdXQgdmJs
YW5rIGluaXRpYWxpemF0aW9uKQ0KPiANCj4gTW9yZW92ZXIgY3VycmVudCBkcm1fdmJsYW5rX2lu
aXQgY2FsbCB3aXRoIG51bV9jcnRjcyA+IDAgY2F1c2VzDQo+IHNlbmRpbmcgRFJNX0VWRU5UX0ZM
SVBfQ09NUExFVEUgZXZlbnQgd2l0aCB6ZXJvIHRpbWVzdGFtcCBldmVyeQ0KPiB0aW1lLiBUaGlz
IGJyZWFrcyB1c2Vyc3BhY2UgYXBwcyAoZm9yIGV4YW1wbGUgd2VzdG9uKSB3aGljaA0KPiByZWxp
ZXMgb24gdGltZXN0YW1wIHZhbHVlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBWZXR0ZXIg
PGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2QHN5bm9wc3lz
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vdWRsL3VkbF9tYWluLmMgfCA3ICstLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdWRsL3VkbF9tYWluLmMgYi9kcml2ZXJz
L2dwdS9kcm0vdWRsL3VkbF9tYWluLmMNCj4gaW5kZXggZjQ1NWYwOTVhMTQ2Li4xYjAxNGQ5Mjg1
NWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX21haW4uYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vdWRsL3VkbF9tYWluLmMNCj4gQEAgLTM1MCwxNSArMzUwLDEwIEBA
IGludCB1ZGxfZHJpdmVyX2xvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdW5zaWduZWQgbG9u
ZyBmbGFncykNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycjsNCj4gIA0KPiAtCXJldCA9IGRy
bV92YmxhbmtfaW5pdChkZXYsIDEpOw0KPiAtCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyX2ZiOw0K
PiAtDQo+ICAJZHJtX2ttc19oZWxwZXJfcG9sbF9pbml0KGRldik7DQo+ICANCj4gIAlyZXR1cm4g
MDsNCj4gLWVycl9mYjoNCj4gLQl1ZGxfZmJkZXZfY2xlYW51cChkZXYpOw0KPiArDQo+ICBlcnI6
DQo+ICAJaWYgKHVkbC0+dXJicy5jb3VudCkNCj4gIAkJdWRsX2ZyZWVfdXJiX2xpc3QoZGV2KTsN
Ci0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
