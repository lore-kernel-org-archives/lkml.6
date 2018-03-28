Return-Path: <shea@shealevy.com>
X-Google-Smtp-Source: AG47ELuiNN3E3D1jyURcSwt4oYfORQupE0WI95rutOUrlfviV4ocdAlEmMXZj7oVlQG1Ib9f6Aj4
ARC-Seal: i=1; a=rsa-sha256; t=1522269460; cv=none;
        d=google.com; s=arc-20160816;
        b=uBIovFX55dvgiPn4/dc8qZdSRdvDKk2gVbEjbDJBx6e2NPbMeplphsldWVqk+d1hs5
         iWMqxBPFJe5V54zbyQV6APNu8yA4zqHqFx3HgcWFEk8GG9zhTWrFEXbXE3mydCo48I//
         7hQmBINIjz58wAIKiByq46dcmKR8FNTnkD8pSgRV8JFFzLCU37SjtdmzNa80cIe9g1+g
         BZfRs9qo1df6B2cTBPYjv+Az/1OFuLIU8uesg8K3MG2V2XGfnqvPTF/9+jtkPN1MkgaS
         sQ1elBjMaooDm8mzDRKdiLxBZT74q2SCKr1NHEP9kjwxjZvF37pPY7a27OGwaDNhiT6h
         6hIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HWFAnEojoWLsxb9bD9GXsWInOjlrpouhcIxCsrfQ/vU=;
        b=jb/Yiab57Nq/C4fMaUsUe/KFXJK1qlrjO27QxhpIoz5T0HOYdCpxo5rRk2/JLkahZE
         vP8GTkjYDjHCTR9qQJgnIVVfto/L47zftb52nZu82Bcf59IkgJ5DXZ2U/Co59YrUeOwV
         5jL+VJk3osvhL2x/uITyxsym0BU0W6UxDdKt1urKswEs5zdnR8RIflRHDFg/lzKGbMwn
         7YPl4ShSyAO4fRFt9tI+MLtDOmvsjHtgNNsK7T0RD3G4V3J2Mxtjh/qphqS4hWRFaLVi
         KagWa7s8cingjLhhpYPzkqX3V0g/w/htEpP0TCwxYTiWT+tv/R0zyTvUZhL/DCQfUl6q
         hibw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.254 as permitted sender) smtp.mailfrom=shea@shealevy.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shea@shealevy.com designates 216.40.44.254 as permitted sender) smtp.mailfrom=shea@shealevy.com
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1534:1538:1566:1711:1714:1730:1747:1777:1792:1978:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:4321:4385:4390:4395:5007:6114:6261:6642:9592:10004:10848:11026:11473:11658:11914:12438:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21611:21627,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: bait32_42e01b9f5963c
X-Filterd-Recvd-Size: 1558
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH v4 07/16] h8300: Use generic free_initrd_mem.
Date: Wed, 28 Mar 2018 16:36:50 -0400
Message-Id: <20180328203659.18692-8-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596215222324618693?=
X-GMAIL-MSGID: =?utf-8?q?1596215222324618693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/h8300/mm/init.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 015287ac8ce8..37574332b202 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -102,13 +102,6 @@ void __init mem_init(void)
 }
 
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void
 free_initmem(void)
 {
-- 
2.16.2
