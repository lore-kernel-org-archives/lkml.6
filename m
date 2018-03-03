Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449371-1520055252-2-3857953645259637964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520055251; b=dVod/yBi0XM6ksfVW+iLaCRqyksPPK+eBDMGe7o9T7iDpDB
    LaXYht9pSFu0ZKzm54yIB6+sh9iKuKo23QtZXkeAm1J9F5L+iEwkQFE5rPtb+wva
    sFaD7HtLwbonBnv+/Q8yT3wjMKFKwxdqpDP33zxv/dwczpadh6jRGHTX7wBIcd8X
    hpfhBnt0u64b4a8I1XNSV8frDnus3mR8UCX3A5N7aHfi+FMwasBIn0/Ekz6stmWl
    sX8PFCj3BKBXWwwNVS3yFO5LgIh3UIAdMTOb29MWtPjs7IPDJdVg5EHjlflPxa1O
    ZM8IajeTcd5ESoVPJG6wBwydUc+YsJd3UhulAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520055251; bh=L
    F33E4S4PiKBtcoJMMxzFQBYkOLmKOOI1M+vcxF4xNE=; b=dI2l2shKNLah9exKM
    LpmYDxD3xlrHDE9tR8DtKU4C2khvDPR7pUrWS2MgUcMbt7zAu1SS1aP6PD9ENEdl
    L64tBLG8pt2/Ae8E2AtwbMR5UbsjOO3kYP+LrGQlgRVTal1y5vqEYjvFHaDUTlxt
    ni61hC+ALEgHILMM3kBBix1vV7RWn4hDneA+uRmKFMpVMLuAby7YC8Q4j4PCSrjf
    ubVKaNaYVwj7Q/IyL+m+E1+5jtnON0Sd9z63g8Xi2v4d5KI68Cc3CI7sy3p/LbNT
    r+6oqwKL+FlUFgosq3mozpr8Vp92rD0uoc1ZTasvJ4FoUGHddoTT9W61nYgZI1fv
    ZO1ig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HxF37NRU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OTLVMo3d;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HxF37NRU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OTLVMo3d;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsob3uYzQaHh7mSEEe6oqaVAVuX6YUhaVJltNcCTDr45p0K+cXMebOBILAXJKG5gmmGJVJdEA==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH v2 5/6] staging: rtl8712: Add spaces around '|'
Date: Sat,  3 Mar 2018 11:02:35 +0530
Message-Id: <1520055156-8388-6-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add spaces around '|' to conform to the Linux
kernel coding style. Issue found using checkpatch.
CHECK: spaces preferred around that '|'.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h | 2 +-
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
index b7dda90..4b8985d 100644
--- a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
@@ -63,7 +63,7 @@
 #define _IMEM_CHK_RPT			BIT(1)
 #define _IMEM_CODE_DONE			BIT(0)
 
-#define	_TXDMA_INIT_VALUE	(_IMEM_CHK_RPT|_EMEM_CHK_RPT)
+#define	_TXDMA_INIT_VALUE	(_IMEM_CHK_RPT | _EMEM_CHK_RPT)
 
 /*RCR*/
 #define	_ENMBID				BIT(27)
diff --git a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h b/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
index 44c9060..66c35c9 100644
--- a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
@@ -70,7 +70,7 @@
 #define		GPIOSEL_PHYDBG	1	/* PHYDBG*/
 #define		GPIOSEL_BT	2	/* BT_coex*/
 #define		GPIOSEL_WLANDBG	3	/* WLANDBG*/
-#define		GPIOSEL_GPIO_MASK	(~(BIT(0)|BIT(1)))
+#define		GPIOSEL_GPIO_MASK	(~(BIT(0) | BIT(1)))
 /* HW Radio OFF switch (GPIO BIT) */
 #define		HAL_8192S_HW_GPIO_OFF_BIT	BIT(3)
 #define		HAL_8192S_HW_GPIO_OFF_MASK	0xF7
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
