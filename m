Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449371-1520055246-3-12862764546935530000
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
    t=1520055246; b=gp+pkiaI6r72I6X5CPQ6jNAjbMoixAjH1FoBgrDmQZSHhP3
    rtYzpLz1xHW6BrsheiIXDnULil6/jDkSpMacX9e33qwasYOn/4UK7//lUmVXr9v3
    OnhwlEjot5Tg4yVmiCi1iGzkQEV2G6D783pkNNJBTpjnonBa0oJFEJ+CnbTOefx3
    87GyeK8GcLy/o1m1LEbjym0uBFPOGb/pn6ea7EAJBAPsaWcmkj3k4IdVI6h0el9j
    Xf86EV8bbYTzt7+QbRr5scmZyZvgfynUPWwqk7ZFUarUS8GtXwygTXk/PfVZo9A9
    Qs94KfFDRD7Qcfc+75YmRYvcw32nlQApE8N1/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520055246; bh=M
    cbnEt44YABOtP+A+CypY5+CQ614geMM/fF7YEjFBaY=; b=g/7TFsaVvm06AiWnn
    6JdMbegXy/RDJIib+XkMA51tJnHO/7/sVhiKL2er253xBcPDAupZP+0ev5jXDO8n
    +aXzE18Xff3c2sj3tXswNyYkZgiXr0BykO7DnOxkHljaOmhqXxJ//fH+d78l+TT9
    47X91Tqy9+KcE86QGZRf4mQIUbNM/A87IvdU7ftwekSZAmXKFwa24LXd1WFRW090
    XtiqTzhLKKm703Wow/dcRnGkNSy1zxWvz0DJEKx/jSD74RCaXS0VoyUcDZFRLUSq
    c4HSDunjOdP4xPqxrbdDko9IkF43IuVjOflvP5ruhzdN3FLDs6UM4TykcKmdbad6
    PQ7jw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gbne+A8x x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kJ3/Iwrd;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gbne+A8x x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kJ3/Iwrd;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELv/2SrcPJ0AIrCdwpEUaaHrVJ15LISdjl+xEwa/DRxgkU4px8At3YoMRCawulh+K4JWDl8OyA==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: outreachy-kernel@googlegroups.com
Subject: [PATCH v2 3/6] staging: rtl8712: Remove multiple blank line(s)
Date: Sat,  3 Mar 2018 11:02:33 +0530
Message-Id: <1520055156-8388-4-git-send-email-arushisinghal19971997@gmail.com>
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

Remove extra blank line(s) to conform to the Linux
kernel coding style. Issue found using checkpatch.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/rtl8712/os_intfs.c                 | 1 -
 drivers/staging/rtl8712/rtl8712_bitdef.h           | 1 -
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h   | 2 --
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h | 1 -
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h | 2 --
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h  | 1 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h  | 2 --
 drivers/staging/rtl8712/rtl8712_gp_regdef.h        | 1 -
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h | 1 -
 9 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index d6d27da..ff4e451 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -347,7 +347,6 @@ u8 r8712_free_drv_sw(struct _adapter *padapter)
 	return _SUCCESS;
 }
 
-
 static void enable_video_mode(struct _adapter *padapter, int cbw40_value)
 {
 	/*   bit 8:
diff --git a/drivers/staging/rtl8712/rtl8712_bitdef.h b/drivers/staging/rtl8712/rtl8712_bitdef.h
index bff57a8..dee35fe 100644
--- a/drivers/staging/rtl8712/rtl8712_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_bitdef.h
@@ -18,7 +18,6 @@
  *
  ******************************************************************************/
 
-
 #ifndef __RTL8712_BITDEF_H__
 #define __RTL8712_BITDEF_H__
 
diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
index 9374f1c..8df42a7 100644
--- a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
@@ -20,7 +20,6 @@
 #ifndef __RTL8712_CMDCTRL_REGDEF_H__
 #define __RTL8712_CMDCTRL_REGDEF_H__
 
-
 #define CR			(RTL8712_CMDCTRL_ + 0x0000)
 #define TXPAUSE			(RTL8712_CMDCTRL_ + 0x0002)
 #define TCR			(RTL8712_CMDCTRL_ + 0x0004)
@@ -29,6 +28,5 @@
 #define SYSF_CFG		(RTL8712_CMDCTRL_ + 0x000D)
 #define MBIDCTRL		(RTL8712_CMDCTRL_ + 0x000E)
 
-
 #endif /* __RTL8712_CMDCTRL_REGDEF_H__ */
 
diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
index 8bd4837..4b34367 100644
--- a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
@@ -51,5 +51,4 @@
 /*FDLOCKFLAG1*/
 #define	_LOCKFLAG1_MSK		0x03
 
-
 #endif /* __RTL8712_DEBUGCTRL_BITDEF_H__ */
diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
index 43630bb..d7c964d 100644
--- a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
@@ -41,7 +41,5 @@
 #define TRXPKTBUF_DBG_CTRL	(RTL8712_DEBUGCTRL_ + 0x38)
 #define DPLL_MON		(RTL8712_DEBUGCTRL_ + 0x3A)
 
-
-
 #endif /* __RTL8712_DEBUGCTRL_REGDEF_H__ */
 
diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
index c564dc8..bd82404 100644
--- a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
@@ -140,6 +140,5 @@
 /*TXFF_PG_NUM*/
 #define	_TXFF_PG_NUM_MSK	0x0FFF
 
-
 #endif	/*	__RTL8712_FIFOCTRL_BITDEF_H__ */
 
diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
index 29b89c4..6d52738 100644
--- a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
@@ -71,6 +71,4 @@
 #define TXQ_PGADD		(RTL8712_FIFOCTRL_ + 0xB3)
 #define TXFF_PG_NUM		(RTL8712_FIFOCTRL_ + 0xB4)
 
-
-
 #endif	/* __RTL8712_FIFOCTRL_REGDEF_H__ */
diff --git a/drivers/staging/rtl8712/rtl8712_gp_regdef.h b/drivers/staging/rtl8712/rtl8712_gp_regdef.h
index 8fc68f6..a037936 100644
--- a/drivers/staging/rtl8712/rtl8712_gp_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_gp_regdef.h
@@ -37,6 +37,5 @@
 #define PHY_REG_RPT		(RTL8712_GP_ + 0x13)
 #define PHY_REG_DATA		(RTL8712_GP_ + 0x14)
 
-
 #endif	/*__RTL8712_GP_REGDEF_H__ */
 
diff --git a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h b/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
index 49598c3..2a561d2 100644
--- a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
@@ -53,6 +53,5 @@
 #define	_VODOK					BIT(1)
 #define	_RXOK					BIT(0)
 
-
 #endif	/*__RTL8712_INTERRUPT_BITDEF_H__*/
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
