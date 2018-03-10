Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1815556-1520642065-2-10464300117154854786
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520642065; b=TvCLrB6rePfNwEuobhqmBOtNQfF7e23iYst25Jwwb+fRUVr
    209xqB7rZzQOorMKV3sHDPAapDxaufg0NdgHBK1LP26T1vOTm6M6khZI/+UTRC3E
    dotNh151gOEbgUDaqVNkkCxuRaFmfLeqrSc+iKMdkXjmklcZniA3x3G6/cBhY9UI
    Uh2jdfhLyTx2rbPKLVDWgx3aR2qZX9pfWG+CkCmoyyPbhQpoxuKNiGS0C/LCaIVq
    MKm2xML4n/CIEXFpbAWzceLjC2T2/fCWklVrjqgqXXhufoUhD0TA5C3KW3htcJMZ
    UK9uoSkAUVxcRAyKE6gnyOtTroRrb3Afjrjphhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520642065; bh=X
    xRIjk99Oi2xqvqosoQf9CfxOnaaHe+FLUv8Pwz8Rx8=; b=joLdnd2Ajz1FIoyul
    QLaSQCzsObWjIuek73es6grsbziNaKjN/ymHQuVYEQRIBn0489FGlzTQJrS+FlCI
    kPC4UShNO5USfmi4gyqQpgL/QRa6IBL34Hr3m1VWAYbtEYs30GUWyIqUr+OIYH11
    nVQzfIhVYYnUAVhn3lw/q87Dqb/hkxl+xHU0GZaIV0BPK6pawvQqTs6pBT8xIxZt
    WC+7Djt6DsurHKW4Tke1iBeFr4iCdIMHm8Gl3jxL+1X4icd8AIdzyoib/C4WfByO
    bBjZtuCOt08/YmWHuoMfnbu879gWg9D9ZPn1KZE4asRKg5wnELR+75yUsEJpq7w5
    vAoaw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=ILHgiNrC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=me.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=ILHgiNrC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=me.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-03-09_11:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1803100003
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] staging: lustre: o2iblnd: fix race at kiblnd_connect_peer
From: Doug Oucharek <dougso@me.com>
In-reply-to: <8D09A62F-69B3-48CF-BE9B-D3C1ABB70910@me.com>
Date: Fri, 09 Mar 2018 16:34:14 -0800
Message-id: <072214EC-91AE-4376-87B5-7CE6A19B23F2@me.com>
References: <8D09A62F-69B3-48CF-BE9B-D3C1ABB70910@me.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, "Drokin, Oleg" <oleg.drokin@intel.com>,
 "Dilger, Andreas" <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>, alexander.boyko@seagate.com
X-Mailer: Apple Mail (2.3445.5.20)
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLiAgVHVybnMgb3V0IGl0IGRlcGVuZHMgb24gYSBzZXJp
ZXMgd2hpY2ggaGFzIG5vdCBiZWVuIHN1Ym1pdHRlZCB5ZXQuICBJ4oCZbGwgcmVzZW5kIHRoaXMg
b25lIG9uY2UgYWxsIG9mIHRob3NlIGFyZSBkb25lLgoKRG91ZwoKPiBPbiBNYXIgOSwgMjAxOCwg
YXQgMzoyOSBQTSwgRG91ZyBPdWNoYXJlayA8ZG91Z3NvQG1lLmNvbT4gd3JvdGU6Cj4gCj4gY21p
ZCB3aWxsIGJlIGRlc3Ryb3llZCBhdCBPRkVEIGlmIGtpYmxuZF9jbV9jYWxsYmFjayByZXR1cm4g
ZXJyb3IuCj4gaWYgZXJyb3IgaGFwcGVuIGJlZm9yZSB0aGUgZW5kIG9mIGtpYmxuZF9jb25uZWN0
X3BlZXIsIGl0IHdpbGwgdG91Y2gKPiBkZXN0cm95ZWQgY21pZCBhbmQgZmFpbCBhcwo+IChvMmli
bG5kX2NiLmM6MTMxNTpraWJsbmRfY29ubmVjdF9wZWVyKCkpCj4gICAgICAgICAgIEFTU0VSVElP
TiggY21pZC0+ZGV2aWNlICE9ICgodm9pZCAqKTApICkgZmFpbGVkOgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRlciBCb3lrbyA8YWxleGFuZGVyLmJveWtvQHNlYWdhdGUuY29tPgo+IEludGVs
LWJ1Zy1pZDogaHR0cHM6Ly9qaXJhLmhwZGQuaW50ZWwuY29tL2Jyb3dzZS9MVS0xMDAxNQo+IFJl
dmlld2VkLWJ5OiBBbGV4ZXkgTHlhc2hrb3YgPGMxNzgxN0BjcmF5LmNvbT4KPiBSZXZpZXdlZC1i
eTogRG91ZyBPdWNoYXJlayA8ZG91Z3NvQG1lLmNvbT4KPiBSZXZpZXdlZC1ieTogSm9obiBMLiBI
YW1tb25kIDxqb2huLmhhbW1vbmRAaW50ZWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERvdWcgT3Vj
aGFyZWsgPGRvdWdzb0BtZS5jb20+Cj4gLS0tCj4gZHJpdmVycy9zdGFnaW5nL2x1c3RyZS9sbmV0
L2tsbmRzL28yaWJsbmQvbzJpYmxuZF9jYi5jIHwgMTggKysrKysrKysrKysrLS0tLS0tCj4gMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9sdXN0cmUvbG5ldC9rbG5kcy9vMmlibG5kL28yaWJsbmRf
Y2IuYyBiL2RyaXZlcnMvc3RhZ2luZy9sdXN0cmUvbG5ldC9rbG5kcy9vMmlibG5kL28yaWJsbmRf
Y2IuYwo+IGluZGV4IDY2OTBhNmMuLjA4MGMyYTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zdGFn
aW5nL2x1c3RyZS9sbmV0L2tsbmRzL28yaWJsbmQvbzJpYmxuZF9jYi5jCj4gKysrIGIvZHJpdmVy
cy9zdGFnaW5nL2x1c3RyZS9sbmV0L2tsbmRzL28yaWJsbmQvbzJpYmxuZF9jYi5jCj4gQEAgLTEy
OTAsMTEgKzEyOTAsNiBAQCBzdGF0aWMgaW50IGtpYmxuZF9yZXNvbHZlX2FkZHIoc3RydWN0IHJk
bWFfY21faWQgKmNtaWQsCj4gCQlnb3RvIGZhaWxlZDI7Cj4gCX0KPiAKPiAtCUxBU1NFUlQoY21p
ZC0+ZGV2aWNlKTsKPiAtCUNERUJVRyhEX05FVCwgIiVzOiBjb25uZWN0aW9uIGJvdW5kIHRvICVz
OiVwSTRoOiVzXG4iLAo+IC0JICAgICAgIGxpYmNmc19uaWQyc3RyKHBlZXItPmlicF9uaWQpLCBk
ZXYtPmliZF9pZm5hbWUsCj4gLQkgICAgICAgJmRldi0+aWJkX2lmaXAsIGNtaWQtPmRldmljZS0+
bmFtZSk7Cj4gLQo+IAlyZXR1cm47Cj4gCj4gZmFpbGVkMjoKPiBAQCAtMjk5Niw4ICsyOTkxLDE5
IEBAIHN0YXRpYyBpbnQga2libG5kX3Jlc29sdmVfYWRkcihzdHJ1Y3QgcmRtYV9jbV9pZCAqY21p
ZCwKPiAJCX0gZWxzZSB7Cj4gCQkJcmMgPSByZG1hX3Jlc29sdmVfcm91dGUoCj4gCQkJCWNtaWQs
ICpraWJsbmRfdHVuYWJsZXMua2liX3RpbWVvdXQgKiAxMDAwKTsKPiAtCQkJaWYgKCFyYykKPiAr
CQkJaWYgKCFyYykgewo+ICsJCQkJa2liX25ldF90ICpuZXQgPSBwZWVyX25pLT5pYnBfbmktPm5p
X2RhdGE7Cj4gKwkJCQlraWJfZGV2X3QgKmRldiA9IG5ldC0+aWJuX2RldjsKPiArCj4gKwkJCQlD
REVCVUcoRF9ORVQsICIlczogY29ubmVjdGlvbiBib3VuZCB0byAiXAo+ICsJCQkJICAgICAgICIl
czolcEk0aDolc1xuIiwKPiArCQkJCSAgICAgICBsaWJjZnNfbmlkMnN0cihwZWVyX25pLT5pYnBf
bmlkKSwKPiArCQkJCSAgICAgICBkZXYtPmliZF9pZm5hbWUsCj4gKwkJCQkgICAgICAgJmRldi0+
aWJkX2lmaXAsIGNtaWQtPmRldmljZS0+bmFtZSk7Cj4gKwo+IAkJCQlyZXR1cm4gMDsKPiArCQkJ
fQo+ICsKPiAJCQkvKiBDYW4ndCBpbml0aWF0ZSByb3V0ZSByZXNvbHV0aW9uICovCj4gCQkJQ0VS
Uk9SKCJDYW4ndCByZXNvbHZlIHJvdXRlIGZvciAlczogJWRcbiIsCj4gCQkJICAgICAgIGxpYmNm
c19uaWQyc3RyKHBlZXItPmlicF9uaWQpLCByYyk7Cj4gLS0gCj4gMS44LjMuMQo+IAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBs
aXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRy
aXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
