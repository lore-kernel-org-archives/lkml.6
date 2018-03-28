Return-Path: <shea@shealevy.com>
X-Google-Smtp-Source: AIpwx49kJi6rGPan4VccBG0VW4ToOyfugwxlGaVhrbslN3F7XpOH3A2T9n+XdpvDT0OJft3ruuti
ARC-Seal: i=1; a=rsa-sha256; t=1522269447; cv=none;
        d=google.com; s=arc-20160816;
        b=wrCkFpLpfdfEidVykLa6LnCFRWGD34HuDmg9MnrI8OjhG7IEEaruvRBUrmeHk/WeWz
         6yGBm3xo3XvuoxRb+MpbkEqjYQMUOdH8DTxN//XE4tpfnYBT6Dj0yjIMUs+ymBVVMsHQ
         A5LV6rlKU7ICvaAB1D9gLtYDuU/FIbZaBj95R4qo0/Z7/wdNYyH7mM9Wm+g4EfHjpFyf
         I9iaVl/mYMNc12IuiEp8UBMRk0Ei+D6TrVLSVhcrLpxjNZZJ6SWZGS5EeHxT5s/ZhMu6
         u3cZXuW5+O59fPpzj3ka5DPXuSqh1hz/Qln10mhNrj3L0od62jJ6lV0QdX1WmyQj1Hvd
         hgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=e5gugXs8Sxt0QVjmxpNPQzNUtTSv8t3FvWLvWI3JtBM=;
        b=q8cxdPkk7FBIcpBZBBLZL5l53sanGqXef9gj1Uucmj5iYrvdHaeI7AN573bagcrnNC
         1mcNSXMVRJRBrujwwJ//AzRgQwLGVZX2ayonWTaZG2FNT8N+TzH/HecAaMN/xjM2FYQZ
         lg22PV1q0Qdz+hfsYT7FKCdfEWQoqL1eaqxpB+/thnVVgHL5cAljQ4WnIKH1cMIIrZ2K
         IO5qe8Cccnj4u2nMcqbMBN2DL35cNANY+DYCJTQgI87f+xZ0GNPXWpeB4DIa6M+qgSWD
         JnDgZb0qgLSOnbCElGrEZlBFBo8JjQGJPNmyBnvcZnPzjfwExMvAOR7IcXMyzKW/sSwT
         rRgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.232 as permitted sender) smtp.mailfrom=shea@shealevy.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.232 as permitted sender) smtp.mailfrom=shea@shealevy.com
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1534:1538:1566:1711:1714:1730:1747:1777:1792:1978:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4321:4385:4390:4395:5007:6114:6261:6642:9592:10004:10848:11026:11473:11658:11914:12438:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: pan64_40e5703f3cd41
X-Filterd-Recvd-Size: 1590
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-alpha@vger.kernel.org
Subject: [PATCH v4 03/16] alpha: Use generic free_initrd_mem.
Date: Wed, 28 Mar 2018 16:36:46 -0400
Message-Id: <20180328203659.18692-4-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596215207960360321?=
X-GMAIL-MSGID: =?utf-8?q?1596215207960360321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/alpha/mm/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 9d74520298ab..55f7c8efa962 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -291,11 +291,3 @@ free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void
-free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
