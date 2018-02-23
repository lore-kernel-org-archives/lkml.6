Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519420190; cv=none;
        d=google.com; s=arc-20160816;
        b=NEdqyfGhOM92Be5SQANCxbzNfpECvasH4One6fn/a+KCx4OtndUW/B+FI44bsw9Blc
         NWDWXADLKF/R3cjIP0v+xE9QCKi5PWdU5FHJeT4bqW4QflDh8qdDle9swJ/iqToa6Q2+
         INm1IMCi32NVVHaymAE7fgC38eo9La8q9VME9uqHyhHDJWS3MxR5bV8vrMGqRnr1VH35
         JGyRY+rMosPeGuEDKOI8fcxT6U+0s8w2r7aYURSdiRsk1sJvRYVztOZVwNJXy0pLM2tj
         YzACM/vhgUO7DW7H8twVYFDNCDyP5lx5PxvMnX+CPTcoMDdB4mpKgTLURmqL5iqO7EyV
         TuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Lg/VRo/rYx8fs0RMCTCt0Nu+cmf7b1W3Wrm5AmtmG58=;
        b=Zl6SzC1vd5seIIASvPUTZOrcvND5hfByNJHQGwIKTizJC+12eDfWbd97p3QdwYRCuU
         ohJrFkfHG+Ms7aRLuIOmZAA6TB4k4IGVf572/iBOegzIvErPYGmdIp9yLg0MV2XZovCg
         1JbLfZzjGjoc5XeTx9h5Hctx5vZUcwLbBMMJx+spn8Z1Pm/U8DsoLexmtGmUtl3O22t/
         rBG2fXqrR/9U4mV487AxlLDoAS9EsmgpYSo2QLtftoz0Yl+sNDRXXkT1QrQHS3HVy930
         lswgIOf6Q4p0eA+NY/yRUHTNFkWKwUutvlTjPSdCxvVPd30zTccykJkW0sXYysilAV2M
         PPbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PQM68C49;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PQM68C49;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuIxz57CtDXGMWfQ1ZpIqvUdPdBTuxknzw1GJyV9MY3J88SYUw8OHovDmMnzFmqFpXRKlz/Ng==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE),
	Doug Berger <opendmb@gmail.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] ARM: add Broadcom Brahma-B15 main ID definition
Date: Fri, 23 Feb 2018 13:09:22 -0800
Message-Id: <20180223210923.544-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227545564810581?=
X-GMAIL-MSGID: =?utf-8?q?1593227545564810581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define Broadcom's Brahma-B15 main ID register value, masked with
ARM_CPU_PART_MASK.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cputype.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 6d1c7b22faea..d1b62ee69f3b 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -78,6 +78,7 @@
 #define ARM_CPU_PART_MASK		0xff00fff0
 
 /* Broadcom implemented processors */
+#define ARM_CPU_PART_BRAHMA_B15		0x420000f0
 #define ARM_CPU_PART_BRAHMA_B53		0x42001000
 
 /* DEC implemented cores */
-- 
2.14.1
