Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41893214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j/edk3+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41893214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLFPt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:49:29 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52058 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeLFPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:49:29 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8699D24E159A;
        Thu,  6 Dec 2018 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544111368; bh=odzpPPKiuVTqR2w81OR3KgSjBLmyCv7yj0xzyY/JA6s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j/edk3+MWvIvzdf6Ryg2UAAlmCP1gLLxRMyntFeMAPh8VU0bcXX/2cv1hDEeBNrse
         2nNsJuGCuQrGS10+GJHmt6xVsgw775B6ymH6VG9D7eVde//Now7rZTYiZJ0tkLuAml
         IFxdlgRVfk83VlAVlWYkQEcuBlfX+EHpizKgvRXFwPpFSY3FZtluiwk/kJ5KCLYiRM
         ZMyw+wg8QyarD4d++qrRVdob+JBhWQ+UubWFYTngLtvmXe28/O2B9soxfpU0tjVImr
         gcAvVFnIqfycrahJal0rNL95zB5macOPNzbQZKbUp85RWv7oIxgI9Nd9E218hf7x2s
         uqnNEBgdEjTHw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 36BA63854;
        Thu,  6 Dec 2018 07:49:28 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Dec 2018 07:49:28 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 6 Dec 2018 16:49:25 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 4/5] ARC: perf: fix description comment
Thread-Topic: [PATCH 4/5] ARC: perf: fix description comment
Thread-Index: AQHUjLzl2R5qGFvvF0WRDfbjpfig2aVxzEgA
Date:   Thu, 6 Dec 2018 15:49:25 +0000
Message-ID: <1544111364.31297.23.camel@synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
         <20181205170609.18690-5-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075014641B8F6@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014641B8F6@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4BA0654C06DF844BDCA572074AC1DD8@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEyLTA1IGF0IDE3OjEzICswMDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDEyLzUvMTggOTowNiBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiA+IEZpeCBkZXNj
cmlwdGlvbiBjb21tZW50IGFzIHRoaXMgY29kZSBkb2Vzbid0IGJlbG9uZyBvbmx5IHRvDQo+ID4g
QVJDNzAwIGFueW1vcmUuDQo+ID4gDQo+ID4gQWxzbyB3aGlsZSBJJ20gYXQgaXQsIHVzZSBTUERY
IExpY2Vuc2UgSWRlbnRpZmllci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBh
bHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQo+IA0KPiBNYXliZSBzcXVhc2gg
dGhpcyBpbnRvIHRyaXZpYWwgY2xlYW51cHMgMS81ID8NCg0KSSBzcGxpdCBjbGVhbnVwIGZvciBz
ZXZlcmFsIHBhdGNoZXMgdG8gbWFrZSByZXZpZXcgZWFzaWVyLg0KSSBjYW4gc3F1YXNoIHRoZW0g
aW50byBzaW5nbGUgcGF0Y2ggaW4gdjIgaWYgeW91IHdhbnQgaXQuDQoNCg0KPiBBY2tlZC1ieTog
VmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KPiANCj4gVGh4LA0KPiAtVmluZWV0
DQotLSANCiBFdWdlbml5IFBhbHRzZXY=
