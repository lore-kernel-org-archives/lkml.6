Return-Path: <wanglong19@meituan.com>
X-Google-Smtp-Source: AH8x227WCCpFeCLCqNNJG7wHIGpdDeaPHe9QajxIL7+tY+yTwNyOM2GDOM4P8T03Z44VVrQ1DD9S
ARC-Seal: i=1; a=rsa-sha256; t=1517847076; cv=none;
        d=google.com; s=arc-20160816;
        b=aAl/gnMmxi8SrH+ZgpcFfsKv98iUxJqnP3LWybCzL6W05w35dUXHNdsxygg/L+RWR/
         c7PwMKVkOnamQZJ/FVh3AY9GctF528ea1kk511KGHoMMMeg62/wZf5RwBXvIzIACkbHc
         mYvrdOmyWP8ZPNHlBg29a8Dci2IwOujXlurrL9IWaqmmR4+2SbgJBroo5NYmVPrlJXCF
         xVgMkMMxgK1gs4Re4f4sSDsVM8k/+l2+qrVRX5Xqvye9oK4U/DpKZHKYiwhtN2S5sGAd
         J5kbSsgJOJnyWwtwpPH11K8e+ns5D4Fwp1PyNrBbLnR6zSjV0SL5soe81uTAzNZ7Aun8
         jTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=TZ2imyoTJqy7wrsXpaWY8vJ8VE0JkBUVUuRYwP+Rvf8=;
        b=niLgBNM9yFO2hPF/BaE9GjOx9hC4kFRz96UP294hCDkTGucGtbM2TLc9u0mGYpeyCI
         zLqXaKxd1pT4rPo9kLgcyhiVnO+kXYYbRyg1Qw94ddbCLzlbGE9si1hHMfxK6vviTcKL
         nvirxxB9Ifo9FG+eKY0dL0nPkSnVR2h4YBzkM9usoQZsDmJg6aqQHSxytafts5lS8Gga
         tHx3FzCo7DCaweImrnmfBEB4Np+Uut6ekEQuoVrJqTnEvpxZCONJ5Mmf1P+lmkb0hUJS
         b9hNYzCMJXNZqiaOrOrSKajix3B9dkd6yQ4pZff8NfuGMqzC2cPHSBbJGeH8GWy/IP7x
         dyQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@meituan.com header.s=20130113 header.b=KXbDbh3Y;
       spf=pass (google.com: domain of wanglong19@meituan.com designates 103.37.138.210 as permitted sender) smtp.mailfrom=wanglong19@meituan.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=meituan.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@meituan.com header.s=20130113 header.b=KXbDbh3Y;
       spf=pass (google.com: domain of wanglong19@meituan.com designates 103.37.138.210 as permitted sender) smtp.mailfrom=wanglong19@meituan.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=meituan.com
DKIM-Filter: OpenDKIM Filter v2.9.2 dx-it-mx02.dx.sankuai.com A7DF32980266
From: Wang Long <wanglong19@meituan.com>
To: kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org
Cc: tglx@linutronix.de,
	pombredanne@nexb.com,
	acme@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] {tools/}include/linux/poison.h: remove not-used poison macros
Date: Mon,  5 Feb 2018 21:05:39 +0800
Message-Id: <1517835939-29618-1-git-send-email-wanglong19@meituan.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591578016186364598?=
X-GMAIL-MSGID: =?utf-8?q?1591578016186364598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch also change the comment(s/jbd/jbd2/g)

Signed-off-by: Wang Long <wanglong19@meituan.com>
---
 include/linux/poison.h       | 3 +--
 tools/include/linux/poison.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 15927eb..ff811a5 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -66,8 +66,7 @@
  * value of "SBAIOMMU POISON\0" for spill-over poisoning.
  */
 
-/********** fs/jbd/journal.c **********/
-#define JBD_POISON_FREE		0x5b
+/********** fs/jbd2/journal.c **********/
 #define JBD2_POISON_FREE	0x5c
 
 /********** drivers/base/dmapool.c **********/
diff --git a/tools/include/linux/poison.h b/tools/include/linux/poison.h
index 9fdcd3e..681ce81 100644
--- a/tools/include/linux/poison.h
+++ b/tools/include/linux/poison.h
@@ -71,8 +71,7 @@
  * value of "SBAIOMMU POISON\0" for spill-over poisoning.
  */
 
-/********** fs/jbd/journal.c **********/
-#define JBD_POISON_FREE		0x5b
+/********** fs/jbd2/journal.c **********/
 #define JBD2_POISON_FREE	0x5c
 
 /********** drivers/base/dmapool.c **********/
-- 
1.8.3.1
