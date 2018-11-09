Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C06C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBCF20817
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZwkU+Q7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBCF20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeKJADd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:03:33 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50392 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKJADd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:03:33 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2371824E13E0;
        Fri,  9 Nov 2018 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541773365; bh=ER1YRrDalTaNukew3M/DLM+ymQINkTe7ERXhsfphU00=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZwkU+Q7zBsN5bJPW7rsBhgPKLC/NiwMsC4JrD+1QDxwrHlNolLtU9NMlopsJ93IXF
         4hePsSKeBYR9ffn/YKCdirYHQ1aK5OD1/Ax6TQskK/OccjzMrVymfST2P8s4bqv39C
         FINixQYAmnwyZKcftLoeKv0Jww6KpCr7Ep8WRX1FCn9chTpDIqV3Aj0XzzQAJ1Nqzt
         OviFSuysA0uW3Sk03CNgcXaAUQjlg8bABTXMSCMqYuQR+lCkHIirneWS0SOoDIENeG
         jxkefvTxRxo3UGy0NTO7u6VnB8j7BXah41IB7FQN1G/diWsAMwnHu8g/5ZTih5vWn/
         WBGKriKpN/LJg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id D926C5918;
        Fri,  9 Nov 2018 06:22:44 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 9 Nov 2018 06:22:44 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 9 Nov 2018 15:22:43 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "ldv@altlinux.org" <ldv@altlinux.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "lineprinter@altlinux.org" <lineprinter@altlinux.org>
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
Thread-Topic: [PATCH 06/13] arc: define syscall_get_arch()
Thread-Index: AQHUd9qaMCi82XFEfUiWRqvqbbOyn6VHbuEA
Date:   Fri, 9 Nov 2018 14:22:43 +0000
Message-ID: <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
References: <20181109031605.GF21511@altlinux.org>
In-Reply-To: <20181109031605.GF21511@altlinux.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CAD563711570744AE3812B371E8B69E@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpPbiBGcmksIDIwMTgtMTEtMDkgYXQgMDY6MTYgKzAzMDAsIERtaXRyeSBW
LiBMZXZpbiB3cm90ZToNCj4gc3lzY2FsbF9nZXRfYXJjaCgpIGlzIHJlcXVpcmVkIHRvIGJlIGlt
cGxlbWVudGVkIG9uIGFsbCBhcmNoaXRlY3R1cmVzDQo+IHRoYXQgdXNlIHRyYWNlaG9va19yZXBv
cnRfc3lzY2FsbF9lbnRyeSgpIGluIG9yZGVyIHRvIGV4dGVuZA0KPiB0aGUgZ2VuZXJpYyBwdHJh
Y2UgQVBJIHdpdGggUFRSQUNFX0dFVF9TWVNDQUxMX0lORk8gcmVxdWVzdC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERtaXRyeSBWLiBMZXZpbiA8bGR2QGFsdGxpbnV4Lm9yZz4NCj4gLS0tDQo+ICBh
cmNoL2FyYy9pbmNsdWRlL2FzbS9zeXNjYWxsLmggfCA2ICsrKysrKw0KPiAgaW5jbHVkZS91YXBp
L2xpbnV4L2F1ZGl0LmggICAgIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KDQpbc25pcF0NCg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2F1ZGl0
LmggYi9pbmNsdWRlL3VhcGkvbGludXgvYXVkaXQuaA0KPiBpbmRleCA4MThhZTY5MGFiNzkuLmE3
MTQ5Y2ViNWI5OCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2F1ZGl0LmgNCj4g
KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2F1ZGl0LmgNCj4gQEAgLTM3NSw2ICszNzUsNyBAQCBl
bnVtIHsNCj4gIA0KPiAgI2RlZmluZSBBVURJVF9BUkNIX0FBUkNINjQJKEVNX0FBUkNINjR8X19B
VURJVF9BUkNIXzY0QklUfF9fQVVESVRfQVJDSF9MRSkNCj4gICNkZWZpbmUgQVVESVRfQVJDSF9B
TFBIQQkoRU1fQUxQSEF8X19BVURJVF9BUkNIXzY0QklUfF9fQVVESVRfQVJDSF9MRSkNCj4gKyNk
ZWZpbmUgQVVESVRfQVJDSF9BUkMJCShFTV9BUkMpDQoNClNpbWlsYXJseSBoZXJlIHdlIG5lZWQg
dG8gaGF2ZToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQorI2RlZmluZSBBVURJVF9BUkNIX0FSQwkJKEVNX0FSQ3xFTV9BUkNWMikN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQoNCi1BbGV4ZXkNCg==
