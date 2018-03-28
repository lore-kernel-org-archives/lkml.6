Return-Path: <shea@shealevy.com>
X-Google-Smtp-Source: AIpwx4+j5EFNeSsrf2JKt6jk1rmVGVr7ZWwTg4lXQH7lOfUWy2cxVSJCHjh+H/J8VStNp1wcGE+X
ARC-Seal: i=1; a=rsa-sha256; t=1522269467; cv=none;
        d=google.com; s=arc-20160816;
        b=BKN1m7zyaobEGkbPFb7PhzVA42cXtB960GU+SOyldJxWxohI9OU2X5MieA6hRXwSIt
         IuQF9UVfMnObsDJKZ+5uiqCapY9mt7rLtQCyd23VUnaQlCiTnT3SVcn3Y43UGfzlZwie
         E5217BE3FNwYSbLReGuvAiSRAsMtl5kjZGpP/SuC2sGTvUrcajuNp1xDL+do5k9OjLcR
         eiWVd1JMim3IMjLTfIPwpOMxv3J5ZMn9BD1axidVjTK3YRjzWSYmep9IH8CYgnSM6ekD
         Da+EviI9VHkhZM7V7nWZwlHQ1nuPbyPQR7bsMElx+Qnhth+Pj2h58XoMqrBZlgwubeeA
         VPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sqga65WMHQUMW+epDSNdWmapxjS58MsRiW4ahDAFvdc=;
        b=IpvdE4xgD1P3IxzZPvK0BBZbUYZx1QuVWveBizNVBc/Ws7qWq4Y79gaJY52U/iEfWD
         tXupvHKDbMq3V3rSNARNFvkbRIINwg0DPbqVd46MEM7nUrSg4JZ88KjPHuP3VohgZNyf
         fUwifyglVMByAawyc+a2uFUUPdL+alEWvFtWrQ3sWJeX2OSxI+UTt/lLp6qKMC+wD3mN
         haUn9eccruy7kScrA62BceNOw3pMnOfSndco+DzD/wsnDG+IKTDSFzU12BHljBttVMF/
         YsFlg8I5kOdYfpOqd+tx0a4PQnJ/x/4PtRKttP4ehncnfminO9ctcemadDnsarXR0YEw
         dDHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.82 as permitted sender) smtp.mailfrom=shea@shealevy.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.82 as permitted sender) smtp.mailfrom=shea@shealevy.com
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::,RULES_HIT:41:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1534:1538:1566:1711:1714:1730:1747:1777:1792:1978:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4385:4390:4395:5007:6114:6261:6642:9592:10004:10848:11026:11473:11658:11914:12438:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: quilt20_43e1e40ff5c20
X-Filterd-Recvd-Size: 1534
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v4 09/16] m68k: Use generic free_initrd_mem.
Date: Wed, 28 Mar 2018 16:36:52 -0400
Message-Id: <20180328203659.18692-10-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596215229649409530?=
X-GMAIL-MSGID: =?utf-8?q?1596215229649409530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/m68k/mm/init.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index e85acd131fa8..e20bef09258c 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -172,10 +172,3 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 	print_memmap();
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
