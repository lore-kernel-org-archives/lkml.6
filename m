Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB186C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA5F206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzWhVyXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA5F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeI2Fae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:30:34 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33049 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeI2Fae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:30:34 -0400
Received: by mail-it1-f196.google.com with SMTP id h6-v6so1309386ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWbnhXNs5XF/W3I2IPiSaq6qUYesoeDpj10rrKjDVak=;
        b=VzWhVyXB/+gk5lL/rxDJVHpfmFsyTR+PvbW6pFh+6xji9CeY2xp8Dp7GP+cyFOfApF
         5aCOYX2ohrKP8g+lyHtxXjimZrRNo8a759/HA1Rx+vOpVzh3ZPW1zPHkW9dpvmcFJHjK
         wL/w9Wi/t7F8Q7gXqmOqZg7nMK7UdBfEUajrSQRgNbOg0Rk97fFAvTjRo5yQthrWMrhZ
         xosWo5U+ua5abGucrTjUgCC+8gfAmUjrRGSpoEON5tcfC1ltcj4N/Yryz6iziwDaZzUU
         G+ygVv66HI5b6iRfJSYBy70mC0Qfffp0GEBOAvmwJSP2gycbxAEDbv/3SDZmY+XDHPu5
         EADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWbnhXNs5XF/W3I2IPiSaq6qUYesoeDpj10rrKjDVak=;
        b=dg6+KeM8j6I4CGjA9SITKlcIRY1ZAmTBWentlxzIQCQhmOujjGBLQ+FuS9Aehb+RY8
         PRjRLvEzcO7i/r5lNMkhh9c+glWHnszznRxQS/HTfHNPOk5QjQ22IWWlOzuo0rdAYjv/
         QzQnlrjjhdU/ByQLEniChVqzUQSQPbTPTZLwqCFsxNhBeEVYggkTRFw/yy6IvTwXrr0b
         Rs/SOXhTBAccnTWJUUlSiWCjzibK8rj8zb+NBqCziodpskg/OAo9fC9bS6iJkINwT8hg
         /5+zGbKzikRI0RtXRXOOgUJIXp9BWNwuyY7W1393aIknA2T+wH6O5MGn2oka3YVs/OtZ
         AqwA==
X-Gm-Message-State: ABuFfohy4ei4EEQB1XqZW5Tz5byjS6XtXsiAHHx27z00WHBWo7dmXDew
        uDdK7csPGnV4jEXbGc6fwFKLiQ==
X-Google-Smtp-Source: ACcGV63PRpRcC0yAoTCJu6eSxsoo3xN/CgYTs5qKUsxqi71qogGKC/NgcS8yyVW1KDKliDvR9mNG8A==
X-Received: by 2002:a24:3095:: with SMTP id q143-v6mr3278033itq.73.1538175875203;
        Fri, 28 Sep 2018 16:04:35 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id m186-v6sm1468973itg.29.2018.09.28.16.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:04:33 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Steve Glendinning <steve.glendinning@shawell.net>
Cc:     netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH] net/usb: cancel pending work when unbinding smsc75xx
Date:   Fri, 28 Sep 2018 17:04:30 -0600
Message-Id: <20180928230430.125003-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cancel pending work before freeing smsc75xx private data structure
during binding. This fixes the following crash in the driver:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
IP: mutex_lock+0x2b/0x3f
<snipped>
Workqueue: events smsc75xx_deferred_multicast_write [smsc75xx]
task: ffff8caa83e85700 task.stack: ffff948b80518000
RIP: 0010:mutex_lock+0x2b/0x3f
<snipped>
Call Trace:
 smsc75xx_deferred_multicast_write+0x40/0x1af [smsc75xx]
 process_one_work+0x18d/0x2fc
 worker_thread+0x1a2/0x269
 ? pr_cont_work+0x58/0x58
 kthread+0xfa/0x10a
 ? pr_cont_work+0x58/0x58
 ? rcu_read_unlock_sched_notrace+0x48/0x48
 ret_from_fork+0x22/0x40

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/net/usb/smsc75xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 05553d252446..b64b1ee56d2d 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -1517,6 +1517,7 @@ static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
 	if (pdata) {
+		cancel_work_sync(&pdata->set_multicast);
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
 		pdata = NULL;
-- 
2.19.0.605.g01d371f741-goog

