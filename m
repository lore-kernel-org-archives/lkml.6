Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E286C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA3208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="aRlG3yFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FA3208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeH0Sup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:50:45 -0400
Received: from m15-29.126.com ([220.181.15.29]:22367 "EHLO m15-29.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0Sup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=TAf7Z
        kzQK+Lu5ppf51ol6hiZ0zEk5cmTqqw70GWXmnA=; b=aRlG3yFYrRYGbcIGTfm9K
        eTxw299VVqkq8Ja4fYjBabnfqi0KmzTQXhgcztK7Cwc0nmeLiZ/n1vEIQdVbdw/9
        X7szzzbRXlstkMOaIDk8I+lW9L32bTR6RhsbFRg+Ffppuu2lYX4pFhOVJFTHBG8/
        JY66eKo8Qip91MmpZFShgU=
Received: from liuxiang_1999$126.com ( [222.209.19.27] ) by
 ajax-webmail-wmsvr29 (Coremail) ; Mon, 27 Aug 2018 23:02:29 +0800 (CST)
X-Originating-IP: [222.209.19.27]
Date:   Mon, 27 Aug 2018 23:02:29 +0800 (CST)
From:   liuxiang <liuxiang_1999@126.com>
To:     "Boris Brezillon" <boris.brezillon@bootlin.com>
Cc:     "Liu Xiang" <liu.xiang6@zte.com.cn>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, han.xu@nxp.com,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at,
        "Yogesh Narayan Gaur" <yogeshnarayan.gaur@nxp.com>
Subject: Re:Re: [PATCH] mtd: spi-nor: fsl-quadspi: fix read error for flash
 size larger than 16MB
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
In-Reply-To: <20180827100613.78823993@bbrezillon>
References: <1534583663-2842-1-git-send-email-liu.xiang6@zte.com.cn>
 <20180827100613.78823993@bbrezillon>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3571f5ca.c32c.1657be858d1.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HcqowADXzVKGEoRbzKA_AQ--.54014W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbi2wavsFpD6TH0pQAAsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGaXhlczplNDZlY2RhNzY0ZGMzN2Y5ZmM2Mjc5ZDk1ZWEyYzAwN2RhZWYxYTcxKCJtdGQ6IHNw
aS1ub3I6IEFkZCBGcmVlc2NhbGUgUXVhZFNQSSBkcml2ZXIiKQpDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZwoKU2hvdWxkIEkgc2VuZCBhIFYyIHBhdGNoIHRoYXQgYWRkcyB0aGVzZSBhYm92Ze+8
nwoKCgoKQXQgMjAxOC0wOC0yNyAxNjowNjoxMywgIkJvcmlzIEJyZXppbGxvbiIgPGJvcmlzLmJy
ZXppbGxvbkBib290bGluLmNvbT4gd3JvdGU6Cj5PbiBTYXQsIDE4IEF1ZyAyMDE4IDE3OjE0OjIz
ICswODAwCj5MaXUgWGlhbmcgPGxpdS54aWFuZzZAenRlLmNvbS5jbj4gd3JvdGU6Cj4KPj4gSWYg
dGhlIHNpemUgb2Ygc3BpLW5vciBmbGFzaCBpcyBsYXJnZXIgdGhhbiAxNk1CLCB0aGUgcmVhZF9v
cGNvZGUKPj4gaXMgc2V0IHRvIFNQSU5PUl9PUF9SRUFEXzFfMV80XzRCLCBhbmQgZnNsX3FzcGlf
Z2V0X3NlcWlkKCkgd2lsbAo+PiByZXR1cm4gLUVJTlZBTCB3aGVuIGNtZCBpcyBTUElOT1JfT1Bf
UkVBRF8xXzFfNF80Qi4gVGhpcyBjYW4KPj4gY2F1c2UgcmVhZCBvcGVyYXRpb24gZmFpbC4KPj4g
Cj4+IFNpZ25lZC1vZmYtYnk6IExpdSBYaWFuZyA8bGl1LnhpYW5nNkB6dGUuY29tLmNuPgo+Cj5J
J20gcHJldHR5IHN1cmUgeW91IHdhbnQgdG8gYmFja3BvcnQgdGhpcyBmaXguIENhbiB5b3UgYWRk
IGEgRml4ZXMgdGFnCj5hbmQgQ0Mgc3RhYmxlPwo+Cj5BbHNvLCBJJ2QgbGlrZSB0byBoYXZlIGFu
IEFjayBmcm9tIHNvbWVvbmUgd29ya2luZyBhdCBOWFAgKEhhbiwKPllvZ2VzaD8pLgo+Cj5UaGFu
a3MsCj4KPkJvcmlzLgo+Cj4+IC0tLQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9mc2wtcXVhZHNw
aS5jIHwgMSArCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4gCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2ZzbC1xdWFkc3BpLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2ZzbC1xdWFkc3BpLmMKPj4gaW5kZXggN2Q5NjIwYy4uNjQzMDRhMyAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9mc2wtcXVhZHNwaS5jCj4+ICsrKyBiL2RyaXZlcnMv
bXRkL3NwaS1ub3IvZnNsLXF1YWRzcGkuYwo+PiBAQCAtNDc4LDYgKzQ3OCw3IEBAIHN0YXRpYyBp
bnQgZnNsX3FzcGlfZ2V0X3NlcWlkKHN0cnVjdCBmc2xfcXNwaSAqcSwgdTggY21kKQo+PiAgewo+
PiAgCXN3aXRjaCAoY21kKSB7Cj4+ICAJY2FzZSBTUElOT1JfT1BfUkVBRF8xXzFfNDoKPj4gKwlj
YXNlIFNQSU5PUl9PUF9SRUFEXzFfMV80XzRCOgo+PiAgCQlyZXR1cm4gU0VRSURfUkVBRDsKPj4g
IAljYXNlIFNQSU5PUl9PUF9XUkVOOgo+PiAgCQlyZXR1cm4gU0VRSURfV1JFTjsK
