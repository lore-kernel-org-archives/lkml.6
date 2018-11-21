Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C205D20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C205D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thalesgroup.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeKUSXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:23:45 -0500
Received: from thsbbfxrt01p.thalesgroup.com ([192.54.144.131]:37334 "EHLO
        thsbbfxrt01p.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728144AbeKUSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:23:45 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 13:23:43 EST
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 430Dzm6b7Mz8Tc;
        Wed, 21 Nov 2018 08:41:56 +0100 (CET)
From:   JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: dw_mmc: IDMAC Invalidate cache after read
Thread-Topic: dw_mmc: IDMAC Invalidate cache after read
Thread-Index: AQHUgW3NJS3s6fdIZ0u0s1IZXxrnfg==
Date:   Wed, 21 Nov 2018 07:42:49 +0000
Message-ID: <1542786115.18775.83.camel@atviedlbe741.rss.d3s.at.thales>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.10.4-0ubuntu2 
x-originating-ip: [10.177.70.241]
x-pmwin-version: 4.0.3, Antivirus-Engine: 3.73.0, Antivirus-Data: 5.57
Content-Type: text/plain; charset="utf-8"
Content-ID: <447A5C5E3632EB419ED9A2822D0C5505@iris.infra.thales>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q1BVIG1heSBub3Qgc2VlIG1vc3QgdXAtdG8tZGF0ZSBhbmQgY29ycmVjdCBjb3B5IG9mIERNQSBi
dWZmZXIsIHdoZW4NCmludGVybmFsIERNQSBjb250cm9sbGVyIGlzIGluIHVzZS4NClByb2JsZW0g
YXBwZWFycyBvbiBUaGUgQWx0ZXJhIFNvQyBGUEdBICh1c2VzIGludGVncmF0ZWQgRE1BIGNvbnRy
b2xsZXIpLA0KZHVyaW5nIGhpZ2hlciBDUFUgYW5kIHN5c3RlbSBtZW1vcnkgbG9hZA0KDQpTaWdu
ZWQtb2ZmLWJ5OiBKYW4gSmFibG9uc2t5IDxqYW4uamFibG9uc2t5QHRoYWxlc2dyb3VwLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLmMgfCAzICstLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2hvc3QvZHdfbW1jLmMgYi9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jDQppbmRleCA4MGRj
MmZkLi42Mzg3M2Q5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYw0KKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYw0KQEAgLTQ5OSw4ICs0OTksNyBAQCBzdGF0aWMg
dm9pZCBkd19tY2lfZG1hY19jb21wbGV0ZV9kbWEodm9pZCAqYXJnKQ0KIA0KIAlkZXZfdmRiZyho
b3N0LT5kZXYsICJETUEgY29tcGxldGVcbiIpOw0KIA0KLQlpZiAoKGhvc3QtPnVzZV9kbWEgPT0g
VFJBTlNfTU9ERV9FRE1BQykgJiYNCi0JICAgIGRhdGEgJiYgKGRhdGEtPmZsYWdzICYgTU1DX0RB
VEFfUkVBRCkpDQorCWlmIChkYXRhICYmIChkYXRhLT5mbGFncyAmIE1NQ19EQVRBX1JFQUQpKQ0K
IAkJLyogSW52YWxpZGF0ZSBjYWNoZSBhZnRlciByZWFkICovDQogCQlkbWFfc3luY19zZ19mb3Jf
Y3B1KG1tY19kZXYoaG9zdC0+c2xvdC0+bW1jKSwNCiAJCQkJICAgIGRhdGEtPnNnLA0K
