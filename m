Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448F7C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F99920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpsaCZIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAVCIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:08:04 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51647 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfAVCID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:08:03 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so19280197ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 18:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uOAmpQ8tpNpwSSe+DsGaIGiIc0oKaybcAwK6+WCbZcw=;
        b=jpsaCZIAqTHZdmFnwF/0lMYHzTVvGF/JksLa305TJQ6Qv8Jz4X5dK6KaDRWyXICuTw
         UBU6p3fIr4FfYYeikWlaH3wmbpsSTFgzJVgz9naGL/sqcniFQTST24FImgimyq58AOCK
         6T87GhqF19DLUGTy9duceB549cu3mUivZQkY1U/fdlj9+F4uvLlisPd6tdiswz+c8+59
         RaRvtY+VrLm9IE2kuxrfR3tkRt0BldfV9ST6/2vngPucE3B0+P22phmun6ugjJUkjM8H
         +UwsJ+OGGDjbbMr8wkqnL+GKssDFJXooSFhj3dSHZbJi+ZZLQWOgyyvkxDzZlVeUo0+i
         F9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uOAmpQ8tpNpwSSe+DsGaIGiIc0oKaybcAwK6+WCbZcw=;
        b=iPqkHcP0qo2GAM2Gpq5RPOS7wIQwV/4UoUQlmPlzmOUr+P9cdShoUZAJ/kbfYWIMwX
         dN1+S0N6uTEfvAtLroUsGSI2y8Pmrc8oDu93fDNjp9Hj3uqy9p7gFaFGA/JemIA1R1vv
         wTiRETbjlsLQyRz1ocKo+TSuWx6pYtCu7anf8KunquhBCqAzka4AYfOi/h1MpV2lPdRF
         mNSCOVZxXJWM+5bPzmVNWuAJYlZN3MagdtVVj9zNFPHfL8ZgP1b3cVWN2UxziTDhA1+p
         wcQModvvuYx1+CDOXoglQ2bSTqABhVSMmxQj/dhSAgAumMgi9kszPjVb/7ozpCKOolL3
         i1Qg==
X-Gm-Message-State: AHQUAubH2V3x3kr6C9AHmEwWI0ky299PweoinFTLU7YIbc23ZVcSzHL0
        ivYdYOduwX7gk+La6COzY4c=
X-Google-Smtp-Source: ALg8bN4z7Fy1crnJkxvo5I/44XE050nGIY8Wu6jfWIslfcUQmi5W4HLfk+HOee4d2/K61qG+oFaO7g==
X-Received: by 2002:a24:88:: with SMTP id 130mr1116696ita.92.1548122882689;
        Mon, 21 Jan 2019 18:08:02 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id w24sm5912958ioc.11.2019.01.21.18.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 18:08:02 -0800 (PST)
Date:   Mon, 21 Jan 2019 21:07:59 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show functions
Message-ID: <20190122020759.GA4054@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The channel level "_show" functions are vulnerable to race conditions.
Add a mutex lock and unlock around the call to the channel level "_show"
functions in vmbus_chan_attr_show().

This problem was discussed here: https://lkml.org/lkml/2018/10/18/830

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 drivers/hv/vmbus_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 403fee01572c..e8189bc168da 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1414,6 +1414,7 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
 		= container_of(attr, struct vmbus_chan_attribute, attr);
 	const struct vmbus_channel *chan
 		= container_of(kobj, struct vmbus_channel, kobj);
+	ssize_t ret;
 
 	if (!attribute->show)
 		return -EIO;
@@ -1421,7 +1422,10 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
 	if (chan->state != CHANNEL_OPENED_STATE)
 		return -EINVAL;
 
-	return attribute->show(chan, buf);
+	mutex_lock(&vmbus_connection.channel_mutex);
+	ret = attribute->show(chan, buf);
+	mutex_unlock(&vmbus_connection.channel_mutex);
+	return ret;
 }
 
 static const struct sysfs_ops vmbus_chan_sysfs_ops = {
-- 
2.17.1

