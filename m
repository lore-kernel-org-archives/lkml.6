Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246482-5-13562533232835031756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
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
    1523246482; b=m5gsEBY+hlELaiB5np0SQe+wRvTJzmm5kisaIErEkKdLUy/Ebw
    /B8cx4a2q2NtQggvHJ07cwvt5hILwfKJ5lPJVIVhkAMTUP4apS8ZW1aNp74W/w3m
    nZpfppDedSzXYDIn3ErmlO6GH8EULoK3jUZOMIHZXVIy4aZXF5I3rnW2p/3R5iBB
    k72px42pSrksPfpWG6MR5eRRTf8TkATm+FuXvYRqZCd6OOfjvN+OolNS2CViVcHF
    cW2XHec3UcSkOzsDzbRWpWGpZGEu1gnCBmAJ27oGQKnV49N0eSLg7WRnk/AqgsAs
    8VxcTdqk/dNf8VLckO2+dIIpiLk6ucslZNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523246482; bh=Yg5Gx
    up0LsP+1UPJqoxwv9o60mLM00bXwJq8ZorFJ3k=; b=Py56C/x2mhcPPvIQk1xST
    pDRUi3M2PVO8NP5RKlzVnnnkYFq5hRkhrO5IQpcUe5H81YwKq5Hmg1wV0cx6We1h
    E2bSPdngKdU7Z6EqEwclaxJy4ARdSJ/eJdTPXLXm4zRvDWzAfVgr1DsMVSxys4Bw
    2oQ7EJP95g5ppk3McYcux6+dCEyAsdzX+vk5sAp61f/twj1toCkhpsy6oC/oHz1E
    rBvK7lqqiE/yqYSWP0lxwQGV4mMO8s9bus15yFz1DK+RUS5hDUsbsS6m0LuPj9SQ
    hVEJ9BiS58TmiU+vQ5KZHLeBfJisvyakP4/anQT5GXAcPy5Y08v4fG2flp7G9vzk
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZhoH4QB5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sSFsj1UE;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZhoH4QB5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sSFsj1UE;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNsJVMlRTb7bzFiZnu6EgYnCppOVAeB0rOhdxP4GEz2vX3YTjhoNGdH72AMvzocVLtcQ2zLNxuM3v6fplhmwW+YOK+PcOFVIgzLpx3rx+Tu4czoPIn1s
    GtBgoyod/Hpznjt15nWKtdeVnXrsNW7unSwy88hCbzFHTFbfHA1u2nvqO15USNlCO2NXXv73SyE0YVPRzGTB7Va9JSukFZn8yCA007oXxymi5i17TotIzZ99
    2LlTcbghthr3FY7icTt5oQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=2OGnzELo1qEA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=pwh-PkiZz6V0pp13r1MA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49DI2EuIKpC+uc9ptzF9yp65+2M1ksX2evOaplGre/i7HPpQQtf6/CVZPcMBDkUOyJA/86K6w==
From: Shannon Booth <shannon.ml.booth@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Staging: pi433: Fixed a coding style issue.
Date: Mon,  9 Apr 2018 15:58:56 +1200
Message-Id: <1523246336-5958-1-git-send-email-shannon.ml.booth@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 Shannon Booth <shannon.ml.booth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed incorrect indentation of a return statement.

Signed-off-by: Shannon Booth <shannon.ml.booth@gmail.com>
---
 drivers/staging/pi433/rf69.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 5b05548..430f7ad 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -579,7 +579,8 @@ bool rf69_get_flag(struct spi_device *spi, enum flag flag)
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_CRC_OK);
 	case battery_low:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_LOW_BAT);
-	default:			 return false;
+	default:
+		return false;
 	}
 }
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
