Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4983220892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IGy6MCS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4983220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeLNKrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:47:35 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:46548 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLNKrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:47:35 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B054124E2106;
        Fri, 14 Dec 2018 02:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544784454; bh=kJjl3PpYxTm7l5O7YiNgHJPpM0dh8ECipLNdVvJsG8Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IGy6MCS4HA1rKhKP7FVOa2Ef/S6B8AA9LbKj4iDpiGyY+QhNGfkNTzkHOITiYNNwC
         1k9UcytgR/rGCeC2eKnC60yOda4bSr+vsmUuE0LH3tbgnt4+AIFKyZdn65YmHGJl0X
         uCG3OBmYeF3FETeJ4/mtVEg2VBFqytAn2g6qH1eAf9PLab7ziDKJkuodKqa8vbNJzT
         3DYZgiI7B2D/Wxgx9bMaBXbM/PKDpH1VmgFOesP8xwu81sY/LG/VAOPBhTv4FmMPpg
         VkCsCLdHvH6eEDwG5NN7WhXnQa5kcW9gQFsnAMdoPuu/hsqvYw4TnWaEqL0mkVtnoe
         KM+HPPqb5pTDQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9FDDC3AF8;
        Fri, 14 Dec 2018 02:47:34 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 02:47:34 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 14 Dec 2018 11:47:31 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: fix __ffs return value to avoid build warnings
Thread-Topic: [PATCH] ARC: fix __ffs return value to avoid build warnings
Thread-Index: AQHUkvqKb3uYi9qbnk+XGfa5481IQ6V9/hiA
Date:   Fri, 14 Dec 2018 10:47:30 +0000
Message-ID: <1544784449.3270.30.camel@synopsys.com>
References: <20181213154257.23033-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075014641F6E3@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014641F6E3@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <24A3642CC61D014D81828E19E0649CB4@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBUaHUsIDIwMTgtMTItMTMgYXQgMTg6MjMgKzAwMDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMTIvMTMvMTggNzo0MyBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3Rl
Og0KPiA+IENoYW5nZSBfX2ZmcyByZXR1cm4gdmFsdWUgZnJvbSAnaW50JyB0byAndW5zaWduZWQg
bG9uZycgYXMgaXQNCj4gPiBpcyBkb25lIGluIG90aGVyIGltcGxlbWVudGF0aW9ucyAobGlrZSBh
c20tZ2VuZXJpYywgeDg2LCBldGMuLi4pDQo+ID4gdG8gYXZvaWQgYnVpbGQtdGltZSB3YXJuaW5n
cyBpbiBwbGFjZXMgd2hlcmUgdHlwZSBpcyBzdHJpY3RseQ0KPiA+IGNoZWNrZWQuDQo+ID4gDQo+
ID4gQXMgX19mZnMgbWF5IHJldHVybiB2YWx1ZXMgaW4gWzAtMzFdIGludGVydmFsIGNoYW5naW5n
IHJldHVybg0KPiA+IHR5cGUgdG8gdW5zaWduZWQgaXMgdmFsaWQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0K
PiANCj4gQ2FuIHlvdSBwbGVhc2UgcGFzdGUgYSBjb3VwbGUgb2YgbGluZXMgb2Ygb2ZmZW5kaW5n
IG91dHB1dCAhDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICBDQyAgICAgIG1tL25vYm9vdG1lbS5vDQpJbiBm
aWxlIGluY2x1ZGVkIGZyb20gLi9pbmNsdWRlL2FzbS1nZW5lcmljL2J1Zy5oOjE4OjAsDQogICAg
ICAgICAgICAgICAgIGZyb20gLi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9idWcuaDozMiwNCiAgICAg
ICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYnVnLmg6NSwNCiAgICAgICAgICAgICAg
ICAgZnJvbSAuL2luY2x1ZGUvbGludXgvbW1kZWJ1Zy5oOjUsDQogICAgICAgICAgICAgICAgIGZy
b20gLi9pbmNsdWRlL2xpbnV4L2dmcC5oOjUsDQogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNs
dWRlL2xpbnV4L3NsYWIuaDoxNSwNCiAgICAgICAgICAgICAgICAgZnJvbSBtbS9ub2Jvb3RtZW0u
YzoxNDoNCm1tL25vYm9vdG1lbS5jOiBJbiBmdW5jdGlvbiDigJhfX2ZyZWVfcGFnZXNfbWVtb3J5
4oCZOg0KLi9pbmNsdWRlL2xpbnV4L2tlcm5lbC5oOjg0NToyOTogd2FybmluZzogY29tcGFyaXNv
biBvZiBkaXN0aW5jdCBwb2ludGVyIHR5cGVzIGxhY2tzIGEgY2FzdA0KICAgKCEhKHNpemVvZigo
dHlwZW9mKHgpICopMSA9PSAodHlwZW9mKHkpICopMSkpKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeDQouL2luY2x1ZGUvbGludXgva2VybmVsLmg6ODU5OjQ6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyDigJhfX3R5cGVjaGVja+KAmQ0KICAgKF9fdHlwZWNoZWNrKHgsIHkpICYm
IF9fbm9fc2lkZV9lZmZlY3RzKHgsIHkpKQ0KICAgIF5+fn5+fn5+fn5+DQouL2luY2x1ZGUvbGlu
dXgva2VybmVsLmg6ODY5OjI0OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYX19zYWZl
X2NtcOKAmQ0KICBfX2J1aWx0aW5fY2hvb3NlX2V4cHIoX19zYWZlX2NtcCh4LCB5KSwgXA0KICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fg0KLi9pbmNsdWRlL2xpbnV4L2tlcm5lbC5o
Ojg3ODoxOTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fY2FyZWZ1bF9jbXDigJkN
CiAjZGVmaW5lIG1pbih4LCB5KSBfX2NhcmVmdWxfY21wKHgsIHksIDwpDQogICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fg0KbW0vbm9ib290bWVtLmM6MTA0OjExOiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8g4oCYbWlu4oCZDQogICBvcmRlciA9IG1pbihNQVhfT1JERVIgLSAxVUws
IF9fZmZzKHN0YXJ0KSk7DQogICAgICAgICAgIF5+fg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCj4gDQo+IC1W
aW5lZXQNCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
