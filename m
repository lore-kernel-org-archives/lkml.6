Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-342653-1520993838-2-12307766565808258223
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520993837; b=QoqWvoxwWLiSHkO6UmeOmrQv/9709XDZB508KddvLs1c5AU
    pfUfAWqvEivFoxdR7KD1VrBA847Ui+fLJhFK1Apy4syfoyjL9kXXmIbHoKkdiaq8
    uF1qwwTGTYM6NDqkKdxe7LrryT3Kft2CuK0QOUJxUmzHN4HQbzebmJwl5tLfrXvi
    8RD/ABm0PiCvR2vjTiqBG+dnrBn5yFqjtFc18NIF50aLQba2dOj6ic1s6IASX7ug
    VMpN6ENAaNiVQ2LJ4XMMffGGLQxiesV/T3tEAjbiqFpn+SG1q6gM/2lh+tIU8KK/
    p3+MgScFrMIUEFVqz5Ylh8Flvuhdr/nSmRRntBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:sender:list-id; s=arctest; t=1520993837; bh=pV1ia0Hn
    M6Z8Ov1EvnOqdc+PwfrajjUQIdAz7KO1BSk=; b=SOqLoHQAhutprukelWgDap+O
    3HIUnif7gv5ogUup7OYeY90KCp6y06h7lQqrXBoTD2FWqPTOndzdxHoWaIIlumah
    4k6DMSCup1V7Q7pXCWhlqKEbk0J2yIOxNXPlzuNhrhCJ9ewREy/k1e3ooGvpigsN
    xxyosqTpPEp07EFcMX9b4Iqax2MW9qBqxo63qgQg2DtZz4/saesRk7St7DXCB9e1
    w3Jiv8Vpt1PXnQk5omDr8g22aZbQQS5u1V2bhjFqtrZjZLlkY0cB2q3gsGDXhK2G
    pUHxgA55fBoxQyrCVKCziQY2/0NoZqZraTqFsyUQ3fJDFPQKLKnkfafnDaPhUQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=S607cP7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=S607cP7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeCNCRO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 22:17:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54669 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbeCNCRN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Mar 2018 22:17:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180314021710epoutp0176a10b8585ee1215ce2a0031ea3fff9c~bp9Sp1P6K2906329063epoutp01v
X-AuditID: b6c32a39-47fff70000000fc5-40-5aa886264e99
From: YOUNGKEUN OH <y.k.oh@samsung.com>
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        YOUNGKEUN OH <y.k.oh@samsung.com>
Subject: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
Date: Wed, 14 Mar 2018 11:17:05 +0900
Message-id: <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7bCmnq5a24oog/u/VC2aF69ns5iy4QOT
        xdZb0haXd81hszizuJfdYkvXD1YHNo/9c9ewe/RtWcXosX7LVRaPz5vkAliiUm0yUhNTUosU
        UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
        9O1sivJLS1IVMvKLS2yVog0NjfQMDcz1jIyM9EzMY62MTIFKElIz3l7ax1TwTbxi9wzFBsbZ
        ol2MnBwSAiYSBybtZ+9i5OIQEtjBKNH3YyEjhPOdUeLA6sVMMFVPT35gB7GFBHYzSrx4HAlR
        9JNR4uTOxSwgCTYBdYkpPffAGkQE5CSe3P7DDFLELDCdUeLn67mMIAlhgQSJCdP3ghWxCKhK
        rF5zF2wqr4CjxJu799khtslJnDw2mRWkWULgIavEq7m/WSESLhLr2r9C2cISr45vAWrgALKl
        JS4dtYUINzNKrNldD9HbwSjx8e5nNoiEsURvzwVmEJtZgE/i3dceVoheXomONiGIEg+Jn60L
        oT52lDi6ZTYLxMexEtd6T7BOYJRcwMiwilEstaA4Nz212LDAVK84Mbe4NC9dLzk/dxMjODVo
        We5gPHbO5xCjAAejEg8vw4XlUUKsiWXFlbmHGCU4mJVEeLfKrIgS4k1JrKxKLcqPLyrNSS0+
        xGgKDI6JzFKiyfnAtJVXEm9oYmlgYmZkampoYGGiJM4bEOASJSSQnliSmp2aWpBaBNPHxMEp
        1cC4u+GTTPHGLVuM+8M+GQUL/epJdJwVlP1N2Hmmz5vi2as+1t9Z3/tS16nWcresuBuv9bFM
        j0ahFuYJMtsFXvsKZHTUqObdlehduv+De9i3hvcHvu+YohIo0WXyPdy4u/b/M+XNp2y7t/FM
        FmZPkVc8xKPXsox5oZov37KEDbMnvs2a9SBFn1eJpTgj0VCLuag4EQAw4XR1IwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJMWRmVeSWpSXmKPExsVy+t9jAV21thVRBs3HBS2aF69ns5iy4QOT
        xdZb0haXd81hszizuJfdYkvXD1YHNo/9c9ewe/RtWcXosX7LVRaPz5vkAliiuGxSUnMyy1KL
        9O0SuDLeXtrHVPBNvGL3DMUGxtmiXYycHBICJhJPT35g72Lk4hAS2MkocezSJ2aQhJDAT0aJ
        BTccQWw2AXWJKT33mEBsEQE5iSe3/zCDNDALTGeUmLv1E1hCWCBBYs2OqywgNouAqsTqNXfZ
        QWxeAUeJN3fvs0Nsk5M4eWwy6wRGrgWMDKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3
        MQL9v+2wVt8OxvtL4g8xCnAwKvHwMlxYHiXEmlhWXJl7iFGCg1lJhHerzIooId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZODilGhhlP3queP2RsV/xrmDHxttN
        U86FbrYoiWdtTIrlZJ7c3PPtnZn+ms+rA1w16+/MyZnvINN7p9swhafifzWLpYlX/0eLw4wL
        WFwZJn+oDlzya+5M+42tQjyuVnuZn3Tfu3v8yYF+gekt0zy6zigyqbVk6Xjm1PHn36m6UxNS
        1FD76UtSyuK+BCWW4oxEQy3mouJEAPYN9yr7AQAA
X-CMS-MailID: 20180314021710epcas1p3766602fe312f87d916cab69af2acf203
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180314021710epcas1p3766602fe312f87d916cab69af2acf203
X-RootMTR: 20180314021710epcas1p3766602fe312f87d916cab69af2acf203
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cleanup checkpatch error:
ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
---
 drivers/tty/serial/samsung.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 3f2f8c1..da9bddb1 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
 }
 console_initcall(s3c24xx_serial_console_init);

-#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
+#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)
 #else
 #define S3C24XX_SERIAL_CONSOLE NULL
 #endif
@@ -2198,7 +2198,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C2410_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2410_serial_drv_data)
 #else
-#define S3C2410_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2410_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #ifdef CONFIG_CPU_S3C2412
@@ -2226,7 +2226,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C2412_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2412_serial_drv_data)
 #else
-#define S3C2412_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2412_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
@@ -2255,7 +2255,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C2440_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c2440_serial_drv_data)
 #else
-#define S3C2440_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C2440_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
@@ -2283,7 +2283,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c6400_serial_drv_data)
 #else
-#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 #ifdef CONFIG_CPU_S5PV210
@@ -2311,7 +2311,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 };
 #define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
 #else
-#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
+#define S5PV210_SERIAL_DRV_DATA	((kernel_ulong_t)NULL)
 #endif

 #if defined(CONFIG_ARCH_EXYNOS)
@@ -2350,8 +2350,8 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
 #else
-#define EXYNOS4210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
-#define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif

 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
--
1.9.1

