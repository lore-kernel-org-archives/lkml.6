Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-814531-1523401074-2-16812412135177266326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523401073; b=jaQYAE8Ej2OQOIIqKA0/0A1b696EcUfNVUU3trI3nl57+9+OLI
    w++Uu6Pa2KCrc+BPvPwGieurUaUo9sQ/W4es+LtrYpXWqJX2scBD/EgL2tQ1QZT0
    qww9Ee18H7OfE2LfIRj9niYROb5p4gzlacp4QxpPmQKUk070VuYzC5Ng8IZ2rdCG
    ArBHD8+VF+r/XvVsXbL+jaDEet89KYHesYGXTk06YAxKY0UOwCsq9P/3p3bOKvJi
    d0vHhlogG7U0v/woRVnuDLWF7K5hKLqGnrLXFXaV4LK2JF1BoK94uAfoCWq0v5Z8
    03GiVXiToTOJMCv1EhWpDYsA6/QB+MhSySCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523401073; bh=9GcsH
    Wew0R+zlxrdchJQ7YqLQCew5r2bJb/MBCV2vMw=; b=IZK+JKfT/xXjrt6sqbyUb
    pBo1dLqSsluwLI7y/fEt3sk3qTjh8d0tFO/48qigsJHq1dpcIxUoQCVihnwD+ESR
    L+XaPAe4u6J4vsNkR6PsjeaShuuiX0xLMYdPR20Q/oNcqDz3AosmiGInerUj+Sjj
    JoCcsn7dwT7f8TX8GWYefs0/zLL0UUaai17M4bdxRyeAXntSFbbGm386fw5366HT
    z3S97+PAq1xCQWhhhbxuRF0+Q1kGEA9bl2+0KfeYcGAsKttAzl8Eu+GM2TLG6XZ9
    q1M7bvqPc2BqDNQzBzg8TWoyD2fnA1rUJ3BmIjNGUQBby4+YJsmD8ED3rZwsMwiL
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lBEA0gMy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EXUZIMDv;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lBEA0gMy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EXUZIMDv;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEwV60W3IQILcynNB9N7hqBjWRpeKbYhlZKgZ9qzkTJx645KaaYiuNg8ZqPrK51jxnGaAC291O1T30PU17v/XRbwFrgHiDPCuV4rWg5fe29h6buuF1Pi
    ipxtvNvZV5mPgbMXj2H9l6n8TbnafYtBAEnSCTl4sUwoghrm1bAF7+b0XeZvXG+OMEUKODap+UNJPmSdeGXncpMxKIYKvbMp7dg9+v8JJET0D1jq/3cRJATo
    MNS5AWNOHVFcCbMFc/7/OA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Jw12gpnuf5sA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=UZ8MZYSOm8shK028Q8QA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48s87HF7+lPdSH7J4rJJ+Z+UacYEMwWkl2FnTZnN9acu/yaiFw13W+VCTarrtPm7ioazRQV+g==
From: Ian Liu Rodrigues <ian.liu88@gmail.com>
To: gregkh@linuxfoundation.org, christian.gromm@microchip.com,
 andrey.shvetsov@k2l.de, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] Staging: most: Move comments to the end of line
Date: Tue, 10 Apr 2018 19:57:21 -0300
Message-Id: <20180410225721.9303-1-ian.liu88@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: Ian Liu Rodrigues <ian.liu88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Ian Liu Rodrigues <ian.liu88@gmail.com>
---
 drivers/staging/most/dim2/reg.h | 84 ++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/most/dim2/reg.h b/drivers/staging/most/dim2/reg.h
index 69cbf78239f1..4343a483017e 100644
--- a/drivers/staging/most/dim2/reg.h
+++ b/drivers/staging/most/dim2/reg.h
@@ -12,48 +12,48 @@
 #include <linux/types.h>
 
 struct dim2_regs {
-	/* 0x00 */ u32 MLBC0;
-	/* 0x01 */ u32 rsvd0[1];
-	/* 0x02 */ u32 MLBPC0;
-	/* 0x03 */ u32 MS0;
-	/* 0x04 */ u32 rsvd1[1];
-	/* 0x05 */ u32 MS1;
-	/* 0x06 */ u32 rsvd2[2];
-	/* 0x08 */ u32 MSS;
-	/* 0x09 */ u32 MSD;
-	/* 0x0A */ u32 rsvd3[1];
-	/* 0x0B */ u32 MIEN;
-	/* 0x0C */ u32 rsvd4[1];
-	/* 0x0D */ u32 MLBPC2;
-	/* 0x0E */ u32 MLBPC1;
-	/* 0x0F */ u32 MLBC1;
-	/* 0x10 */ u32 rsvd5[0x10];
-	/* 0x20 */ u32 HCTL;
-	/* 0x21 */ u32 rsvd6[1];
-	/* 0x22 */ u32 HCMR0;
-	/* 0x23 */ u32 HCMR1;
-	/* 0x24 */ u32 HCER0;
-	/* 0x25 */ u32 HCER1;
-	/* 0x26 */ u32 HCBR0;
-	/* 0x27 */ u32 HCBR1;
-	/* 0x28 */ u32 rsvd7[8];
-	/* 0x30 */ u32 MDAT0;
-	/* 0x31 */ u32 MDAT1;
-	/* 0x32 */ u32 MDAT2;
-	/* 0x33 */ u32 MDAT3;
-	/* 0x34 */ u32 MDWE0;
-	/* 0x35 */ u32 MDWE1;
-	/* 0x36 */ u32 MDWE2;
-	/* 0x37 */ u32 MDWE3;
-	/* 0x38 */ u32 MCTL;
-	/* 0x39 */ u32 MADR;
-	/* 0x3A */ u32 rsvd8[0xB6];
-	/* 0xF0 */ u32 ACTL;
-	/* 0xF1 */ u32 rsvd9[3];
-	/* 0xF4 */ u32 ACSR0;
-	/* 0xF5 */ u32 ACSR1;
-	/* 0xF6 */ u32 ACMR0;
-	/* 0xF7 */ u32 ACMR1;
+	u32 MLBC0;       /* 0x00 */
+	u32 rsvd0[1];    /* 0x01 */
+	u32 MLBPC0;      /* 0x02 */
+	u32 MS0;         /* 0x03 */
+	u32 rsvd1[1];    /* 0x04 */
+	u32 MS1;         /* 0x05 */
+	u32 rsvd2[2];    /* 0x06 */
+	u32 MSS;         /* 0x08 */
+	u32 MSD;         /* 0x09 */
+	u32 rsvd3[1];    /* 0x0A */
+	u32 MIEN;        /* 0x0B */
+	u32 rsvd4[1];    /* 0x0C */
+	u32 MLBPC2;      /* 0x0D */
+	u32 MLBPC1;      /* 0x0E */
+	u32 MLBC1;       /* 0x0F */
+	u32 rsvd5[0x10]; /* 0x10 */
+	u32 HCTL;        /* 0x20 */
+	u32 rsvd6[1];    /* 0x21 */
+	u32 HCMR0;       /* 0x22 */
+	u32 HCMR1;       /* 0x23 */
+	u32 HCER0;       /* 0x24 */
+	u32 HCER1;       /* 0x25 */
+	u32 HCBR0;       /* 0x26 */
+	u32 HCBR1;       /* 0x27 */
+	u32 rsvd7[8];    /* 0x28 */
+	u32 MDAT0;       /* 0x30 */
+	u32 MDAT1;       /* 0x31 */
+	u32 MDAT2;       /* 0x32 */
+	u32 MDAT3;       /* 0x33 */
+	u32 MDWE0;       /* 0x34 */
+	u32 MDWE1;       /* 0x35 */
+	u32 MDWE2;       /* 0x36 */
+	u32 MDWE3;       /* 0x37 */
+	u32 MCTL;        /* 0x38 */
+	u32 MADR;        /* 0x39 */
+	u32 rsvd8[0xb6]; /* 0x3A */
+	u32 ACTL;        /* 0xF0 */
+	u32 rsvd9[3];    /* 0xF1 */
+	u32 ACSR0;       /* 0xF4 */
+	u32 ACSR1;       /* 0xF5 */
+	u32 ACMR0;       /* 0xF6 */
+	u32 ACMR1;       /* 0xF7 */
 };
 
 #define DIM2_MASK(n)  (~((~(u32)0) << (n)))
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
