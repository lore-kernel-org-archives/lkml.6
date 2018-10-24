Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22826ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55B620831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55B620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeJYHUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:20:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:54991 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYHUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:20:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 15:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="98333195"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2018 15:50:22 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 15:50:22 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 15:50:22 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.139]) with mapi id 14.03.0415.000;
 Wed, 24 Oct 2018 16:50:20 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
Thread-Topic: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
Thread-Index: AQHUT6S8E0XwPCm1jkGysv7aiho556UvXU2A//+dxwCAAGf+AP//m/AwgABp3oD//87bgA==
Date:   Wed, 24 Oct 2018 22:50:19 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66CCBF6F@CRSMSX101.amr.corp.intel.com>
References: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
 <1537312139-5580-3-git-send-email-chang.seok.bae@intel.com>
 <CALCETrUr3DGwW8y6y_cffEKWO_KQs1J2_UvTBZsbdAzES_f-Ag@mail.gmail.com>
 <C9BB696F3A938947B10DCAD29FAB8FFA66CCBBE3@CRSMSX101.amr.corp.intel.com>
 <CALCETrWMMQDa4T0m34GfkkYBxqwGUOg96aeWgiANRv9tCvQVRw@mail.gmail.com>
 <C9BB696F3A938947B10DCAD29FAB8FFA66CCBC7E@CRSMSX101.amr.corp.intel.com>
 <CALCETrV=dJ-3CGM3oB7xgNYsKE_Tbpu5i7H4qwKpuNmEsjyL_A@mail.gmail.com>
In-Reply-To: <CALCETrV=dJ-3CGM3oB7xgNYsKE_Tbpu5i7H4qwKpuNmEsjyL_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGE1NDcxMjItODE4MC00ZDAzLTg4MmItZDMxNWI3YjAyZDAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYTZKdnUyNFNEWEpUZVh5K1BpMERlOEJxXC9JV3NuaGFacnc0NXU5UlpacHBnUWZaM1wvbjVkd29QRzEwZ2dtaG9XIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBPY3QgMjQsIDIwMTggYXQgMTI6NDMgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiBJIHRoaW5rIHg4Nl9mc2Jhc2Vfd3JpdGVfdGFzaygpIG1ha2Vz
IHBsZW50eSBvZiBzZW5zZSwgYnV0IEkgdGhpbmsNCj4gdGhhdCBjYWxsZXJzIG5lZWQgdG8gYmUg
YXdhcmUgdGhhdCB0aGUgZWZmZWN0IG9mIHdyaXRpbmcgYSBub256ZXJvDQo+IGZzYmFzZSAqYW5k
KiBhIG5vbnplcm8gZnNpbmRleCBpcyBiaXphcnJlIG9uIG5vbi1GU0dTQkFTRSBzeXN0ZW1zLiAg
U28NCj4gdGhhdCBjb2RlIHNob3VsZCBnbyBpbiB0aGUgY2FsbGVycy4gIFRoZSBvZGRpdGllcyBp
bnZvbHZlZCBoYXZlIGxpdHRsZQ0KPiB0byBkbyB3aXRoIHdoZXRoZXIgdGhlIGNhbGxlciBpcyB3
cml0aW5nIHRvIGN1cnJlbnQgb3IgdG8gc29tZXRoaW5nDQo+IGVsc2UuDQo+IA0KPiBBcmd1YWJs
eSB0aGUgY29kZSBzaG91bGQgYmUgZW50aXJlbHkgc3BsaXQgb3V0IGludG8gdGhlIGNvZGUgdGhh
dA0KPiB3cml0ZXMgY3VycmVudCAoYXJjaF9wcmN0bCgpKSBhbmQgdGhlIGNvZGUgdGhhdCB3cml0
ZXMgYSBzdG9wcGVkIHRhc2sNCj4gKHB0cmFjZSkuICBJIGRvbid0IHRoaW5rIHRoZXJlIGFyZSBh
bnkgY29kZSBwYXRocyB0aGF0IGdlbnVpbmVseSBjYW4NCj4gd3JpdGUgZWl0aGVyLg0KPiANCg0K
Q2FuIHlvdSBjaGVjayB0aGlzIHBhdGNoIGlzIGNsb3NlIHRvIHdoYXQgaW4geW91ciBtaW5kPw0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYyBiL2FyY2gveDg2L2tl
cm5lbC9wcm9jZXNzXzY0LmMNCmluZGV4IGQ2Njc0YTQyNTcxNC4uNWY5ODZlMTU4NDJlIDEwMDY0
NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYw0KKysrIGIvYXJjaC94ODYva2Vy
bmVsL3Byb2Nlc3NfNjQuYw0KQEAgLTM0MSwxOSArMzQxLDExIEBAIHN0YXRpYyB1bnNpZ25lZCBs
b25nIHg4Nl9mc2dzYmFzZV9yZWFkX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLA0KIA0K
IHZvaWQgeDg2X2ZzYmFzZV93cml0ZV9jcHUodW5zaWduZWQgbG9uZyBmc2Jhc2UpDQogew0KLQkv
Kg0KLQkgKiBTZXQgdGhlIHNlbGVjdG9yIHRvIDAgYXMgYSBub3Rpb24sIHRoYXQgdGhlIHNlZ21l
bnQgYmFzZSBpcw0KLQkgKiBvdmVyd3JpdHRlbiwgd2hpY2ggd2lsbCBiZSBjaGVja2VkIGZvciBz
a2lwcGluZyB0aGUgc2VnbWVudCBsb2FkDQotCSAqIGR1cmluZyBjb250ZXh0IHN3aXRjaC4NCi0J
ICovDQotCWxvYWRzZWcoRlMsIDApOw0KIAl3cm1zcmwoTVNSX0ZTX0JBU0UsIGZzYmFzZSk7DQog
fQ0KIA0KIHZvaWQgeDg2X2dzYmFzZV93cml0ZV9jcHVfaW5hY3RpdmUodW5zaWduZWQgbG9uZyBn
c2Jhc2UpDQogew0KLQkvKiBTZXQgdGhlIHNlbGVjdG9yIHRvIDAgZm9yIHRoZSBzYW1lIHJlYXNv
biBhcyAlZnMgYWJvdmUuICovDQotCWxvYWRzZWcoR1MsIDApOw0KIAl3cm1zcmwoTVNSX0tFUk5F
TF9HU19CQVNFLCBnc2Jhc2UpOw0KIH0NCiANCkBAIC0zNjEsOSArMzUzLDcgQEAgdW5zaWduZWQg
bG9uZyB4ODZfZnNiYXNlX3JlYWRfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2spDQogew0K
IAl1bnNpZ25lZCBsb25nIGZzYmFzZTsNCiANCi0JaWYgKHRhc2sgPT0gY3VycmVudCkNCi0JCWZz
YmFzZSA9IHg4Nl9mc2Jhc2VfcmVhZF9jcHUoKTsNCi0JZWxzZSBpZiAodGFzay0+dGhyZWFkLmZz
aW5kZXggPT0gMCkNCisJaWYgKHRhc2stPnRocmVhZC5mc2luZGV4ID09IDApDQogCQlmc2Jhc2Ug
PSB0YXNrLT50aHJlYWQuZnNiYXNlOw0KIAllbHNlDQogCQlmc2Jhc2UgPSB4ODZfZnNnc2Jhc2Vf
cmVhZF90YXNrKHRhc2ssIHRhc2stPnRocmVhZC5mc2luZGV4KTsNCkBAIC0zNzUsOSArMzY1LDcg
QEAgdW5zaWduZWQgbG9uZyB4ODZfZ3NiYXNlX3JlYWRfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRhc2spDQogew0KIAl1bnNpZ25lZCBsb25nIGdzYmFzZTsNCiANCi0JaWYgKHRhc2sgPT0gY3Vy
cmVudCkNCi0JCWdzYmFzZSA9IHg4Nl9nc2Jhc2VfcmVhZF9jcHVfaW5hY3RpdmUoKTsNCi0JZWxz
ZSBpZiAodGFzay0+dGhyZWFkLmdzaW5kZXggPT0gMCkNCisJaWYgKHRhc2stPnRocmVhZC5nc2lu
ZGV4ID09IDApDQogCQlnc2Jhc2UgPSB0YXNrLT50aHJlYWQuZ3NiYXNlOw0KIAllbHNlDQogCQln
c2Jhc2UgPSB4ODZfZnNnc2Jhc2VfcmVhZF90YXNrKHRhc2ssIHRhc2stPnRocmVhZC5nc2luZGV4
KTsNCkBAIC0zOTYsOCArMzg0LDYgQEAgaW50IHg4Nl9mc2Jhc2Vfd3JpdGVfdGFzayhzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRhc2ssIHVuc2lnbmVkIGxvbmcgZnNiYXNlKQ0KIA0KIAlwcmVlbXB0X2Rp
c2FibGUoKTsNCiAJdGFzay0+dGhyZWFkLmZzYmFzZSA9IGZzYmFzZTsNCi0JaWYgKHRhc2sgPT0g
Y3VycmVudCkNCi0JCXg4Nl9mc2Jhc2Vfd3JpdGVfY3B1KGZzYmFzZSk7DQogCXRhc2stPnRocmVh
ZC5mc2luZGV4ID0gMDsNCiAJcHJlZW1wdF9lbmFibGUoKTsNCiANCkBAIC00MTEsOCArMzk3LDYg
QEAgaW50IHg4Nl9nc2Jhc2Vfd3JpdGVfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIHVu
c2lnbmVkIGxvbmcgZ3NiYXNlKQ0KIA0KIAlwcmVlbXB0X2Rpc2FibGUoKTsNCiAJdGFzay0+dGhy
ZWFkLmdzYmFzZSA9IGdzYmFzZTsNCi0JaWYgKHRhc2sgPT0gY3VycmVudCkNCi0JCXg4Nl9nc2Jh
c2Vfd3JpdGVfY3B1X2luYWN0aXZlKGdzYmFzZSk7DQogCXRhc2stPnRocmVhZC5nc2luZGV4ID0g
MDsNCiAJcHJlZW1wdF9lbmFibGUoKTsNCiANCkBAIC03NjEsMjAgKzc0NSw0MiBAQCBsb25nIGRv
X2FyY2hfcHJjdGxfNjQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBpbnQgb3B0aW9uLCB1bnNp
Z25lZCBsb25nIGFyZzIpDQogCXN3aXRjaCAob3B0aW9uKSB7DQogCWNhc2UgQVJDSF9TRVRfR1M6
IHsNCiAJCXJldCA9IHg4Nl9nc2Jhc2Vfd3JpdGVfdGFzayh0YXNrLCBhcmcyKTsNCisJCWlmICh0
YXNrID09IGN1cnJlbnQgJiYgcmV0ID09IDApIHsNCisJCQlwcmVlbXB0X2Rpc2FibGUoKTsNCisJ
CQlsb2Fkc2VnKEdTLCAwKTsNCisJCQl4ODZfZ3NiYXNlX3dyaXRlX2NwdV9pbmFjdGl2ZSgpOw0K
KwkJCXByZWVtcHRfZW5hYmxlKCk7DQorCQl9DQogCQlicmVhazsNCiAJfQ0KIAljYXNlIEFSQ0hf
U0VUX0ZTOiB7DQogCQlyZXQgPSB4ODZfZnNiYXNlX3dyaXRlX3Rhc2sodGFzaywgYXJnMik7DQor
CQlpZiAodGFzayA9PSBjdXJyZW50ICYmIHJldCA9PSAwKSB7DQorCQkJcHJlZW1wdF9kaXNhYmxl
KCk7DQorCQkJbG9hZHNlZyhGUywgMCk7DQorCQkJeDg2X2ZzYmFzZV93cml0ZV9jcHUoKTsNCisJ
CQlwcmVlbXB0X2VuYWJsZSgpOw0KKwkJfQ0KIAkJYnJlYWs7DQogCX0NCiAJY2FzZSBBUkNIX0dF
VF9GUzogew0KLQkJdW5zaWduZWQgbG9uZyBiYXNlID0geDg2X2ZzYmFzZV9yZWFkX3Rhc2sodGFz
ayk7DQorCQl1bnNpZ25lZCBsb25nIGJhc2U7DQorDQorCQlpZiAodGFzayA9PSBjdXJyZW50KQ0K
KwkJCWJhc2UgPSB4ODZfZnNiYXNlX3JlYWRfY3B1KCk7DQorCQllbHNlDQorCQkJYmFzZSA9IHg4
Nl9mc2Jhc2VfcmVhZF90YXNrKHRhc2spOw0KIA0KIAkJcmV0ID0gcHV0X3VzZXIoYmFzZSwgKHVu
c2lnbmVkIGxvbmcgX191c2VyICopYXJnMik7DQogCQlicmVhazsNCiAJfQ0KIAljYXNlIEFSQ0hf
R0VUX0dTOiB7DQotCQl1bnNpZ25lZCBsb25nIGJhc2UgPSB4ODZfZ3NiYXNlX3JlYWRfdGFzayh0
YXNrKTsNCisJCXVuc2lnbmVkIGxvbmcgYmFzZTsNCisNCisJCWlmICh0YXNrID09IGN1cnJlbnQp
DQorCQkJYmFzZSA9IHg4Nl9nc2Jhc2VfcmVhZF9jcHVfaW5hY3RpdmUoKTsNCisJCWVsc2UNCisJ
CQliYXNlID0geDg2X2dzYmFzZV9yZWFkX3Rhc2sodGFzayk7DQogDQogCQlyZXQgPSBwdXRfdXNl
cihiYXNlLCAodW5zaWduZWQgbG9uZyBfX3VzZXIgKilhcmcyKTsNCiAJCWJyZWFrOw0K
