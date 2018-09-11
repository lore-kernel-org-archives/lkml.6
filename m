Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEF820890
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EDZKHo1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEF820890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIKUZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:25:06 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57482 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKUZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:25:06 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B497410C11FC;
        Tue, 11 Sep 2018 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536679519; bh=Q8j/ymc+XmgEPv+ZkHhnsvjz+yVkOVirP8AIcWzHK+0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EDZKHo1rWUuYQCIYmERZnPCtiXZQ1yorgpjxSP57VZrK7FxmBZKjhpiPb9b86arqL
         p8rXePrRkuihtEzQDWPJMfXiAKsGN4A1nkMlF4DAFyFevdTTvgOZbXguY08/uhepjp
         M6Or14N/Pb8pTbP2fQmHKdS2vYU2OHmO0ovy5hz2Dbxe+3QuBWdQtHC0kfgtEG+FII
         DN7xHpKDb+9tIEnxEjZKxxOtIBhHFNfULMBwxxLuSMK3H0zusspSOwGz207MwF2/0j
         Q1ScC61F9JoxdpNrTTbBvFB89iNrvtY9eSFIcOLlEHSmS6gm0tkXUQpfGSsz2bmlCZ
         coe8bvE/MNjTw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 854A63372;
        Tue, 11 Sep 2018 08:25:13 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 11 Sep 2018 08:25:05 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 11 Sep 2018 17:25:03 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: HSDK: improve reset driver
Thread-Topic: [PATCH] ARC: HSDK: improve reset driver
Thread-Index: AQHUPhOUaZSCotcop0yU3vqnzO0KH6TrKYkA
Date:   Tue, 11 Sep 2018 15:25:02 +0000
Message-ID: <1536679502.5041.21.camel@synopsys.com>
References: <20180827143803.28178-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180827143803.28178-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.37]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EC5BDC439683F4A87B7FA63D2FAC791@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcCwNCg0KTWF5YmUgeW91IGhhdmUgYW55IGNvbW1lbnRzIG9yIHJlbWFya3MgYWJv
dXQgdGhpcyBwYXRjaD8gQW5kIGlmIHlvdSBkb24ndCBjb3VsZCB5b3UgcGxlYXNlIGFwcGx5IGl0
Lg0KVGhhbmtzIQ0KDQpPbiBNb24sIDIwMTgtMDgtMjcgYXQgMTc6MzggKzAzMDAsIEV1Z2VuaXkg
UGFsdHNldiB3cm90ZToNCj4gQXMgZm9yIHRvZGF5IEhTREsgcmVzZXQgZHJpdmVyIGltcGxlbWVu
dHMgb25seQ0KPiAucmVzZXQoKSBjYWxsYmFjay4NCj4gDQo+IEluIGNhc2Ugb2YgZHJpdmVyIHdo
aWNoIGltcGxlbWVudHMgb25lIG9mIHN0YW5kYXJkDQo+IHJlc2V0IGNvbnRyb2xsZXIgdXNhZ2Ug
cGF0dGVybg0KPiAoY2FsbCAqX2RlYXNzZXJ0KCkgaW4gcHJvYmUoKSwgY2FsbCAqX2Fzc2VydCgp
IGluIHJlbW92ZSgpKQ0KPiB0aGF0IGxlYWRzIHRvIGlub3BlcmFiaWxpdHkgb2YgdGhpcyByZXNl
dCBkcml2ZXIuDQo+IA0KPiBJbXByb3ZlIEhTREsgcmVzZXQgZHJpdmVyIGJ5IGNhbGxpbmcgLnJl
c2V0KCkgY2FsbGJhY2sgaW5zaWRlIG9mDQo+IC5hc3NlcnQoKS8uZGVhc3NlcnQoKSBjYWxsYmFj
a3MgdG8gYXZvaWQgZWFjaCByZXNldCBjb250cm9sbGVyDQo+IHVzZXIgYWRhcHRhdGlvbiBmb3Ig
d29yayB3aXRoIGJvdGggcmVzZXQgbWV0aG9kcw0KPiAocmVzZXQoKSBhbmQgLmFzc2VydCgpLy5k
ZWFzc2VydCgpIHBhaXIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1
Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9yZXNldC9yZXNl
dC1oc2RrLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC1oc2RrLmMgYi9kcml2ZXJzL3Jlc2V0
L3Jlc2V0LWhzZGsuYw0KPiBpbmRleCA4YmNlMzkxYzY5NDMuLjFmZDkxZGY5MTM0MyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC1oc2RrLmMNCj4gKysrIGIvZHJpdmVycy9yZXNl
dC9yZXNldC1oc2RrLmMNCj4gQEAgLTg2LDYgKzg2LDggQEAgc3RhdGljIGludCBoc2RrX3Jlc2V0
X3Jlc2V0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ICANCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcmVzZXRfY29udHJvbF9vcHMgaHNka19yZXNldF9vcHMgPSB7DQo+ICAJ
LnJlc2V0CT0gaHNka19yZXNldF9yZXNldCwNCj4gKwkuYXNzZXJ0ID0gaHNka19yZXNldF9yZXNl
dCwNCj4gKwkuZGVhc3NlcnQgPSBoc2RrX3Jlc2V0X3Jlc2V0LA0KPiAgfTsNCj4gIA0KPiAgc3Rh
dGljIGludCBoc2RrX3Jlc2V0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQot
LSANCiBFdWdlbml5IFBhbHRzZXY=
