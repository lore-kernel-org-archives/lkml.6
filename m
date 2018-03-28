Return-Path: <shea@shealevy.com>
X-Google-Smtp-Source: AIpwx48swNTlC/H3PA+JF9XREO9ml7kn4opzc7DdZZln1Nx3QWVEPoJQbtMqvb591fSYih1jyNS1
ARC-Seal: i=1; a=rsa-sha256; t=1522269480; cv=none;
        d=google.com; s=arc-20160816;
        b=hLELtlFF2LeZ+1v3kRv1dWlr/y+38fFMqSPhtzifi5UeEqirmV4jroatmM4f1jnyNC
         84H+sjLOdd6f7RIHqEu/d8Cn4sBsY/0JGGGG3iYU4bGbfF6Ut1Kwk44QgjI9JULbHpdY
         U+31Iv9zWwuZaxbqBgBOY0/tvVcbnbuCym8D9ZiMvOx5IRDHzcV3E1QhSmhJP62JwQxI
         P3Q9hil8OFUIPXA/8V9aCO5OxboGc/ZMzCetKfXwVSjdRKEGAxs+ppwB0jrg1gjuRG98
         Yr9Gfv6eiL0JIDDVs3qiyi80ViplppWvgHREY0ETWDVXqRnQ2vdWLZEJST8VfTQazPJ/
         gNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JDjMqVeOfY29vPix3ET+B98fa9Vtlho2doHR6yjKLHY=;
        b=vj+34W0s/K0biEpTK3FNIGuzibRcroUi9bF4XhfO3TLqRgoYrG8xgVv9BDypRfff6e
         V4HgVQlaSupQkba9OoRpq0g/lqXluxOS2RuF9w/QCquhHWwmGv2WR6c4vANbTosRoLYT
         KJfFShR1hvwXwHGI+bqJmI5ZF4cVMN2d2C/L5NGLIU3uiDRqW0w0b3QLZc/OIqfjYv17
         BMYLSP6wnB7BdO8+5i7hym23xoDFRY9EIUS94+wfTqHOMAs4h1M2e0D6rphl77Of5I3W
         h23YsONG4WCB65evxZtjRiqdLUprnuffcZEg92afXdc/MobcXfCfSyu0CBto3lL2oOdn
         zh/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.97 as permitted sender) smtp.mailfrom=shea@shealevy.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.97 as permitted sender) smtp.mailfrom=shea@shealevy.com
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1534:1538:1566:1711:1714:1730:1747:1777:1792:1978:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4321:4385:4390:4395:5007:6114:6261:6642:9592:10004:10848:11026:11473:11658:11914:12438:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: scent32_45b78949ef92b
X-Filterd-Recvd-Size: 1565
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-parisc@vger.kernel.org
Subject: [PATCH v4 13/16] parisc: Use generic free_initrd_mem.
Date: Wed, 28 Mar 2018 16:36:56 -0400
Message-Id: <20180328203659.18692-14-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596215242230537096?=
X-GMAIL-MSGID: =?utf-8?q?1596215242230537096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/parisc/mm/init.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index cab32ee824d2..3643399230f3 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -932,10 +932,3 @@ void flush_tlb_all(void)
 	spin_unlock(&sid_lock);
 }
 #endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
