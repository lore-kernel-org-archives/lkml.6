Return-Path: <shea@shealevy.com>
X-Google-Smtp-Source: AG47ELuPLWJ3d8m2F8/ltnK5vEdhkRXUoi8zNTiY28WSQSmqMRHhbOz5Wf60OiSRM41vnm0627k4
ARC-Seal: i=1; a=rsa-sha256; t=1522269463; cv=none;
        d=google.com; s=arc-20160816;
        b=yz8UQFjG5C7vVX32MYhwIuTIiqyfGruke/1lK9XJPaHOvRJfOlxkHWXNfCDEzP5xm9
         J6zc80pxm/IR1nKo9mCIAk2KLuCdIOc4zVmOhW8foq/c+X6pGhvCF6EW17Ama4NzouxD
         Gi2U4qjyDDTYO4otFwKZw7rU4LfYmeVbq5RTPYXOflh9wfSUopuzrQl/EQmvwdOfNaum
         fRlyEGXsOO/UR0pUebu8AN1cFeKZb1lngDvS8N8SQOtQsCcY8IO4MAkSoFvrUEKAzBTM
         ZuigWACCBuw5Pa7EhBjaICHA0M+2q08VA8g9usl7DNVJW90O8Oi+ALAo28pfaB+e1eTR
         vCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JgtGvXBUiZz6bZkiNg0ZnrdmqoXVw+FQPNlGxAGTWg8=;
        b=geE7i3NF9ev8D0p0jKrnS0eNDWGzP7J4GGGINys1ciNZngYijBISGMQnfnCdIq1L0r
         s6mcdMzavtP7Axe3/5I05rOM+hOYZC8SRKTV2YX7wOkIXqHnrD4wHBKvrHNwtrSgCEed
         d+iBThjI5FCLgIW4vBaUmpvR4ofV7tlfrU4TPXmCTx9HvLui+ZZCQLOp/f/8eqE+qN8U
         aO7k7Ly7/KKH/kiNjT3EnPZzqB1iB6lnYaDqaeRxsqDbeeLMRitmDmwi2oCqDRD2ObQH
         +2ejqOh1Qt3Ab2HO77K5Ba3Jgo4N0F+x35r3lrVua+hwH21g0uqjL/3ah3PTwNx7dS8G
         20bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.185 as permitted sender) smtp.mailfrom=shea@shealevy.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.185 as permitted sender) smtp.mailfrom=shea@shealevy.com
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::,RULES_HIT:41:69:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1534:1539:1567:1711:1714:1730:1747:1777:1792:1978:2196:2199:2282:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4385:4390:4395:5007:6114:6261:6642:9592:10004:10848:11026:11473:11658:11914:12043:12291:12438:12555:12683:12895:13069:13311:13357:14096:14110:14181:14384:14394:14721:21080:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: rub39_435802f223f44
X-Filterd-Recvd-Size: 1648
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v4 08/16] m32r: Use generic free_initrd_mem.
Date: Wed, 28 Mar 2018 16:36:51 -0400
Message-Id: <20180328203659.18692-9-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596215225303275760?=
X-GMAIL-MSGID: =?utf-8?q?1596215225303275760?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/m32r/mm/init.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
index 93abc8c3a46e..e2b5f09209ee 100644
--- a/arch/m32r/mm/init.c
+++ b/arch/m32r/mm/init.c
@@ -139,14 +139,3 @@ void free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-/*======================================================================*
- * free_initrd_mem() :
- * orig : arch/sh/mm/init.c
- *======================================================================*/
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
