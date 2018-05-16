Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470752; cv=none;
        d=google.com; s=arc-20160816;
        b=w3TZeoXV2S1HCFA3rlgye/AR5dltwssng+nz8xtdKyNi0dOJSDOONEJk4qrw52rRuA
         9KG1/ziGcwq6ftr8DJnBCjGWxs8dW0zTkIQMq+Zm5/ohJf/xLG1ss/L6M5//ajGEOSbT
         E93ey+9pGiWlqcVwYp7eBXw5amVxE54SnFIf0yQbCCTAn6lWm3Wo6pAH3llWZdPNq4yw
         IdvdSiZG3jVCo/CH/dyiuUuQKfe+GZtrglhbK4A39CDeCvtemZzsnrIkRIxOxaI6OsW7
         z6s2u7IGL1b9yHgH7B/RRo0+BAiKgkj7W9PR+cIWdZE5zWm9Cv26rkY86NAoo2PdBgVr
         VAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=DnQSKW5o2YhxDqE/nKAX2tk0JqwF4Q5eataCmZqSwi4=;
        b=eZo8/ueRKVthS4F20GbpETeRTwZoSZeEacmtJyaSA3ibEd5jSpXCe1+0WPBbPwaug+
         +PR8ZhRnZjHhMLoX7mCrof4LGnct80XcDP04Oqxn09u+SUI+4Qi7CIXzdmN/AaLtmwjg
         9MjLDQe/7ilccJXK6fUc0dgJGThD+x5dzTAxCulwzlug3669OOcF8BcEZhMlJpc2DY8U
         Nzn60a7XaYbiLBKq2kFY0gxeumXtT9N50AVxawv+qt9N67bZAiBjv1nIi+tBhy4mu+i4
         5te0quriNzD6j883/GO9rfIQ9ysxKJQn/vMKA6CvflYeHmZWANQxLkjmkzLIQp9AOQhZ
         KqTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JxE4LVYo;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JxE4LVYo;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrrrUWFlSIAEXWWwBBAHsBus15A6J7IvnYrIs4haUR8vsvkcMcDsy1qaTwHptv3Iqbvjn5kyg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/7] slimbus: messaging: pass correct wbuf
Date: Wed, 16 May 2018 12:36:39 +0100
Message-Id: <20180516113642.28136-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620595515261792?=
X-GMAIL-MSGID: =?utf-8?q?1600620595515261792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There seems to be a typo while filling msg for slim_write, wbuf is
set to NULL instead of rbuf.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 457ea1f8db30..5a2ff01b394c 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -307,7 +307,7 @@ int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
 {
 	struct slim_val_inf msg;
 
-	slim_fill_msg(&msg, addr, count,  val, NULL);
+	slim_fill_msg(&msg, addr, count,  NULL, val);
 
 	return slim_xfer_msg(sdev, &msg, SLIM_MSG_MC_CHANGE_VALUE);
 }
-- 
2.16.2
