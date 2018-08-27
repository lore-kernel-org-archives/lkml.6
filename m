Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1650C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA52208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McQqere0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA52208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeH0WL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:29 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52113 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:29 -0400
Received: by mail-pg1-f202.google.com with SMTP id 132-v6so11372622pga.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yEFWKUBx5GkL6MvlPKzEVqGIgKNvhhKE0n3XN6GitDg=;
        b=McQqere0Ch8BJ+7VrMaTxjIfbIBStCMDADxwFGc4cZ6jDFJ8Gp2vzrZt9ZdPZ0V58V
         NQJ9v1znoJLSUnVvY/9enJaJp6am+GDCxO0lL0e9Aduy8ZAFtCLW96gw1+TJMrwnFLxM
         w6uXfP2ihGyyETN33EzyIUupt+LkLhTEndTUjCk4bHBTpANY0LPQCNLcBGFCxsvJDJKF
         GiEWCc7XJdTzi4qPdHwzrdYhGOOvJtcEBsjLbUb8sDKr24sDVsgdy8mRZ5ufWhTG/5dH
         qcUBNf/70cY/WXquBlOiRB+mOe2BFks+gE9FxT5XYSh60R4FlUPaBRirIMS7vVj30ybE
         fR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yEFWKUBx5GkL6MvlPKzEVqGIgKNvhhKE0n3XN6GitDg=;
        b=EpGA/32G4W/wBZNHD7L5htU5bEoBJahMnDN4Iqzl8y7tPokNsNUWwIDf9tlKEyfZFh
         +Lz0qcIIGFf+9oVuCevmyDsGE25amTlHoqzGmOGpy78XVX6L4Y/qlU4Oc6GjjQNKALKY
         nXp602In3JuP+2cUu8WgZ71GGpnBgANnaqAzBequGcYnfoV8ON96dT1GfY7L5ZUiSXXB
         tWrHP+RTAx3hyXS9aRUsoqrjx/sc/odLpAOPpLtMZqwCNnD/LaEWpPRtnhmngpUMNvF3
         6oGYuh70/hQEhOGefbHXFazQf2XMC7vMAG8gK2ut/LrvxiST6g9xVOiZs3cIuDT40Et1
         KHxw==
X-Gm-Message-State: APzg51C88KShQpjA55KUg176CG03ubYI9oJSpkG3/Je82iXoq1ZJEJga
        F/TVTs5+jUUObe1a0A1O8+KPytpB
X-Google-Smtp-Source: ANB0VdZpxvaXLWNeBT16ooGZvEmHWWpoWhhHPSRlZVTNNJ4z9zU3Lmzft5yEnLXKT2Up+5MWd8ZWxHJZ
X-Received: by 2002:a65:5689:: with SMTP id v9-v6mr3308781pgs.139.1535394227085;
 Mon, 27 Aug 2018 11:23:47 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:00 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-5-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 05/20] platform: goldfish: pipe: Update the comment for GFP_ATOMIC
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Provide an explanation why GFP_ATOMIC is needed to prevent changing it to
other values.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index caf514aafb21..0c55e657da5a 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -640,7 +640,10 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
 			return id;
 
 	{
-		/* Reallocate the array */
+		/* Reallocate the array.
+		 * Since get_free_pipe_id_locked runs with interrupts disabled,
+		 * we don't want to make calls that could lead to sleep.
+		 */
 		u32 new_capacity = 2 * dev->pipes_capacity;
 		struct goldfish_pipe **pipes =
 			kcalloc(new_capacity, sizeof(*pipes), GFP_ATOMIC);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

