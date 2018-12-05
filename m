Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAFBC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323472064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323472064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeLELnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:43:41 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39507 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLELnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:43:40 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID wB5BggTU018984, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id wB5BggTU018984
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 5 Dec 2018 19:42:42 +0800
Received: from RTITMBSV02.realtek.com.tw ([fe80::cc0e:6d5f:56d7:c15f]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0399.000; Wed, 5 Dec 2018 19:42:41 +0800
From:   Kailang <kailang@realtek.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
CC:     Jaroslav Kysela <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Hui Wang" <hui.wang@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: RE: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN
Thread-Topic: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode
 fixups for ASUS X542UN
Thread-Index: AQHUjG4z5Y1EMUXolEKQbVvni1nQzqVv0chg//+KUwCAAKnw7A==
Date:   Wed, 5 Dec 2018 11:42:37 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184200EB@RTITMBSV02.realtek.com.tw>
References: <20181205074212.31104-1-jian-hong@endlessm.com>
 <20181205074212.31104-2-jian-hong@endlessm.com>
 <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>,<CAPpJ_ed5qbhxUONdoACcQhH8jv1J_vvw4M-Vp4QwDsgQ1w8Vdw@mail.gmail.com>
In-Reply-To: <CAPpJ_ed5qbhxUONdoACcQhH8jv1J_vvw4M-Vp4QwDsgQ1w8Vdw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [112.104.14.167]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck5vLgpEb24ndCB0cnkgIEFMQzI2OV9GSVhVUF9IRUFEU0VUX01PREVfTk9fSFBfTUlDIG1vZGVs
IGZvciBBTEMyODYgcGxhdGZvcm0uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCrFxOiBKaWFuLUhvbmcgUGFuIFtqaWFuLWhvbmdAZW5kbGVzc20uY29tXQqxSKXzpOm0
wTogMjAxOKZ+MTKk6zWk6SCkVaTIIDA1OjMzCqbcOiBLYWlsYW5nCrDGpbs6IEphcm9zbGF2IEt5
c2VsYTsgdGl3YWlAc3VzZS5jb207IEh1aSBXYW5nOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmc7IExpbnV4IEtlcm5lbDsgTGludXggVXBzdHJlYW1pbmcgVGVhbTsgQ2hyaXMgQ2hpdTsgRGFu
aWVsIERyYWtlCqVEpq46IFJlOiBbUEFUQ0ggMS8zXSBBTFNBOiBoZGEvcmVhbHRlazogQUxDMjk0
IG1pYyBhbmQgaGVhZHNldC1tb2RlIGZpeHVwcyBmb3IgQVNVUyBYNTQyVU4KCkthaWxhbmcgPGth
aWxhbmdAcmVhbHRlay5jb20+IKnzIDIwMTimfjEypOs1pOkgtmekVCCkVaTINDozNrxnuUShRwo+
Cj4gSGkgSmlhbi1Ib25nLAo+Cj4gQ291bGQgeW91IHRlc3QgdG8gY2hhbmdlIHRoZSBtb2RlbCB0
byBBTEMyNjlfRklYVVBfSEVBRFNFVF9NT0RFX05PX0hQX01JQz8KPgo+IC5jaGFpbl9pZCA9IEFM
QzI1Nl9GSVhVUF9BU1VTX0hFQURTRVRfTU9ERSAgPT0+IGNoYW5nZSB0byBBTEMyNjlfRklYVVBf
SEVBRFNFVF9NT0RFX05PX0hQX01JQwoKQWNjb3JkaW5nIHRvIHRoZSBjb21tZW50Cmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA3MTMwODcvIzIyMzYwMjUzICwgc2hvdWxkIEkg
dHJ5CkFMQzI2OV9GSVhVUF9IRUFEU0VUX01PREVfTk9fSFBfTUlDIG9uIHRoaXMgbW9kZWw/CgpK
aWFuLUhvbmcgUGFuCgotLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9y
ZSBwcmludGluZyB0aGlzIGUtbWFpbC4K
