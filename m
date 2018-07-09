Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D46C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BD0208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BD0208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933555AbeGIArr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:47:47 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37713 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933204AbeGIArp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:47:45 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w690lY8G006245, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id w690lY8G006245
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Mon, 9 Jul 2018 08:47:34 +0800
Received: from RTITEXH01.realtek.com.tw (172.21.6.62) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Mon, 9 Jul 2018 08:47:33 +0800
Received: from RTITMBSV07.realtek.com.tw ([fe80::8d2f:f777:70b1:3332]) by
 RTITEXH01.realtek.com.tw ([::1]) with mapi id 14.03.0361.001; Mon, 9 Jul 2018
 08:47:33 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>
Subject: Re: [PATCH] staging: r8822be: Fix RTL8822be can't find any wireless AP
Thread-Topic: [PATCH] staging: r8822be: Fix RTL8822be can't find any
 wireless AP
Thread-Index: AQHUFOyC2kO+smoEKUCR24m0t57bT6SFAegAgACK7QA=
Date:   Mon, 9 Jul 2018 00:47:33 +0000
Message-ID: <1531097242.2699.1.camel@realtek.com>
References: <20180706054435.3732-1-pkshih@realtek.com>
         <63971c24-d99d-459e-fb9a-df583c5a89d6@lwfinger.net>
In-Reply-To: <63971c24-d99d-459e-fb9a-df583c5a89d6@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E761A555773D4C4B8B9B11975C2C682E@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTA3LTA4IGF0IDExOjMwIC0wNTAwLCBMYXJyeSBGaW5nZXIgd3JvdGU6DQo+
IE9uIDA3LzA2LzIwMTggMTI6NDQgQU0sIHBrc2hpaEByZWFsdGVrLmNvbSB3cm90ZToNCj4gPiBG
cm9tOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPsKgDQo+ID4gUlRMODgy
MmJlIGNhbid0IGJyaW5nIHVwIHByb3Blcmx5IG9uIEFTVVMgWDUzMFVOLCBhbmQgZG1lc2cgc2F5
czoNCj4gPiBbIDguNTkxMzMzXSByODgyMmJlOiBtb2R1bGUgaXMgZnJvbSB0aGUgc3RhZ2luZyBk
aXJlY3RvcnksIHRoZSBxdWFsaXR5DQo+ID4gaXMgdW5rbm93biwgeW91IGhhdmUgYmVlbiB3YXJu
ZWQuDQo+ID4gWyA4LjU5MzEyMl0gcjg4MjJiZSAwMDAwOjAyOjAwLjA6IGVuYWJsaW5nIGRldmlj
ZSAoMDAwMCAtPiAwMDAzKQ0KPiA+IFsgOC42NjkxNjNdIHI4ODIyYmU6IFVzaW5nIGZpcm13YXJl
IHJ0bHdpZmkvcnRsODgyMmJlZncuYmluDQo+ID4gWyA5LjI4OTkzOV0gcjg4MjJiZTogcnRsd2lm
aTogd2lyZWxlc3Mgc3dpdGNoIGlzIG9uDQo+ID4gWyAxMC4wNTY0MjZdIHI4ODIyYmUgMDAwMDow
MjowMC4wIHdscDJzMDogcmVuYW1lZCBmcm9tIHdsYW4wDQo+ID4gLi4uDQo+ID4gWyAxMS45NTI1
MzRdIHI4ODIyYmU6IGhhbG1hY19pbml0X2hhbCBmYWlsZWQNCj4gPiBbIDExLjk1NTkzM10gcjg4
MjJiZTogaGFsbWFjX2luaXRfaGFsIGZhaWxlZA0KPiA+IFsgMTEuOTU2MjI3XSByODgyMmJlOiBo
YWxtYWNfaW5pdF9oYWwgZmFpbGVkDQo+ID4gWyAyMi4wMDc5NDJdIHI4ODIyYmU6IGhhbG1hY19p
bml0X2hhbCBmYWlsZWQNCj4gPsKgDQo+ID4gSmlhbi1Ib25nIHJlcG9ydGVkIGl0IHdvcmtzIGlm
IHR1cm4gb2ZmIEFTUE0gd2l0aCBtb2R1bGUgcGFyYW1ldGVyIGFzcG09MC4NCj4gPiBJbiBvcmRl
ciB0byBmaXggdGhpcyBwcm9ibGVtIGtpbmRseSwgdGhpcyBjb21taXQgZG9uJ3QgdHVybiBvZmYg
YXNwbSBidXQNCj4gPiBlbmxhcmdlIEFTUE0gTDEgbGF0ZW5jeSB0byA3Lg0KPiA+wqANCj4gPiBS
ZXBvcnRlZC1ieTogSmlhbi1Ib25nIFBhbiA8amlhbi1ob25nQGVuZGxlc3NtLmNvbT4NCj4gPiBU
ZXN0ZWQtYnk6IEppYW4tSG9uZyBQYW4gPGppYW4taG9uZ0BlbmRsZXNzbS5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBUaGlz
IHBhdGNoIGRlZmluaXRlbHkgbmVlZHMgYSBDYyBmb3Igc3RhYmxlLiBPdGhlcndpc2UgSSBBQ0sg
aXQuDQo+IA0KDQpIaSBMYXJyeSwNCg0KVGhpcyBwYXRjaCBoYWQgYmVlbiBhcHBsaWVkIGJ5IEdy
ZWcsIGFuZCBDQydlZCB0byBzdGFibGUuDQpUaGFua3MgZm9yIHlvdXIgcmVtaW5kZXIuwqANCg0K
UEsNCg==
