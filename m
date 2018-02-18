Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2132234-1518983504-2-16869350658625057829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518983503; b=FpGW7diZQJymxw/dcOLAoYuQpeHkL/6I77pTn+eAgJHoGsB
    EaX6ZgcZ9bSDx0KPiL0o63lKH2xIXylVcrY8osUagyoyThrse2j3DmVOGHDF49QZ
    FAN61+EKFj0DWqFiTUaBTZyjqqGZXlH5j6fMOOpFGrbXu+/a89feEhss7s7y7Rv0
    g6FniaokmdMfzVh4YKNxfyCUSCmBa0T++I4cNHSf2bI9hEq/+t6v8pSWAaGwoAyg
    tMV5pJ47bdeaOTHiMYiml+4tejQ9y+mWQaPHNjuJ4rPyx7A0MS8A7APOZn7ruhA0
    EqagzUWeIPhVEHftW8NyXvyrzGFO3JGeEBRV3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518983503; bh=Y
    7VfW1dVNMj+QLhr98rZ6VezPZjM/S3ztur5unGXNdg=; b=tcSU69M4fUiFVvWbm
    JsM8anpY+AMwJYk2cG1P9meYFY6GWvEpyj16Sn1GhhrL7uZxqz5yUe8QxiQKCmWD
    YMn/I+81mMfVsxdw9W5F+xFQsSe6vL/3W/M5HWN8Kgb6qjz/TGOGmZ5iniYxmoRt
    fv5N/UFuZ6LUiOrRrkOItelYL4YU1KCvUl9SWyRC3jqOfdvC9JNtDjIQ9sUtTsd7
    Wc02B40xJRXF9RhuZOzEASGMd2H2hZlF0qQYVs0FAcRq17wSBaJroy0JqxZAj+tD
    7B/0/K+8jfAci5Qoc8gGDF8CIFUk3Q9ZTbDyGwrYGGBFkHc/HX8Z8Gwrkttp9gEH
    pAT1w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ryca7Vvg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S5YoV24d;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ryca7Vvg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S5YoV24d;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224FRyjqR+3mqfQj6zcVmj3g0LA1v4ZIHxMwszndgAOy5GV7O5nb0XdmcbaFYcu6qC0RFzvd0w==
Message-ID: <1518983493.12414.1.camel@gmail.com>
Subject: Re: [PATCH 1/2] staging: rtl8712: make unsigned length for
 rtl8717_get{_wpa_,_wpa2_,_}ie
From: Stefano Manni <stefano.manni@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 18 Feb 2018 20:51:33 +0100
In-Reply-To: <20180216144819.GA10052@kroah.com>
References: <20180201191453.4611-1-stefano.manni@gmail.com>
 <20180216144819.GA10052@kroah.com>
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
 linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTE2IGF0IDE1OjQ4ICswMTAwLCBHcmVnIEtIIHdyb3RlOgo+IENhbiB5
b3UgcmViYXNlIGJvdGggb2YgdGhlc2UgcGF0Y2hlcyBvbiB0aGUgc3RhZ2luZy10ZXN0aW5nIGJy
YW5jaCBvZgo+IHRoZSBzdGFnaW5nLmdpdCB0cmVlIHNvIHRoYXQgSSBjYW4gYXBwbHkgdGhlbT/C
oMKgUmlnaHQgbm93IHRoZXkgaGF2ZQo+IHRvbwo+IG1hbnkgY29uZmxpY3RzLgoKUmViYXNlZCBv
biBzdGFnaW5nLXRlc3RpbmcgZDkyYTFmYS4gdjIgdG8gY29tZS4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxA
bGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
