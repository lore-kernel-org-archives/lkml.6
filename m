Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38613C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B772070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBVP4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:56:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:8261 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfBVP4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:56:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP; 22 Feb 2019 07:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,400,1544515200"; 
   d="scan'208";a="136409664"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
  by orsmga002.jf.intel.com with ESMTP; 22 Feb 2019 07:56:40 -0800
Received: from pgsmsx106.gar.corp.intel.com ([169.254.9.56]) by
 PGSMSX107.gar.corp.intel.com ([169.254.7.61]) with mapi id 14.03.0415.000;
 Fri, 22 Feb 2019 23:56:39 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Thread-Topic: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Thread-Index: AQHUxN2S4q+yUIjeC0iMAHeR7ONaRaXmasgAgAH8UQCAAFQ6AIACwzWA
Date:   Fri, 22 Feb 2019 15:56:38 +0000
Message-ID: <9647a9f3c84cfc055603ecf0b693250d343dd6c6.camel@intel.com>
References: <20190206154214.576-1-harry.pan@intel.com>
         <20190214111543.22137-1-harry.pan@intel.com>
         <2819109.DzhZvocLkm@aspire.rjw.lan>
         <cf6926800899354808143bd48b4f943629c8cbe7.camel@intel.com>
         <CAJZ5v0gmFz8aK5_+0a36RwEiPScU=Z8BhD8pR50V1GRcmbXFgA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gmFz8aK5_+0a36RwEiPScU=Z8BhD8pR50V1GRcmbXFgA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.73.187]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBBE8646C386A24F90FC30CD24DEDE33@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBXaHkgZG9uJ3QgeW91IGFkZCBhICJzeW5jIiBoZWxwZXIgZnVuY3Rpb24gaW4gbWFpbi5jIHdp
dGggdGhlIHRpbWluZw0KPiBhbmQgbWVzc2FnZSB0aGF0IHdpbGwgYmUgY2FsbGVkIGZyb20gaGli
ZXJuYXRlLmMsIHVzZXIuYyBhbmQNCj4gc3VzcGVuZC5jDQo+IChpbiB0aGUgbGFzdCBvbmUgY29u
ZGl0aW9uYWwgb24NCj4gIUlTX0VOQUJMRUQoQ09ORklHX1NVU1BFTkRfU0tJUF9TWU5DKSk/DQo+
IA0KPiBUaGF0IHdvdWxkIHJlZHVjZSBzb21lIGNvZGUgZHVwbGljYXRpb24gbmljZWx5Lg0KDQpJ
IHVwbG9hZGVkIHY1IGluIHJlY2lwcm9jYXRlIHRvIHlvdXIgY29tbWVudCwgSSBhcG9sb2dpemUg
SSBzZW50IGl0DQpzZWNvbmQgdGltZSBpbiBvcmRlciB0byBjbGVhbiB1cCB0aGUgaGVhZGVyIGZp
bGVzLg0KDQotSGFycnkNCg==
