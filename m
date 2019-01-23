Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B36C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5764420868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibAX4Oaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfAWCSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:18:20 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44895 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfAWCST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:18:19 -0500
Received: by mail-yb1-f193.google.com with SMTP id k189so255302yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 18:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QLkdGGmSdcyEXuoOYx6qu73Wobx/Bs5R2hqaIqKrdhY=;
        b=ibAX4OawfE4eGJmBFORHHmSNHVaDHgvUD4WkH+4SZWgxXEeAPhu40iN3qyiYUdI+Sq
         aQ8oGBMgZgGwl3zuWCzfOCb0EOAIz82xW9qKt0T/n9h+RJDSM09HpTnKhS+NnaP1H4Yu
         bnx4k6Gia7r999duK+ON3bxcXhAM0xIHyThY3r6l3LV0/dBzoHeWqfKS2jr7xE6M6X3F
         ZiHH6i0t48xs9/p+hpSYU9ogs9YCpI+BTYBn5h23MdN6mlTioNZ64eXZru1+nICI+l6P
         E2GMsVCsZgWSQCvJ8T4R99Nq1yTnaHi1tLour7E1MGLohveUy9yEqg4aoarehZRUWp7t
         ZWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QLkdGGmSdcyEXuoOYx6qu73Wobx/Bs5R2hqaIqKrdhY=;
        b=p+TXEKNDKe7KLy+MyB0VRRJ45rAdn1FsuMAAiR9GccpMQ2Iq7P7Z8CXDYkusxL5O0q
         mw+DmU6uw+UjXJpdwmlb5SFNFGx+FaisAwORrR0lnIx0FdcC9SZA6zr2Giw1idVVRPbK
         3EX6I8WfRpqawcy8mRPD3wZa/217wenco5P7c+z8CJPg8pGB70vqv5C0P+UpT0LdQbvc
         LjFb0TzAjLW2KTHSNvJbHhy0KTtwuEBT8S3z9br2J2bYxYWPa1NveFHXggDB/q32tAI4
         WYp1p6WswhKwuOLFxkot5Yq13QE5b8eALB7wL9JRz+OcH27CJUJLXrsWCN8pGhc2S6jC
         +fbg==
X-Gm-Message-State: AJcUukfiepsh0nSbQWzCXArlwtcepM1bSZQgvaTxkzY0OmdJjGCssVcZ
        8sE9Fct0RbAUhWuIKcoJWmEYI0RKxVM=
X-Google-Smtp-Source: ALg8bN6afMSzgGN6wCO1DkFGDWLPXduW7CXpNqYnxXXgM3XQPKsxX36JjvzBZdhHhXHqFf4JkT0ajA==
X-Received: by 2002:a25:5087:: with SMTP id e129mr330363ybb.365.1548209898359;
        Tue, 22 Jan 2019 18:18:18 -0800 (PST)
Received: from mmccoy (cpe-2606-A000-111F-7E1-241A-8A48-C4E8-C468.dyn6.twc.com. [2606:a000:111f:7e1:241a:8a48:c4e8:c468])
        by smtp.gmail.com with ESMTPSA id s185sm13785380yws.69.2019.01.22.18.18.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 18:18:17 -0800 (PST)
Date:   Tue, 22 Jan 2019 21:18:16 -0500
From:   Matt McCoy <mattmccoy110@gmail.com>
To:     Matt McCoy <mattmccoy110@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: remove unnecessary parentheses
Message-ID: <20190123021816.GA3478@mmccoy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Matt McCoy <mattmccoy110@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 065bce1..d938b09 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -35,7 +35,7 @@ static inline u8 get_byte(struct ks_wlan_private *priv)
 {
 	u8 data;
 
-	data = *(priv->rxp)++;
+	data = *priv->rxp++;
 	/* length check in advance ! */
 	--(priv->rx_size);
 	return data;
@@ -171,7 +171,7 @@ int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
 		   "- rate_set_size=%d\n",
 		   ap->bssid[0], ap->bssid[1], ap->bssid[2],
 		   ap->bssid[3], ap->bssid[4], ap->bssid[5],
-		   &(ap->ssid.body[0]),
+		   &ap->ssid.body[0],
 		   ap->rate_set.body[0], ap->rate_set.body[1],
 		   ap->rate_set.body[2], ap->rate_set.body[3],
 		   ap->rate_set.body[4], ap->rate_set.body[5],
@@ -732,7 +732,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 		netdev_dbg(priv->net_dev, " scan_ind_count=%d :: aplist.size=%d\n",
 			priv->scan_ind_count, priv->aplist.size);
 		get_ap_information(priv, (struct ap_info *)(priv->rxp),
-				   &(priv->aplist.ap[priv->scan_ind_count - 1]));
+				   &priv->aplist.ap[priv->scan_ind_count - 1]);
 		priv->aplist.size = priv->scan_ind_count;
 	} else {
 		netdev_dbg(priv->net_dev, " count over :: scan_ind_count=%d\n",
-- 
2.7.4

