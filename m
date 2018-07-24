Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE0AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA18C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="VZNVSang"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA18C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeGXO0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:26:04 -0400
Received: from m15-29.126.com ([220.181.15.29]:21687 "EHLO m15-29.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeGXO0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=DZAqB
        kCEBDR6p4QbVK3A8MVP5Y5rvFG7HipwrdxPAwk=; b=VZNVSangUWNcySXlt5hoe
        U6U3asm/Tmz+Izl410tVOG6JtbrfI7RvG+2IgTnjZNGAdMhdQZZGHKCg+YFZCf8R
        Cx0mje0GYpxryrQHfAHXrLcr+6YlORYGnbwNur1HaZh3x0THY3njbtsZXpFU200q
        zKfmybeMv8B3oI35b/2jSI=
Received: from liuxiang_1999$126.com ( [110.184.152.61] ) by
 ajax-webmail-wmsvr29 (Coremail) ; Tue, 24 Jul 2018 21:19:20 +0800 (CST)
X-Originating-IP: [110.184.152.61]
Date:   Tue, 24 Jul 2018 21:19:20 +0800 (CST)
From:   liuxiang <liuxiang_1999@126.com>
To:     "Rob Herring" <robh+dt@kernel.org>
Cc:     liu.xiang6@zte.com.cn, "Frank Rowand" <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] of: irq: Add a helper function for
 irq_of_parse_and_map
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
In-Reply-To: <CAL_JsqLozSJ-0YeajN=qHuR69KCjeR_xO21MyZxr-n6tR5G0cw@mail.gmail.com>
References: <1532187494-2704-1-git-send-email-liu.xiang6@zte.com.cn>
 <CAL_JsqLozSJ-0YeajN=qHuR69KCjeR_xO21MyZxr-n6tR5G0cw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <549a231a.a051.164cc71b1c8.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HcqowAA36pBZJ1dbrWMkAQ--.46790W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiJBiNsFpD5+HgRgABs5
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkkgZm91bmQgaW4gcHJvYmUgZnVuY3Rpb24gc29tZSBkcml2ZXJzIHVzZSBpcnFfb2ZfcGFyc2Vf
YW5kX21hcAphbmQgZG8gbm90IGNhbGwgaXJxX2Rpc3Bvc2VfbWFwcGluZyBpbiBlcnIgcGF0aCwg
d2hpbGUgb3RoZXIgZHJpdmVycyBkby4KU28gSSB0aGluayBhIHJlc291cmNlIG1hbmFnZWQgaXJx
X29mX3BhcnNlX2FuZF9tYXAgZnVuY3Rpb24gY2FuIApiZSBiZXR0ZXIgdG8gZmluaXNoIHRoaXMg
am9iLgoKQXQgMjAxOC0wNy0yMyAyMzoyODo1MiwgIlJvYiBIZXJyaW5nIiA8cm9iaCtkdEBrZXJu
ZWwub3JnPiB3cm90ZToKPk9uIFNhdCwgSnVsIDIxLCAyMDE4IGF0IDk6MzggQU0gTGl1IFhpYW5n
IDxsaXUueGlhbmc2QHp0ZS5jb20uY24+IHdyb3RlOgo+Pgo+PiBJbXBsZW1lbnQgYSByZXNvdXJj
ZSBtYW5hZ2VkIGlycV9vZl9wYXJzZV9hbmRfbWFwIGZ1bmN0aW9uLgo+Cj5UaGF0IGlzIG9idmlv
dXMgZnJvbSB0aGUgZGlmZi4gV2h5IGRvIHlvdSBuZWVkIHRoaXM/Cj4KPkFueXRoaW5nIHRoYXQg
aXMgYSBwbGF0Zm9ybSBkZXZpY2Ugc2hvdWxkIHVzZSBwbGF0Zm9ybV9nZXRfaXJxLiBUaGUKPm1h
cHBpbmcgaXMgY3JlYXRlZCBieSB0aGUgY29yZSBBbHNvLCBvZl9pcnFfZ2V0KCkgaXMgcHJlZmVy
cmVkIG92ZXIKPmlycV9vZl9wYXJzZV9hbmRfbWFwKCkgZm9yIG5ldyB1c2VycyBhcyBpdCBoYXMg
YmV0dGVyIGVycm9yIHJldHVybgo+aGFuZGxpbmcuCj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTGl1
IFhpYW5nIDxsaXUueGlhbmc2QHp0ZS5jb20uY24+Cj4+IC0tLQo+PiAgZHJpdmVycy9vZi9pcnEu
YyAgICAgICB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+ICBp
bmNsdWRlL2xpbnV4L29mX2lycS5oIHwgIDcgKysrKysrKwo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0
NSBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL29mL2lycS5jIGIvZHJp
dmVycy9vZi9pcnEuYwo+PiBpbmRleCAwMmFkOTNhLi45NDdmZTQxIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL29mL2lycS5jCj4+ICsrKyBiL2RyaXZlcnMvb2YvaXJxLmMKPj4gQEAgLTQ1LDYgKzQ1
LDQ0IEBAIHVuc2lnbmVkIGludCBpcnFfb2ZfcGFyc2VfYW5kX21hcChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKmRldiwgaW50IGluZGV4KQo+PiAgfQo+PiAgRVhQT1JUX1NZTUJPTF9HUEwoaXJxX29mX3Bh
cnNlX2FuZF9tYXApOwo+Pgo+PiArc3RhdGljIHZvaWQgZGV2bV9pcnFfZGlzcG9zZV9tYXBwaW5n
KHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqcmVzKQo+PiArewo+PiArICAgICAgIGlycV9kaXNw
b3NlX21hcHBpbmcoKih1bnNpZ25lZCBpbnQgKilyZXMpOwo+Cj5XZSBkb24ndCByZWYgY291bnQg
Y3JlYXRpbmcgbWFwcGluZ3MsIHNvIHRoaXMgd291bGQgYnJlYWsgZm9yIGFueSBzaGFyZWQgaXJx
Lgo+Cj5Sb2IK
