Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-995127-1526313250-2-3360456573773424054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313249; b=bQTh9mQFpmFv7TV+RuTxMIwSTSRh84nMOoNVJJ0SQkJp/Ya+R4
    yO7j7bv7t/bP4hOq26Qbv2aCLM74+szgll+4J0nPVBhWL0XSoFh2agg2xnuHgTsn
    lUwtVF7tHF5zQlBv82NNsQ0mUZpH5xMhH2NiPvpaDJfRfl07XDXeyiqsYs25F6y0
    B1rMUhzMLZgSFrbB7nMzZUf+l2VJ8IzuzgzppTfPj6uzjR8jVLrHDWToVIYIjZ/3
    xikux4VD3gHqJll8PNfVbDofDXN2hJfrfHj7V0Zm08/ttWau5z3PG/Ji53prMgy0
    bT8UAK3RjvFo+TFra7vzx+csCN/lXLYvqDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313249; bh=nEsby
    5JNg15GP4d+/gJ5QAbJlziDcn9s3TTpJjqN+3c=; b=A+soBdnvVzTQ9VxOne+zK
    RLamkzb5mwfYAF2oNSLcspjnpco8Zy4f7A0EDoRG0rbA3hC6ZOD1xCFMvyjp9p4P
    mVLdwE09tMkuA7/MI/4+WAM8N7TM1jUkF4QorrdzMdgG8L6vWHdbCeMYJCQ69FAg
    y1jmXeMRAMAqY1V1WCcVjnLedsVnGW/L3b5Ji0s+lEbSoizmpVLeD58/5xwnXLXb
    I9S1EqvKyUprPKlKLb4NxxvxVmUYTQSiT+zJARb4mPR03x9n0O6yTGwI7ysFTanm
    hV317Oau2hSpUZLOitnEZ3E6z/8Txi5Joy5XCLg7JFfZnVZkxqiqtgBgN9Eo7X55
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=q0Lpty0R x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=isULYGxH;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=q0Lpty0R x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=isULYGxH;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCJgHrJfejh03rC3bY6ovtlZn/mp+wc294BL6xUqQwfgk/sbIw0Cl72CdkJtS0UtPRtbDbDoJO7XNQ5o3cqv3tDI7WY63hqNLflSO20oRsX6UzPN3mPA
    aP+UBzxqK0K34G6amK2sCq9shHlNHd48gyfmRvGuwmdkjVxLGnS4b0G+Q45vCXrTe+lXKE+EmCrF9dIcx9IY3Ku15j5vyKdcDxmlgSL7dB2ITFiAnIfag5Ox
    1J2b66eXVyuR1dREXV9KEg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=A8vicNgK_FEA:10 a=kj9zAlcOel0A:10
    a=x7bEGLp0ZPQA:10 a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=IsCDPIKJR3lfdBMgYJEA:9
    a=0TYJaL4z8OcfC4sS:21 a=IRjE1diSvUEVnoAW:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoYinCdjibegQwqiJyAqcimnA6sbTENJCQPuRDVDPArSYibpJC+V24/MtymDI+FMDD19EP10A==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: Coding Style of drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
Date: Mon, 14 May 2018 16:53:05 +0100
Message-Id: <20180514155318.32195-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
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
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, johnfwhitmore@gmail.com,
 colin.king@canonical.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There were a lot of coding style issues with this file, but I think I've
reduced the number down to mainly line length and CamelCase issues. I've put
it in 13 patches to, hopefully, make it easier to review, and see that I've
made no changes to functionality of the code, (I hope).

John

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
