Return-Path: <tavery321@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521497397; cv=none;
        d=google.com; s=arc-20160816;
        b=uAFdWSwKBBYgrHOPeT+uMIM32iXfQqotyXC5t/y/xjv44oW08otjRHgQp4atFBAjyh
         YUYpmYUob7Ep/eiv315YeUsXECqvXem0IzvbG5/LvsNR4Hw1IFhRfRAetNOQyLvEEPPE
         bzZ4d+eRHyTCzfRz6BYm6i1kGi0QJu6rLzHDe+oqW8hZd8JuAsQEFpjruQ8klrHKK3kA
         JENiwI46Y4DUaUcVY+BGTEoHkNbi+LL+ndnhMKsjeK47XkwSkoqEXSwVdnzGogtThJZc
         aWTnWm6jh5K9Zhrnpxk3QX8p66X6oi4tkWH82flzvEcE6GSTr8HsqGAfgsHDWoFz+nYi
         xNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=iHbTOCIVcB2reO16XVyNILyZ4gjdyyNc3JfVeEKIG74=;
        b=FAcaPuWHTsqItnIsmo/OhfLXGWPL89EJzLy1dzJ2ze0UbbeRdpEqy7WnajxSDxM4jN
         33sDUEQBhEtu0F76ZuzfeeX2shXwAyBlqNX1LXetWtIfbrsLvne1I6uJkgAmb/BbTmt/
         94uBZdDJ+CeDG0pmgsUi6wm47Umw+zrcsT1ULUldybf23c0WUz0858Tg+66QmSHBRKOc
         GKxPjM9jyCnnr9arnGiFhpjDWzJWwGbMOpYJPUdHgKj2QQzFbUQaztjcUip61GhfloJh
         ZIUsUpH/Bc1/VuWYWMxcOdZj3Tn+CMKgu/mGGNx6rJg6Jt4Z0PazjCIwO+p8agY+wBd2
         Dx+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JiASYbjE;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JiASYbjE;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELupud6sMbj82G1SU7T7EYYGtA4xOBY6eUMK7DBSc+dWODT82uHsR6WfIuGiT5ouwdJ43MIT+w==
Date: Mon, 19 Mar 2018 18:09:55 -0400
From: Thomas Avery <tavery321@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@verg.kernel.org
Subject: [PATCH] staging: rtl8723bs: Replace yield() call with cond_resched()
Message-ID: <20180319220955.zau6w6ur2hob3lmz@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595405655432080560?=
X-GMAIL-MSGID: =?utf-8?q?1595405655432080560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove yield() call. yield() does not guarantee progress, and should not
be used. cond_resched or wait_event are a safe alternative.

Signed-off-by: Thomas Avery <tavery321@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 4a6af72013fa..85f7769ecc2d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -701,7 +701,7 @@ void LPS_Leave_check(
 	bReady = false;
 	start_time = jiffies;
 
-	yield();
+	cond_resched();
 
 	while (1) {
 		down(&pwrpriv->lock);
-- 
2.11.0
