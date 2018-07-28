Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68100C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCB620873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ5YwcJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCB620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeG1Fp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 01:45:58 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:40142 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeG1Fp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 01:45:58 -0400
Received: by mail-pl0-f50.google.com with SMTP id s17-v6so3126507plp.7;
        Fri, 27 Jul 2018 21:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l73sYXufoVXsSgz5wAueDRXj8K1+OAjg3R9harSih44=;
        b=mQ5YwcJEfOjMJbc1YEPqtRvOZLEow7dY0KBkdAkNvHv7333xwIKJC1yEO7fdYPhLOv
         AnErfLQlPbz+GuBWBLiOEk/YYHrEv4amelxo6Job3Nd7DnZIhEAR5dlPwDvnY/Ubhp70
         7DX+Oq8qJLhvbbT6mwtWEg2Wc+l7FyLlv9sYwq5iaLwwr+v1SgVZo4WM8Ls3KEBlOZ7U
         r6d3t+52A3tmwj6POAFVKvTYaakYp1oUITK5VeV3cykm5gNMsnNbccKhnD+Gq7bCTA5H
         oHfbO4jXx2wKqyW7dpWwgn+mMAl1x0uVLDTa0iwdHsaMR654INCXpg3TTT4PY6X8mGGg
         wFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l73sYXufoVXsSgz5wAueDRXj8K1+OAjg3R9harSih44=;
        b=bX8MPsAHQOcjl1fc9FVSP8aNy/pmRAcndaUM9a1V6sTZORjPZ1njm+SSfw/KnYY4t0
         ldEXRIRCym6BGvQcQTp2wuezS2ot6WSMZ8uxkj1MlCYZUOQYhrhJsKpUetP3vDFabNCK
         aclUdOaqfEj6jPwPnIN1BYHt5tAfPM2DYrXS3CWXMcyUCRTMZh5mj9HFEDDLl3hqmPL9
         0oqD3xNbferdOCTGuiKyNudv2m/Z4avVkqJMFNDXlySQLPCtyYi1Osmz2822FKd6vh9o
         8fTiPWYhvAaepIkBqS5cwF/8I+YQr0tUaSiKdOWPpK/be0+8IWjR8kG1OqR+1mdne+cd
         6tPw==
X-Gm-Message-State: AOUpUlHaaGdqhslPpcCt42XbtBdgu2V4CXpX9t3FDSyJMYD7R2w7F6Gg
        2HY3kNgPUVvRvfTVmI9+Ts6gCv7y
X-Google-Smtp-Source: AAOMgpfVa+fiMuRLdHe8I8hAXrcKOIj6lNp18GK84//lCprVKqDEJk8ZuEw+AcnspqhL3FukwpW04A==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33-v6mr8405579pld.134.1532751660753;
        Fri, 27 Jul 2018 21:21:00 -0700 (PDT)
Received: from pjb1027-Latitude-E5410 ([58.227.15.43])
        by smtp.gmail.com with ESMTPSA id c85-v6sm11159342pfd.110.2018.07.27.21.20.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 21:21:00 -0700 (PDT)
Date:   Sat, 28 Jul 2018 13:20:44 +0900
From:   Jinbum Park <jinb.park7@gmail.com>
To:     axboe@kernel.dk, bart.vanassche@wdc.com,
        jiufei.xue@linux.alibaba.com, gustavo@embeddedor.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pktcdvd: Fix possible Spectre-v1 for pkt_devs
Message-ID: <20180728042044.GA3571@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User controls @dev_minor which to be used as index of pkt_devs.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of pkt_devs, [1]
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @dev_minor before using it to prevent attack.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
v3: work from latest linux-next tree

 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a4b4d52..9bb7721 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,7 +67,7 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
 
 #define DRIVER_NAME	"pktcdvd"
@@ -2254,6 +2254,8 @@ static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
 {
 	if (dev_minor >= MAX_WRITERS)
 		return NULL;
+
+	dev_minor = array_index_nospec(dev_minor, MAX_WRITERS);
 	return pkt_devs[dev_minor];
 }
 
-- 
1.9.1

