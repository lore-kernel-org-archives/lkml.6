Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6354C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B3C213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="biIkrD+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B3C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeJLXiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:38:09 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:50961 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeJLXiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:38:08 -0400
Received: by mail-yb1-f201.google.com with SMTP id z8-v6so6315273ybo.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NDvBRyzPI19TDI7D7xfoh0mgwG/zsZQZklkTkLuyUF8=;
        b=biIkrD+sByMLze2bdvbQnMN+drtdTmCXqOJjrC/KLe/dbACO5h7Mde6Lix3COoAFNn
         x5m7mqunVDfcjk7dnI/ONWwSHdLwEDlDXM8EtD9BqAJouEiUM4eeC8vU0BFEEXf6Wzbx
         6dLtGE1D7fKcGNEBZZeaUWwkY4FOHj9DBeCwDd7QxXEJSxCW19Dy2DW2ax/PwvXWAmdH
         Td97en7nEBBQwFW+mzRAR86vq84RABH4b2lAyBEo7G5FvUS/pYUtAJa0GVA2mmXuoEsR
         VKFZmHFL67CBK4g8OxNrT9roU2edIxKIiyyGTWXko+FeuVLywy+s4rGUdCJv1nUqAuv7
         aFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NDvBRyzPI19TDI7D7xfoh0mgwG/zsZQZklkTkLuyUF8=;
        b=lYZpeNInm09Hck0kQN5yUVXdV1o20UURlgYRi1LsH7dVEQ2uu/TBKcGwobFonWPaSC
         32CVNoqiJ/lkaUzYp2jXgqOLlfmeWYAjTre4KYLHZ1W+nvM0ifgPS3LUKQ9GU59K1oua
         FsGf4LVK9MuhAcPhVPW3TQGLPoSW3pPe/IyR3szfyDqLy2fb97dIMmVUceHS+d2RjQ3k
         7FiDtZeyZWV/x88hqgzLi/WHWTB3bf+wrDkmggQ4hU1LAmodMm9/SNSXOh2qqQwKV3W5
         g5B+BLGlKmAkXJFeKQebCMmBnxkte6RY3MQng5CYI2qYwXuuQfkRIfY40zt8hVy0hJK4
         nmVw==
X-Gm-Message-State: ABuFfog7gdMqUhjfkdj//xIvjba+6GlVRzEl1hAkuSt3EkGXZWl0o/7m
        sdA5fzMFnS+a0GwaIxUNIxfOenk3WjlR
X-Google-Smtp-Source: ACcGV62P5fWu5/SW8gTuPDo02RykNKICE2mooVbg9zO5TZIZ7xoEO6vtuQhSR87QSAX1eNnb4XtXguSp+Ipf
X-Received: by 2002:a25:330a:: with SMTP id z10-v6mr3830839ybz.100.1539360298619;
 Fri, 12 Oct 2018 09:04:58 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:04:46 -0600
In-Reply-To: <20181012160448.79018-1-zwisler@google.com>
Message-Id: <20181012160448.79018-3-zwisler@google.com>
Mime-Version: 1.0
References: <20181012160448.79018-1-zwisler@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 2/4] gsmi: Add coreboot to list of matching BIOS vendors
From:   Ross Zwisler <zwisler@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Duncan Laurie <dlaurie@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        linux-kernel@vger.kernel.org, Furquan Shaikh <furquan@google.com>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@chromium.org>

In order to use this coreboot needs board support for:
CONFIG_ELOG=y
CONFIG_ELOG_GSMI=y

And the kernel driver needs enabled:
CONFIG_GOOGLE_GSMI=y

To test, verify that clean shutdown event is added to the log:

> mosys eventlog list | grep 'Clean Shutdown'
11 | 2012-06-25 09:49:24 | Kernl Event | Clean Shutdown

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Reviewed-by: Vadim Bendebury <vbendeb@chromium.org>
Reviewed-by: Stefan Reinauer <reinauer@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@google.com>
Tested-by: Furquan Shaikh <furquan@chromium.org>
Reviewed-by: Aaron Durbin <adurbin@chromium.org>
Reviewed-by: Justin TerAvest <teravest@chromium.org>
[zwisler: update changelog for upstream]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/firmware/google/gsmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 62337be07afc..252884787266 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -715,6 +715,12 @@ static const struct dmi_system_id gsmi_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Google, Inc."),
 		},
 	},
+	{
+		.ident = "Coreboot Firmware",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		},
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(dmi, gsmi_dmi_table);
-- 
2.19.0.605.g01d371f741-goog

