Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705C3C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A562173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VftFiSS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A562173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHHPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:54:48 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:46252 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeHHPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:54:48 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EA36824E246C;
        Wed,  8 Aug 2018 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533735305; bh=O09XWEZxx+r7jp2Q3hgC5/weQXAOPdzZLUzTC3dI2jE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VftFiSS4lHKTBG1I2E9Zwhp5zPqkMMSiZK3mLwyQ9oLgTmsVIiNeHBYZIJej3Rlwt
         ujer/7QLcYuF3JCAMjdCGVZfD8bfIQB4LApe9OzD/mgB+Gw2mHyFnME/ULV3hO+rd0
         FLxPKPzghUoDX7yD/QDk1qoERDd9BoY1xPZI7MsaekOklxsALMhqSIVOahcmXyg8GP
         y0DQNsL9tsQhusjfSLglD9MiLV4/jTIu6CJRnFdWUMjrb4ecntuzDoa3iCQA4XlXRF
         HV8xB2tSM5bUejguY8RSYdBZ3auXb+Tpl2hS8omCEwb/BhA8mD6MvEsKtW7dyIU8bH
         20WZY50XgPccA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id AF1995063;
        Wed,  8 Aug 2018 06:35:05 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 8 Aug 2018 06:35:05 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed,
 8 Aug 2018 15:35:02 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: [plat-axs10x] Enable SWAP
Thread-Topic: [PATCH] ARC: [plat-axs10x] Enable SWAP
Thread-Index: AQHUKj3aMlVf9fIwTkm9muJbdwedfKSy56OAgALbkQA=
Date:   Wed, 8 Aug 2018 13:35:02 +0000
Message-ID: <895ec9ce12151312c093a6676c68cd00a06df5aa.camel@synopsys.com>
References: <20180802085016.16000-1-abrodkin@synopsys.com>
         <14efb038-3fa4-9f92-740f-46ec982f2c8c@synopsys.com>
In-Reply-To: <14efb038-3fa4-9f92-740f-46ec982f2c8c@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAFBAD53C07B904DB4949125D38F1D43@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBNb24sIDIwMTgtMDgtMDYgYXQgMTA6NTYgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMDgvMDIvMjAxOCAwMTo1MCBBTSwgQWxleGV5IEJyb2RraW4gd3Jv
dGU6DQo+ID4gU1dBUCBzdXBwb3J0IG9uIEFSQyB3YXMgZml4ZWQgZWFybGllciBieQ0KPiA+IGNv
bW1pdCA2ZTM3NjExNDVhOWIgKCJBUkM6IEZpeCBDT05GSUdfU1dBUCIpDQo+ID4gc28gbm93IHdl
IG1heSBzYWZlbHkgZW5hYmxlIGl0IG9uIHBsYXRmb3JtcyB0aGF0DQo+ID4gaGF2ZSBleHRlcm5h
bCBtZWRpYSBsaWtlIFVTQiBhbmQgU0QtY2FyZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMuY29tPg0KPiA+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnICMgNmUzNzYxMTQ1YTliOiBBUkM6IEZpeCBDT05GSUdfU1dBUA0KPiANCj4g
RG9lcyB0aGlzIHJlYWxseSBxdWFsaWZ5IGFzIGEgZml4IGZvciBiYWNrcG9ydCA/DQo+DQo+ID4g
LS0tDQo+ID4gIGFyY2gvYXJjL2NvbmZpZ3MvYXhzMTAxX2RlZmNvbmZpZyAgICAgfCAxIC0NCj4g
PiAgYXJjaC9hcmMvY29uZmlncy9heHMxMDNfZGVmY29uZmlnICAgICB8IDEgLQ0KPiA+ICBhcmNo
L2FyYy9jb25maWdzL2F4czEwM19zbXBfZGVmY29uZmlnIHwgMSAtDQo+IA0KPiBBbHNvIGhzZGsg
Pw0KDQpFeGFjdGx5IC0gaW4gSFNESyB3ZSBoYXBwZW5lZCB0byBoYXZlIFNXQVAgZnJvbSB0aGUg
dmVyeSBiZWdpbm5pbmcNCnNvIG15IGludGVudGlvbiB3YXMgdG8gYWxpZ24gb3RoZXIgYm9hcmRz
IHNvIHdlIGdldCBleGFjdGx5IHRoZSBzYW1lDQpiZWhhdmlvciBvbiBhbGwgYm9hcmRzIG9uY2Ug
U1dBUCB3YXMgZml4ZWQgYnkNCmNvbW1pdCA2ZTM3NjExNDVhOWIgKCJBUkM6IEZpeCBDT05GSUdf
U1dBUCIpLg0KDQpPdGhlcndpc2Ugc2luY2UgdGhpcyBpcyBqdXN0IGEgbWF0dGVyIG9mIHRvZ2ds
aW5nIGEgY29uZmlnIG9wdGlvbg0Kd2UgbWF5IGxlYXZlIGl0IHVwIHRvIHVzZXIgdG8gZGVjaWRl
IGlmIGhlL3NoZSB3YW50cyB0byBoYXZlDQpTV0FQIGVuYWJsZWQuDQoNClRoYXQgc2FpZCBpdCBz
aG91bGQgYmUgZmluZSBpbiBlaXRoZXIgd2F5Lg0KDQotQWxleGV5DQo=
