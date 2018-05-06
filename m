Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2878077-1525589463-5-5933558591376761272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525589463; b=IC8LozTO8exL1tuKD3FVYTxNgkKgpiuulVlDvo/DAvQuwY8Bi3
    i70h/jwZ0HufArqvP1p1Y/v7amGfj29JEgZdZBt9XZhBFNlY5fb7TnFCcZ9sKgP0
    e+iw01pPYfSh8535agTTp7gLJWDkyV8OCcenRiIz46GGtsPFwBKDGe0D6tSnwyN/
    dtqJEZiwyKwSyWXqsiPus0/Hgg16qKH7WQ7v0rgpkadNWTOFPqjeZxGDPQRR7Cjp
    Jlg/FacXewzntASChD86mQqNho3rwP3/3DUA4eIwbGBwYfxCJ18XLNmCJzWJizjR
    NUj3hlDE4gsIqKSIVWMkKsylEEmM4Ogvrvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525589463; bh=4utt0
    lzmgg/jC0ZlhAhEief/1QuQkwx3s/E7HjSeCP8=; b=Dige457o2HtMg8v6O5imt
    HsCZtJLRQVhtveS3+aCcaVQ0f/shpFx4xrj3Y8VqEXb3uK3YLNfFDcreu/hA3zWi
    YkUksnZINhaFYqkByr3XOQZ2RJ6Tw5nVMBXE3LUv8Th6hL1j4S1sjmL0vayYrYTz
    jvUZ/WJdoICdvxlXFxNfSZk4DuZEEjmH9C6HXi95+RH6McgNn2VOhkrp3y2oZxOs
    Pc2y5GrJAZ2M5fioHG8NPWcvtbTw/VJnVl3WhBF0D0pUmHP2k7shLSEgUk+4SUcx
    a32Yn5wpIiy9p1ts7seS4druCWg6I+F5YgSbF0nefa+ocGzfQNYxiGFG4NaUm1UQ
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=SGKkL+/G x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pzxlp78W;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=SGKkL+/G x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pzxlp78W;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO8r9HQicPcfVJh+1msjUKgD/7/i2gQu8bsnOppjyQehjZooxp1PDwZZPKwKWLrUsbKHamcDKKexTftwolRi3U4GOTOp1cNbjeJyL32NDovOY71AGpNm
    o/yvbzBBY+f3IHRU+yoopglQXMvbmpMbrfaELoAp+JKve9psq6LFE06DbkkXZhvzcp995SbAL9bwT72e6mHV/lKp+l1GDChi6hs3gxK+w4fA9J99U/GFBlA2
    xCbYvpt5CQu0f98pOJTpMQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=2ZfT-T1qzbMdvYaZ0scA:9 a=QEXdDO2ut3YA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoDXzwlToUX6eTrO38O0ArPzsZB7bpWWbgzdFpvYAePHjKKfLdK2edkkwVu0fASO3ypvLFeCQ==
From: Nathan Chancellor <natechancellor@gmail.com>
To: greybus-dev@lists.linaro.org
Subject: [PATCH] staging: greybus: Remove unused local variable
Date: Sat,  5 May 2018 23:50:44 -0700
Message-Id: <20180506065044.25311-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEgd2FybmluZzogdmFyaWFibGUg4oCYaW50Zl9pZOKAmSBz
ZXQgYnV0Cm5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKU2lnbmVkLW9mZi1i
eTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4KLS0tCiBkcml2
ZXJzL3N0YWdpbmcvZ3JleWJ1cy9zdmMuYyB8IDMgLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9zdmMuYyBiL2Ry
aXZlcnMvc3RhZ2luZy9ncmV5YnVzL3N2Yy5jCmluZGV4IGE4NzRmZWQ3NjFhMS4uYTJiYjdlMWEz
ZGIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9zdmMuYworKysgYi9kcml2
ZXJzL3N0YWdpbmcvZ3JleWJ1cy9zdmMuYwpAQCAtMTEzNyw3ICsxMTM3LDYgQEAgc3RhdGljIGlu
dCBnYl9zdmNfaW50Zl9yZXNldF9yZWN2KHN0cnVjdCBnYl9vcGVyYXRpb24gKm9wKQogCXN0cnVj
dCBnYl9zdmMgKnN2YyA9IGdiX2Nvbm5lY3Rpb25fZ2V0X2RhdGEob3AtPmNvbm5lY3Rpb24pOwog
CXN0cnVjdCBnYl9tZXNzYWdlICpyZXF1ZXN0ID0gb3AtPnJlcXVlc3Q7CiAJc3RydWN0IGdiX3N2
Y19pbnRmX3Jlc2V0X3JlcXVlc3QgKnJlc2V0OwotCXU4IGludGZfaWQ7CiAKIAlpZiAocmVxdWVz
dC0+cGF5bG9hZF9zaXplIDwgc2l6ZW9mKCpyZXNldCkpIHsKIAkJZGV2X3dhcm4oJnN2Yy0+ZGV2
LCAic2hvcnQgcmVzZXQgcmVxdWVzdCByZWNlaXZlZCAoJXp1IDwgJXp1KVxuIiwKQEAgLTExNDYs
OCArMTE0NSw2IEBAIHN0YXRpYyBpbnQgZ2Jfc3ZjX2ludGZfcmVzZXRfcmVjdihzdHJ1Y3QgZ2Jf
b3BlcmF0aW9uICpvcCkKIAl9CiAJcmVzZXQgPSByZXF1ZXN0LT5wYXlsb2FkOwogCi0JaW50Zl9p
ZCA9IHJlc2V0LT5pbnRmX2lkOwotCiAJLyogRklYTUUgUmVzZXQgdGhlIGludGVyZmFjZSBoZXJl
ICovCiAKIAlyZXR1cm4gMDsKLS0gCjIuMTcuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVy
cHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
