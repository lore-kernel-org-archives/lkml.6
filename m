Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1142CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD44A213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD44A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJCWgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:36:53 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.140]:48705 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbeJCWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:36:52 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 99817400DD6E0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 10:47:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7jNKgJgsu8YaU7jNPgmWAb; Wed, 03 Oct 2018 10:47:55 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:55718 helo=[192.168.43.69])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g7jNJ-004BlM-As; Wed, 03 Oct 2018 10:47:45 -0500
Subject: Re: [PATCH] scsi: mark expected switch fall-throughs
To:     Don.Brace@microchip.com, don.brace@microsemi.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        aacraid@microsemi.com, osst@riede.org, Kai.Makisara@kolumbus.fi
Cc:     esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, osst-users@lists.sourceforge.net
References: <20181003145535.GA24941@embeddedor.com>
 <BYAPR11MB2855F7449E2A15FDB28EC5B7E1E90@BYAPR11MB2855.namprd11.prod.outlook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <1bacbf96-f4d7-8ecd-106b-277d8c983663@embeddedor.com>
Date:   Wed, 3 Oct 2018 17:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2855F7449E2A15FDB28EC5B7E1E90@BYAPR11MB2855.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: base64
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g7jNJ-004BlM-As
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net ([192.168.43.69]) [92.93.206.174]:55718
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMvMTggNTo0NCBQTSwgRG9uLkJyYWNlQG1pY3JvY2hpcC5jb20gd3JvdGU6
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gKkZyb206Kkd1c3Rhdm8gQS4gUi4gU2ls
dmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQo+ICpTZW50OiogV2VkbmVzZGF5LCBPY3Rv
YmVyIDMsIDIwMTggOTo1NSBBTQ0KPiAqVG86KiBEb24gQnJhY2U7IEphbWVzIEUuSi4gQm90
dG9tbGV5OyBNYXJ0aW4gSy4gUGV0ZXJzZW47IEFkYXB0ZWMgT0VNIFJhaWQgU29sdXRpb25z
OyBXaWxsZW0gUmllZGU7IEthaSBN5Gtpc2FyYQ0KPiAqQ2M6KiBlc2Muc3RvcmFnZWRldkBt
aWNyb3NlbWkuY29tOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgb3NzdC11c2Vyc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IEd1
c3Rhdm8gQS4gUi4gU2lsdmENCj4gKlN1YmplY3Q6KiBbUEFUQ0hdIHNjc2k6IG1hcmsgZXhw
ZWN0ZWQgc3dpdGNoIGZhbGwtdGhyb3VnaHMNCj4gDQo+IKANCj4gDQo+IEluIHByZXBhcmF0
aW9uIHRvIGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoIGNh
c2VzDQo+IHdoZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9y
LmNvbT4NCj4gLS0tDQo+IKBkcml2ZXJzL3Njc2kvaHBzYS5jIHwgNSArKysrKw0KPiCgZHJp
dmVycy9zY3NpL2lwcy5joCB8IDEgKw0KPiCgZHJpdmVycy9zY3NpL29zc3QuYyB8IDYgKysr
KysrDQo+IKBkcml2ZXJzL3Njc2kvcHBhLmOgIHwgMSArDQo+IKBkcml2ZXJzL3Njc2kvc3Qu
Y6CgIHwgNCArKysrDQo+IKA1IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvaHBzYS5jIGIvZHJpdmVycy9zY3NpL2hw
c2EuYw0KPiBpbmRleCBmOTAzOTgzLi5mYjZhMzU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3Njc2kvaHBzYS5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS9ocHNhLmMNCj4gQEAgLTQ2NjIs
NiArNDY2Miw3IEBAIHN0YXRpYyBpbnQgZml4dXBfaW9hY2NlbF9jZGIodTggKmNkYiwgaW50
ICpjZGJfbGVuKQ0KPiCgoKCgoKCgIGNhc2UgV1JJVEVfNjoNCj4goKCgoKCgoCBjYXNlIFdS
SVRFXzEyOg0KPiCgoKCgoKCgoKCgoKCgoKAgaXNfd3JpdGUgPSAxOw0KPiAroKCgoKCgoKCg
oKCgoKAgLyogZmFsbCB0aHJvdWdoICovDQo+IKCgoKCgoKAgY2FzZSBSRUFEXzY6DQo+IKCg
oKCgoKAgY2FzZSBSRUFEXzEyOg0KPiCgoKCgoKCgoKCgoKCgoKAgaWYgKCpjZGJfbGVuID09
IDYpIHsNCj4gQEAgLTUwOTIsNiArNTA5Myw3IEBAIHN0YXRpYyBpbnQgaHBzYV9zY3NpX2lv
YWNjZWxfcmFpZF9tYXAoc3RydWN0IGN0bHJfaW5mbyAqaCwNCj4goKCgoKCgoCBzd2l0Y2gg
KGNtZC0+Y21uZFswXSkgew0KPiCgoKCgoKCgIGNhc2UgV1JJVEVfNjoNCj4goKCgoKCgoKCg
oKCgoKCgIGlzX3dyaXRlID0gMTsNCj4gK6CgoKCgoKCgoKCgoKCgIC8qIGZhbGwgdGhyb3Vn
aCAqLw0KPiCgoKCgoKCgIGNhc2UgUkVBRF82Og0KPiCgoKCgoKCgoKCgoKCgoKAgZmlyc3Rf
YmxvY2sgPSAoKChjbWQtPmNtbmRbMV0gJiAweDFGKSA8PCAxNikgfA0KPiCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgIChjbWQtPmNtbmRbMl0gPDwgOCkgfA0KPiBAQCAtNTEw
Miw2ICs1MTA0LDcgQEAgc3RhdGljIGludCBocHNhX3Njc2lfaW9hY2NlbF9yYWlkX21hcChz
dHJ1Y3QgY3Rscl9pbmZvICpoLA0KPiCgoKCgoKCgoKCgoKCgoKAgYnJlYWs7DQo+IKCgoKCg
oKAgY2FzZSBXUklURV8xMDoNCj4goKCgoKCgoKCgoKCgoKCgIGlzX3dyaXRlID0gMTsNCj4g
K6CgoKCgoKCgoKCgoKCgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPiCgoKCgoKCgIGNhc2UgUkVB
RF8xMDoNCj4goKCgoKCgoKCgoKCgoKCgIGZpcnN0X2Jsb2NrID0NCj4goKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKAgKCgodTY0KSBjbWQtPmNtbmRbMl0pIDw8IDI0KSB8DQo+IEBAIC01MTE0
LDYgKzUxMTcsNyBAQCBzdGF0aWMgaW50IGhwc2Ffc2NzaV9pb2FjY2VsX3JhaWRfbWFwKHN0
cnVjdCBjdGxyX2luZm8gKmgsDQo+IKCgoKCgoKCgoKCgoKCgoCBicmVhazsNCj4goKCgoKCg
oCBjYXNlIFdSSVRFXzEyOg0KPiCgoKCgoKCgoKCgoKCgoKAgaXNfd3JpdGUgPSAxOw0KPiAr
oKCgoKCgoKCgoKCgoKAgLyogZmFsbCB0aHJvdWdoICovDQo+IKCgoKCgoKAgY2FzZSBSRUFE
XzEyOg0KPiCgoKCgoKCgoKCgoKCgoKAgZmlyc3RfYmxvY2sgPQ0KPiCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCAoKCh1NjQpIGNtZC0+Y21uZFsyXSkgPDwgMjQpIHwNCj4gQEAgLTUxMjgs
NiArNTEzMiw3IEBAIHN0YXRpYyBpbnQgaHBzYV9zY3NpX2lvYWNjZWxfcmFpZF9tYXAoc3Ry
dWN0IGN0bHJfaW5mbyAqaCwNCj4goKCgoKCgoKCgoKCgoKCgIGJyZWFrOw0KPiCgoKCgoKCg
IGNhc2UgV1JJVEVfMTY6DQo+IKCgoKCgoKCgoKCgoKCgoCBpc193cml0ZSA9IDE7DQo+ICug
oKCgoKCgoKCgoKCgoCAvKiBmYWxsIHRocm91Z2ggKi8NCj4goKCgoKCgoCBjYXNlIFJFQURf
MTY6DQo+IKCgoKCgoKCgoKCgoKCgoCBmaXJzdF9ibG9jayA9DQo+IKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgICgoKHU2NCkgY21kLT5jbW5kWzJdKSA8PCA1NikgfA0KPiANCj4goA0KPiAN
Cj4gVGVzdGVkLWJ5OiBEb24gQnJhY2UgPGRvbi5icmFjZUBtaWNyb3NlbWkuY29tPg0KPiBB
Y2tlZC1ieTogRG9uIEJyYWNlIDxkb24uYnJhY2VAbWljcm9zZW1pLmNvbT4NCj4gDQoNClRo
YW5rcyBmb3IgdGhpcywgYnV0IHBsZWFzZSBkb24ndCByZW1vdmUgdGhlIENvdmVyaXR5IHRh
Z3MuDQoNCi0tDQpHdXN0YXZvDQo=
