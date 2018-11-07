Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC03C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0776C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="BOZalumJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0776C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeKHDgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:36:11 -0500
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:1185 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeKHDgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2296; q=dns/txt; s=iport;
  t=1541613881; x=1542823481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iaEcaU+4GRs7X3tNXY/HSWtgmmZpToVTTqHr9ZxKrRU=;
  b=BOZalumJ/bXwbmPqNLofeNOtR9ll307RisZApFnN3Mc9XX0dZMIWnbmv
   wa57uYVJQLcc75gDGEqnqDyU9fRV66dYWSbueBDevrL55HV5JVCix72B6
   7dLd8sgzllF4a9ZO94M/Y16yu+qJhGV6EzvK+Z+t54V62dHVTX7pKgS5m
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAAB0KONb/5tdJa1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBggNmgQInCoNuiBiLfIFoJZcwgXoLAQE?=
 =?us-ascii?q?YDYRHAheCciI0DQ0BAwEBAgEBAm0cDIU7AQEBAwEiEUUQAgEIDgoCAiYCAgI?=
 =?us-ascii?q?mChUQAgQOBYMhAYIBD6g3gS6ELQGFcxR3im0XgUE/gTgME4JMgxsDAoFegwQ?=
 =?us-ascii?q?xgiYCn0EJAoZthg2EFhiCI45FjRmKJwIRFIEmHTiBVXAVSBMKAYJBCYsThT5?=
 =?us-ascii?q?BMQGMQYEfAQE?=
X-IronPort-AV: E=Sophos;i="5.54,476,1534809600"; 
   d="scan'208";a="393482958"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 18:04:39 +0000
Received: from XCH-RTP-002.cisco.com (xch-rtp-002.cisco.com [64.101.220.142])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id wA7I4ajq019177
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 7 Nov 2018 18:04:37 GMT
Received: from xch-rtp-001.cisco.com (64.101.220.141) by XCH-RTP-002.cisco.com
 (64.101.220.142) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 7 Nov
 2018 13:04:35 -0500
Received: from xch-rtp-001.cisco.com ([64.101.220.141]) by
 XCH-RTP-001.cisco.com ([64.101.220.141]) with mapi id 15.00.1395.000; Wed, 7
 Nov 2018 13:04:35 -0500
From:   "Nikunj Kela (nkela)" <nkela@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Thread-Topic: [PATCH] jffs2: implement mount option to configure endianness
Thread-Index: AQHUdhqbTj/3Cc5mIU2fPUfH4B/ycqVEWbYAgACWlIA=
Date:   Wed, 7 Nov 2018 18:04:35 +0000
Message-ID: <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
In-Reply-To: <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.41.48.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <01205EDF9E5AF841A6C38CAD04ACCD40@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-SMTP-Client: 64.101.220.142, xch-rtp-002.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNy8xOCwgMTowNSBBTSwgIkRhdmlkIFdvb2Rob3VzZSIgPGR3bXcyQGluZnJhZGVhZC5v
cmc+IHdyb3RlOg0KDQogICAgT24gVHVlLCAyMDE4LTExLTA2IGF0IDEzOjQ5IC0wODAwLCBOaWt1
bmogS2VsYSB3cm90ZToNCiAgID4+IFRoaXMgcGF0Y2ggYWxsb3dzIHRoZSBlbmRpYW5uZXNzIG9m
IHRoZSBKRlNTMiBmaWxlc3lzdGVtIHRvIGJlDQogICAgPj4gc3BlY2lmaWVkIGJ5IG1vdW50IG9w
dGlvbiAnZm9yY2VfZW5kaWFuPWJpZ3xsaXR0bGV8bmF0aXZlJy4gSWYNCiAgICA+PiBlbmRpYW5u
ZXNzIGlzIG5vdCBzcGVjaWZpZWQsIGl0IGRlZmF1bHRzIHRvICduYXRpdmUnIGVuZGlhbm5lc3MN
CiAgICA+PiB0aHVzIHJldGFpbmluZyB0aGUgZXhpc3RpbmcgYmVoYXZpb3IuDQogICAgPj4gDQog
ICAgPj4gU29tZSBhcmNoaXRlY3R1cmVzIGJlbmVmaXQgZnJvbSBoYXZpbmcgYSBzaW5nbGUga25v
d24gZW5kaWFubmVzcw0KICAgID4+IG9mIEpGRlMyIGZpbGVzeXN0ZW0gKGZvciBkYXRhLCBub3Qg
ZXhlY3V0YWJsZXMpIGluZGVwZW5kZW50IG9mIHRoZQ0KICAgID4+IGVuZGlhbm5lc3Mgb2YgdGhl
IHByb2Nlc3NvciAoQVJNIHByb2Nlc3NvcnMgY2FuIGJlIHN3aXRjaGVkIHRvIGVpdGhlcg0KICAg
ID4+IGVuZGlhbm5lc3MgYXQgcnVuLXRpbWUpLg0KICAgID4+IA0KICAgID4+IFdlIGhhdmUgYm9h
cmRzIHRoYXQgYXJlIHNoaXBwZWQgd2l0aCBCRSBqZmZzMiBhbmQgQkUga2VybmVsLiBXZSBhcmUN
CiAgICA+PiBub3cgbWlncmF0aW5nIHRvIExFIGtlcm5lbC4gVGhpcyBtb3VudCBvcHRpb24gaGVs
cHMgdXMgaW4gbW91bnRpbmcNCiAgICA+PiBCRSBqZmZzMiBvbiBMRSBrZXJuZWwuDQogICAgDQog
ICAgPlRoYW5rcyBmb3IgaW1wbGVtZW50aW5nIHRoaXMuIEpGRlMyIGhhcyBvZnRlbiBiZWVuIHZl
cnkgc2Vuc2l0aXZlIHRvDQogICAgPnBlcmZvcm1hbmNlIGF0IG1vdW50IHRpbWUg4oCUIEknZCBs
b3ZlIHRvIHNlZSBob3cgdGhpcyBhZmZlY3RzIHRoZSB0aW1lDQogICAgPnRha2VuIHRvIG1vdW50
IGEgbGFyZ2UgZmlsZSBzeXN0ZW0uIElmIGl0J3Mgc2lnbmlmaWNhbnQsIHdlIG1heSB3YW50IGEN
CiAgICA+Y29uZmlnIG9wdGlvbiB0byBtYWtlIHRoaXMgY29uZGl0aW9uYWw/DQogICAgPg0KICAg
ID5BbHNvLCBwZXJoYXBzIHdlIHNob3VsZCBpbXByb3ZlIHRoZSBiZWhhdmlvdXIgd2hlbiB0aGUg
dXNlcg0KICAgID5hY2NpZGVudGFsbHkgdHJpZXMgdG8gbW91bnQgYSB3cm9uZy1lbmRpYW4gZmls
ZSBzeXN0ZW0uIElmIHdlIGNhbid0DQogICAgPmp1c3QgbWFrZSBpdCBhdXRvZGV0ZWN0IGFuZCB1
c2UgdGhlICJjb3JyZWN0IiBlbmRpYW5uZXNzLCBwZXJoYXBzIHdlDQogICAgPnNob3VsZCBhdCBs
ZWFzdCBwcmludGsgYSBtZXNzYWdlIHN1Z2dlc3RpbmcgdGhhdCB0aGUgdXNlciB0cnkgYWdhaW4N
CiAgICA+d2l0aCB0aGUgb3RoZXIgZW5kaWFubmVzcz8NCg0KSSBoYWQgdHJpZWQgdG8gdXNlIGNv
bmZpZ3MgdG8gc3RhcnQgd2l0aCB2aWEgdGhlIGZvbGxvd2luZyBwYXRjaCBob3dldmVyIEkgd2Fz
IGFkdmlzZWQgdG8gaGF2ZSBhIG1vdW50IG9wdGlvbjoNCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL3BpcGVybWFpbC9saW51eC1tdGQvMjAxOC1Ob3ZlbWJlci8wODUxMjYuaHRtbA0KDQpUaGFu
a3MsDQotTmlrdW5qDQogICAgDQoNCg==
