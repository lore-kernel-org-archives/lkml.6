Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3946841-1521634679-2-15293297303288349248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensvda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521634679; b=YJ0UEMCVepjtl9xIIrHAZaKe4ebFIMywWb1HgIDOumjqfZx
    W3yOtpP3IVCHNscBCxgwUwahhXZ3uaIK35ZO/4Zg3bF3esn83wwKmxwWAuH3cErZ
    Rlu7Ox1zMYpg8CCS4co+LYNbp9tsNMY4aMAD3k2IbTqOdSJI+BDKVGEp71BDJSkT
    cMhmYKoCkYKOq+BuSzFLK5nqjeGq/FLG7ZevQXaTpfWvs/Z9ASmkykyI2zqn4O7U
    u0IFf+HZRElfNydGKu5rngh+HuRxjjV+e2BEcgj643Src6XS1pPUf6fx9FFtmY+l
    wofaP1Hgnn1afqcTLJkiO6Qwmbu2vKkceSD/pQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521634679; bh=S
    wvIipt+55waL3p1yQjy5ICZg4t6zS6o7nfQKqvgSHg=; b=uNFYmc9fdXqMsUpiG
    A04nlEEpHewhkY3JqePd+eTKGQUiA2pNGDvmZnIursuWRy8kAgKFWwpDlDebvGZN
    k35mO2xa8VYMXfy6bFGMKPSP3GHjNN0KtqcXh+TFfskdy4mGK8X0Repslx43vJPC
    k/DDnjOrn3WprHPR6/0PH9eUyGYlfnXpj/qcTG1uoZt+l0oX2m4SIXa4hEc1Ta/U
    zcBpXIIQ3S1Jd6lmEE/PpstIVkxUBs2V/ZkFpTi5wJOcKQksxt6xOpxA4J9ebf4i
    JoT4bfRQlvoQxu73hnjMTgOqltPBGfzvyrWGI5qnZ75Axt+zYlvPpV/8erpovXmz
    5nP+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YGDR1OWG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DXDbD6T4;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YGDR1OWG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DXDbD6T4;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt/Mb0bgMhypkyEHjUc+II+hbcEfjTc8hcyfj9H7e/x5D4VwLkecrZbQ38lBjAvMwqs/JXHXn46sslDHbBrSAQ=
MIME-Version: 1.0
In-Reply-To: <faa92f0e20fc44019ee0b64b04413d69@AcuMS.aculab.com>
References: <20180321111604.9902-1-hariprasath.elango@gmail.com>
 <faa92f0e20fc44019ee0b64b04413d69@AcuMS.aculab.com>
From: Denis Kirjanov <kirjanov@gmail.com>
Date: Wed, 21 Mar 2018 15:17:51 +0300
Message-ID: <CAHj3AVkQMn26EGtYzu3R2TgDMAaijXoJXnAV3f94eUui6kWtJA@mail.gmail.com>
Subject: Re: [PATCH] staging: fsl-dpaa2: replace simple switch case by if
 statement
To: David Laight <David.Laight@aculab.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "hariprasath.elango@gmail.com" <hariprasath.elango@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMy8yMS8xOCwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6
Cj4gRnJvbTogPiBoYXJpcHJhc2F0aC5lbGFuZ29AZ21haWwuY29tCj4+IFNlbnQ6IDIxIE1hcmNo
IDIwMTggMTE6MTYKPj4gRnJvbTogSGFyaVByYXNhdGggRWxhbmdvIDxoYXJpcHJhc2F0aC5lbGFu
Z29AZ21haWwuY29tPgo+Pgo+PiBSZXBsYWNlIGEgY291cGxlIG9mIHNpbXBsZSBzd2l0Y2ggY2Fz
ZXMgYnkgaWYgY29uZGl0aW9uCj4KPiBXaHk/Cj4gSW4gcHJpbmNpcGxlIGV4dHJhICdjYXNlJyBt
aWdodCBiZSBuZWVkZWQgaW4gdGhlIGZ1dHVyZS4KCkkgaGFkIHRoZSBzYW1lIHF1ZXN0aW9uIHdo
ZW4gc2F3IGl0LgpJdCdzIGJldHRlciB0byBrZWVwIHRoaW5ncyBhcyBpcy4KPgo+IC4uLgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2ZzbC1kcGFhMi9ldGhlcm5ldC9kcGFhMi1ldGh0
b29sLmMKPj4gYi9kcml2ZXJzL3N0YWdpbmcvZnNsLQo+PiBkcGFhMi9ldGhlcm5ldC9kcGFhMi1l
dGh0b29sLmMKPj4gaW5kZXggMDcwYTNmMi4uZmI1MTdjYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9zdGFnaW5nL2ZzbC1kcGFhMi9ldGhlcm5ldC9kcGFhMi1ldGh0b29sLmMKPj4gKysrIGIvZHJp
dmVycy9zdGFnaW5nL2ZzbC1kcGFhMi9ldGhlcm5ldC9kcGFhMi1ldGh0b29sLmMKPj4gQEAgLTE3
MSw4ICsxNzEsNyBAQCBzdGF0aWMgdm9pZCBkcGFhMl9ldGhfZ2V0X3N0cmluZ3Moc3RydWN0IG5l
dF9kZXZpY2UKPj4gKm5ldGRldiwgdTMyIHN0cmluZ3NldCwKPj4gIAl1OCAqcCA9IGRhdGE7Cj4+
ICAJaW50IGk7Cj4+Cj4+IC0Jc3dpdGNoIChzdHJpbmdzZXQpIHsKPj4gLQljYXNlIEVUSF9TU19T
VEFUUzoKPj4gKwlpZiAoc3RyaW5nc2V0ID09IEVUSF9TU19TVEFUUykgewo+PiAgCQlmb3IgKGkg
PSAwOyBpIDwgRFBBQTJfRVRIX05VTV9TVEFUUzsgaSsrKSB7Cj4+ICAJCQlzdHJsY3B5KHAsIGRw
YWEyX2V0aHRvb2xfc3RhdHNbaV0sIEVUSF9HU1RSSU5HX0xFTik7Cj4+ICAJCQlwICs9IEVUSF9H
U1RSSU5HX0xFTjsKPj4gQEAgLTE4MSwxOCArMTgwLDE2IEBAIHN0YXRpYyB2b2lkIGRwYWEyX2V0
aF9nZXRfc3RyaW5ncyhzdHJ1Y3QgbmV0X2RldmljZQo+PiAqbmV0ZGV2LCB1MzIgc3RyaW5nc2V0
LAo+PiAgCQkJc3RybGNweShwLCBkcGFhMl9ldGh0b29sX2V4dHJhc1tpXSwgRVRIX0dTVFJJTkdf
TEVOKTsKPj4gIAkJCXAgKz0gRVRIX0dTVFJJTkdfTEVOOwo+PiAgCQl9Cj4+IC0JCWJyZWFrOwo+
PiAgCX0KPj4gIH0KPiAuLi4KPgo+IAlEYXZpZAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBkZXZlbCBtYWlsaW5nIGxpc3QKPiBkZXZlbEBsaW51
eGRyaXZlcnByb2plY3Qub3JnCj4gaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCj4KCgotLSAKUmVnYXJkcyAvIE1p
dCBiZXN0ZW4gR3LDvMOfZW4sCkRlbmlzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2pl
Y3Qub3JnCmh0dHA6Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaXZlcmRldi1kZXZlbAo=
