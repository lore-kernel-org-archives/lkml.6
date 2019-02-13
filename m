Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBFEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE1321934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfBMDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:22:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:7640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfBMDWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:22:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 19:22:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,364,1544515200"; 
   d="scan'208";a="126026862"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2019 19:22:43 -0800
Received: from pgsmsx110.gar.corp.intel.com (10.221.44.111) by
 PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 11:22:42 +0800
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.233]) by
 PGSMSX110.gar.corp.intel.com ([169.254.13.64]) with mapi id 14.03.0415.000;
 Wed, 13 Feb 2019 11:22:42 +0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "Giuseppe Cavallaro" <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>
Subject: RE: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
Thread-Topic: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
Thread-Index: AQHUwu+UOCpTiEkLQkC84M7CF1vk+KXcHcYAgADu6wA=
Date:   Wed, 13 Feb 2019 03:22:40 +0000
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C04507764FAE@PGSMSX101.gar.corp.intel.com>
References: <1549988692-4124-1-git-send-email-joyce.ooi@intel.com>
 <0c93846a-48ab-5cde-6d27-291606dd8c31@linux.intel.com>
In-Reply-To: <0c93846a-48ab-5cde-6d27-291606dd8c31@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTQ1NzNjZGMtNjE5Mi00NTliLTgxNTctZWZkNDZiNTI0MGExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGs0RVwvWUFocCtObXJ2TWxFcHQ2ZlZ5Uk5RSjhNNU9jV2VRRmZMR0tHaGhMQXpUUVRPcmVJNk5lWk5BdXlqZ1MifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9yIFRoYXllciBbbWFpbHRv
OnRob3IudGhheWVyQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFy
eSAxMywgMjAxOSA0OjUzIEFNDQo+IFRvOiBPb2ksIEpveWNlIDxqb3ljZS5vb2lAaW50ZWwuY29t
PjsgR2l1c2VwcGUgQ2F2YWxsYXJvDQo+IDxwZXBwZS5jYXZhbGxhcm9Ac3QuY29tPjsgQWxleGFu
ZHJlIFRvcmd1ZSA8YWxleGFuZHJlLnRvcmd1ZUBzdC5jb20+Ow0KPiBKb3NlIEFicmV1IDxqb2Fi
cmV1QHN5bm9wc3lzLmNvbT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47
DQo+IE1heGltZSBDb3F1ZWxpbiA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT4NCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBs
eS5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgU2VlLCBDaGluDQo+IExpYW5nIDxjaGluLmxpYW5nLnNlZUBp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldDogc3RtbWFjOiBBZGQgU01DIHN1
cHBvcnQgZm9yIEVNQUMgU3lzdGVtIE1hbmFnZXINCj4gcmVnaXN0ZXINCj4gDQo+IEhpIEpveWNl
LA0KPiANCj4gT24gMi8xMi8xOSAxMDoyNCBBTSwgT29pLCBKb3ljZSB3cm90ZToNCj4gPiBBcyB0
aGVyZSBpcyByZXN0cmljdGlvbiB0byBhY2Nlc3MgdG8gRU1BQyBTeXN0ZW0gTWFuYWdlciByZWdp
c3RlcnMgaW4NCj4gPiB0aGUga2VybmVsIGZvciBJbnRlbCBTdHJhdGl4MTAsIHRoZSB1c2Ugb2Yg
U01DIGNhbGxzIGFyZSByZXF1aXJlZCBhbmQNCj4gPiBhZGRlZCBpbiBkd21hYy1zb2NmcGdhIGRy
aXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE9vaSwgSm95Y2UgPGpveWNlLm9vaUBpbnRl
bC5jb20+DQo+IA0KPiA8c25pcD4NCj4gDQo+IEkgaGF2ZSBhIHBlbmRpbmcgcGF0Y2hzZXRbMV0g
dGhhdCBhZGRyZXNzZXMgdGhpcyBidXQgY2FuIGJlIHVzZWQgYnkgb3RoZXIgZHJpdmVycw0KPiBh
cyB3ZWxsLg0KPiANCj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTA2
MTI4OTEvW10gDQpPaCwgZGlkbid0IHJlYWxpemUgeW91ciBwYXRjaHNldC4gSSBndWVzcyBteSBw
YXRjaCBjYW4gYmUgaWdub3JlZCB0aGVuLiBUaGFua3MhDQoNCg==
