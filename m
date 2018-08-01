Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FF2C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10539208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10539208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didichuxing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeHAEK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 00:10:58 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:25573 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1725872AbeHAEK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 00:10:57 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Aug 2018 00:10:47 EDT
X-ASG-Debug-ID: 1533089824-0e4088207339e640001-xx1T2L
Received: from BJEXCAS003.didichuxing.com ([172.20.1.43]) by bsf01.didichuxing.com with ESMTP id 9YSTt8LBJvzJRdIW; Wed, 01 Aug 2018 10:17:04 +0800 (CST)
X-Barracuda-Envelope-From: yuzhoujian@didichuxing.com
Received: from BJSGEXMBX10.didichuxing.com (172.20.15.140) by
 BJSGEXMBX10.didichuxing.com (172.20.15.140) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Wed, 1 Aug 2018 10:17:04 +0800
Received: from BJSGEXMBX10.didichuxing.com ([fe80::a436:8e81:8635:1818]) by
 BJSGEXMBX10.didichuxing.com ([fe80::a436:8e81:8635:1818%22]) with mapi id
 15.00.1263.000; Wed, 1 Aug 2018 10:17:04 +0800
From:   =?gb2312?B?0+3W272hKLv5tKHGvcyosr8p?= <yuzhoujian@didichuxing.com>
To:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>
CC:     kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, "lkp@01.org" <lkp@01.org>
Subject: Re: [LKP] [mm, oom]  c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
Thread-Topic: [LKP] [mm, oom]  c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
X-ASG-Orig-Subj: Re: [LKP] [mm, oom]  c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
Thread-Index: AdQpPbgwC23d4h0LRx6Pf9dW6T3uUg==
Date:   Wed, 1 Aug 2018 02:17:04 +0000
Message-ID: <0d4090532f15434aa71779e9dc8a0014@BJSGEXMBX10.didichuxing.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.14.140]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[172.20.1.43]
X-Barracuda-Start-Time: 1533089824
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 4462
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0203
X-Barracuda-Spam-Score: -1.82
X-Barracuda-Spam-Status: No, SCORE=-1.82 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=PR0N_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.54863
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.20 PR0N_SUBJECT           Subject has letters around special characters (pr0n)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T0ssIG5vIHByb2JsZW1zLg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogTWljaGFsIEhv
Y2tvIDxtaG9ja29Aa2VybmVsLm9yZz4gDQq3osvNyrG85DogMjAxOMTqN9TCMzHI1SAxNDo1NQ0K
ytW8/sjLOiBEYXZpZCBSaWVudGplcyA8cmllbnRqZXNAZ29vZ2xlLmNvbT47INPt1tu9oSi7+bSh
xr3MqLK/KSA8eXV6aG91amlhbkBkaWRpY2h1eGluZy5jb20+DQqzrcvNOiBrZXJuZWwgdGVzdCBy
b2JvdCA8cm9uZy5hLmNoZW5AaW50ZWwuY29tPjsgU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIu
YXV1Zy5vcmcuYXU+OyBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5p
bnRlbC5jb20+OyBBbmRyZWEgQXJjYW5nZWxpIDxhYXJjYW5nZUByZWRoYXQuY29tPjsgVGV0c3Vv
IEhhbmRhIDxwZW5ndWluLWtlcm5lbEBpLWxvdmUuc2FrdXJhLm5lLmpwPjsgUm9tYW4gR3VzaGNo
aW4gPGd1cm9AZmIuY29tPjsgWWFuZyBTaGkgPHlhbmcuc0BhbGliYWJhLWluYy5jb20+OyBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTEtNTCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IGxrcEAwMS5vcmcNCtb3zOI6IFu0y9PKvP7SycvGzqrArLv408q8
/l0gUmU6IFtMS1BdIFttbSwgb29tXSBjMWU0YzU0ZjljOiBCVUc6S0FTQU46bnVsbC1wdHItZGVy
ZWZfaW5fZA0KDQpPbiBNb24gMzAtMDctMTggMTk6MDU6NTAsIERhdmlkIFJpZW50amVzIHdyb3Rl
Og0KPiBPbiBNb24sIDMwIEp1bCAyMDE4LCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+IA0KPiA+IE9u
IE1vbiAzMC0wNy0xOCAxNzowMzoyMCwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+ID4gWy4u
Ll0NCj4gPiA+IFsgICAgOS4wMzQzMTBdIEJVRzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIGR1
bXBfaGVhZGVyKzB4MTBjLzB4NDQ4DQo+ID4gDQo+ID4gQ291bGQgeW91IGZhZGRyMmxpbmUgb24g
dGhlIG9mZnNldCBwbGVhc2U/DQo+ID4gDQo+IA0KPiBJdCdzIHBvc3NpYmxlIHRoYXQgcCBpcyBO
VUxMIHdoZW4gY2FsbGluZyBkdW1wX2hlYWRlcigpLiAgSW4gdGhpcyBjYXNlIA0KPiB3ZSBkbyBu
b3Qgd2FudCB0byBwcmludCBhbnkgbGluZSBjb25jZXJuaW5nIGEgdmljdGltIGJlY2F1c2Ugbm8g
b29tIA0KPiBraWxsIGhhcyBvY2N1cnJlZC4NCg0KWW91IGFyZSByaWdodC4gSSBoYXZlIG1pc3Nl
ZCB0aG9zZS4NCg0KPiBUaGlzIGNvZGUgc2hvdWxkbid0IGJlIHBhcnQgb2YgZHVtcF9oZWFkZXIo
KSwgd2hpY2ggaXMgY2FsbGVkIGZyb20gDQo+IG11bHRpcGxlIGNvbnRleHRzIGV2ZW4gd2hlbiBh
biBvb20ga2lsbCBoYXMgbm90IG9jY3VycmVkLCBhbmQgaXMgDQo+IHJhdGVsaW1pdGVkLiAgVGhl
IHNpbmdsZSBsaW5lIG91dHB1dCBzaG91bGQgYmUgdGhlIGNhbm9uaWNhbCB3YXkgdGhhdCANCj4g
dXNlcnNwYWNlIHBhcnNlcyB0aGUgbG9nIGZvciBvb20gdmljdGltcywgd2UgY2FuJ3QgcmF0ZWxp
bWl0IGl0Lg0KPiANCj4gVGhlIGZvbGxvd2luZyB3b3VsZCBiZSBhIGZpeCBwYXRjaCwgYnV0IGl0
IHdpbGwgYmUgYnJva2VuIGlmIHRoZSANCj4gY2dyb3VwIGF3YXJlIG9vbSBraWxsZXIgaXMgcmVt
b3ZlZCBmcm9tIC1tbSBzbyB0aGF0IHRoZSBvb21fZ3JvdXAgDQo+IHN0dWZmIGNhbiBiZSBtZXJn
ZWQuDQoNCmNncm91cCBhd2FyZSBvb20ga2lsbGVyIGlzIGdvaW5nIHRvIGJlIHJlcGxhY2VkIGJ5
IGEgbmV3IGltcGxlbWVudGF0aW9uIElJVUMgc28gdGhlIGZpeCBzaG91bGQgYmUgYmFzZWQgb24g
dGhlIHl1emhvdWppYW4gcGF0Y2guIElkZWFsbHkgdG8gYmUgcmVzdWJtaXR0ZWQuDQoNCkkgd291
bGQganVzdCBzdWdnZXN0IGFkZGluZyBpdCBpbnRvIGEgZnVuY3Rpb24gZHVtcF9vb21fc3VtbWFy
eShzdHJ1Y3Qgb29tX2NvbnRyb2wgKm9jLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApDQoNCnl1emhv
dWppYW4gY291bGQgeW91IHRha2UgY2FyZSBvZiB0aGF0IHBsZWFzZT8NCg0KPiBkaWZmIC0tZ2l0
IGEvbW0vb29tX2tpbGwuYyBiL21tL29vbV9raWxsLmMNCj4gLS0tIGEvbW0vb29tX2tpbGwuYw0K
PiArKysgYi9tbS9vb21fa2lsbC5jDQo+IEBAIC00MzgsMTQgKzQzOCw2IEBAIHN0YXRpYyB2b2lk
IGR1bXBfaGVhZGVyKHN0cnVjdCBvb21fY29udHJvbCAqb2MsIA0KPiBzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnApDQo+ICANCj4gIAlkdW1wX3N0YWNrKCk7DQo+ICANCj4gLQkvKiBvbmUgbGluZSBzdW1t
YXJ5IG9mIHRoZSBvb20ga2lsbGVyIGNvbnRleHQuICovDQo+IC0JcHJfaW5mbygib29tLWtpbGw6
Y29uc3RyYWludD0lcyxub2RlbWFzaz0lKnBibCIsDQo+IC0JCQlvb21fY29uc3RyYWludF90ZXh0
W29jLT5jb25zdHJhaW50XSwNCj4gLQkJCW5vZGVtYXNrX3ByX2FyZ3Mob2MtPm5vZGVtYXNrKSk7
DQo+IC0JY3B1c2V0X3ByaW50X2N1cnJlbnRfbWVtc19hbGxvd2VkKCk7DQo+IC0JbWVtX2Nncm91
cF9wcmludF9vb21fY29udGV4dChvYy0+bWVtY2csIHApOw0KPiAtCXByX2NvbnQoIix0YXNrPSVz
LHBpZD0lZCx1aWQ9JWRcbiIsIHAtPmNvbW0sIHAtPnBpZCwNCj4gLQkJZnJvbV9rdWlkKCZpbml0
X3VzZXJfbnMsIHRhc2tfdWlkKHApKSk7DQo+ICAJaWYgKGlzX21lbWNnX29vbShvYykpDQo+ICAJ
CW1lbV9jZ3JvdXBfcHJpbnRfb29tX21lbWluZm8ob2MtPm1lbWNnKTsNCj4gIAllbHNlIHsNCj4g
QEAgLTgzNiw3ICs4MjgsOCBAQCBzdGF0aWMgYm9vbCB0YXNrX3dpbGxfZnJlZV9tZW0oc3RydWN0
IHRhc2tfc3RydWN0ICp0YXNrKQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gLXN0YXRp
YyB2b2lkIF9fb29tX2tpbGxfcHJvY2VzcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnZpY3RpbSkNCj4g
K3N0YXRpYyB2b2lkIF9fb29tX2tpbGxfcHJvY2VzcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnZpY3Rp
bSwNCj4gKwkJCSAgICAgICBzdHJ1Y3Qgb29tX2NvbnRyb2wgKm9jKQ0KPiAgew0KPiAgCXN0cnVj
dCB0YXNrX3N0cnVjdCAqcDsNCj4gIAlzdHJ1Y3QgbW1fc3RydWN0ICptbTsNCj4gQEAgLTg4Myw2
ICs4NzYsMTggQEAgc3RhdGljIHZvaWQgX19vb21fa2lsbF9wcm9jZXNzKHN0cnVjdCB0YXNrX3N0
cnVjdCAqdmljdGltKQ0KPiAgCQlLKGdldF9tbV9jb3VudGVyKHZpY3RpbS0+bW0sIE1NX0FOT05Q
QUdFUykpLA0KPiAgCQlLKGdldF9tbV9jb3VudGVyKHZpY3RpbS0+bW0sIE1NX0ZJTEVQQUdFUykp
LA0KPiAgCQlLKGdldF9tbV9jb3VudGVyKHZpY3RpbS0+bW0sIE1NX1NITUVNUEFHRVMpKSk7DQo+
ICsNCj4gKwlpZiAob2MpIHsNCj4gKwkJLyogT25lIGxpbmUgc3VtbWFyeSBmb3Igbm9uLWdyb3Vw
IG9vbSBraWxscyAqLw0KPiArCQlwcl9pbmZvKCJvb20ta2lsbDogY29uc3RyYWludD0lcywgbm9k
ZW1hc2s9JSpwYmwiLA0KPiArCQkJb29tX2NvbnN0cmFpbnRfdGV4dFtvYy0+Y29uc3RyYWludF0s
DQo+ICsJCQlub2RlbWFza19wcl9hcmdzKG9jLT5ub2RlbWFzaykpOw0KPiArCQljcHVzZXRfcHJp
bnRfY3VycmVudF9tZW1zX2FsbG93ZWQoKTsNCj4gKwkJbWVtX2Nncm91cF9wcmludF9vb21fY29u
dGV4dChvYy0+bWVtY2csIHZpY3RpbSk7DQo+ICsJCXByX2NvbnQoIiwgdGFzaz0lcywgcGlkPSVk
LCB1aWQ9JWRcbiIsDQo+ICsJCQl2aWN0aW0tPmNvbW0sIHZpY3RpbS0+cGlkLA0KPiArCQkJZnJv
bV9rdWlkKCZpbml0X3VzZXJfbnMsIHRhc2tfdWlkKHZpY3RpbSkpKTsNCj4gKwl9DQo+ICAJdGFz
a191bmxvY2sodmljdGltKTsNCj4gIA0KPiAgCS8qDQo+IEBAIC05ODYsMTMgKzk5MSwxMyBAQCBz
dGF0aWMgdm9pZCBvb21fa2lsbF9wcm9jZXNzKHN0cnVjdCBvb21fY29udHJvbCAqb2MsIGNvbnN0
IGNoYXIgKm1lc3NhZ2UpDQo+ICAJfQ0KPiAgCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsN
Cj4gIA0KPiAtCV9fb29tX2tpbGxfcHJvY2Vzcyh2aWN0aW0pOw0KPiArCV9fb29tX2tpbGxfcHJv
Y2Vzcyh2aWN0aW0sIG9jKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBvb21fa2lsbF9tZW1j
Z19tZW1iZXIoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCB2b2lkIA0KPiAqdW51c2VkKSAgew0K
PiAgCWdldF90YXNrX3N0cnVjdCh0YXNrKTsNCj4gLQlfX29vbV9raWxsX3Byb2Nlc3ModGFzayk7
DQo+ICsJX19vb21fa2lsbF9wcm9jZXNzKHRhc2ssIE5VTEwpOw0KPiAgCXJldHVybiAwOw0KPiAg
fQ0KPiAgDQo+IEBAIC0xMDIwLDcgKzEwMjUsNyBAQCBzdGF0aWMgYm9vbCBvb21fa2lsbF9tZW1j
Z192aWN0aW0oc3RydWN0IG9vbV9jb250cm9sICpvYykNCj4gIAkJICAgIG9jLT5jaG9zZW5fdGFz
ayA9PSBJTkZMSUdIVF9WSUNUSU0pDQo+ICAJCQlnb3RvIG91dDsNCj4gIA0KPiAtCQlfX29vbV9r
aWxsX3Byb2Nlc3Mob2MtPmNob3Nlbl90YXNrKTsNCj4gKwkJX19vb21fa2lsbF9wcm9jZXNzKG9j
LT5jaG9zZW5fdGFzaywgb2MpOw0KPiAgCX0NCj4gIA0KPiAgb3V0Og0KDQotLQ0KTWljaGFsIEhv
Y2tvDQpTVVNFIExhYnMNCg==
