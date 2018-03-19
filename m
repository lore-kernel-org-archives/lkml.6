Return-Path: <tavery321@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521497462; cv=none;
        d=google.com; s=arc-20160816;
        b=G+0c+ydm1vsYW9bJIRc8iFvIZ7AWz7Hf0p8/kHAWryztM8roYlh7rzqLbVCIgoN7Q+
         AFI6jpclhV5ck5T8TcFXy67mDBnQGf23okO8DCXb+gA9GJnD426BJ0SzxIBnaKic3WUu
         ZZGuwyqLcym1IGZmAhVAaOtXfLUWTaY+7iU3bi0oNrI9xmKxWSJ5vJ0jyb83SPyfw0hu
         3Zmd4tEe8awSUl0KB6HqlWqZy/s5ufisuqL2LskzkQRUMF8yq1Z0ybiZ59t++nOB4YNB
         YmWdO268jWZK+XYE6l+ERD1vzrgS9XuSYkQSaqWvh/bS6cdP3cEfHDM8dZ3rfwOKzvhs
         IdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=iHbTOCIVcB2reO16XVyNILyZ4gjdyyNc3JfVeEKIG74=;
        b=ps1woLmpU6/hBi4JdalWtU5QJ0zuNunB9Y+0fiK1rn/QQRGD8wJ8Z9HMIJqeShcMJJ
         7rcAubp2JYNn4gUzs3hIVXrBaT2QeOsbQr9cq4iVOKm8mj1Pawgagt2kYWcEPiD5xfTD
         So3i3SST37Xe5mwZ2XhfXslcmLNAspvtKE7DVviWngkhvITQjxIV/L6IAfy4Nst/gkuq
         YUxa5GGTt9/cAJOv4ZC1XLq3kxmkJpC1K9RqwAYcsGbo5ztdqdRvakXXRAAqp4NK+AqY
         8yAqrC8yBBceQ44YmrLYPF4WXYLa812Iou0u3uCsm5ysxY36A3Hm/a0F8piSPQjF4RV9
         jPyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JV6SO+1Q;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JV6SO+1Q;
       spf=pass (google.com: domain of tavery321@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tavery321@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvJ0YKCbSYkRlxD/8Fb8DaBhlJ1dzxfQFIEpjpzXQS38VuCTHOddHgNEqdY4dsddyBGIzaL/Q==
Date: Mon, 19 Mar 2018 18:11:00 -0400
From: Thomas Avery <tavery321@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Replace yield() call with cond_resched()
Message-ID: <20180319221100.rxs2n54ch53tukje@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595405655432080560?=
X-GMAIL-MSGID: =?utf-8?q?1595405723001174492?=
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
