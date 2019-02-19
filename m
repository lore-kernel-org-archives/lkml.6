Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFF1217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utH1o2/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfBSFiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:38:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38904 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:38:10 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so3482012itg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImUvkukmD+C9C72uwxCLIPpkOjYCj8A1c+E+z+QNOtI=;
        b=utH1o2/gjdJ+gtGs+zmbO2Ym67uOSXee/38as4/MUAotNStu5vkvQY03wXX4E+oh1m
         SdeFRcAnEV70fEQu9+Z5J0C+rIoWtD3DVhf0cAr+1gz2BG7mljvF3/B+r4qyyE+ryWqF
         zPgXOdXpPSyWEZPWDSi05Q7QYqYkJ4NpV1pB5xj3VH5m3XwVdVf7/gg2Wh/tmpn2lj9Y
         w/Y6D9UcNk5UdbcnY3m0A+mT4UaczC82STBhkXcAGNe1tfg6X4J6HdLg106GsYOH/w0k
         cSwqIekrkXq2ezVkAsk9qNgEkdvPzS87mHnzAHnUe1KPH2smScz0Au/6SMa9EHk1rgSc
         75Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImUvkukmD+C9C72uwxCLIPpkOjYCj8A1c+E+z+QNOtI=;
        b=QxG017ite/0XTq4Fdiwq9bDNm7F2VavWBRIVc165vuvWMUtes7eE6/YTF2LMHdslFI
         JBI/UaLxVsad1VLYIUyvg0hHfaH6191xApSCko8SnJALPJxiOgmOaacLqCxSeX9UFe73
         9mmGFJvRJcCyAZEMemLpXFmKcp60osxiiI+qEMSzBkdqeIUQFDtIkMis7sYQ/pP4hQ/C
         kIvhesqqpnFNpt8vaEE3eu7IViaBEM9ivoU1314h4pNMWLiXNZGAaAvGLrCZ1Q7WjcFN
         MG/TFa7nLdbhJoukZjiJ4ZT4sq8OhWtQ/VlgdfBeQabUSFts1oHbsYfkDnUbzHPjlz8c
         hbjw==
X-Gm-Message-State: AHQUAuY4nJbLmql4SmUz4psxI6mb0u6eF6O9Iyzx0vJAB9yohIFt7LHT
        aY4NWOGnzWOGpPXlmwF/uf0=
X-Google-Smtp-Source: AHgI3IYAybdsZhG+kVMl2WVkAn3eV4BP57khWz9dwJajmBQ6ousK0NWK7p+MsTRhk610E2R5fiGV4Q==
X-Received: by 2002:a02:c943:: with SMTP id u3mr14505486jao.96.1550554689207;
        Mon, 18 Feb 2019 21:38:09 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id m26sm727257iti.6.2019.02.18.21.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:38:08 -0800 (PST)
Date:   Tue, 19 Feb 2019 00:38:06 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Change server monitor_pages index
 to 0
Message-ID: <23823f617d325c9e961d2433901e6bba3e7ca5f2.1550549612.git.kimbrownkd@gmail.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
 <cover.1550549612.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550549612.git.kimbrownkd@gmail.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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

