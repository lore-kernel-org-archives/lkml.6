Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E87C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEAE2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436634AbfBNMfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:35:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:43384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfBNMfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:35:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 04:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="114887908"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2019 04:35:37 -0800
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 14 Feb 2019 04:35:36 -0800
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 14 Feb 2019 04:35:36 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.81]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 06:35:35 -0600
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Doug Ledford <dledford@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: linux-next: build warning after merge of the rdma tree
Thread-Topic: linux-next: build warning after merge of the rdma tree
Thread-Index: AQHUw/rlXlV8xi0R8E++WNHU9qRfAaXe0vQAgABnQFA=
Date:   Thu, 14 Feb 2019 12:35:34 +0000
Message-ID: <3F128C9216C9B84BB6ED23EF16290AFB750DA68D@CRSMSX101.amr.corp.intel.com>
References: <20190214111839.6300f9b7@canb.auug.org.au>
 <86f77ecfe862e224149ada80dd5b5650280c74ec.camel@redhat.com>
In-Reply-To: <86f77ecfe862e224149ada80dd5b5650280c74ec.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWU3NDIwMWItYjViZi00ZGMxLWIyNzgtMmYwNmFlNzZlZTc2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ3dyaDRFMDc2K01udTJOZWRjTU9xVU5uZW1aU1d3U25HWEgwdnZUeXNhajZCZ20xN1IxK3ZLY2hBcTY5eGg3MiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG91ZyBMZWRmb3JkIFtt
YWlsdG86ZGxlZGZvcmRAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAx
MywgMjAxOSA3OjIxIFBNDQo+IFRvOiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9y
Zy5hdT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG1lbGxhbm94LmNvbT4NCj4gQ2M6IExpbnV4
IE5leHQgTWFpbGluZyBMaXN0IDxsaW51eC1uZXh0QHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtl
cm5lbA0KPiBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBXYW4s
IEthaWtlDQo+IDxrYWlrZS53YW5AaW50ZWwuY29tPjsgR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3Vz
dGF2b0BlbWJlZGRlZG9yLmNvbT47DQo+IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogbGludXgtbmV4dDogYnVpbGQgd2FybmluZyBhZnRlciBtZXJnZSBv
ZiB0aGUgcmRtYSB0cmVlDQo+IA0KPiBPbiBUaHUsIDIwMTktMDItMTQgYXQgMTE6MTggKzExMDAs
IFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gQWZ0ZXIgbWVy
Z2luZyB0aGUgcmRtYSB0cmVlLCB0b2RheSdzIGxpbnV4LW5leHQgYnVpbGQgKHg4Nl82NA0KPiA+
IGFsbG1vZGNvbmZpZykgcHJvZHVjZWQgdGhpcyB3YXJuaW5nOg0KPiA+DQo+ID4gZHJpdmVycy9p
bmZpbmliYW5kL2h3L2hmaTEvcXAuYzogSW4gZnVuY3Rpb24gJ2hmaTFfc2V0dXBfd3FlJzoNCj4g
PiBkcml2ZXJzL2luZmluaWJhbmQvaHcvaGZpMS9xcC5jOjMyODozOiB3YXJuaW5nOiB0aGlzIHN0
YXRlbWVudCBtYXkgZmFsbA0KPiB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4g
PiAgICBoZmkxX3NldHVwX3RpZF9yZG1hX3dxZShxcCwgd3FlKTsNCj4gPiAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9oZmkxL3Fw
LmM6MzI5OjI6IG5vdGU6IGhlcmUNCj4gPiAgIGNhc2UgSUJfUVBUX1VDOg0KPiA+ICAgXn5+fg0K
PiA+DQo+ID4gSW50cm9kdWNlZCBieSBjb21taXQNCj4gPg0KPiA+ICAgZjFhYjRlZmE2ZDMyICgi
SUIvaGZpMTogRW5hYmxlIFRJRCBSRE1BIFJFQUQgcHJvdG9jb2wiKQ0KPiA+DQo+ID4gSSBnZXQg
dGhpcyB3YXJuaW5nIGJlY2F1c2UgSSBhbSBidWlsZGluZyB3aXRoIC1XaW1wbGljaXQtZmFsbHRo
cm91Z2gNCj4gPiBpbiBhdHRlbXB0IHRvIGNhdGNoIG5ldyBhZGRpdGlvbnMgZWFybHkuICBUaGUg
Z2NjIHdhcm5pbmcgY2FuIGJlDQo+ID4gdHVybmVkIG9mZiBieSBhZGRpbmcgYSAvKiBmYWxsIHRo
cm91Z2ggKi8gY29tbWVudCBhdCB0aGUgcG9pbnQgdGhlDQo+ID4gZmFsbCB0aHJvdWdoIGhhcHBl
bnMgKGFzc3VtaW5nIHRoYXQgdGhlIGZhbGwgdGhyb3VnaCBpcyBpbnRlbnRpb25hbCkuDQo+ID4N
Cj4gDQo+IFRoYW5rcyBTdGVwaGVuLCB3ZSdsbCBzb3J0IGl0IGFuZCBtYWtlIGFuIGFwcHJvcHJp
YXRlIGZpeHVwIHBhdGNoLg0KPiANCj4gS2Fpa2U/DQoNCkl0J3MgaW50ZW50aW9uYWwuIFdlIHdp
bGwgYWRkIGEgIi8qIGZhbGwgdGhyb3VnaCAqLyIgY29tbWVudCBhcyBhIGZpeHVwIHBhdGNoLg0K
DQpLYWlrZQ0KPiANCj4gLS0NCj4gRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29tPg0K
PiAgICAgR1BHIEtleUlEOiBCODI2QTMzMzBFNTcyRkREDQo+ICAgICBLZXkgZmluZ2VycHJpbnQg
PSBBRTZCIDFCREEgMTIyQiAyM0I0IDI2NUIgIDEyNzQgQjgyNiBBMzMzIDBFNTcgMkZERA0K
