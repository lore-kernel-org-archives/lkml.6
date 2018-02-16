Return-Path: <yashomer0007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518766530; cv=none;
        d=google.com; s=arc-20160816;
        b=MHlaimhHuKJjhdpdZJ3G5yBUhThMjwaLXPCzxaQvJdWRrtU4tM0/qMoAsZqTUt3btV
         E8sWkyECUkcP55ro3TrJ8RoH5g9v2JYDR8N3uVH3/REtq2wOTJtFAKEcf7VjF3Vm/ER6
         TGZNHa4BezHIjymQBHC4wMV4rGTcC6C2B5WT2JrNGEa8+vH2RDVaDaTCDFTpbXg06yyl
         5whwClQ5LxAf+hPi1CDeLyRmHSwvXnYjlcVYrYqr0vLbX1z5imLmTBNdJA/RYWSe9r1E
         SFr8LTn7ssFM56h6qHhkVWQAAiq6kUw4klDvEoRTXAUZxlaZI9t2kTnSjgOIrp5WD9UM
         alDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=418jiaoPxeKahfaaEW4/ZfsdbOg+M68Y9URBp39qICc=;
        b=XwsIGxLruJCL+vUuRfoeEQNyN2+1DGw2Ytr7yvwM+FXJW/7HKAKLkOGktJhm/ho7uY
         ufx5PdL6utVRlzyJH3fAG9FnTHH48WNh0QfUJMlp0b9kAFv4SUugA7q9SIib8x7MpGXX
         wLWF7V7lfhB1SwfELxzoMMh0Osax+GoJ2Ft3DwviPk2J5do441GCm++0EyOixmlIP8ct
         RQJbfvhpXcdYy+VP4IGNe8kb/iAcEtDLm6lsgntPGCbW1V1p3aZZ/UEObe6thnC1+V7/
         T0PruRrDUB/GRuG/Gk6MAq/FHndYdlytMB+uWQR91BpZLsuL2ZM3RPXAWPT7e1lc33aT
         nhSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZO1j2UkL;
       spf=pass (google.com: domain of yashomer0007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yashomer0007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZO1j2UkL;
       spf=pass (google.com: domain of yashomer0007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yashomer0007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227YTXITxL5hTN12xIarQsv51FQGkO1StPXTxFjWhseG5H2goKCEpdTCa3CWClg89/z3so6Vcw==
From: Yash Omer <yashomer0007@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@oracle.com,
	Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	linux-kernel@vger.kernel.org,
	driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org
Subject: [PATCH] Staging: wlan-ng: fix unnecessary parantheses in prism2mgmt.c
Date: Fri, 16 Feb 2018 13:05:20 +0530
Message-Id: <20180216073520.6763-1-yashomer0007@gmail.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592542132475784862?=
X-GMAIL-MSGID: =?utf-8?q?1592542132475784862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes up a unncessary paratheses warning found by checkpatch.pl script.

Signed-off-by: Yash Omer <yashomer0007@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index e47a839f83a6..236961e3ba0d 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -564,7 +564,7 @@ int prism2mgmt_start(struct wlandevice *wlandev, void *msgp)
 	/*** STATION ***/
 	/* Set the REQUIRED config items */
 	/* SSID */
-	pstr = (struct p80211pstrd *)&(msg->ssid.data);
+	pstr = (struct p80211pstrd *)&msg->ssid.data;
 	prism2mgmt_pstr2bytestr(p2bytestr, pstr);
 	result = hfa384x_drvr_setconfig(hw, HFA384x_RID_CNFOWNSSID,
 					bytebuf, HFA384x_RID_CNFOWNSSID_LEN);
-- 
2.14.3
