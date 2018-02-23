Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519420187; cv=none;
        d=google.com; s=arc-20160816;
        b=FV43ELqSxikKO6hWNDbPNdPPrYyctiCYwSyehuy6ZwXuil9CE4K95dNdx0QDlLiy0z
         46eoVxFJxRaS/K6rm3Zt42dq0+bRz9dliXVfQOIUb4Ul4bhb6HKPqEsgtexCrizViX2e
         DKGbNQu1LJUXmO6U+U1QSOjy9mGkqLwKoqprThFghd/I6kTbHNUBvXf0G/BhgokAGOkz
         tWHiwj8nbQ9UKfPVTaOPifHjgx48EvwTg8WcrXLcWMnOrFDEfQGTi8/o+SGgRcs29gZP
         K0B8iVJRm4N0VUPwID8dOiip5kVnAOC0aohQcwME98jVJpK8zI7hvzcqXTk6TrtPsfsW
         dI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Amtk+7mWyWduJ91TY8CEd/uBYe9HWvnniGvOwVpqJIY=;
        b=ajBHqKZxs7U7NjCcQsF9fWkugSEZ53vm7vE1dmRN1QpjhuaNDBocXIZkCYLZcJHJhS
         AO7wJydvqDMJkVN+A9g85If0GhrBJA6duVDznFE3pxeO2tIh9aaQHhZn4HL1Ay3LEA6l
         N39igoam9HhaHtzp+kL0DHNtSC07l8fFB1s1/yNEA6StsEYxMEb+xFcFzqWcB3IFIcBU
         8+QW6BNBDmp9JgDdNUxXGWpSdl2bKODi5LTunXHiRfQoGerOojfi1mtaqYZO2OYz1BzW
         vEeuglgKVWNiWOvdkpSnGKJwRi4BfcHztnXJ9EAal4gaSZdbXDBhx6f10DVsgZNhtDnj
         EI+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=beSEqbTf;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=beSEqbTf;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvj8Hi4kouSOfepw8Ix3+qYINZOY3sDI1isMVDDpC4IgjPhOBBGP3jQfppYRtEJeoz5XZU+zg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE),
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] ARM: add Broadcom Brahma-B53 main ID definition
Date: Fri, 23 Feb 2018 13:09:21 -0800
Message-Id: <20180223210923.544-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227542953652875?=
X-GMAIL-MSGID: =?utf-8?q?1593227542953652875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Berger <opendmb@gmail.com>

This commit allows a Broadcom Brahma-B53 core to be detected when executing
an arm architecture kernel in aarch32 state.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cputype.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index e7632f536633..6d1c7b22faea 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -59,6 +59,7 @@
 	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
 
 #define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_BRCM		0x42
 #define ARM_CPU_IMP_DEC			0x44
 #define ARM_CPU_IMP_INTEL		0x69
 
@@ -76,6 +77,9 @@
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 #define ARM_CPU_PART_MASK		0xff00fff0
 
+/* Broadcom implemented processors */
+#define ARM_CPU_PART_BRAHMA_B53		0x42001000
+
 /* DEC implemented cores */
 #define ARM_CPU_PART_SA1100		0x4400a110
 
-- 
2.14.1
