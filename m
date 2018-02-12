Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x224e4qHK+Lq2i8Wh5yHcLfwsrCKQ6PUyqap+DO6JGxCfHMn0nc0vRwq32xVK6gYWEmckKXhO
ARC-Seal: i=1; a=rsa-sha256; t=1518395678; cv=none;
        d=google.com; s=arc-20160816;
        b=zo9w2OH/40Pa4mQIvgQOlUq4M+B/0UvC/3dQ584DdAGcLdn81zK8/AZIX1SnxN+7/V
         z98m2zgn5J6fHCN80M+mh2LaGMhZY5ulfR8t7LRXsNlugaJFEw1MYFkmdQRXUBd46w5T
         m5Rg4DL5gL9qyiryRjDglEN2qPuebaqnRQ17zapoOFZMSoxfyMp05K/VwQ+3hxnJeL5V
         v7Fry8ijDADXyVwiC3Lwnuo11CoyVkdtT2Jz1UuQixsT4yne0TGoEGcKbhJVdvvul4X6
         GlA5ULhB+B5rgxfTvZmY2NvOUeRoVO71DwTeqfrMoXokQRDU9RgVKbRC7RduSdmTtW2u
         B+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=w+nslwt2GH2mVnaAYeSTpfFSas2hkuIh/FZxTQjzJhY=;
        b=LbBGc4PpHq/Xiukk1AwLm9BCR64JEpQTeTwoXPKc8T/8Kph0WP/U963vdzDFrGjlz/
         4iH9boI8dTcU6Ej/69zaim/tSQJ4Vo/7pRz/hb8O8qGiE6mgU7LGxOHwJpYpNKRi0Edt
         WXviNrJcO3w3Q2hp/Lu5Wc+SM1//4o9P5ZFmL60t+J6Cxc2Z2xBB4W30M8cRp7luamf/
         4YyMCpzImkW0+gw70ho0o/wvhedTAxoIeOtdQLSASOagr7ZNqsUEimFgOdSH5SxF9GkV
         LWjiieEAzhH587hp2nqtQTTxFnf+YO9G2PxOKpt6wMCfssvekXN2semEPBkvA5JGF//4
         FoIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/12] hv_balloon: fix printk loglevel
Date: Sun, 11 Feb 2018 17:33:17 -0700
Message-Id: <20180212003320.6748-9-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfNlz0XpK94vnLd9YGAHOnLUSrKdaW3REP0kibOY4AR7nFiacVIwMXPvluS9XHiBhMf7a10C0r6OxQmyAfJxKlLVOtX01Vf0ofj6QfQ2Ctaqt0qi0he6X
 Z0Tv+iP6XpJVmq+22xf6u6Dr0586bCssXe3nRtof/1SI1/ktM0lWWxFzgY4DxooTQgEpUVfHrOp8j/cYzEQkrB0OpYqAEgkGesoWvde5gcIE7xCvX+tBE2vv
 zBbM0qYJgG2KXUJf90omtaBecUT/QyXwhkJCG7J9vdtKwy5tLobqWmMeAplwetFH2GKU/GXAsyD7G83N8IcQo/ZQuq6c89NLGW2MqAZxbaLy/Xzy4Lr8kVX/
 5I3ocXcuxVTy+sB+0Bsd2mCUscajn1tK4Lhp6vSGsx2BH5uIgP2wBGJa5R6h8QlYXV3jnonluvgA/LXhL6JDZMyy2ZNdb/sVYmvJYdP2AmdGtQa6+YoLSOm+
 zREhgWcufhKkNbK5XoYSrAocOb9jJOYGlwt3Q1OOW/lZiPr6y5trf5JAWBE7cKxQ01Ik8vj/vUnUAlf/lLpJIHfaSRQBiNf5WkOxDg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153266458505479?=
X-GMAIL-MSGID: =?utf-8?q?1592153266458505479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

We have a mix of different ideas of which loglevel should be used. Unify
on the following:
- pr_info() for normal operation
- pr_warn() for 'strange' host behavior
- pr_err() for all errors.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_balloon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index db0e6652d7ef..1aece72da9ba 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -691,7 +691,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				(HA_CHUNK << PAGE_SHIFT));
 
 		if (ret) {
-			pr_warn("hot_add memory failed error is %d\n", ret);
+			pr_err("hot_add memory failed error is %d\n", ret);
 			if (ret == -EEXIST) {
 				/*
 				 * This error indicates that the error
@@ -1014,7 +1014,7 @@ static void hot_add_req(struct work_struct *dummy)
 		resp.result = 0;
 
 	if (!do_hot_add || (resp.page_count == 0))
-		pr_info("Memory hot add failed\n");
+		pr_err("Memory hot add failed\n");
 
 	dm->state = DM_INITIALIZED;
 	resp.hdr.trans_id = atomic_inc_return(&trans_id);
@@ -1041,7 +1041,7 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
 
 		break;
 	default:
-		pr_info("Received Unknown type: %d\n", info_hdr->type);
+		pr_warn("Received Unknown type: %d\n", info_hdr->type);
 	}
 }
 
@@ -1290,7 +1290,7 @@ static void balloon_up(struct work_struct *dummy)
 			/*
 			 * Free up the memory we allocatted.
 			 */
-			pr_info("Balloon response failed\n");
+			pr_err("Balloon response failed\n");
 
 			for (i = 0; i < bl_resp->range_count; i++)
 				free_balloon_pages(&dm_device,
@@ -1421,7 +1421,7 @@ static void cap_resp(struct hv_dynmem_device *dm,
 			struct dm_capabilities_resp_msg *cap_resp)
 {
 	if (!cap_resp->is_accepted) {
-		pr_info("Capabilities not accepted by host\n");
+		pr_err("Capabilities not accepted by host\n");
 		dm->state = DM_INIT_ERROR;
 	}
 	complete(&dm->host_event);
@@ -1508,7 +1508,7 @@ static void balloon_onchannelcallback(void *context)
 			break;
 
 		default:
-			pr_err("Unhandled message: type: %d\n", dm_hdr->type);
+			pr_warn("Unhandled message: type: %d\n", dm_hdr->type);
 
 		}
 	}
-- 
2.15.1
