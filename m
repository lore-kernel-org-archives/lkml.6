Return-Path: <hariprasath.elango@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522070525; cv=none;
        d=google.com; s=arc-20160816;
        b=JFDAPa3eL6fC5eYzHf2fAdbLm5GvqStYgRWn+J+AgqaB2XWX+2j+sowabgbcXZcBBp
         mDYz3DAkxSqbnnFcLM2y+xhSeSzvZx8YwA5ZlcY83XtofPI4xqXcJMVCyDc0fxq+1atw
         eqeu27XjYdu7mHAA5pMiXVTWNWWmAqfFsHMWCPa0BLI5v4hIuv7eLSj9kQ1JCcvdlALL
         aBYd3JAPeBPBgR1vAJuoRizt/7sycegtgYSjmBUeCPLPiIW/gskNPQNoVG4QYyoqGH3m
         Ux7Egt1HiPx5pjG4SyXQt0N+gHzRGJ+I6kw+WuFBbxLFZkGxOxNjUtLKUNGePy87GB9I
         cntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=qMYaxlfVnNpGAPxbHF2FerqH2P85KGa6Zwlypo9ZJkw=;
        b=e+EvXadU8+n0QrWkSNnvglXBnhaXjlHhwwoBfAvOEeyWt1XNY1NLcNPrQty5ENoGJ2
         3qcF3R23Ws0RyJyucbbE/oqMe9NswnCyztiSKAFk91gOrMQCCdxLWQC8ZSkDjIcgCWOj
         BAEc3LKdWeFrajObIrxuwwLLUoRK/mWAFs1Ru47vxvmpxmdlCF+YkKoFvH/EZG+EHKr8
         xkjAcYtCKQI+8gziZ6sxTAjvmO8dzKw3xebNstYPsOB99NvDZmqCNzFi1ClawHtpxFVZ
         nNqJAz3OnpfBC5RrtlN71G2qqIfk9Xzp2ITrVOhD8I4gnwPls3Qds85Ueyg5L8uvq1VB
         G2wA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Pbwkr+Nq;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Pbwkr+Nq;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv2dOtUlwiep/bIkMH6uGs5QZxg8e5Zre7Sa/OR1PFEtKdSHtSrHkSbUNSODIW71KjMFpMQ1A==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com,
	gregkh@linuxfoundation.org,
	ganesh.krishna@microchip.com
Cc: gehariprasath@gmail.com,
	HariPrasath Elango <hariprasath.elango@gmail.com>,
	linux-wireless@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: remove unused return variable
Date: Mon, 26 Mar 2018 18:51:55 +0530
Message-Id: <20180326132155.24612-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596006623813521391?=
X-GMAIL-MSGID: =?utf-8?q?1596006623813521391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

In this function,removed the unused integer variable as it is not
actually used to return function success or failure. Return is a pointer
to net_device structure.

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/linux_mon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_mon.c b/drivers/staging/wilc1000/linux_mon.c
index 47e3025..169213f 100644
--- a/drivers/staging/wilc1000/linux_mon.c
+++ b/drivers/staging/wilc1000/linux_mon.c
@@ -252,7 +252,7 @@ static const struct net_device_ops wilc_wfi_netdev_ops = {
  *  @brief      WILC_WFI_init_mon_interface
  *  @details
  *  @param[in]
- *  @return     int : Return 0 on Success
+ *  @return     Pointer to net_device
  *  @author	mdaftedar
  *  @date	12 JUL 2012
  *  @version	1.0
@@ -260,7 +260,6 @@ static const struct net_device_ops wilc_wfi_netdev_ops = {
 struct net_device *WILC_WFI_init_mon_interface(const char *name,
 					       struct net_device *real_dev)
 {
-	u32 ret = 0;
 	struct WILC_WFI_mon_priv *priv;
 
 	/*If monitor interface is already initialized, return it*/
@@ -275,8 +274,7 @@ struct net_device *WILC_WFI_init_mon_interface(const char *name,
 	wilc_wfi_mon->name[IFNAMSIZ - 1] = 0;
 	wilc_wfi_mon->netdev_ops = &wilc_wfi_netdev_ops;
 
-	ret = register_netdevice(wilc_wfi_mon);
-	if (ret) {
+	if (register_netdevice(wilc_wfi_mon)) {
 		netdev_err(real_dev, "register_netdevice failed\n");
 		return NULL;
 	}
-- 
2.10.0.GIT
