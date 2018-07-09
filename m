Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C94C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE052089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P4iIC49L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE052089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeGIHWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:22:13 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:40570 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGIHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:22:11 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8942624E23BD;
        Mon,  9 Jul 2018 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531120930; bh=uQnPDXRbutNxzzISl+nyORlw4hFx11llQ4h23JNHDUA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=P4iIC49L9PyVGjnKjCdGcVwTXxXrE463L/r8ogJj+uNd8hEzrwTYC9aHBFvgGqjCg
         Xni2f8ryOk0wZv0cpL+hQseWZfBr2a9JJ2j+WqMDMmRZkTMhKnOIWY2IsjHaR3zpYn
         4IF3O65XT+/EUfjv5rBxkYAUPWrtTzI3aAYuvQ0LboLxcXZZ0YmsjuYD6eaJLiM2o/
         Ep/GtZTPiwl4BEHu9MEnmAZC6+zWQrr7Bq7BfroSX47eym8HOJPGqF2fOS5QDpQZy8
         PyOOVQSVu38PeHRsj9qdCZvHs7gZCgyQEdkknATnwujb87QxHhS0pN0drXlBxNPGBh
         ZSHnyEtG3zMrA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7207136B2;
        Mon,  9 Jul 2018 00:22:10 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 00:22:10 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 09:22:08 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "geert@linux-m68k.org" <geert@linux-m68k.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz+a+E6GQfxV7UuzGYUzCAFtDqSGQPUAgAAV8ICAAAQqgA==
Date:   Mon, 9 Jul 2018 07:22:08 +0000
Message-ID: <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <20180709054842.GB7618@kroah.com>
         <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9F84045480B6D46A3A36428C8A395AC@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAwOTowNyArMDIwMCwgR2VlcnQgVXl0
dGVyaG9ldmVuIHdyb3RlOg0KPiBPbiBNb24sIEp1bCA5LCAyMDE4IGF0IDc6NDkgQU0gR3JlZyBL
SCA8Z3JlZ0Brcm9haC5jb20+IHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA3
OjQ0OjQ0QU0gKzAzMDAsIEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+ID4gRGVwZW5kaW5nIG9u
IEFCSSAibG9uZyBsb25nIiB0eXBlIG9mIGEgcGFydGljdWxhciAzMi1iaXQgQ1BVDQo+ID4gPiBt
aWdodCBiZSBhbGlnbmVkIGJ5IGVpdGhlciB3b3JkICgzMi1iaXRzKSBvciBkb3VibGUgd29yZCAo
NjQtYml0cykuDQo+IA0KPiBPciBldmVuIDE2LWJpdCAob24gZS5nLiBtNjhrKS4NCg0KSW5kZWVk
LCB0aGFua3MgZm9yIHRoZSBub3RlIQ0KV2lsbCBhZGQgdGhpcyBpbiBteSB2My4NCg0KRm9yIEFS
QyBJJ2QgbGlrZSB0aGlzIGZpeCB0byBiZSBiYWNrLXBvcnRlZCBzdGFydGluZw0KZnJvbSB2NC44
IHdoZXJlIHdlIGFkZGVkIHN1cHBvcnQgb2YgIm5hdGl2ZSIgYXRvbWljNjRfdCwgc2VlIGNvbW1p
dA0KY2U2MzY1MjcwZWNkICgiIEFSQ3YyOiBJbXBsZW1lbnQgYXRvbWljNjQgYmFzZWQgb24gTExP
Q0tEL1NDT05ERCBpbnN0cnVjdGlvbnMiKS4NCg0KV2hhdCBhYm91dCBtNjhrLCBkbyB5b3UgaGF2
ZSBhbnkgcHJlZmVyZW5jZSBvZiBlYXJsaWVzdCBrZXJuZWwgdmVyc2lvbg0Kd2hlcmUgdGhpcyBm
aXggbWlnaHQgYmUgdXNlZnVsPw0KDQotQWxleGV5
