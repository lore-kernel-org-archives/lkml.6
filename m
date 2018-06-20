Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0394EC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6F520693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iooSjIzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6F520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeFTTKH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:10:07 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:52956 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFTTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:10:06 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AB9BE1E04A8;
        Wed, 20 Jun 2018 21:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529521804; bh=nwQD0IDxq0gfWOSb1wzoWEoVW/c/R9Os5IvGlTmyVVk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iooSjIzoDrOjBvWy6g2uJ7rPqHy+FuW/6nw0d1LCZ0okemYesZaoGZEIUiQbFijDz
         Qr+2/Y9r7pa0jrBFj8E7bCuNYHy+lKGOcSZj5pupZmJU+oWALxrh//KR1ZE6PBFYz1
         iiUSvFETNnU4NgNRqeUyKagEQeAbKZsT4zdCd7jhi9xO/7I1hwY/d+Qe0vox8DtT1C
         5NtiCDaqUAtH7e6NqG7TpAS2hBZ8AeTX/WAn82iASl9mt3Pq+zK63AEoNc7cXB3dyF
         69MnCHdCNDTSisezOimE3dHjV3mkVZrzMgSxnuClwqIf5ADccNr3NTfH/FBbhY+FtE
         /7ieFpWvG6Njw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id F3DDF54CB;
        Wed, 20 Jun 2018 12:10:03 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 20 Jun 2018 12:10:03 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed,
 20 Jun 2018 21:10:00 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] ARC: Add PCIe support for ARC HSDK platform
Thread-Topic: [PATCH v2] ARC: Add PCIe support for ARC HSDK platform
Thread-Index: AQHUCLTQbYBn4teVp0+qomsYPWSPd6RpYZ4A
Date:   Wed, 20 Jun 2018 19:09:59 +0000
Message-ID: <ba16de7195ab84cc6f29f1a7ec2844dbc202392d.camel@synopsys.com>
References: <9f41b2f9d6da018563fa35aee462ddb60afd922f.1529505192.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <9f41b2f9d6da018563fa35aee462ddb60afd922f.1529505192.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2262EC222F9DA640BD252CF8EBD5000F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VzdGF2bywNCg0KT24gV2VkLCAyMDE4LTA2LTIwIGF0IDE3OjM2ICswMTAwLCBHdXN0YXZv
IFBpbWVudGVsIHdyb3RlOg0KPiBBZGQgUENJIHN1cHBvcnQgdG8gdGhlIEFSQyBIU0RLIHBsYXRm
b3JtIGFsbG93aW5nIHRvIHVzZSB0aGUgZ2VuZXJpYyBQQ0kNCj4gc2V0dXAgZnVuY3Rpb25zLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBz
eW5vcHN5cy5jb20+DQo+IC0tLQ0KPiBDaGFuZ2UgdjEtPnYyOg0KPiAgLSBTcGxpdCBpbml0aWFs
IHBhdGNoLCBmb2xsb3dpbmcgQWxleGV5IEJyb2RraW4gc3VnZ2VzdGlvbi4NCj4gDQo+ICBhcmNo
L2FyYy9wbGF0LWhzZGsvS2NvbmZpZyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvcGxhdC1oc2RrL0tjb25maWcgYi9h
cmNoL2FyYy9wbGF0LWhzZGsvS2NvbmZpZw0KPiBpbmRleCAxOWFiM2NmLi41NTZiYzVlIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FyYy9wbGF0LWhzZGsvS2NvbmZpZw0KPiArKysgYi9hcmNoL2FyYy9w
bGF0LWhzZGsvS2NvbmZpZw0KPiBAQCAtOSwzICs5LDQgQEAgbWVudWNvbmZpZyBBUkNfU09DX0hT
REsNCj4gIAlib29sICJBUkMgSFMgRGV2ZWxvcG1lbnQgS2l0IFNPQyINCj4gIAlzZWxlY3QgQ0xL
X0hTREsNCj4gIAlzZWxlY3QgUkVTRVRfSFNESw0KPiArCXNlbGVjdCBNSUdIVF9IQVZFX1BDSQ0K
DQpBZGRpbmcgQmpvcm4gYW5kIGxpbnV4LXBjaSBtYWlsaW5nIGxpc3RzLCBvdGhlcndpc2UuLi4N
Cg0KQWNrZWQtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBzeW5vcHN5cy5jb20+DQoNCg==
