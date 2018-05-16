Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470755; cv=none;
        d=google.com; s=arc-20160816;
        b=HI9A3mIttjIOVwzYaH47iwU8P8z2n5gFBggsZB0vikGAUkFfakRcuUN84jAED9H4cw
         PpqnG5P8iV8nN72Y5cmwtQim2XQq/Vbdz9ZSQkMybGbsMo5v4DyQoFxhLNai8dCcH1fn
         uOAxixM1/9UeEJOoadWDVhEAT8Qm6XiBlfLRP+V0awpZT2Nf10Tz2dIpyKrrhB1CwZy+
         VLBZRCBbahUaUd7NFPM1pjM0xKQNi3yKGA45NeUyVs6f9xpk3WpLClXOs8jcx4mYk5Xe
         ffcUG/FSzLD3FVWszKK4fwcc7tNeUUsmzi87XcEjcQ2T2/AomPwRUTIxjRCkNBTuoWwO
         Ivwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=wO/3Vwe2w+OXBq8uJE10e6m5PMua/N0ytj4b2qk2ZkA=;
        b=f7mggdQTPpvyzIRnJNqPiJFS4lsmexh4rqTnGmF0KPK2hlB6ai9Lw1Qtt8uQT70yxq
         KzAm81FDKQio1j3nMnkNTlSqmwIENiThDYaAP1IUtcOumEoz7e/Umsh9NKC9xqrLhTpe
         Rws7GsGkJA9KszDiKHwIu1dIJMuejvh0ZqKP+2cQEdj1uvsEm/E1WAVRdI61Qapy7cT8
         wGvoveQs+sLQZs4K5gnLXL4eeCWISboTYbsAlD6GbKoWJX2Cj0E5Twh51dJgthVDy0s+
         ygoKZoaie4r6r9vGKN62E5QEFy6hJlPZ+jaxyyDwQKSKDSam0xrwpeyV0lUp0U7LvCR/
         hvVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WdwPjHet;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WdwPjHet;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqaLjRXBMzsuI5uk0APX1vJOvvhOM0UvjzZKUQK3nL+ldSX61yfh/r53Zohit5ZOU0+IS2JVQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] slimbus: messaging: initialize completion correctly
Date: Wed, 16 May 2018 12:36:42 +0100
Message-Id: <20180516113642.28136-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620598503700516?=
X-GMAIL-MSGID: =?utf-8?q?1600620598503700516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

slim_val_inf can contain random value from stack, make sure the completion
is initialized to NULL while filling the msg.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index fd0788019357..2635eaaadf4a 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -277,6 +277,7 @@ static void slim_fill_msg(struct slim_val_inf *msg, u32 addr,
 	msg->num_bytes = count;
 	msg->rbuf = rbuf;
 	msg->wbuf = wbuf;
+	msg->comp = NULL;
 }
 
 /**
-- 
2.16.2
