Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2531373-1520027005-2-6062371612540953276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520027004; b=TX/vJog2essJyshnJ8ho3zDPGlrTWnWPEHqLEuTyPN1bKeO
    Xnv84jqEEwt6OpEe/tMAh/5n1ShaFsuw/+iHojkam8ECg8B0AGN5RwGeLQAWV1Ko
    twvB3nZt/Ta5HBukAuCYbQNv2Pkj0fsqDgtXZjU8eDFVDxAV8TKunJIUWCFb7Gow
    jVXig1hpdFnIf45l1jcVTj1vDFDybr3KqBlScqyWG0KO/zlJtt17NENS4Vymdgbf
    sxZhskvf7oeb7zMBboU27S5x4TX1plYaj51UEfiW0eJvjFjPd216GCRUTAiPwb+o
    5mVzfJUugn81mZLbLnTHXwQEr9PkJC3avSxnzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520027004; bh=l
    XdBmzrEkfB+gJWl3SWGEgsiRFyhgd6sDLtmjv+uSQ0=; b=mVqmfAPZrHZHAELxV
    VlUtVY5YyBdFo1VLU54gbdkEucRwSN2YyPTEOA4uEaByNMhvQKA1ng2rvU11/pIM
    4GaLyLOOXzqFq3um+4fYmbG+h0dPE6YydGGDP17wUo5uojs2dq4c4ZkJGs+eDSr3
    xRvI1URKiAWzTvodgccJtGxtbNLewgSSXX9rbeXVnW7QP2oZv+siLSMsMCBmSo6g
    EcUG5yvSdYe4RuDN1a2w/gW4h5Lyya/SzVkE+N03ILzuEa1XSb1XyK4ibLjsnX73
    BRqsah0hdTihurGATGq/mUmJxLsVGXWa/ryViHFVklu6h83zKNSLjYXjD8L4te/J
    T8Geg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KVglC6sI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HXYaN+EN;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KVglC6sI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HXYaN+EN;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtjIwCUdjn4oRX0lXc41hlAa0maN1w1evjeqmuV3A0RKmVWby9XiYmZ9uKhC1Ss342PAkBqIQ==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: Larry.Finger@lwfinger.net
Subject: [PATCH 3/4] staging: rtl8712: Add spaces around '|'
Date: Sat,  3 Mar 2018 03:12:20 +0530
Message-Id: <1520026941-16548-4-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520026941-16548-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520026941-16548-1-git-send-email-arushisinghal19971997@gmail.com>
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
 Arushi Singhal <arushisinghal19971997@gmail.com>,
 outreachy-kernel@googlegroups.com, Arushi Singhal <arushisinghal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arushi Singhal <arushisinghal@gmail.com>

Add spaces around '|' to fix the checkpatch issue.
CHECK: spaces preferred around that '|'.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
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
