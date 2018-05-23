Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3751275-1527056601-2-10730024103346137361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527056600; b=WDWDZRZWJdEJoL1HoOpjqgMfwm5s6SLxMlitux9nBzsQdX2Uln
    3mPtWYPSeLVCqaIeBMLDSg0+9IGl7nRHRmzUEzeISdMEYdDXkJVrpl1x0WbsnTKT
    4PlvSts/K1NPK5fcyTnpm3fPag0Sh7N5MpZVtLbBaLE0Jb5ruv9u56sA7m5SQ2ts
    pMLTL8IplaDfNgVYudV2IRu01q/rCQwTi7LvJSeYGTfFLk8hpWh5JSEfJjxqWxnP
    /gH+ExGBaaPtTXl9SBJNfkjxLtY4zWT5TIyeqoRzZR+78CCZBD7z7zSluETxem7q
    SvwklwvvzSwxYDhdPqcudQLL7pB7bjw8zz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:to:sender:list-id; s=fm2; t=
    1527056600; bh=IXcxZnG+ssvqvUgII1IvTB6WTYMbx39zzxDfcxZ5pec=; b=e
    a1LF7RWOV0imKZg7KRZ3x0F2Zi1WRs5WtNpPCdyqmL4LMmDuzNbGdJfMhKu5ebaY
    a7p4N9vphYfpDLFg1e1mDVVGQuRm0ji3ivVm71Lh5873eFxogRS7db+6DGDyd38W
    zQf+ZCyA5tJU+xmW8c1pChw0ftVtJk62etKBGCkBpr7UJH0mjMhsfZVeCcnwSKUr
    QZCxsJFpAjAkBZPBohpjvv0RrF5XF4wwlK/oFVFosj/rlafZZffWse90K4oF3dxB
    aPOIpdVWzsWE92UNMF9N6S55CXwAmDbQBfr6X0z5149rGZ1FoD4rOu+Zc1G2OBj2
    XDc6qA4byBpVfKj0LEgwg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.de);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=amazon.de header.i=@amazon.de header.b=tJsRxTc+ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amazon.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.de);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=amazon.de header.i=@amazon.de header.b=tJsRxTc+ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amazon.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC37EyDKPZvyv03q5/8/z66MTUplIfKBxZXfI0Jq1Cb43CloEaaU/nzraIJIgmPbZAB3k3U0j+9h/bh9mFwW50g4C/IhBAk51EklSQA6Qxjv5hz9WTYP
    0iAmIge/P5ABxMCZikS1ReDLVidk3WauGtNPeSrGw7VUmjG3/cH+UPZcIgG2P5lOlkaelhvPSjIV2Dedgq3RXS8PL9O3yG4KoIzAMViyyrg9EBp9CQlLMVb6
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=O76VCmqbo-wA:10
    a=VUJBJC2UJ8kA:10 a=fXe6s7U_Q94W9MA4-jYA:9 a=QEXdDO2ut3YA:10
    a=fkqBw3BD5RLjSgApC7jY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeEWGXQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 02:23:16 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:33595 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeEWGWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 May 2018 02:22:33 -0400
X-IronPort-AV: E=Sophos;i="5.49,432,1520899200";
   d="scan'208";a="613693846"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <stable@vger.kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jordan Lazare <Jordan.Lazare@amd.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm: fix off-by-one in logger
Date: Wed, 23 May 2018 08:22:04 +0200
Message-ID: <1527056531-9568-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527054785-5417-1-git-send-email-nmanthey@amazon.de>
References: <1527054785-5417-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: unlisted-recipients:; (no To-header on input)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2lsbCBsZWFrIGEgYnl0ZSB0byB0aGUgbG9nIHZp
YSBtZW1tb3ZlLiBUaGUKc3BlY2lmaWVkIDI3IGJ5dGVzIGFyZSBvZmYtYnktb25lLCBhcyB0aGUg
cGF5bG9hZCBpcyAyNSBieXRlcywgYW5kIHRoZQp0ZXJtaW5hdGlvbiBjaGFyYWN0ZXIgaXMgb25s
eSBvbmUgYnl0ZSBsYXJnZS4gVG8gYXZvaWQgdGhpcywgZmFjdG9yIG91dAp0aGUgZXJyb3IgbWVz
c2FnZSwgYW5kIGZ1cnRoZXJtb3JlIG1ha2UgdGhlIHNlY29uZCBwYXJhbWV0ZXIgb2YgdGhlCmFw
cGVuZF9lbnRyeSBmdW5jdGlvbiBjb25zdC4KClRoZSBmdWxsIHRyYWNlIGlzIGFzIGZvbGxvd3M6
CgpJbiBmdW5jdGlvbiDigJhtZW1tb3Zl4oCZLAogICBmcm9tIOKAmGFwcGVuZF9lbnRyeeKAmSBh
dAogICAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvbG9nZ2VyLmM6
MjU3OjIsCiAgIGZyb20g4oCYZG1fbG9nZ2VyX2FwcGVuZF92YeKAmSBhdAogICAgICAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvbG9nZ2VyLmM6MzQ4OjQKICAgZGV0ZWN0
ZWQgcmVhZCBiZXlvbmQgc2l6ZSBvZiBvYmplY3QgcGFzc2VkIGFzIDJuZCBwYXJhbWV0ZXIKClNp
Z25lZC1vZmYtYnk6IE5vcmJlcnQgTWFudGhleSA8bm1hbnRoZXlAYW1hem9uLmRlPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvbG9nZ2VyLmMgfCA2ICsrKystLQog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2xvZ2dlci5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9sb2dnZXIuYwppbmRleCAzMWJlZTA1
Li42YmE4ZDBjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFz
aWNzL2xvZ2dlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3Mv
bG9nZ2VyLmMKQEAgLTI0NCw3ICsyNDQsNyBAQCBzdGF0aWMgdm9pZCBsb2dfaGVhZGluZyhzdHJ1
Y3QgbG9nX2VudHJ5ICplbnRyeSkKIAogc3RhdGljIHZvaWQgYXBwZW5kX2VudHJ5KAogCQlzdHJ1
Y3QgbG9nX2VudHJ5ICplbnRyeSwKLQkJY2hhciAqYnVmZmVyLAorCQljb25zdCBjaGFyICpidWZm
ZXIsCiAJCXVpbnQzMl90IGJ1Zl9zaXplKQogewogCWlmICghZW50cnktPmJ1ZiB8fApAQCAtMzQ2
LDcgKzM0Niw5IEBAIHZvaWQgZG1fbG9nZ2VyX2FwcGVuZF92YSgKIAkJaWYgKHNpemUgPCBMT0df
TUFYX0xJTkVfU0laRSAtIDEpIHsKIAkJCWFwcGVuZF9lbnRyeShlbnRyeSwgYnVmZmVyLCBzaXpl
KTsKIAkJfSBlbHNlIHsKLQkJCWFwcGVuZF9lbnRyeShlbnRyeSwgIkxPR19FUlJPUiwgbGluZSB0
b28gbG9uZ1xuIiwgMjcpOworCQkJc3RhdGljIGNvbnN0IGNoYXIgbXNnW10gPSAiTE9HX0VSUk9S
LCBsaW5lIHRvbyBsb25nXG4iOworCisJCQlhcHBlbmRfZW50cnkoZW50cnksIG1zZywgc2l6ZW9m
KG1zZykpOwogCQl9CiAJfQogfQotLSAKMi43LjQKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIg
R2VybWFueSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVz
ZW5zdHIuIDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJy
aWNoLCBDaHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4g
YW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
