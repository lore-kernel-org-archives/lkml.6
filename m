Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0BDC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6FC20856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6FC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=xiaomi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeJ0RdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 13:33:19 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.126]:63438 "EHLO
        outboundhk.mxmail.xiaomi.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbeJ0RdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 13:33:19 -0400
X-AuditID: 0a3808ce-4c9ff70000012663-6f-5bd4276bb7cd
Received: from xiaomi.com (cnbox4.mioffice.cn [10.237.8.144])
        by outboundhk.mxmail.xiaomi.com (xiaomi.com) with SMTP id 89.8D.09827.B6724DB5; Sat, 27 Oct 2018 16:52:59 +0800 (HKT)
Received: from CNBOX2.mioffice.cn (10.237.8.142) by cnbox4.mioffice.cn
 (10.237.8.144) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Sat, 27 Oct
 2018 16:52:58 +0800
Received: from CNBOX2.mioffice.cn ([fe80::212f:6b18:4f64:d874]) by
 cnbox2.mioffice.cn ([fe80::212f:6b18:4f64:d874%20]) with mapi id
 15.00.1365.000; Sat, 27 Oct 2018 16:52:58 +0800
From:   =?gb2312?B?UGVuZzE1IFdhbmcgzfXF9A==?= <wangpeng15@xiaomi.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pstore: Remove duplicate invoking of persistent_ram_zap()
Thread-Topic: [PATCH] pstore: Remove duplicate invoking of
 persistent_ram_zap()
Thread-Index: AQHUbN0v5C0yQ2LlqUewhVi3HkXRxKUwwToAgAIEa+o=
Date:   Sat, 27 Oct 2018 08:52:58 +0000
Message-ID: <1540630374669.30217@xiaomi.com>
References: <1540525277916.97809@xiaomi.com>,<CAGXu5jJtwLgrMVvXR+C8oSKPus+iVdYsYn4Q2+8FjRbgpL+jNA@mail.gmail.com>
In-Reply-To: <CAGXu5jJtwLgrMVvXR+C8oSKPus+iVdYsYn4Q2+8FjRbgpL+jNA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.91.193]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXC9ZZjgm62+pVog8XX1C0ObtW02L7xG6vF
        me5ci8u75rBZvLlwj8WB1WPb7m2sHrMbLrJ4TOj/xOixeM9LJo/Pm+QCWKO4bFJSczLLUov0
        7RK4Mm6t3M1c8EO04szOfYwNjBtEuxg5OCQETCQ2TfTvYuTiEBLYyigxp3UhI4SzilHi3ZpJ
        TBDOdkaJS6vPADmcHGwCzhLr35xmBLFFBFQlvl9qZgYpYhY4wiix6s4DZpCEsICfxJRFl1gh
        igIlPqyZDGVbSfycugbMZgFq3vblKwuIzSugI/Fvyiw2EFtIoFBi9os/YMs4gXpf35wEZjMK
        yEpcbdkGVsMsIC5x68l8sLiEgIDEkj3nmSFsUYmXj/+xQtgGEluX7mOBsBUlpi+7D9WrJTGv
        4TcThK0oMaX7ITvEDYISJ2c+YZnAKD4LyYpZSFpmIWmZhaRlASPLKkbJjPy89GwgLi5IzDXU
        y83MT0vLTE7VS87bxAiKTAuOczsYJ7xLPcQowMGoxMPLYHU5Wog1say4MvcQowQHs5II76LL
        QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Bo0HooUE0hNLUrNTUwtSi2CyTBycUg2Mmyszdj1Y
        cuTHBEtRc6Ft3Rkrco3WsZ3xamkwsHJ5YXKnJvSfUd3SJXFlLzSP8ZhlHvKJvSMeFG+/bOn9
        iEXF+4tYMoKObZr79N+KKXW+h1NPNS1Y+bY35JT/y6VtAnMZn6fyPTtsVdFfVJZTsVXj9b0l
        UmmV64K2bzEQnJBvUF69wE9VwHGTEktxRqKhFnNRcSIAXMDZPsgCAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5Gcm9tOiBLZWVzIENv
b2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4KPlNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNiwgMjAx
OCAxNzo0NAo+VG86IFBlbmcxNSBXYW5nIM31xfQKPkNjOiBhbnRvbkBlbm9tc2cub3JnOyBjY3Jv
c3NAYW5kcm9pZC5jb207IHRvbnkubHVja0BpbnRlbC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcKPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBzdG9yZTogUmVtb3ZlIGR1cGxpY2F0ZSBp
bnZva2luZyBvZiBwZXJzaXN0ZW50X3JhbV96YXAoKQoKPk9uIEZyaSwgT2N0IDI2LCAyMDE4IGF0
IDQ6NDEgQU0sIFBlbmcxNSBXYW5nIM31xfQgPHdhbmdwZW5nMTVAeGlhb21pLmNvbT4gd3JvdGU6
Cj4+IEZyb206IFBlbmcgV2FuZyA8d2FuZ3BlbmcxNUB4aWFvbWkuY29tPgo+Pgo+PiBXaGVuIGlu
aXRpYWxpbmcgcHJ6cyB3aXRoIGludmFsaWQgZGF0YSBpbiBidWZmZXIobm8gUEVSU0lTVEVOVF9S
QU1fU0lHKSwKPj4gZnVuY3Rpb24gY2FsbCBwYXRoIGlzIGxpa2UgdGhpczoKPj4KPj4gcmFtb29w
c19pbml0X3ByeiAtPgo+PiB8Cj4+IHwtPiBwZXJzaXN0ZW50X3JhbV9uZXcgLT4gcGVyc2lzdGVu
dF9yYW1fcG9zdF9pbml0IC0+IHBlcnNpc3RlbnRfcmFtX3phcAo+PiB8Cj4+IHwtLT4gcGVyc2lz
dGVudF9yYW1femFwCj4KPlRoZXJlIGRvZXMgYXBwZWFyIHRvIGJlIGEgZHVwbGljYXRlIGNhbGwg
dG8gcGVyc2lzdGVudF9yYW1femFwKCkgaW4gdGhpcyBjYXNlLgo+Cj4+IEFzIHdlIGNhbiBzZWUs
IHBlcnNpc3RlbnRfcmFtX3phcCgpIGlzIGNhbGxlZCB0d2ljZS4KPj4gV2UgY2FuIGF2b2lkIHRo
aXMgYnkgcmVtb3ZpbmcgaXQgaW4gcmFtb29wc19pbml0X3ByeigpLAo+PmFuZCBvbmx5IGNhbGwg
aXQgaW4gcGVyc2lzdGVudF9yYW1fcG9zdF9pbml0KCkuCj4KPkhvd2V2ZXIsIEkgdGhpbmsgdGhl
IHByb3Bvc2VkIGZpeCBkb2Vzbid0IHdvcmsgdGhlIHdheSBpdCBzaG91bGQuCj4KPlRoZXJlIGFy
ZSB0d28gcHJ6IGluaXQgcGF0aHM6IHJhbW9vcHNfaW5pdF9wcnooKSAoYSBzaW5nbGUgcHJ6KSBh
bmQKPnJhbW9vcHNfaW5pdF9wcnpzIChtdWx0aXBsZSBwcnpzKS4gVGhlICJkdW1wIiBhbmQgImZ0
cmFjZSIgY2FzZXMgdXNlCj50aGUgbGF0dGVyLiBJbiB0aG9zZSwgdGhlcmUgaXMgbm8gY2FsbCB0
byBwZXJzaXN0ZW50X3JhbV96YXAoKSBpZiB0aGUKPmJ1ZmZlciBpcyB2YWxpZC4KPgo+SW4gb3Ro
ZXIgd29yZHM6Cj4KPnJhbW9vcHNfaW5pdF9wcnooKSB1bmNvbmRpdGlvbmFsbHkgY2FsbHMgcGVy
c2lzdGVudF9yYW1femFwKCkuIChBbmQKPm1heSBjYWxsIGl0IHR3aWNlIGlmIHRoZXJlIGlzIGEg
bWlzbWF0Y2ggb2YgdGhlIG1hZ2ljIGhlYWRlci4pCj4KPnJhbW9vcHNfaW5pdF9wcnpzKCkgb25s
eSBjYWxscyBwZXJzaXN0ZW50X3JhbV96YXAoKSB3aGVuIHRoZSBtYWdpYwo+aGVhZGVyIGlzIHdy
b25nLgo+Cj5UaGUgcHJvcG9zZWQgcGF0Y2ggdW5jb25kaXRpb25hbGx5IHphcHMgYWxsIHJlZ2lv
bnMsIHdoaWNoIG1lYW5zIHdlJ2QKPmxvc2UgImR1bXAiIGFuZCAiZnRyYWNlIiBhY3Jvc3MgdGhl
IG5leHQgcmVib290Lgo+Cj5QZXJoYXBzIHdlIGNvdWxkIG1ha2UgaXQgYW4gb3B0aW9uIHRvIHBl
cnNpc3RlbnRfcmFtX25ldygpPwo+Cj4tLQo+S2VlcyBDb29rCgpUaGFua3MgZm9yIHlvdXIgcmVw
bHkuIAoKWW91IGFyZSByaWdodCwgdGhpcyBwYXRjaCBkb2VzIHphcCByZWdpb25zIHVuY29uZGl0
aW9uYWxseSB3aGVuIGl0IGNvbWVzIHRvICJkdW1wIiBhbmQKImZ0cmFjZSIuIFNvcnJ5IGZvciB0
aGUgaW5jb252ZW5pZW5jZSBvd2luZyB0byBteSBwcmV2aW91cyBtaXN0YWtlLgoKSSBoYXZlIHRy
aWVkIGFkZGluZyBhbiBvcHRpb24gdG8gcGVyc2lzdGVudF9yYW1fbmV3KCkgYWNjb3JkaW5nIHRv
IHlvdXIgYWR2aWNlIGFuZCB3aWxsIHNlbmQKYSBWMiB2ZXJzaW9uIHBhdGNoIGxhdGVyLiBDb3Vs
ZCB5b3UgcGxlYXNlIGtpbmRseSBwYXkgYW55IGF0dGVudGlvbiB0byBpdD8gVGhhbmsgeW91IQo=
