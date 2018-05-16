Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470751; cv=none;
        d=google.com; s=arc-20160816;
        b=MOodL8d1LVBQCXoS7CInlQ66xd9M7kR+gsvgqrTqWuDPR59xJmumOjhnkw2wmPNL69
         VagUd5cE18yMF453n3143y4XSSJ20LD6BYaqfPhgbu1yCIOMF7qZYjE2jkjH92ouIUKq
         l63++yHYLBUKJuHseofIiqlMkm5HhdYkCls0UQKUx1F4xay5UX1E90cBQnszdg+Wqu7O
         dbpyrQ+HInowPCEylMaYbNFfCtURc0QGGeBmOzBJsPMMUDpHiTY1f88qyyfh2lWpCaJm
         /JL7GEw0GyFRXifKbGG89EGjUlhaXe72r/YeMiSPCVNu7XLycMuddQRss87bJ1l+HEFB
         pn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=kop1X9UoEwWP69B2WuA6tdzOmbS3f24bCaePwaN7Tu8=;
        b=IEh1IYbeD2jcgNYfutYktGjk7C+43BxVpqGAwY1vfqWivPYE3+ZoYKV+bfo6FoPVhl
         QEfljHUXQOGaV1q2gN5TWAeMeTzmhYzeEr1ro6HruNP4fGD7YskGtY8kADblcz7fbH1s
         xElZ9nUyqKuhdcuiaKbjtbElQcqYQonQFUIkEJ+ZlTOetegPh3cWVf+3+8Mvwx3tjLFs
         dp6ZQiRebAg1JxDfJJfKT5uT05JmA825go72pkJNX5uf33Zh8ERqlsY22FKdHWXiPT6E
         LLmB3p0aVaVHI5kKQJT6NJsXiSzPXyO77Pk4sDGdunQzXaIyYVK3F+gHhWmk1/mZSlWG
         lqPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XPzI/tBG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XPzI/tBG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo6jjtNm0n4YjzCJBEHJ/nhlvEA08VK6ulBQAHTua8eoJ6AMFqO+RMr9956dDY8rg+GLzXDPg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/7] slimbus: core: add need_tid flag to slim_msg_txn
Date: Wed, 16 May 2018 12:36:38 +0100
Message-Id: <20180516113642.28136-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620594608427719?=
X-GMAIL-MSGID: =?utf-8?q?1600620594608427719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add need_tid flag to txn, this flag can be set before start of transcation.
Having this flag would avoid calling slim_tid_txn() multiple times on the
same txn. Also it is handy for controller drivers too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 79f8e05d92dd..c0450f469e07 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -113,6 +113,7 @@ struct slim_msg_txn {
 	u8			la;
 	struct slim_val_inf	*msg;
 	struct	completion	*comp;
+	bool			need_tid;
 };
 
 /* Frequently used message transaction structures */
-- 
2.16.2
