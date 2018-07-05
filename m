Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B3FC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC524116
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAC524116
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeGECFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:05:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:54270 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbeGECFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:05:50 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Jul 2018 11:05:49 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 05809180B52;
        Thu,  5 Jul 2018 11:05:50 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Thu, 5 Jul 2018 11:05:50 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Thu, 5 Jul 2018 11:05:34 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Thu, 5 Jul 2018 11:05:33 +0900
From:   <yamada.masahiro@socionext.com>
To:     <rob@landley.net>, <trivial@kernel.org>, <keescook@chromium.org>,
        <ulfalizer@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Use short unix-style option instead of --longname.
Thread-Topic: [PATCH] Use short unix-style option instead of --longname.
Thread-Index: AQHUE8oWFlvvixABh0K6x+rlfaTmwqR/3l9A
Date:   Thu, 5 Jul 2018 02:05:33 +0000
Message-ID: <e9c2a4e820664c43a29d006153e5043c@SOC-EX01V.e01.socionext.com>
References: <eb82286e-cd9f-5847-0217-9387db5d6fe4@landley.net>
In-Reply-To: <eb82286e-cd9f-5847-0217-9387db5d6fe4@landley.net>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIExhbmRsZXkg
W21haWx0bzpyb2JAbGFuZGxleS5uZXRdDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDA1LCAyMDE4
IDQ6MDYgQU0NCj4gVG86IHRyaXZpYWxAa2VybmVsLm9yZzsgWWFtYWRhLCBNYXNhaGlyby/lsbHn
lLAg55yf5byYDQo+IDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT47IEtlZXMgQ29vayA8
a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPjsgVWxmDQo+IE1hZ251c3NvbiA8dWxmYWxpemVyQGdtYWls
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBVc2Ugc2hvcnQgdW5peC1zdHlsZSBvcHRpb24gaW5z
dGVhZCBvZiAtLWxvbmduYW1lLg0KPiANCj4gRnJvbTogUm9iIExhbmRsZXkgPHJvYkBsYW5kbGV5
Lm5ldD4NCj4gDQo+IFVzZSBzaG9ydCB1bml4LXN0eWxlIG9wdGlvbiBpbnN0ZWFkIG9mIC0tbG9u
Z25hbWUuDQoNClRoaXMgaXMgdGhlIHJlcGVhdCBvZiB0aGUgc3ViamVjdC4NCkluc3RlYWQsIGNv
dWxkIHlvdSBkZXNjcmliZSB0aGUgcmVhc29uIG9mIHRoaXMgcGF0Y2ggaGVyZSBwbGVhc2U/DQoN
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgTGFuZGxleSA8cm9iQGxhbmRsZXkubmV0Pg0KPiAtLS0N
Cj4gDQo+IEF2b2lkcyB3YXJuaW5nIG1lc3NhZ2VzIHdpdGggdGhlIGxhdGVzdCByZWxlYXNlIG9m
IHRveWJveCwgd2hpY2ggbmV2ZXINCj4gYm90aGVyZWQNCj4gdG8gaW1wbGVtZW50IHRoZSAtLWxv
bmdvcHRzIG5vdGhpbmcgd2FzIHVzaW5nLg0KDQpJIGFtIGZpbmUgd2l0aCB0aGlzIHBhdGNoLA0K
YnV0IEkgd2FudCB0aGUgaW5mb3JtYXRpb24gYmVsb3cgdGhlIC0tLSBsaW5lDQp0byBiZSByZWNv
cmRlZCBpbiBnaXQuDQoNCg0KSSB0aGluayBXSFkgaXMgdGhlIG1vc3QgaW1wb3J0YW50IHBhcnQg
aW4gdGhlIGNvbW1pdCBsb2cuDQoNCklmIHRoZSBjb21taXQgbG9nIG9ubHkgbWVudGlvbnMgJ1Vz
ZSBzaG9ydCB1bml4LXN0eWxlIG9wdGlvbiBpbnN0ZWFkIG9mIC0tbG9uZ25hbWUnDQppdCBpcyBu
b3QgZWFzeSB0byBrbm93IHdoeSB0aGlzIGNvbW1pdCBpcyBuZWNlc3NhcnkuDQoNCg0KDQoNCg0K
PiAgaW5pdC9LY29uZmlnIHwgICAgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luaXQvS2NvbmZpZyBi
L2luaXQvS2NvbmZpZw0KPiBpbmRleCAwNDFmM2EwLi4xOTJkNDAwIDEwMDY0NA0KPiAtLS0gYS9p
bml0L0tjb25maWcNCj4gKysrIGIvaW5pdC9LY29uZmlnDQo+IEBAIC0yLDkgKzIsOSBAQCBjb25m
aWcgREVGQ09ORklHX0xJU1QNCj4gIAlzdHJpbmcNCj4gIAlkZXBlbmRzIG9uICFVTUwNCj4gIAlv
cHRpb24gZGVmY29uZmlnX2xpc3QNCj4gLQlkZWZhdWx0ICIvbGliL21vZHVsZXMvJChzaGVsbCx1
bmFtZSAtLXJlbGVhc2UpLy5jb25maWciDQo+ICsJZGVmYXVsdCAiL2xpYi9tb2R1bGVzLyQoc2hl
bGwsdW5hbWUgLXIpLy5jb25maWciDQo+ICAJZGVmYXVsdCAiL2V0Yy9rZXJuZWwtY29uZmlnIg0K
PiAtCWRlZmF1bHQgIi9ib290L2NvbmZpZy0kKHNoZWxsLHVuYW1lIC0tcmVsZWFzZSkiDQo+ICsJ
ZGVmYXVsdCAiL2Jvb3QvY29uZmlnLSQoc2hlbGwsdW5hbWUgLXIpIg0KPiAgCWRlZmF1bHQgQVJD
SF9ERUZDT05GSUcNCj4gIAlkZWZhdWx0ICJhcmNoLyQoQVJDSCkvZGVmY29uZmlnIg0K
