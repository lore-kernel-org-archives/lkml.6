Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022230-5-4629068378466384575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022229; b=MBZh3rhInaVPoOXaRzlxvNu4p69cmOj9IgioVMO7Jz4myxLmo5
    Cs+WnXrhZvLBVIIygF2o0wD6ffTXiKjbuTicTfATyIOc4WOmek8lFoGDO+ZzK0lO
    +N/4w3iSCn+aybNWB+8brsflDrZuliAfnsJtG4M/mXlMbnvLTAAnWZXfF2kZSh45
    l+kx1zTV/mqlfy+DxFPjznDdrRr6rYEyVCkUxBm6S5VCRKjQT8Sliz+AvAGt9HXJ
    OzNCXBHjYIlRkW2DF5JS++lhEXJTHDdkRj05j4cPAwbYACA80hNDhfEa0VIbSW7g
    5i0vTT5R2A/Z/0tlA4V5mIveq5/Bn21z3b7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022229; bh=WMApy3XM+3Pp3+bgMxJb0u4KB/tMFt
    G/qVxVWQ2TUnE=; b=RrldGiiQe1ny5nlbmNhornwn00xQ3/db7PZI5k8tgMAFJe
    oK//krKcmCZ+iydHZEbx3rZ1O9GUa+Up6+y6FgJApCKO+GV5AI53q75P32kwZGxb
    Lc8YQYVBG3qBbXDxRCyIS3TH6Z/StnnZjELhS1arOsFhtN1dGEoq5vToj6eTrSkl
    SH0/kFL45oLw4ysb1h/zPnaIulxXYc1lDtqmvP1e80taDLeBasl5WOjL83vhosfE
    fgM8mr3+k/akqPcVCd4APYFtirBYMKi9x67bdMgeqYDKfRGOtqt47vAkTymBHdMh
    ewGDFhD34PVXI8bMjeAixTXEaRfCsii+nXCPoG7w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF1pC0JchpcCt/KsWULUcRfWfy5k98p7FHoLsd+mnwCq/VN5V9MGWrrw5Zlh5mjqNG1yWEsxzvHAOpR8z0F9ZE1Egfi7kYwx22COzXQIdCpK3lGFPNkc
    EwBPGwWbQb1naTj5TxlmjnuaN6gHi2+Yrmf1JEv0bW94NWaPu0HfRw0sIUKgHz2EGiZ1e1O3h4UaxEqECEgUdjVa3q3uXzXuYWyOxez3ifjYfWJyzNEvQJPc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=FNyBlpCuAAAA:8 a=ag1SF4gXAAAA:8
    a=WkbNqe7Jen_D_RCmz68A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=RlW-AWeGUCXs_Nkyno-6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756794AbeDFNno (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:43:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbeDFNnm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:43:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Conor McLoughlin <conor.mcloughlin@intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 52/72] crypto: testmgr - Fix incorrect values in PKCS#1 test vector
Date: Fri,  6 Apr 2018 15:24:27 +0200
Message-Id: <20180406084353.081766497@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor McLoughlin <conor.mcloughlin@intel.com>

commit 333e18c5cc74438f8940c7f3a8b3573748a371f9 upstream.

The RSA private key for the first form should have
version, prime1, prime2, exponent1, exponent2, coefficient
values 0.
With non-zero values for prime1,2, exponent 1,2 and coefficient
the Intel QAT driver will assume that values are provided for the
private key second form. This will result in signature verification
failures for modules where QAT device is present and the modules
are signed with rsa,sha256.

Cc: <stable@vger.kernel.org>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Conor McLoughlin <conor.mcloughlin@intel.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/testmgr.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -548,7 +548,7 @@ static const struct akcipher_testvec rsa
 static const struct akcipher_testvec pkcs1pad_rsa_tv_template[] = {
 	{
 	.key =
-	"\x30\x82\x03\x1f\x02\x01\x10\x02\x82\x01\x01\x00\xd7\x1e\x77\x82"
+	"\x30\x82\x03\x1f\x02\x01\x00\x02\x82\x01\x01\x00\xd7\x1e\x77\x82"
 	"\x8c\x92\x31\xe7\x69\x02\xa2\xd5\x5c\x78\xde\xa2\x0c\x8f\xfe\x28"
 	"\x59\x31\xdf\x40\x9c\x60\x61\x06\xb9\x2f\x62\x40\x80\x76\xcb\x67"
 	"\x4a\xb5\x59\x56\x69\x17\x07\xfa\xf9\x4c\xbd\x6c\x37\x7a\x46\x7d"
@@ -597,8 +597,8 @@ static const struct akcipher_testvec pkc
 	"\xfe\xf8\x27\x1b\xd6\x55\x60\x5e\x48\xb7\x6d\x9a\xa8\x37\xf9\x7a"
 	"\xde\x1b\xcd\x5d\x1a\x30\xd4\xe9\x9e\x5b\x3c\x15\xf8\x9c\x1f\xda"
 	"\xd1\x86\x48\x55\xce\x83\xee\x8e\x51\xc7\xde\x32\x12\x47\x7d\x46"
-	"\xb8\x35\xdf\x41\x02\x01\x30\x02\x01\x30\x02\x01\x30\x02\x01\x30"
-	"\x02\x01\x30",
+	"\xb8\x35\xdf\x41\x02\x01\x00\x02\x01\x00\x02\x01\x00\x02\x01\x00"
+	"\x02\x01\x00",
 	.key_len = 804,
 	/*
 	 * m is SHA256 hash of following message:
