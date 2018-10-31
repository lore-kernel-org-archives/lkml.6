Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B9CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3442820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b3E1XL+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3442820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbeKAD7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:59:16 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:34630 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeKAD7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:59:16 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5AC8E10C0964;
        Wed, 31 Oct 2018 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541012397; bh=Fd1cauIXYKYwOMGcXMa821Y/DN04bh89Ljs7jVuJcvw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=b3E1XL+TWvG16ThEtZBaZWnZpLVWEn+fNFmXPvjqwOfX9EKVFkIpUd0HwWPggO2/N
         x6gbxejE7yzFBf9NFI7a5uUjgzO2cKvKLz84Ix28nyIBdobTsd48G/S9GdXMcmKRkZ
         4NHhqmMVHptV1NU0ji7h7g1doY8IVtugHHmvb64rWLSzRa7bqaGw5GvL1E42sg9ES5
         6BpuNbgrpbmiO+LnVjhxSDleX023H2IeSxGbkJT0X/FP9ia3q+gBGmP3QPi7aGJHxl
         eGaAw+KMP3+nV2gMsTQqtoPG3qr00P/izJBZwsPoadvY9G2/hO8wiGQyy/DX6LFRwD
         P6Oh2gM33UFnA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4897E326E;
        Wed, 31 Oct 2018 11:59:57 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 31 Oct 2018 11:59:57 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 31 Oct 2018 19:59:54 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: [plat-hsdk] Enable DW APB GPIO support
Thread-Topic: [PATCH] ARC: [plat-hsdk] Enable DW APB GPIO support
Thread-Index: AQHUaslFo5wJ/nyDekafXj9rIUlPp6U4BMsAgAGsrQA=
Date:   Wed, 31 Oct 2018 18:59:53 +0000
Message-ID: <220be0675d0114028930e6fe122f98cefba130a7.camel@synopsys.com>
References: <20181023120919.11627-1-Eugeniy.Paltsev@synopsys.com>
         <0f3fcfcf-6a3d-1277-cee8-91f27f0a3c06@synopsys.com>
In-Reply-To: <0f3fcfcf-6a3d-1277-cee8-91f27f0a3c06@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6690D0DAE9EFCE489CA65302EF3AC948@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBUdWUsIDIwMTgtMTAtMzAgYXQgMTA6MjUgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMTAvMjMvMTggNTowOSBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3Rl
Og0KPiA+IEVuYWJsZSBHUElPIHN1cHBvcnQgb24gSFNESy4gSFNESyBTb0MgaW5jbHVkZXMgU3lu
b3BzeXMNCj4gPiBEZXNpZ25XYXJlIERXX2FwYl9ncGlvIElQIHdpdGggMjQgR1BJT3MgbWFwcGVk
IG9udG8gcG9ydCBBLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNldiA8
RXVnZW5peS5QYWx0c2V2QHN5bm9wc3lzLmNvbT4NCj4gDQo+IEBBbGV4ZXksIHUgaGFwcHkgd2l0
aCB0aGlzID8NCj4gDQo+IC1WaW5lZXQNCg0KQWNrZWQtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJv
ZGtpbkBzeW5vcHN5cy5jb20+DQo=
