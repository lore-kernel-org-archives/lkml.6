Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2253037-1523047709-2-17624381806861255421
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='nu', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523047708; b=ThyTnfx4BYHNf6x5+lChpGWnFQqDaFYd8zv7vg2nxSa7Ie+4VF
    VWLB2nOV55d1Sqfmd6FgYLziFjiN7FemQTNe+fDpzlsOa7Ucse6L0w17oNjUuo4S
    zA2p9oNHFLxRE+eGmYiG5dso0oYHwLU9IL6wX4jn1twfMHY/ytYbH/jBs/J7GMtv
    QPGInY8lvVTtq3CPkBoVK1E7x/XSxYc5y5eoMDc1wdiwip+6gSzD51QhvOnmg2PB
    b4etWIby4nrOimImtHhJxRyYzw8Ei2SlTzbkmRuwd+opGtFNla3ugflBWh4CTrid
    4fcgZxZxnD/PAkOalG0bn/P4fmrXx828IkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523047708; bh=o5ekl
    OHPCaUu8xp1722JJjMovIwVOTcX6suQRFSvSbg=; b=L73LWdygHD+O84hcoLjiU
    yHz12tknV5DZwGB4o+oAtSOYNhyC512qPBq2+7F34IlKW6mOCXscdZVb5caNWipi
    kDIvkiryJrjkbNmSZo64zwTNqXYL3CwY8HS8crvfZIGAUA8CBg3x5jXc6yqlUxfe
    zAA24HFfia/rYQpwa24IxdhRw1XtK4aO07VC0C5yJcC3C5Js2gq5pwStTBy+kbz5
    5CjgUKuN5ONoh+rSFSY+zjCMnU3raQTErTq0DikG2TBP3NoRZ6ulQ1Hvdnk6vcx0
    E0LMMUGQsX01W7AGjF+7wGyx1B7ktnZEdxkyA1+/50uYJ+oEwAhaQm/ulyAESwhN
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b=O7CPjI0v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nikanor.nu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ATmSLl8r;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nikanor.nu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b=O7CPjI0v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nikanor.nu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ATmSLl8r;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nikanor.nu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGw0DnngJwSPLzvpf7OF0m7HqHqKtaw7vAdrhQ1btSD6kv2YrHBC9pB2QDIbR5MICgqWvK3kP7NE65k7O2VnoSp2nIH8BXGMTCFwjFL8WJmchw7L5QDP
    jG/q812wGYCldl4GrHf9fwsj04LkMgcME4muJW/JS9XqLnAwf5RdQXT+hikLHnG9DacDtjVPx2jaQw4444Og6UreNKK4gQsLiraSNryX1MlgxZKAvh2y2oox
    hN4C2SiQl6XjaONCPvpMLw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=Yu7x-E3cA1-EU_5rSAIA:9
    a=mSuXp8X1uqK9u8aZ:21 a=u60FNru7B2CIiCxa:21 a=QEXdDO2ut3YA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/LCZP15y8l6IipNQlejqBrdrCp4J9IMCG8mpItWSACczTIsqesnjg9oQZaDWu9hsBb4gUwZg==
From: =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: pi433: break long lines in pi433_if.c
Date: Fri,  6 Apr 2018 22:48:17 +0200
Message-Id: <20180406204817.7470-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.11.0
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
Cc: devel@driverdev.osuosl.org, Valentin.Vidic@CARNet.hr,
 linux-kernel@vger.kernel.org, srishtishar@gmail.com,
 linux@wolf-entwicklungen.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

QnJlYWtzIGxvbmcgbGluZXMgaW4gcGk0MzNfaWYuYywgZml4aW5nIGNoZWNrcGF0Y2gucGwgd2Fy
bmluZ3M6CiJXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycyIKClNpZ25lZC1vZmYtYnk6
IFNpbW9uIFNhbmRzdHLDtm0gPHNpbW9uQG5pa2Fub3IubnU+Ci0tLQogZHJpdmVycy9zdGFnaW5n
L3BpNDMzL3BpNDMzX2lmLmMgfCAxOSArKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3N0YWdpbmcvcGk0MzMvcGk0MzNfaWYuYyBiL2RyaXZlcnMvc3RhZ2luZy9waTQzMy9waTQzM19p
Zi5jCmluZGV4IGQxZTBkZGJjNzljZS4uNzk1Y2Y3N2UwMDJjIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3N0YWdpbmcvcGk0MzMvcGk0MzNfaWYuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvcGk0MzMvcGk0
MzNfaWYuYwpAQCAtNTkzLDE0ICs1OTMsMTggQEAgcGk0MzNfdHhfdGhyZWFkKHZvaWQgKmRhdGEp
CiAKIAkJcmV0dmFsID0ga2ZpZm9fb3V0KCZkZXZpY2UtPnR4X2ZpZm8sICZ0eF9jZmcsIHNpemVv
Zih0eF9jZmcpKTsKIAkJaWYgKHJldHZhbCAhPSBzaXplb2YodHhfY2ZnKSkgewotCQkJZGV2X2Ri
ZyhkZXZpY2UtPmRldiwgInJlYWRpbmcgdHhfY2ZnIGZyb20gZmlmbyBmYWlsZWQ6IGdvdCAlZCBi
eXRlKHMpLCBleHBlY3RlZCAlZCIsIHJldHZhbCwgKHVuc2lnbmVkIGludClzaXplb2YodHhfY2Zn
KSk7CisJCQlkZXZfZGJnKGRldmljZS0+ZGV2LAorCQkJCSJyZWFkaW5nIHR4X2NmZyBmcm9tIGZp
Zm8gZmFpbGVkOiBnb3QgJWQgYnl0ZShzKSwgZXhwZWN0ZWQgJWQiLAorCQkJCXJldHZhbCwgKHVu
c2lnbmVkIGludClzaXplb2YodHhfY2ZnKSk7CiAJCQltdXRleF91bmxvY2soJmRldmljZS0+dHhf
Zmlmb19sb2NrKTsKIAkJCWNvbnRpbnVlOwogCQl9CiAKIAkJcmV0dmFsID0ga2ZpZm9fb3V0KCZk
ZXZpY2UtPnR4X2ZpZm8sICZzaXplLCBzaXplb2Yoc2l6ZV90KSk7CiAJCWlmIChyZXR2YWwgIT0g
c2l6ZW9mKHNpemVfdCkpIHsKLQkJCWRldl9kYmcoZGV2aWNlLT5kZXYsICJyZWFkaW5nIG1zZyBz
aXplIGZyb20gZmlmbyBmYWlsZWQ6IGdvdCAlZCwgZXhwZWN0ZWQgJWQiLCByZXR2YWwsICh1bnNp
Z25lZCBpbnQpc2l6ZW9mKHNpemVfdCkpOworCQkJZGV2X2RiZyhkZXZpY2UtPmRldiwKKwkJCQki
cmVhZGluZyBtc2cgc2l6ZSBmcm9tIGZpZm8gZmFpbGVkOiBnb3QgJWQsIGV4cGVjdGVkICVkIiwK
KwkJCQlyZXR2YWwsICh1bnNpZ25lZCBpbnQpc2l6ZW9mKHNpemVfdCkpOwogCQkJbXV0ZXhfdW5s
b2NrKCZkZXZpY2UtPnR4X2ZpZm9fbG9jayk7CiAJCQljb250aW51ZTsKIAkJfQpAQCAtNjIzLDcg
KzYyNywxMSBAQCBwaTQzM190eF90aHJlYWQodm9pZCAqZGF0YSkKIAogCQkvKiBhZGQgbGVuZ3Ro
IGJ5dGUsIGlmIHJlcXVlc3RlZCAqLwogCQlpZiAodHhfY2ZnLmVuYWJsZV9sZW5ndGhfYnl0ZSAg
PT0gT1BUSU9OX09OKQotCQkJZGV2aWNlLT5idWZmZXJbcG9zaXRpb24rK10gPSBzaXplIC0gMTsg
LyogYWNjb3JkaW5nIHRvIHNwZWMgbGVuZ3RoIGJ5dGUgaXRzZWxmIG11c3QgYmUgZXhjbHVkZWQg
ZnJvbSB0aGUgbGVuZ3RoIGNhbGN1bGF0aW9uICovCisJCQkvKgorCQkJICogYWNjb3JkaW5nIHRv
IHNwZWMsIGxlbmd0aCBieXRlIGl0c2VsZiBtdXN0IGJlCisJCQkgKiBleGNsdWRlZCBmcm9tIHRo
ZSBsZW5ndGggY2FsY3VsYXRpb24KKwkJCSAqLworCQkJZGV2aWNlLT5idWZmZXJbcG9zaXRpb24r
K10gPSBzaXplIC0gMTsKIAogCQkvKiBhZGQgYWRyIGJ5dGUsIGlmIHJlcXVlc3RlZCAqLwogCQlp
ZiAodHhfY2ZnLmVuYWJsZV9hZGRyZXNzX2J5dGUgPT0gT1BUSU9OX09OKQpAQCAtODU2LDcgKzg2
NCw4IEBAIHBpNDMzX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxwLCBjb25zdCBjaGFyIF9fdXNlciAq
YnVmLAogCiBhYm9ydDoKIAlkZXZfZGJnKGRldmljZS0+ZGV2LCAid3JpdGUgdG8gZmlmbyBmYWls
ZWQ6IDB4JXgiLCByZXR2YWwpOwotCWtmaWZvX3Jlc2V0KCZkZXZpY2UtPnR4X2ZpZm8pOyAvLyBU
T0RPOiBtYXliZSBmaW5kIGEgc29sdXRpb24sIG5vdCB0byBkaXNjYXJkIGFscmVhZHkgc3RvcmVk
LCB2YWxpZCBlbnRyaWVzCisJLyogVE9ETzogZmluZCBhIHNvbHV0aW9uIHRvIG5vdCBkaXNjYXJk
IGFscmVhZHkgc3RvcmVkIHZhbGlkIGVudHJpZXMgKi8KKwlrZmlmb19yZXNldCgmZGV2aWNlLT50
eF9maWZvKTsKIAltdXRleF91bmxvY2soJmRldmljZS0+dHhfZmlmb19sb2NrKTsKIAlyZXR1cm4g
LUVBR0FJTjsKIH0KQEAgLTEwNDIsNyArMTA1MSw3IEBAIHN0YXRpYyBpbnQgc2V0dXBfZ3Bpbyhz
dHJ1Y3QgcGk0MzNfZGV2aWNlICpkZXZpY2UpCiAJCS8qIGNvbmZpZ3VyZSBpcnEgKi8KIAkJZGV2
aWNlLT5pcnFfbnVtW2ldID0gZ3Bpb2RfdG9faXJxKGRldmljZS0+Z3Bpb2RbaV0pOwogCQlpZiAo
ZGV2aWNlLT5pcnFfbnVtW2ldIDwgMCkgewotCQkJZGV2aWNlLT5ncGlvZFtpXSA9IEVSUl9QVFIo
LUVJTlZBTCk7Ly8oc3RydWN0IGdwaW9fZGVzYyAqKWRldmljZS0+aXJxX251bVtpXTsKKwkJCWRl
dmljZS0+Z3Bpb2RbaV0gPSBFUlJfUFRSKC1FSU5WQUwpOwogCQkJcmV0dXJuIGRldmljZS0+aXJx
X251bVtpXTsKIAkJfQogCQlyZXR2YWwgPSByZXF1ZXN0X2lycShkZXZpY2UtPmlycV9udW1baV0s
Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCmh0dHA6
Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaXZl
cmRldi1kZXZlbAo=
