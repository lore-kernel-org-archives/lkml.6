Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B615C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B232083C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="QKGBRQpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B232083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeH1SKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:10:44 -0400
Received: from m15-35.126.com ([220.181.15.35]:9842 "EHLO m15-35.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1SKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=dZV5B
        3SdBh8DYOnzg2MPOADPwQwhdvIsF6m7T7TFhNM=; b=QKGBRQpFH1Vq14EYdXKOf
        i9Q9C6149vBfL9mznvVDSGgqZt6WPFbdrFZnjZBkvD1HmZX5oKjrnkch0DVn37Py
        EhbEVlcUJ1uEzEDeDIs7TMqSFnIHQuN62E3c4HdRWGG+K9HBKKiOvWs07sj84kWj
        R69+Kqgs4onCz9W8J7q6mA=
Received: from liuxiang_1999$126.com ( [110.184.152.116] ) by
 ajax-webmail-wmsvr35 (Coremail) ; Tue, 28 Aug 2018 22:16:08 +0800 (CST)
X-Originating-IP: [110.184.152.116]
Date:   Tue, 28 Aug 2018 22:16:08 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "Boris Brezillon" <boris.brezillon@bootlin.com>
Cc:     "Liu Xiang" <liu.xiang6@zte.com.cn>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        han.xu@nxp.com, marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at
Subject: Re:Re: [PATCH v2] mtd: spi-nor: fsl-quadspi: fix read error for
 flash size  larger than 16MB
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
In-Reply-To: <20180828152305.18df57e2@bbrezillon>
References: <1535462476-3540-1-git-send-email-liu.xiang6@zte.com.cn>
 <20180828152305.18df57e2@bbrezillon>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <749634d5.bb6a.16580e444f2.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: I8qowEBJYUMpWYVbG2FAAQ--.59302W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiZx+wsFpD6TSrfwABsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gU2hvdWxkIEkgc2VuZCBhbm90aGVyIHBhdGNo
PwoKCgoKCgoKQXQgMjAxOC0wOC0yOCAyMToyMzowNSwgIkJvcmlzIEJyZXppbGxvbiIgPGJvcmlz
LmJyZXppbGxvbkBib290bGluLmNvbT4gd3JvdGU6Cj5PbiBUdWUsIDI4IEF1ZyAyMDE4IDIxOjIx
OjE2ICswODAwCj5MaXUgWGlhbmcgPGxpdS54aWFuZzZAenRlLmNvbS5jbj4gd3JvdGU6Cj4KPj4g
SWYgdGhlIHNpemUgb2Ygc3BpLW5vciBmbGFzaCBpcyBsYXJnZXIgdGhhbiAxNk1CLCB0aGUgcmVh
ZF9vcGNvZGUKPj4gaXMgc2V0IHRvIFNQSU5PUl9PUF9SRUFEXzFfMV80XzRCLCBhbmQgZnNsX3Fz
cGlfZ2V0X3NlcWlkKCkgd2lsbAo+PiByZXR1cm4gLUVJTlZBTCB3aGVuIGNtZCBpcyBTUElOT1Jf
T1BfUkVBRF8xXzFfNF80Qi4gVGhpcyBjYW4KPj4gY2F1c2UgcmVhZCBvcGVyYXRpb24gZmFpbC4K
Pj4gCj4+IC0tLQo+PiB2MjoKPj4gICBhZGQgRml4ZXMgdGFnIGFuZCBDQyBzdGFibGUgc3VnZ2Vz
dGVkIGJ5IEJvcmlzLgo+PiAtLS0KPgo+VGhlIGFib3ZlIGNoYW5nZWxvZwo+Cj4+IAo+PiBGaXhl
czogZTQ2ZWNkYTc2NGRjICgibXRkOiBzcGktbm9yOiBBZGQgRnJlZXNjYWxlIFF1YWRTUEkgZHJp
dmVyIikKPj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+PiBTaWduZWQtb2ZmLWJ5OiBM
aXUgWGlhbmcgPGxpdS54aWFuZzZAenRlLmNvbS5jbj4KPj4gLS0tCj4KPnNob3VsZCBiZSBwbGFj
ZWQgaGVyZS4KPgo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9mc2wtcXVhZHNwaS5jIHwgMSArCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL2ZzbC1xdWFkc3BpLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2ZzbC1x
dWFkc3BpLmMKPj4gaW5kZXggN2Q5NjIwYy4uNjQzMDRhMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9mc2wtcXVhZHNwaS5jCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
ZnNsLXF1YWRzcGkuYwo+PiBAQCAtNDc4LDYgKzQ3OCw3IEBAIHN0YXRpYyBpbnQgZnNsX3FzcGlf
Z2V0X3NlcWlkKHN0cnVjdCBmc2xfcXNwaSAqcSwgdTggY21kKQo+PiAgewo+PiAgCXN3aXRjaCAo
Y21kKSB7Cj4+ICAJY2FzZSBTUElOT1JfT1BfUkVBRF8xXzFfNDoKPj4gKwljYXNlIFNQSU5PUl9P
UF9SRUFEXzFfMV80XzRCOgo+PiAgCQlyZXR1cm4gU0VRSURfUkVBRDsKPj4gIAljYXNlIFNQSU5P
Ul9PUF9XUkVOOgo+PiAgCQlyZXR1cm4gU0VRSURfV1JFTjsK
