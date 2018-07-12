Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6024EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AEC20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AEC20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbeGLF7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:59:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54290 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeGLFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:57 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5218C13FE78A8;
        Wed, 11 Jul 2018 22:48:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 22:48:01 -0700 (PDT)
Message-Id: <20180711.224801.1129067473269289703.davem@davemloft.net>
To:     neilb@suse.com
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH resend] rhashtable: detect when object movement might
 have invalidated a lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180711.224658.2077863065492745521.davem@davemloft.net>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au>
        <87k1q8yh70.fsf@notabene.neil.brown.name>
        <20180711.224658.2077863065492745521.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Jul 2018 22:48:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KRGF0ZTogV2VkLCAxMSBK
dWwgMjAxOCAyMjo0Njo1OCAtMDcwMCAoUERUKQ0KDQo+IEZyb206IE5laWxCcm93biA8bmVpbGJA
c3VzZS5jb20+DQo+IERhdGU6IEZyaSwgMDYgSnVsIDIwMTggMTc6MDg6MzUgKzEwMDANCj4gDQo+
PiANCj4+IFNvbWUgdXNlcnMgb2Ygcmhhc2h0YWJsZSBtaWdodCBuZWVkIHRvIGNoYW5nZSB0aGUg
a2V5DQo+PiBvZiBhbiBvYmplY3QgYW5kIG1vdmUgaXQgdG8gYSBkaWZmZXJlbnQgbG9jYXRpb24g
aW4gdGhlIHRhYmxlLg0KPj4gT3RoZXIgdXNlcnMgbWlnaHQgd2FudCB0byBhbGxvY2F0ZSBvYmpl
Y3RzIHVzaW5nDQo+PiBTTEFCX1RZUEVTQUZFX0JZX1JDVSB3aGljaCBjYW4gcmVzdWx0IGluIHRo
ZSBzYW1lIG1lbW9yeSBhbGxvY2F0aW9uDQo+PiBiZWluZyB1c2VkIGZvciBhIGRpZmZlcmVudCAo
dHlwZS1jb21wYXRpYmxlKSBwdXJwb3NlIGFuZCBzaW1pbGFybHkNCj4+IGVuZCB1cCBpbiBhIGRp
ZmZlcmVudCBoYXNoLWNoYWluLg0KPj4gDQo+PiBUbyBzdXBwb3J0IHRoZXNlLCB3ZSBzdG9yZSBh
IHVuaXF1ZSBOVUxMU19NQVJLRVIgYXQgdGhlIGVuZCBvZg0KPj4gZWFjaCBjaGFpbiwgYW5kIHdo
ZW4gYSBzZWFyY2ggZmFpbHMgdG8gZmluZCBhIG1hdGNoLCB3ZSBjaGVjaw0KPj4gaWYgdGhlIE5V
TExTIG1hcmtlciBmb3VuZCB3YXMgdGhlIGV4cGVjdGVkIG9uZS4gIElmIG5vdCwNCj4+IHRoZSBz
ZWFyY2ggaXMgcmVwZWF0ZWQuDQo+PiANCj4+IFRoZSB1bmlxdWUgTlVMTFNfTUFSS0VSIGlzIGRl
cml2ZWQgZnJvbSB0aGUgYWRkcmVzcyBvZiB0aGUNCj4+IGhlYWQgb2YgdGhlIGNoYWluLg0KPj4g
DQo+PiBJZiBhbiBvYmplY3QgaXMgcmVtb3ZlZCBhbmQgcmUtYWRkZWQgdG8gdGhlIHNhbWUgaGFz
aCBjaGFpbiwgd2Ugd29uJ3QNCj4+IG5vdGljZSBieSBsb29raW5nIHRoYXQgdGhlIE5VTExTIG1h
cmtlci4gIEluIHRoaXMgY2FzZSB3ZSBtdXN0IGJlIHN1cmUNCj4+IHRoYXQgaXQgd2FzIG5vdCBy
ZS1hZGRlZCAqYWZ0ZXIqIGl0cyBvcmlnaW5hbCBsb2NhdGlvbiwgb3IgYSBsb29rdXAgbWF5DQo+
PiBpbmNvcnJlY3RseSBmYWlsLiAgVGhlIGVhc2llc3Qgc29sdXRpb24gaXMgdG8gZW5zdXJlIGl0
IGlzIGluc2VydGVkIGF0DQo+PiB0aGUgc3RhcnQgb2YgdGhlIGNoYWluLiAgaW5zZXJ0X3Nsb3co
KSBhbHJlYWR5IGRvZXMgdGhhdCwNCj4+IGluc2VydF9mYXN0KCkgZG9lcyBub3QuICBTbyB0aGlz
IHBhdGNoIGNoYW5nZXMgaW5zZXJ0X2Zhc3QgdG8gYWx3YXlzDQo+PiBpbnNlcnQgYXQgdGhlIGhl
YWQgb2YgdGhlIGNoYWluLg0KPj4gDQo+PiBOb3RlIHRoYXQgc3VjaCBhIHVzZXIgbXVzdCBkbyB0
aGVpciBvd24gZG91YmxlLWNoZWNraW5nIG9mDQo+PiB0aGUgb2JqZWN0IGZvdW5kIGJ5IHJoYXNo
dGFibGVfbG9va3VwX2Zhc3QoKSBhZnRlciBlbnN1cmluZw0KPj4gbXV0dWFsIGV4Y2x1c2lvbiB3
aGljaCBhbnl0aGluZyB0aGF0IG1pZ2h0IGNoYW5nZSB0aGUga2V5LCBzdWNoIGFzDQo+PiBzdWNj
ZXNzZnVsbHkgdGFraW5nIGEgbmV3IHJlZmVyZW5jZS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTog
TmVpbEJyb3duIDxuZWlsYkBzdXNlLmNvbT4NCj4gDQo+IEFwcGxpZWQgdG8gbmV0LW5leHQuDQoN
CkFjdHVhbGx5LCByZXZlcnRlZCwgaXQgZG9lc24ndCBldmVuIGNvbXBpbGUuDQoNCmxpYi9yaGFz
aHRhYmxlLmM6IEluIGZ1bmN0aW9uIKFyaHRfYnVja2V0X25lc3RlZKI6DQpsaWIvcmhhc2h0YWJs
ZS5jOjExODc6Mzk6IGVycm9yOiBtYWNybyAiSU5JVF9SSFRfTlVMTFNfSEVBRCIgcGFzc2VkIDMg
YXJndW1lbnRzLCBidXQgdGFrZXMganVzdCAxDQogICAgSU5JVF9SSFRfTlVMTFNfSEVBRChyaG51
bGwsIE5VTEwsIDApOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0K
bGliL3JoYXNodGFibGUuYzoxMTg3OjQ6IGVycm9yOiChSU5JVF9SSFRfTlVMTFNfSEVBRKIgdW5k
ZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4goUlOSVRf
TElTVF9IRUFEoj8NCiAgICBJTklUX1JIVF9OVUxMU19IRUFEKHJobnVsbCwgTlVMTCwgMCk7DQog
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fg0KICAgIElOSVRfTElTVF9IRUFEDQpsaWIvcmhhc2h0YWJs
ZS5jOjExODc6NDogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQg
b25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4NCg==
