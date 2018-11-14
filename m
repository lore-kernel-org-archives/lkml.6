Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D022AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F1821582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="cjjL1SgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F1821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbeKOAvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:51:21 -0500
Received: from m15-35.126.com ([220.181.15.35]:13677 "EHLO m15-35.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbeKOAvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=zkVnT
        TI9gKDVJSqT8RtXMc9usGNrrjfEZBls4bwxfTM=; b=cjjL1SgGx5ckC45sAGCLp
        JyjoOFjzdG6LForYtp3vEaVvv+dXN1xtbP5Q89pdCfyWjordmxwEL7wDS+aqp8Rg
        AJR6OcIl0tqlfa+h/FuQuT6gdNejuImBWzahdTwPYKBqBG7TH3QIp2pmvKpDThVd
        tlJtwpl25hT41SGoSqEiOs=
Received: from liuxiang_1999$126.com ( [110.184.153.105] ) by
 ajax-webmail-wmsvr35 (Coremail) ; Wed, 14 Nov 2018 22:46:03 +0800 (CST)
X-Originating-IP: [110.184.153.105]
Date:   Wed, 14 Nov 2018 22:46:03 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "Boris Brezillon" <boris.brezillon@bootlin.com>
Cc:     "Liu Xiang" <liu.xiang6@zte.com.cn>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: Re:Re: [PATCH] mtd: spi-nor: Return error when nor->addr_width not
 match the device size
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
In-Reply-To: <20181114145129.568e4bb3@bbrezillon>
References: <1542200165-3073-1-git-send-email-liu.xiang6@zte.com.cn>
 <20181114145129.568e4bb3@bbrezillon>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5a1999c4.c3d8.16712afb14d.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: I8qowEBpgUMsNexb2IiQAQ--.56699W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiuQf+sFpD6Xkc5AABsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpLApJZiB0aGUgY2hlY2sgaXMgbW92ZWQgdG8KWzJdaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjQuMjAtcmMyL3NvdXJjZS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyNM
Mzc1OCwKdGhlIG5vci0+YWRkcl93aWR0aCBzZWxlY3Rpb24gbG9naWMgbWF5IGJlIG5lZWRlZCB0
byByZXdvcmsuIAoKSSBoYXZlIHNlbnQgYW4gZW1haWwgdG8gSVNTSSBmb3IgdGhlIHJlZ2lzdGVy
IHZhbHVlLCBidXQgaGF2ZW4ndCBnb3QgdGhlIHJlcGx5LgpEbyB5b3UgdGhpbmsgaXQgaXMgYmV0
dGVyIHRvIGFkZCB0aGlzIGNoZWNrIHVudGlsIEkgZ2V0IHRoZSByaWdodCBhbnN3ZXIgZnJvbSBJ
U1NJPwoKCgpBdCAyMDE4LTExLTE0IDIxOjUxOjI5LCAiQm9yaXMgQnJlemlsbG9uIiA8Ym9yaXMu
YnJlemlsbG9uQGJvb3RsaW4uY29tPiB3cm90ZToKPk9uIFdlZCwgMTQgTm92IDIwMTggMjA6NTY6
MDUgKzA4MDAKPkxpdSBYaWFuZyA8bGl1LnhpYW5nNkB6dGUuY29tLmNuPiB3cm90ZToKPgo+PiBJ
biBpczI1bHAyNTYsIHRoZSBEV09SRDEgb2YgSkVERUMgQmFzaWMgRmxhc2ggUGFyYW1ldGVyIEhl
YWRlcgo+PiBpcyAweGZmZjkyMGU1LiBTbyB0aGUgRFdPUkQxWzE4OjE3XSBBZGRyZXNzIEJ5dGVz
IGJpdHMgYXJlIDBiMDAsCj4+IG1lYW5zIHRoYXQgMy1CeXRlIG9ubHkgYWRkcmVzc2luZy4KPgo+
QWNjb3JkaW5nIHRvIHlvdXIgb3RoZXIgcGF0Y2ggdGhpcyBOT1Igc3VwcG9ydHMgNEIgb3Bjb2Rl
LCB3aGljaCBtZWFucwo+dGhlIFNGRFAgdGFibGUgaXMgd3JvbmcuCj4KPj4gQnV0IHRoZSBkZXZp
Y2Ugc2l6ZSBpcyBsYXJnZXIKPj4gdGhhbiAxNk1CLCBub3ItPmFkZHJfd2lkdGggbXVzdCBiZSA0
IHRvIGFjY2VzcyB0aGUgd2hvbGUgYWRkcmVzcy4KPj4gQW4gZXJyb3Igc2hvdWxkIGJlIHJldHVy
bmVkIHdoZW4gbm9yLT5hZGRyX3dpZHRoIG5vdCBtYXRjaAo+Cj4JCQkJCQkgICBeZG9lcyBub3QK
Pgo+PiB0aGUgZGV2aWNlIHNpemUgaW4gc3BpX25vcl9wYXJzZV9zZmRwKCkuCj4+IAo+PiBTdWdn
ZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPgo+
PiBTaWduZWQtb2ZmLWJ5OiBMaXUgWGlhbmcgPGxpdS54aWFuZzZAenRlLmNvbS5jbj4KPj4gLS0t
Cj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDQgKysrKwo+PiAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMKPj4gaW5kZXgg
M2ViYTEzYS4uNzdlYWYyMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGkt
bm9yLmMKPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMKPj4gQEAgLTI2Njks
NiArMjY2OSwxMCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25v
ciAqbm9yLAo+PiAgCX0KPj4gIAlwYXJhbXMtPnNpemUgPj49IDM7IC8qIENvbnZlcnQgdG8gYnl0
ZXMuICovCj4+ICAKPj4gKwkvKmlmIHRoZSBkZXZpY2UgZXhjZWVkcyAxNk1pQiwgYWRkcl93aWR0
aCBtdXN0IGJlIDQqLwo+Cj5QbGVhc2UgYWRkIGEgd2hpdGUgc3BhY2UgYWZ0ZXIgJy8qJyBhbmQg
YmVmb3JlICcqLyc6Cj4KPgkvKiBJZiB0aGUgZGV2aWNlIGV4Y2VlZHMgMTZNaUIsIC0+YWRkcl93
aWR0aCBtdXN0IGJlIDQuICovCj4KPj4gKwlpZiAoKHBhcmFtcy0+c2l6ZSA+IDB4MTAwMDAwMCkg
JiYgKG5vci0+YWRkcl93aWR0aCA9PSAzKSkKPgo+UGFyZW5zIGFyZSBub3QgbmVlZGVkIGFyb3Vu
ZCBzdWItY29uZGl0aW9uczoKPgo+CWlmIChwYXJhbXMtPnNpemUgPiAweDEwMDAwMDAgJiYgbm9y
LT5hZGRyX3dpZHRoID09IDMpCj4KPj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPgo+SSdtIG5v
dCBzdXJlIHRoaXMgaXMgY29ycmVjdC4gTG9va3MgbGlrZSBzb21lIE5PUnMgb25seSBzdXBwb3J0
IDNCCj5vcGNvZGVzIGJ1dCBoYXZlIGEgIjQtYnl0ZSBhZGRyZXNzaW5nIiBtb2RlIChzZWUgc2V0
XzRieXRlKCkgWzFdKS4KPkRvbid0IGtub3cgd2hhdCdzIHJlcG9ydGVkIGJ5IHRoZSBCRlBUIHNl
Y3Rpb24gaW4gdGhpcyBjYXNlIHRob3VnaAo+KEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19P
TkxZIG9yIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19PUl80KS4KPgo+QW55d2F5LCBJIHRo
aW5rIHRoaXMgY2hlY2sgc2hvdWxkIGJlIG1vdmVkIGhlcmUgWzJdIHRvIGNvdmVyIHRoZQo+bm9u
LVNGRFAgY2FzZS4KPgo+PiAgCS8qIEZhc3QgUmVhZCBzZXR0aW5ncy4gKi8KPj4gIAlmb3IgKGkg
PSAwOyBpIDwgQVJSQVlfU0laRShzZmRwX2JmcHRfcmVhZHMpOyBpKyspIHsKPj4gIAkJY29uc3Qg
c3RydWN0IHNmZHBfYmZwdF9yZWFkICpyZCA9ICZzZmRwX2JmcHRfcmVhZHNbaV07Cj4KPlsxXWh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y0LjIwLXJjMi9zb3VyY2UvZHJpdmVycy9t
dGQvc3BpLW5vci9zcGktbm9yLmMjTDI3OAo+WzJdaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvdjQuMjAtcmMyL3NvdXJjZS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyNMMzc1
OAo=
