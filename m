Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A316AC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8792098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8792098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJSGqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:46:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:46907 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeJSGqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:46:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 15:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="89446290"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2018 15:43:13 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.251]) with mapi id 14.03.0319.002;
 Thu, 18 Oct 2018 15:43:12 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>
Subject: RE: [PATCH] pstore/ram: Clarify resource reservation labels
Thread-Topic: [PATCH] pstore/ram: Clarify resource reservation labels
Thread-Index: AQHUZnmhS6JJW9Sah02QmQlJol9sRqUkoTqAgABrroCAAIs2AIAAU0+AgAASAgCAAAwSAIAAAUsAgAAA3YD//4szkA==
Date:   Thu, 18 Oct 2018 22:43:12 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D4195E1@ORSMSX107.amr.corp.intel.com>
References: <20181018002924.GA42803@beast>
 <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
 <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
 <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
 <CAPcyv4hyZFRog8EBvhnO0bz3ryVNX=udupgnFUSZDgUBN23YWg@mail.gmail.com>
 <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com>
In-Reply-To: <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTNjNjBmM2YtOWUwZi00NDIxLTg2OWMtYjBmZTBmZjViMDQ1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2RLaHczV3d1cVJ1Sk5Ed2xjeUZNYkc0XC9GT3IwdTU5UENnM3o4TVpuUzZzbUYybVE2M2xwSU5wamNpZ2ZxNEEifQ==
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

PiBJZiB0aGUgZmlsZXN5c3RlbSBleGlzdGVkIG9uIHRoZSBuYW1lc3BhY2UgYmVmb3JlIHRoZSB1
c2VyIHNwZWNpZmllZA0KPiB0aGUgcmFtb29wcyBjb21tYW5kIGxpbmUgdGhlbiByYW1vb3BzIHdp
bGwgY2xvYmJlciB0aGUgZmlsZXN5c3RlbSBhbmQNCj4gdGhlIHVzZXIgd2lsbCBvbmx5IGZpbmQg
b3V0IHdoZW4gbW91bnQgbGF0ZXIgZmFpbHMuIEFsbCB0aGUga2VybmVsDQo+IHdpbGwgc2F5IGlz
Og0KPg0KPiAgICAgZGV2X3dhcm4oZGV2LCAiY291bGQgbm90IHJlc2VydmUgcmVnaW9uICVwUlxu
IiwgcmVzKTsNCj4NCj4gLi4uZnJvbSB0aGUgcG1lbSBkcml2ZXIsIGFuZCB0aGVuIHRoZSBvbmx5
IHdheSB0byBmaWd1cmUgd2hvIHRoZQ0KPiBjb25mbGljdCBpcyB3aXRoIGlzIHRvIGxvb2sgYXQg
L3Byb2MvaW9tZW0sIGJ1dCB0aGUgZGFtYWdlIGlzIGFscmVhZHkNCj4gbGlrZWx5IGRvbmUgYnkg
dGhhdCBwb2ludC4NCg0KV2hlbiB5b3Ugc2V0IHVwIGEgcmFtb29wcyByZWdpb24gaW4gcG1lbSwg
d3JpdGUgYSBtYWdpYyBoZWFkZXIgYmxvY2sNCmF0IHRoZSBzdGFydCBvZiB0aGUgYXJlYS4gIFRo
ZW4gd2hlbiBwc3RvcmUvcmFtb29wcyBnb2VzIHRvIGZpbmQgdGhlDQpyZWdpb24sIGl0IGNoZWNr
cyBmb3IgdGhlIG1hZ2ljIGhlYWRlci4gIE5vdCB0aGVyZT8gRG9uJ3Qgd3JpdGUgdG8gdGhlDQpy
ZWdpb24uIFByb2JsZW0gc29sdmVkLg0KDQotVG9ueQ0K
