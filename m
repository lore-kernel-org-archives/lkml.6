Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26592C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D618320883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D618320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbeGZWNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:13:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbeGZWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:13:47 -0400
Received: from localhost (unknown [172.58.43.154])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9EFFA108CAEA2;
        Thu, 26 Jul 2018 13:55:13 -0700 (PDT)
Date:   Thu, 26 Jul 2018 13:55:12 -0700 (PDT)
Message-Id: <20180726.135512.137481791294209800.davem@davemloft.net>
To:     neilb@suse.com
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] rhashtable: detect when object movement
 between tables might have invalidated a lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <876016r9z5.fsf@notabene.neil.brown.name>
References: <87fu0kt5m0.fsf@notabene.neil.brown.name>
        <20180719.051440.931407144963903326.davem@davemloft.net>
        <876016r9z5.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 13:55:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmNvbT4NCkRhdGU6IE1vbiwgMjMgSnVsIDIwMTgg
MTE6NTY6MTQgKzEwMDANCg0KPiBTb21lIHVzZXJzIG9mIHJoYXNodGFibGVzIG1pZ2h0IG5lZWQg
dG8gbW92ZSBhbiBvYmplY3QgZnJvbSBvbmUgdGFibGUNCj4gdG8gYW5vdGhlciAtICB0aGlzIGFw
cGVhcnMgdG8gYmUgdGhlIHJlYXNvbiBmb3IgdGhlIGluY29tcGxldGUgdXNhZ2UNCj4gb2YgTlVM
TFMgbWFya2Vycy4NCj4gDQo+IFRvIHN1cHBvcnQgdGhlc2UsIHdlIHN0b3JlIGEgdW5pcXVlIE5V
TExTX01BUktFUiBhdCB0aGUgZW5kIG9mDQo+IGVhY2ggY2hhaW4sIGFuZCB3aGVuIGEgc2VhcmNo
IGZhaWxzIHRvIGZpbmQgYSBtYXRjaCwgd2UgY2hlY2sNCj4gaWYgdGhlIE5VTExTIG1hcmtlciBm
b3VuZCB3YXMgdGhlIGV4cGVjdGVkIG9uZS4gIElmIG5vdCwNCj4gdGhlIHNlYXJjaCBpcyByZXBl
YXRlZC4NCiAuLi4NCj4gVGhpcyBpcyBhIHNpbXBsaWZpZWQgdmVyc2lvbiBvZiBhIHByZXZpb3Vz
IHBhdGNoLg0KPiBJdCBwcm92aWRlcyBOVUxMU19NQVJLRVIgc3VwcG9ydCBvbmx5IGZvciB0aGUg
c3BlY2lmaWMgdXNlIGNhc2UNCj4gd2hpY2ggaXMgY3VycmVudGx5IHRob3VnaHQgYmUgdmFsdWFi
bGUgdG8gaW4tdHJlZSB1c2Vycw0KPiBvZiByaGFzaHRhYmxlcy4NCg0KTmVpbCwgdGhpcyBkb2Vz
bid0IGV2ZW4gY29tcGlsZToNCg0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGxpYi9yaGFzaHRhYmxl
LmM6Mjg6DQpsaWIvcmhhc2h0YWJsZS5jOiBJbiBmdW5jdGlvbiChcmh0X2J1Y2tldF9uZXN0ZWSi
Og0KLi9pbmNsdWRlL2xpbnV4L3JoYXNodGFibGUuaDo3OToyOiBlcnJvcjogaW5pdGlhbGl6ZXIg
ZWxlbWVudCBpcyBub3QgY29tcHV0YWJsZSBhdCBsb2FkIHRpbWUNCiAgKCh2b2lkICopTlVMTFNf
TUFSS0VSKCgodW5zaWduZWQgbG9uZykgKHB0cikpID4+IDEpKQ0KICBeDQpsaWIvcmhhc2h0YWJs
ZS5jOjExNzg6NDM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyChUkhUX05VTExTX01BUktF
UqINCiAgc3RhdGljIHN0cnVjdCByaGFzaF9oZWFkIF9fcmN1ICpyaG51bGwgPSBSSFRfTlVMTFNf
TUFSS0VSKCZyaG51bGwpOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn4NCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWls
ZDozMTg6IGxpYi9yaGFzaHRhYmxlLm9dIEVycm9yIDENCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTY1
MzogbGliL3JoYXNodGFibGUub10gRXJyb3IgMg0KDQpJIGltYWdpbmUgeW91IGhhdmUgYSBtaXgg
b2Ygb3RoZXIgY2hhbmdlcyBvciB3aGF0ZXZlciBpbiB5b3VyIHRyZWUsIHNvIEknbGwNCmdpdmUg
eW91IHRoZSBiZW5lZml0IG9mIHRoZSBkb3VidC4NCg0KQnV0IHRoaXMgaXMgdGhlIHNlY29uZCB0
aW1lIHRoaXMgaGFzIGhhcHBlbmVkIHdpdGggeW91ciByaGFzaHRhYmxlIGNoYW5nZXMsDQpzby4u
Lg0K
