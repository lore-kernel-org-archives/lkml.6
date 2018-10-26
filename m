Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BF3ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8882082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 03:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8882082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=xiaomi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeJZMUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 08:20:43 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.126]:61816 "EHLO
        outboundhk.mxmail.xiaomi.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbeJZMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 08:20:43 -0400
X-AuditID: 0a3808ce-4afff70000012663-2e-5bd28cec1576
Received: from xiaomi.com (cnbox3.mioffice.cn [10.237.8.143])
        by outboundhk.mxmail.xiaomi.com (xiaomi.com) with SMTP id F4.3E.09827.CEC82DB5; Fri, 26 Oct 2018 11:41:32 +0800 (HKT)
Received: from CNBOX2.mioffice.cn (10.237.8.142) by cnbox3.mioffice.cn
 (10.237.8.143) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 26 Oct
 2018 11:41:21 +0800
Received: from CNBOX2.mioffice.cn ([fe80::212f:6b18:4f64:d874]) by
 cnbox2.mioffice.cn ([fe80::212f:6b18:4f64:d874%20]) with mapi id
 15.00.1365.000; Fri, 26 Oct 2018 11:41:20 +0800
From:   =?gb2312?B?UGVuZzE1IFdhbmcgzfXF9A==?= <wangpeng15@xiaomi.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] pstore: Remove duplicate invoking of persistent_ram_zap()
Thread-Topic: [PATCH] pstore: Remove duplicate invoking of
 persistent_ram_zap()
Thread-Index: AQHUbN0v5C0yQ2LlqUewhVi3HkXRxA==
Date:   Fri, 26 Oct 2018 03:41:20 +0000
Message-ID: <1540525277916.97809@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.91.193]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsXC9ZajX/dNz6Vog/M7rC0ObtW02L7xG6vF
        me5ci8u75rBZvLlwj8WB1WPb7m2sHrMbLrJ4TOj/xOixeM9LJo/Pm+QCWKO4bFJSczLLUov0
        7RK4Ms584SlYJVCxf/VB9gbGL/xdjJwcEgImEic/LWTtYuTiEBLYyihxacUyZpCEkMAqRokH
        1yIgEtsZJb5ObWUCSbAJOEusf3OaESQhIrCNUWLCunVgHcwCjhK3974FKxIW8JKY/e8kK4gt
        IhAo8WHNZChbT+LKug6wGhYBVYmpb26zg9i8AjoSjatXgdmMArIS0x7dZ4KYKS4xd9osVohT
        BSSW7DnPDGGLSrx8/A8qbiCxdek+FghbUWL6svtsEL1aEvMafkPNUZSY0v0QapegxMmZT1gm
        MIrOQrJiFpKWWUhaZiFpWcDIsopRMiM/Lz0biIsLEnMN9XIz89PSMpNT9ZLzNjGC4syC49wO
        xgnvUg8xCnAwKvHwTvh2MVqINbGsuDL3EKMEB7OSCO/e20Ah3pTEyqrUovz4otKc1OJDjNIc
        LErivAaNB6KFBNITS1KzU1MLUotgskwcnFINjDdnrhBc+VHAzKTspAnj/7jCJ2E8W8NnP71W
        IfcpdkUR9+ctp36zfO1+mTTtnPvLKWXi3jc/Ht8pOavbRut+4YtZiU/vHqroPLLY6WrI9doi
        gdjpVpq9HzqbjuWqXLi3q/nP09MSH1fZrfDVkWyQ0Fkum3ZYSv4Vu0Jhe2vcz8LyG7mST5rL
        1JRYijMSDbWYi4oTAZ6xfnyvAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGVuZyBXYW5nIDx3YW5ncGVuZzE1QHhpYW9taS5jb20+CgpXaGVuIGluaXRpYWxpbmcg
cHJ6cyB3aXRoIGludmFsaWQgZGF0YSBpbiBidWZmZXIobm8gUEVSU0lTVEVOVF9SQU1fU0lHKSwK
ZnVuY3Rpb24gY2FsbCBwYXRoIGlzIGxpa2UgdGhpczoKCnJhbW9vcHNfaW5pdF9wcnogLT4KfAp8
LT4gcGVyc2lzdGVudF9yYW1fbmV3IC0+IHBlcnNpc3RlbnRfcmFtX3Bvc3RfaW5pdCAtPiBwZXJz
aXN0ZW50X3JhbV96YXAKfAp8LS0+IHBlcnNpc3RlbnRfcmFtX3phcAoKQXMgd2UgY2FuIHNlZSwg
cGVyc2lzdGVudF9yYW1femFwKCkgaXMgY2FsbGVkIHR3aWNlLgpXZSBjYW4gYXZvaWQgdGhpcyBi
eSByZW1vdmluZyBpdCBpbiByYW1vb3BzX2luaXRfcHJ6KCksCmFuZCBvbmx5IGNhbGwgaXQgaW4g
cGVyc2lzdGVudF9yYW1fcG9zdF9pbml0KCkuCgpTaWduZWQtb2ZmLWJ5OiBQZW5nIFdhbmcgPHdh
bmdwZW5nMTVAeGlhb21pLmNvbT4KLS0tCiBmcy9wc3RvcmUvcmFtLmMgICAgICB8IDIgLS0KIGZz
L3BzdG9yZS9yYW1fY29yZS5jIHwgMyArLS0KIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvcHN0b3JlL3JhbS5jIGIvZnMvcHN0
b3JlL3JhbS5jCmluZGV4IGZmY2ZmNjUxNmU4OS4uM2Y1NzA3NGE0ZmFiIDEwMDY0NAotLS0gYS9m
cy9wc3RvcmUvcmFtLmMKKysrIGIvZnMvcHN0b3JlL3JhbS5jCkBAIC02NDksOCArNjQ5LDYgQEAg
c3RhdGljIGludCByYW1vb3BzX2luaXRfcHJ6KGNvbnN0IGNoYXIgKm5hbWUsCiAJCXJldHVybiBl
cnI7CiAJfQogCi0JcGVyc2lzdGVudF9yYW1femFwKCpwcnopOwotCiAJKnBhZGRyICs9IHN6Owog
CiAJcmV0dXJuIDA7CmRpZmYgLS1naXQgYS9mcy9wc3RvcmUvcmFtX2NvcmUuYyBiL2ZzL3BzdG9y
ZS9yYW1fY29yZS5jCmluZGV4IDEyZTIxZjc4OTE5NC4uM2VmMGZkNWE3Y2Q1IDEwMDY0NAotLS0g
YS9mcy9wc3RvcmUvcmFtX2NvcmUuYworKysgYi9mcy9wc3RvcmUvcmFtX2NvcmUuYwpAQCAtNTA1
LDE1ICs1MDUsMTQgQEAgc3RhdGljIGludCBwZXJzaXN0ZW50X3JhbV9wb3N0X2luaXQoc3RydWN0
IHBlcnNpc3RlbnRfcmFtX3pvbmUgKnByeiwgdTMyIHNpZywKIAkJCXByX2RlYnVnKCJmb3VuZCBl
eGlzdGluZyBidWZmZXIsIHNpemUgJXp1LCBzdGFydCAlenVcbiIsCiAJCQkJIGJ1ZmZlcl9zaXpl
KHByeiksIGJ1ZmZlcl9zdGFydChwcnopKTsKIAkJCXBlcnNpc3RlbnRfcmFtX3NhdmVfb2xkKHBy
eik7Ci0JCQlyZXR1cm4gMDsKIAkJfQogCX0gZWxzZSB7CiAJCXByX2RlYnVnKCJubyB2YWxpZCBk
YXRhIGluIGJ1ZmZlciAoc2lnID0gMHglMDh4KVxuIiwKIAkJCSBwcnotPmJ1ZmZlci0+c2lnKTsK
KwkJcHJ6LT5idWZmZXItPnNpZyA9IHNpZzsKIAl9CiAKIAkvKiBSZXdpbmQgbWlzc2luZyBvciBp
bnZhbGlkIG1lbW9yeSBhcmVhLiAqLwotCXByei0+YnVmZmVyLT5zaWcgPSBzaWc7CiAJcGVyc2lz
dGVudF9yYW1femFwKHByeik7CiAKIAlyZXR1cm4gMDsKLS0gCjIuMTkuMQoK
