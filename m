Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89232C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D622087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="HDhenEiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D622087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeKPXhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:37:41 -0500
Received: from m15-41.126.com ([220.181.15.41]:33999 "EHLO m15-41.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeKPXhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=gWTc9
        8paPWlnLOtE6mVk0Ef68WlXtYlVMgv0OrCf63Q=; b=HDhenEiCFCpErcr3KmDDR
        A1a46hA69S6mK3ljY12vwSNwAJ4e0arBLm2Ed/1FmHy4pNZD8vCPttRN7eZ3XR6m
        XHWlNRqBSH7ioallCi6f4kPkbnpnwX+CA5t1dchxmByo8d9tjaDC/YPLgwKJn3nF
        jUwrByws4geP8Mt1ngBzD4=
Received: from liuxiang_1999$126.com ( [222.209.16.97] ) by
 ajax-webmail-wmsvr41 (Coremail) ; Fri, 16 Nov 2018 21:24:10 +0800 (CST)
X-Originating-IP: [222.209.16.97]
Date:   Fri, 16 Nov 2018 21:24:10 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "Boris Brezillon" <boris.brezillon@bootlin.com>
Cc:     Tudor.Ambarus@microchip.com, liu.xiang6@zte.com.cn,
        cyrille.pitchen@wedev4u.fr, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at
Subject: Re:Re: [PATCH] mtd: spi-nor: Return error when nor->addr_width not
 match the device size
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
In-Reply-To: <20181115120256.4e1a86b2@bbrezillon>
References: <1542200165-3073-1-git-send-email-liu.xiang6@zte.com.cn>
 <20181114145129.568e4bb3@bbrezillon>
 <96397ec0-14de-f09a-a18d-c67396e33fba@microchip.com>
 <20181115120256.4e1a86b2@bbrezillon>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <55597875.b295.1671cb170cb.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: KcqowABnVfn7xO5bAeKTAQ--.23688W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiqBsBsFpD6YjDzwAAs2
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpIFR1ZG9yLCBCb3JpcywgQ3lyaWxsZSwKVGhlcmUgaXMgbm8gSkVERUMgQkZQVCB0YWJsZXMg
aW4gdGhlIGRhdGFzaGVldC4gCkluIG15IHRlc3QgcGxhdGZvcm0sIEkgc2VudCBSRFNGRFAgY29t
bWFuZCB0byB0aGUgZmxhc2ggYW5kIGdvdCB0aGUKcGFyYW1ldGVycyBiYWNrLgpNeSBkZXZpY2Ug
dHlwZSBpcyBJUzI1TFAyNTZELUpNTEEsIHdoaWNoIGlzIG5vdCBpbiBIL0UvRy9GIHNlcmllcyBv
ZiBmbGFzaAp0aGF0IGlzIGRlc2NyaWJlZCBpbiBjaGFwdGVyIDExIG9mIHRoZSBkYXRhc2hlZXQu
IFRoZSByZXBseSBmcm9tIElTU0kgIHN1Z2dlc3RzCm9ubHkgdGhlc2UgY2VydGFpbiBkZXZpY2Vz
IGNhbiBzdXBwb3J0IFNGRFAgdGFibGUuCkkgYW0gY29uZnVzZWQgd2h5IG15IGRldmljZSBjYW4g
c3VwcG9ydCBSRFNGRFAgY29tbWFuZCBhbmQgZ2l2ZSAKcGFyYW1ldGVycyBiYWNrLiBJIHdpbGwg
YXNrIElTU0kgZm9yIG1vcmUgZGV0YWlscy4KCgoKQXQgMjAxOC0xMS0xNSAxOTowMjo1NiwgIkJv
cmlzIEJyZXppbGxvbiIgPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT4gd3JvdGU6Cj5PbiBU
aHUsIDE1IE5vdiAyMDE4IDEwOjU0OjM5ICswMDAwCj48VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPiB3cm90ZToKPgo+PiBIaSwgTGl1LCBCb3JpcywgQ3lyaWxsZSwKPj4gCj4+IE9uIDExLzE0
LzIwMTggMDM6NTEgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToKPj4gPiBPbiBXZWQsIDE0IE5v
diAyMDE4IDIwOjU2OjA1ICswODAwCj4+ID4gTGl1IFhpYW5nIDxsaXUueGlhbmc2QHp0ZS5jb20u
Y24+IHdyb3RlOgo+PiA+ICAgCj4+ID4+IEluIGlzMjVscDI1NiwgdGhlIERXT1JEMSBvZiBKRURF
QyBCYXNpYyBGbGFzaCBQYXJhbWV0ZXIgSGVhZGVyCj4+ID4+IGlzIDB4ZmZmOTIwZTUuIFNvIHRo
ZSBEV09SRDFbMTg6MTddIEFkZHJlc3MgQnl0ZXMgYml0cyBhcmUgMGIwMCwgIAo+PiAKPj4gTGl1
LCBjYW4geW91IHBvaW50IHVzIHRvIGEgZGF0YXNoZWV0IHRoYXQgaGFzIHRoZSBKRURFQyBCRlBU
IHRhYmxlcyBkZXNjcmliZWQ/IEkKPj4gY291bGRuJ3QgZmluZCBvbmUgLi4uCj4+IAo+PiA+PiBt
ZWFucyB0aGF0IDMtQnl0ZSBvbmx5IGFkZHJlc3NpbmcuICAKPj4gPiAKPj4gPiBBY2NvcmRpbmcg
dG8geW91ciBvdGhlciBwYXRjaCB0aGlzIE5PUiBzdXBwb3J0cyA0QiBvcGNvZGUsIHdoaWNoIG1l
YW5zCj4+ID4gdGhlIFNGRFAgdGFibGUgaXMgd3JvbmcuCj4+ID4gICAKPj4gPj4gQnV0IHRoZSBk
ZXZpY2Ugc2l6ZSBpcyBsYXJnZXIKPj4gPj4gdGhhbiAxNk1CLCBub3ItPmFkZHJfd2lkdGggbXVz
dCBiZSA0IHRvIGFjY2VzcyB0aGUgd2hvbGUgYWRkcmVzcy4KPj4gPj4gQW4gZXJyb3Igc2hvdWxk
IGJlIHJldHVybmVkIHdoZW4gbm9yLT5hZGRyX3dpZHRoIG5vdCBtYXRjaCAgCj4+ID4gCj4+ID4g
CQkJCQkJICAgXmRvZXMgbm90Cj4+ID4gICAKPj4gPj4gdGhlIGRldmljZSBzaXplIGluIHNwaV9u
b3JfcGFyc2Vfc2ZkcCgpLgo+PiA+Pgo+PiA+PiBTdWdnZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxv
biA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPgo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBMaXUg
WGlhbmcgPGxpdS54aWFuZzZAenRlLmNvbS5jbj4KPj4gPj4gLS0tCj4+ID4+ICBkcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDQgKysrKwo+PiA+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQo+PiA+Pgo+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9z
cGktbm9yLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYwo+PiA+PiBpbmRleCAzZWJh
MTNhLi43N2VhZjIyIDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1u
b3IuYwo+PiA+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYwo+PiA+PiBAQCAt
MjY2OSw2ICsyNjY5LDEwIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9wYXJzZV9iZnB0KHN0cnVjdCBz
cGlfbm9yICpub3IsCj4+ID4+ICAJfQo+PiA+PiAgCXBhcmFtcy0+c2l6ZSA+Pj0gMzsgLyogQ29u
dmVydCB0byBieXRlcy4gKi8KPj4gPj4gIAo+PiA+PiArCS8qaWYgdGhlIGRldmljZSBleGNlZWRz
IDE2TWlCLCBhZGRyX3dpZHRoIG11c3QgYmUgNCovICAKPj4gPiAKPj4gPiBQbGVhc2UgYWRkIGEg
d2hpdGUgc3BhY2UgYWZ0ZXIgJy8qJyBhbmQgYmVmb3JlICcqLyc6Cj4+ID4gCj4+ID4gCS8qIElm
IHRoZSBkZXZpY2UgZXhjZWVkcyAxNk1pQiwgLT5hZGRyX3dpZHRoIG11c3QgYmUgNC4gKi8KPj4g
PiAgIAo+PiA+PiArCWlmICgocGFyYW1zLT5zaXplID4gMHgxMDAwMDAwKSAmJiAobm9yLT5hZGRy
X3dpZHRoID09IDMpKSAgCj4+ID4gCj4+ID4gUGFyZW5zIGFyZSBub3QgbmVlZGVkIGFyb3VuZCBz
dWItY29uZGl0aW9uczoKPj4gPiAKPj4gPiAJaWYgKHBhcmFtcy0+c2l6ZSA+IDB4MTAwMDAwMCAm
JiBub3ItPmFkZHJfd2lkdGggPT0gMykKPj4gPiAgIAo+PiA+PiArCQlyZXR1cm4gLUVJTlZBTDsK
Pj4gPj4gKyAgCj4+ID4gCj4+ID4gSSdtIG5vdCBzdXJlIHRoaXMgaXMgY29ycmVjdC4gTG9va3Mg
bGlrZSBzb21lIE5PUnMgb25seSBzdXBwb3J0IDNCCj4+ID4gb3Bjb2RlcyBidXQgaGF2ZSBhICI0
LWJ5dGUgYWRkcmVzc2luZyIgbW9kZSAoc2VlIHNldF80Ynl0ZSgpIFsxXSkuCj4+ID4gRG9uJ3Qg
a25vdyB3aGF0J3MgcmVwb3J0ZWQgYnkgdGhlIEJGUFQgc2VjdGlvbiBpbiB0aGlzIGNhc2UgdGhv
dWdoCj4+ID4gKEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19PTkxZIG9yIEJGUFRfRFdPUkQx
X0FERFJFU1NfQllURVNfM19PUl80KS4gIAo+PiAKPj4gQm9yaXMsIHRoaXMgaXMgaW4gY2xvc2Ug
cmVsYXRpb24gd2l0aCB5b3VyIHNlY29uZCBwYXRjaDogW1BBVENIIHYzIDIvMl0gbXRkOgo+PiBz
cGktbm9yOiBVc2UgNEIgb3Bjb2RlcyB3aGVuIHRoZSBOT1IgYWR2ZXJ0aXNlcyBib3RoIDNCIGFu
ZCA0Qi4KPj4gCj4+IFdoZW4gbG9va2luZyBhZ2FpbiBhdCB0aGlzLCBJIHdvdWxkIHNheSB0aGF0
IGZvciB0aGUgZmxhc2hlcyB0aGF0IGhhdmUgYSAiNC1ieXRlCj4+IGFkZHJlc3NpbmciIG1vZGUs
IGJ1dCBqdXN0IDNCIG9wY29kZXMsIEkgd291bGQgZXhwZWN0IHRoZSBEV09SRDFbMTg6MTddIHRv
IGJlIG9mCj4+IHZhbHVlIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19PUl80IChlbnRlcnMg
NC1CeXRlIG1vZGUgb24gY29tbWFuZCAtIHVzZXMgM0IKPj4gb3Bjb2RlcykuCj4KPlRoZSBOT1Ig
d2UgaGF2ZSBhbmQgd2hpY2ggaXMgZXhwb3NpbmcgQkZQVF9EV09SRDFfQUREUkVTU19CWVRFU18z
X09SXzQKPmFjdHVhbGx5IHN1cHBvcnRzIGJvdGggM0IgYW5kIDRCIGNvbW1hbmRzLCBzbywgaW4g
dGhpcyBwYXJ0aWN1bGFyIGNhc2UsCj5CRlBUX0RXT1JEMV9BRERSRVNTX0JZVEVTXzNfT1JfNCBk
b2VzIG5vdCBtZWFuICIzQiBvcGNvZGUrNC1ieXRlCj5hZGRyZXNzaW5nIG1vZGUiCj4KPj4gCj4+
IElmIEJGUFRfRFdPUkQxX0FERFJFU1NfQllURVNfM19PUl80IGFuZCA0QiBvcGNvZGVzLCB0aGVu
IHdlIGNhbiBxdWVyeSBCRlBUCj4+IERXT1JEMTZbMzE6MjRdOiBpdCBzaG91bGQgaGF2ZSB2YWx1
ZSB4eDF4X3h4eHhiIHRvIGluZGljYXRlIHRoYXQgNEIgb3Bjb2RlcyBhcmUKPj4gc3VwcG9ydGVk
LiBCdXQgd2hpY2ggNEIgb3Bjb2RlcyBhcmUgc3VwcG9ydGVkPwo+Cj5JIGhvcGUgYWxsIG9mIHRo
ZW0uIFdvdWxkbid0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSBvbmx5IHNvbWUgb2YgdGhlbQo+c3VwcG9y
dGVkLgo+Cj4+IERvIGFsbCAzQiBvcGNvZGVzIGhhdmUgYSA0Qgo+PiBvcGNvZGUgY29ycmVzcG9u
ZGVudCBpZiBTRkRQIDQtYnl0ZSB0YWJsZSBpcyBub3QgYXZhaWxhYmxlPyBUaGlzIG1pZ2h0IGJl
IGEgZ29vZAo+PiBhc3N1bXB0aW9uLCBidXQgSSBjYW4ndCBzZWUgaXQgYW55d2hlcmUgaW4gamVz
ZDIxNmMuCj4KPkkgaG9wZSBzby4uLgo=
