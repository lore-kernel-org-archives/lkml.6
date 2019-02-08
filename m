Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB64C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469BC218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN2xrX62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBHVFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:05:40 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40607 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBHVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:05:40 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so12413771ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6y4KeMeLMFgTB3O2vfmpU68U43lkDznFYjjKhrvbDBA=;
        b=DN2xrX62PoBBIAIDFIWk6yejeCUhnXgjszF6+kH+VKeg6Nb3kyCF/fYBj9bpjSp8mi
         kXEPE0DkVJRZ2gdR4dUpYgStDmbgvZjOByDDfC4U0ZsLVYpgYatIKAERW1niVqF9mFpf
         NMxVcujcKgjKqM1zXHVKi3omEU4RIavrPpDAI7MpjWoWStP6U4ZgnwGqop+U5jl4y5CS
         PqDwl3+LCK5XmvyZTJA0if4MM/pasjHfecd1aN/650WaDpjEn5wIXTo6R23cYvQJuy/J
         qdzOwiJXvK0tg7sjnrHhom2OCY8OxgInuG84cMmVFjX06BOlCGalAfCZQVC8xEByZlP5
         XN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6y4KeMeLMFgTB3O2vfmpU68U43lkDznFYjjKhrvbDBA=;
        b=FHqOMjdyCiQ6IcxqiEbtcmFrIrZx/816KRAmYZOzQstKCm8Py5gSF/pS1AO0n2wGAK
         FK0oNPVLL1Ia3xBBJAg3bT4yqhjQS8sPja61uPqFa4Y9XpPx5eqJoCRrLNLTHwKAVPgo
         gbp42WWtC+Rh151aIj7jjX/BSDYS/0pSld9JsZItwZjh7HWZXMxtiQLVteDxexHy0aix
         rdLRTPT+iqDs4e7y+p9ih6iGKa1HLRcg6dUnABt9BWUYhmVGHmeY0zDHDcvFJUu4JieQ
         Nki30lb4uFlKyC6g67OoOR/H/RS+UaIYCzX1CtDPYTGn078VZwicZLIE07Pmbovi/CFH
         FhvA==
X-Gm-Message-State: AHQUAuY4JtNwqWHJsqRoZIZ+E/+d9b230b7hDVcrsmE6Yye++NzFFAfM
        1QFp49Y77jNIWpnDilaUTe9seNy9jKU=
X-Google-Smtp-Source: AHgI3Ia0veZPGtKdhgpu6xUi13IfZKEBAruR0gpre3k0cdy1y8pnEdLGraBLxj4B4ye1C+TZY3/qyg==
X-Received: by 2002:a6b:ee19:: with SMTP id i25mr12806470ioh.149.1549659939421;
        Fri, 08 Feb 2019 13:05:39 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id h123sm1707722itb.36.2019.02.08.13.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 13:05:38 -0800 (PST)
Date:   Fri, 8 Feb 2019 04:58:52 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Drivers: hv: vmbus: Change server monitor_pages index to
 0
Message-ID: <181a0a2a82e1ad0353a7bdd55a3bdaa0891812cd.1549619051.git.kimbrownkd@gmail.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549619051.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the monitor_pages index in server_monitor_pending_show() to '0'.
'0' is the correct monitor_pages index for the server. A comment for the
monitor_pages field in the vmbus_connection struct definition indicates
that the 1st page is for parent->child notifications. In addition, the
server_monitor_latency_show() and server_monitor_conn_id_show()
functions use monitor_pages index '0'.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 403fee01572c..f2a79f5129d7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -234,7 +234,7 @@ static ssize_t server_monitor_pending_show(struct device *dev,
 		return -ENODEV;
 	return sprintf(buf, "%d\n",
 		       channel_pending(hv_dev->channel,
-				       vmbus_connection.monitor_pages[1]));
+				       vmbus_connection.monitor_pages[0]));
 }
 static DEVICE_ATTR_RO(server_monitor_pending);
 
-- 
2.17.1

