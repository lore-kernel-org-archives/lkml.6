Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2235763-1523578581-2-13731572092671057962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DRUGS_MUSCLE 0.164, FREEMAIL_FORGED_FROMDOMAIN 0.25,
  FREEMAIL_FROM 0.001, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523578580; b=qweAhZR8OA3/T8BKDE1LVNf+dpB8dOKgjW4rpbARwu5aIB52ok
    KnKCuSDF7o5L3rWIA1crJyoltA1Kfa1uxtKAXPpk/Q47Dz2AKGcaHKK77vJeo87P
    0FedaUg+/jOL6lm2nklketBRiwMil6Kt0mrgT/uoP3tcs/h6qCDGNEQYLm7/NNsm
    /IHSLo0EXKS3YA8h2pYxSZhV2DLmNrEW0hbBiwSenPqqM9F49QXXoCnAFeFCHG4F
    spqV9hkh9+IADYz/P3zqOtB+GEy99tRNzpQjy8RE9VOmErcAxD+VaketILAnx1TG
    hKkU3CLAPwp68pG7dprJZOZgz/mWUVPxAKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523578580; bh=jrZyo
    Al+QQnFIP1a2SykUWYzlBeb52ACDyQf1hVOcgs=; b=Wb6GrUts4UvUBYBtiqiLP
    zg6Tf//pMX6JbGk/X5tRQnZCCED6LA/heYiY1xjlfg34TRPlREBwPPM6rz4Kawfj
    LMXQc4V/fY2GGU4H7DYTHWzsrhJn8k8vAC0K4vR2aJeWYbD6H5s+RDpFBjpCVs6q
    QlcLg2HxcbbY5Ze6QTosh7R08LEx2tfaFF0WrwTalUChKxHqLEBBeQ074PWVq9UC
    FJuCvhe8woARCOfCCZerdbrqIwKY6hhNYV+NAuKm6pw5ewmQ54gZXAUztRG/VQQJ
    NwoBHRxLas3hIdsnoHJeoEp/4gOcnRdWHy9FefVV6jjSNHRblTv4iB0bxgK4IQMP
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tTRkexnP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q2ygJPr1;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tTRkexnP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q2ygJPr1;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIm4mfUAt8QMb8YRkpxhBL5y6PuLVDbRPzC5g1SkXNTCP2jB557xeJmeOuEpQSLl36wu4FUPfs/Al2NgknxUXznKyuEmtcAfD4c32fNleTtUUp6Cfl0H
    6KgGxdd6JllJJJL1uJlWyj4yC3xopSq1eQNAb+EB4Uhqg4MPG+TC1EYPhswQVgdSKQ8r51H1ZVRCce88UV7OUHlCkgaFJigchEQ3duU3fHPXAzZCwYUTqWcM
    tLJ5bnTiHrUG/WuUFvnCYg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Y44SiAWf95kA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=oV_6Fk2uNbn53Y0RMnsA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/WXbXESd5h8vNyQ2W8pyUpYF8471IgJjx17n7g3v1+2Pezn8cxvKmtynL5gk9wX+lERbdJnw==
Date: Thu, 12 Apr 2018 21:16:02 -0300
From: Renato Soma <renatoys08@gmail.com>
To: thomas.petazzoni@free-electrons.com
Subject: [PATCH] staging fbtft: Fixed lines exceeding columns limit
Message-ID: <20180413001602.GA18920@rys-Inspiron-5420>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 lkcamp@lists.libreplanetbr.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix checkpatch.pl warnings of line sizes exceeding 80 columns.
Break lines in order to reduce the instructions lengths to less than 80 columns.

Signed-off-by: Renato Soma <renatoys08@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index a263bce2..57742d7 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -22,10 +22,13 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {                    \
 		va_start(args, len);                                          \
 		for (i = 0; i < len; i++) {                                   \
-			buf[i] = modifier((data_type)va_arg(args, unsigned int)); \
+			buf[i] = modifier((data_type)va_arg(args,             \
+						unsigned int));               \
 		}                                                             \
 		va_end(args);                                                 \
-		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device, buffer_type, buf, len, "%s: ", __func__); \
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,                  \
+				par->info->device, buffer_type,               \
+				buf, len, "%s: ", __func__);                  \
 	}                                                                     \
 									      \
 	va_start(args, len);                                                  \
@@ -37,7 +40,8 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	}                                                                     \
 									      \
 	*buf = modifier((data_type)va_arg(args, unsigned int));               \
-	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset, 0); \
+	ret = fbtft_write_buf_dc(par, par->buf,                               \
+			sizeof(data_type) + offset, 0);                       \
 	if (ret < 0)							      \
 		goto out;						      \
 	len--;                                                                \
@@ -48,7 +52,8 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	if (len) {                                                            \
 		i = len;                                                      \
 		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args, unsigned int)); \
+			*buf++ = modifier((data_type)va_arg(args,             \
+						unsigned int));               \
 		fbtft_write_buf_dc(par, par->buf,			      \
 				   len * (sizeof(data_type) + offset), 1);    \
 	}                                                                     \
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
