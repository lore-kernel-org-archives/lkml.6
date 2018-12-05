Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55AA20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55AA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeLEUbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:31:44 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45456 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:31:43 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wB5KUotb026532
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Dec 2018 05:30:50 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB5KUo5i022167;
        Thu, 6 Dec 2018 05:30:50 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB5KUoQa016274;
        Thu, 6 Dec 2018 05:30:50 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-375347; Thu, 6 Dec 2018 05:29:15 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Thu, 6
 Dec 2018 05:29:15 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     lijiang <lijiang@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Thread-Topic: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Thread-Index: AQHUjKXemQXNLRGc+UGdsBH5ZuUNaqVwM/AQ
Date:   Wed, 5 Dec 2018 20:29:14 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0356426E@BPXM09GP.gisp.nec.co.jp>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205113032.GF29510@zn.tnic>
 <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
In-Reply-To: <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.133.146]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBHZW5lcmF0aW5nIFZNQ09SRUlORk8gaXMgZWFzeSBpbiB0aGUgZmlyc3Qga2VybmVsLCBm
b3IgZXhhbXBsZToNCj4gPj4gIyBtYWtlZHVtcGZpbGUgLWcgVk1DT1JFSU5GTyAteCB2bWxpbnV4
DQo+ID4NCj4gPiBJIGdldDoNCj4gPg0KPiA+ICQgbWFrZWR1bXBmaWxlIC1nIFZNQ09SRUlORk8g
LXggdm1saW51eA0KPiA+IFRoZSBrZXJuZWwgdmVyc2lvbiBpcyBub3Qgc3VwcG9ydGVkLg0KPiA+
IFRoZSBtYWtlZHVtcGZpbGUgb3BlcmF0aW9uIG1heSBiZSBpbmNvbXBsZXRlLg0KPiA+DQo+ID4g
VGhlIHZtY29yZWluZm8gaXMgc2F2ZWQgdG8gVk1DT1JFSU5GTy4NCj4gPg0KPiA+IG1ha2VkdW1w
ZmlsZSBDb21wbGV0ZWQuDQo+ID4NCj4gPiBCdXQgdGhlIHRleHQgZmlsZSBsb29rcyBvayBBRkFJ
Q1QuIFBsZWFzZSBhZGQgdGhhdCBjb21tYW5kIHRvIHRoZQ0KPiA+IGRvY3VtZW50YXRpb24gZmls
ZS4NCj4gPg0KDQpQbGVhc2Ugbm90ZSB0aGF0IHRoaXMgVk1DT1JFSU5GTyBpcyBnZW5lcmF0ZWQg
ZnJvbSB0aGUgaW5mb3JtYXRpb24gaW4NCnRoZSB2bWxpbnV4IG9ubHksIG5vdCBmcm9tIHRoZSBy
dW5uaW5nIGtlcm5lbCBhbmQgL3Byb2Mva2NvcmUuIFNvIGlmDQp3ZSBhZGQgYSBjb21tYW5kIHRv
IGR1bXAgaXQgZnJvbSBydW5uaW5nIGtlcm5lbCwgaXQncyBub3Qgc3VpdGFibGUuDQoNCihUaGlz
IHN3aXRjaCBpcyBpbnRlbmRlZCB0byBtYWtlIGEgZGF0YSB0aGF0IGlzIHVzZWQgaW5zdGVhZCBv
ZiB2bWxpbnV4DQogd2hlbiB2bWNvcmUgZGlkbid0IGhhdmUgVk1DT1JFSU5GTyBhbmQgbWFrZWR1
bXBmaWxlIGlzIGluIGEgc2l0dWF0aW9uDQogdGhhdCB3ZSBkb24ndCBoYXZlIHZtbGludXguIFBs
ZWFzZSBzZWUgdGhlIGV4cGxhbmF0aW9uIG9mIHRoZSAtaSBhbmQNCiAtZyBvcHRpb25zIGluIG1h
a2VmdW1wZmlsZSg4KS4pDQoNCm1ha2VkdW1wZmlsZSBkb2Vzbid0IGhhdmUgYW55IHN3aXRjaCB3
aGljaCBkdW1wcyBWTUNPUkVJTkZPIGZyb20ga2NvcmUNCmZvciBub3cuIChJJ20gdGhpbmtpbmcg
dG8gaGF2ZSBtYWtlZHVtcGZpbGUgZHVtcCBpdCBhcyBkZWJ1ZyBtZXNzYWdlLA0KdGhvdWdoLikN
Cg0KVGhhbmtzLA0KS2F6dQ0KDQo=

