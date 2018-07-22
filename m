Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA518C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9145420850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="tzVnxjOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9145420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeGVX2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:28:16 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34161 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbeGVX2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:28:15 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 962138365E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:29:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532298598;
        bh=EwtXqXX95vGObhKKCjYIeUmFB0a525boSHXYlls969w=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=tzVnxjOSahL0sVxJyc2jbMSJjIJCYL+s2x9dGVWo0ei4A4OHzeP8C6EBDLOcRBhvx
         Oto6tRMi75bs+Gna5D9EmQx4GUgzhcrMNZbFUSoTcb58HlssCVULltSvCvc+HnR4dJ
         cVdLlHC1MXvV9/BeDSbyNzVDppza2lp0+857QlRc=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5505670001>; Mon, 23 Jul 2018 10:29:59 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Mon, 23 Jul 2018 10:29:58 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 23 Jul 2018 10:29:58 +1200
From:   Theuns Verwoerd <Theuns.Verwoerd@alliedtelesis.co.nz>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Secure deletion under JFFS2
Thread-Topic: [PATCH 0/2] Secure deletion under JFFS2
Thread-Index: AQHUH7qBk8c9Ntxibk6iCpnqihACd6Sa1W4AgAA4/IA=
Date:   Sun, 22 Jul 2018 22:29:58 +0000
Message-ID: <bc19f9b8-fccc-67e8-00af-1d83e5fd508a@alliedtelesis.co.nz>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <CAFLxGvyqZNLeRgxGvNNnc-zsPydYLisEB3eX0R5CVCEhEuN4QQ@mail.gmail.com>
In-Reply-To: <CAFLxGvyqZNLeRgxGvNNnc-zsPydYLisEB3eX0R5CVCEhEuN4QQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.16.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A350C2E054BAC4AB3571C2908C43D3E@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LzIzLzIwMTggMDc6MDYgQU0sIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMjAsIDIwMTggYXQgMTo1MCBBTSwgVGhldW5zIFZlcndvZXJkDQo+IDx0aGV1
bnMudmVyd29lcmRAYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+PiBTZWN1cml0eSBjZXJ0
aWZpY2F0aW9ucyBzdWNoIGFzIEZJUFMgcmVxdWlyZSB0aGUgY2FwYWJpbGl0eSB0byBzZWN1cmVs
eQ0KPj4gZGVsZXRlIGZpbGVzLCB3aGljaCBpcyBwcm9ibGVtYXRpYyB1bmRlciBKRkZTMidzIGxv
Zy1iYXNlZCBtb2RlbC4gIFdlIGNhbg0KPiBDYW4geW91IHBsZWFzZSBiZSBhIGxpdHRsZSBtb3Jl
IHNwZWNpZmljIGFib3V0IHRoZSBjZXJ0aWZpY2F0aW9ucz8NCmh0dHBzOi8vd3d3Lm5pYXAtY2Nl
dnMub3JnL0RvY3VtZW50c19hbmRfR3VpZGFuY2Uvdmlld190ZC5jZm0/dGRfaWQ9MTMzDQoNCmdp
dmVzIHNvbWUgbGV2ZWwgb2YgY29udGV4dC7CoCBJIGJlbGlldmUgYm90aCBGSVBTIGFuZCBDQyBo
YXZlIHNpbWlsYXIgDQpleHBlY3RhdGlvbnMgYXJvdW5kIGtleSBkZWxldGlvbi4NCj4gVGhlc2Ug
ZGF5cyBzZWN1cmUgZGVsZXRpb24gYXQgZmlsZSBzeXN0ZW0gbGV2ZWwgaXMgYWxtb3N0IGltcG9z
c2libGUgdG8gYWNoaWV2ZQ0KPiBzaW5jZSB5b3UgZG9uJ3QgaGF2ZSBmdWxsIGNvbnRyb2wgb2Yg
dGhlIHN0b3JhZ2Ugc3RhY2suDQo+IEkga25vdywgSSBrbm93LCBJbiB0aGUgcmF3IGZsYXNoIGNh
c2Ugd2UgaGF2ZSwgYnV0IHN0aWxsLiBJdCBtYWtlcw0KPiB0aGluZ3MgdmVyeSBjb21wbGljYXRl
ZC4NCj4NCj4gQSBjb21tb24gYXBwcm9hY2ggZG8gZGVsZXRlIGEgZmlsZSBpbiBhIHNlY3VyZSB3
YXkgaXMgaGF2aW5nIGl0DQo+IGVuY3J5cHRlZCBhbmQgdXBvbiBkZWxldGlvbg0KPiB5b3UgZm9y
Z2V0IHRoZSBrZXkuDQo+IFdvdWxkbid0IHRoYXQgd29yayBmb3IgeW91IHRvbz8NClRvIHJldGFp
biBncmFudWxhcml0eSBmb3IgbWFuYWdpbmcgaW5kaXZpZHVhbCBrZXlzLCB5b3UnZCByZXF1aXJl
IGEgMToxIA0Ka2V5LXRvLWFjY2Vzcy1rZXkgKGt0YWspLsKgIEJlY2F1c2Uga2V5cyBhcmUgZXhw
ZWN0ZWQgdG8gYmUgcGVyc2lzdGVudCwgDQpzbyBtdXN0IHRoZSBrdGFrIGJlIC0gYXQgd2hpY2gg
cG9pbnQgd2UndmUgcmVwbGFjZWQgdGhlIHJlcXVpcmVtZW50IGZvciANCnNlY3VyZWx5IGRlbGV0
aW5nIGEga2V5IHdpdGggb25lIHRvIHNlY3VyZWx5IGRlbGV0ZSBhIGt0YWsuDQooSW4gYWRkaXRp
b24sIHNpbmNlIHRoaXMgYXBwcm9hY2ggZmFsbHMgb3V0c2lkZSB0aGUgc3BlY2lmaWMgbGFuZ3Vh
Z2UgDQp1c2VkIGluIHRoZSBjZXJ0aWZpY2F0aW9uIGd1aWRhbmNlIGRvY3VtZW50cywgaXQnZCBu
ZWVkIHRvIGJlIGp1c3RpZmllZCANCmluIGRldGFpbCwgd2hpY2ggYWRkcyByaXNrLikNCg0KUmVn
YXJkcywNCg0KVGhldW5zDQpLUk4=
