Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B018C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F75520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPHDFL1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F75520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJELLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeJELLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so6191473plp.6;
        Thu, 04 Oct 2018 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aHk2/msirjmyKqS+4FgQGJlEqHm8O56cobU/W37vLhc=;
        b=WPHDFL1AZ4qHSKkELUE2W1LvCrnK6Pxi8/u4Gxz7KiTGTf2de0QmdT8Dpjo90P2m50
         tBLYvaNIeDrkpCXs5dSvLOloAqmcZJyfUNsU+wtkKNStmHC/lmU5rGpSPeOUWshkGI4U
         3DIoYXkLaRQI6NpX+4XS3alki+OyGC+MXy2YJ9QpsYnZknlzAu75STLnCPs76y3je3YB
         csaYIytF5bx1OxdE/uIl0V1v5FhuVPH5qN3legSD4bV7qal8t0e+R9kw23xhoI1VrgHr
         rTCD6MSXx02IxTgsB8no6OvCzU1aJ2KJWbapwUBCkUR2Sg/gUBN8VzEOTqiRWP0FWlyz
         1BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aHk2/msirjmyKqS+4FgQGJlEqHm8O56cobU/W37vLhc=;
        b=L4VwSEig/AiPoZTeMKLNZKSVf6T+d308IxMivXioEdSCzdHWUNC2Emtr/AkHp9oNrX
         YTy+Vsbqdxxgy+TB08jFkImNqNUxWbAEUk7yedZufzzK3oCfQLZG1Tusi8oXxTm59f07
         ObZZTIoR34MVgyhNnE35YwArKNXh7AAX68CU6r1yUhyBGqvqVPWLnfGHfk+b4qoS0Kas
         Ya1JpgtARrDgHtCE6tpk/J0WoDstBHTkZuh6QrtqFN6SGpPiItj0n+7bz0VuaGyL6Mpi
         WyI1k9sXXZax5RNpYDjCqRXrjnikPhklbvoUgchPYTyeV+9OxJzGY60lf8QRY7t7TZ6C
         AHtg==
X-Gm-Message-State: ABuFfoj+B7b7uFZsFvbcOv6RyBYUdghVF9U5K0swA61AJKsa6S9Feelb
        B05qYfzo1XH1onUcVtAGUYPiMOX0
X-Google-Smtp-Source: ACcGV630SMvEEH91kwNT67O2vqkxPbPUjcKTqO0n6Bwy5xOdSqnPdJwHrDaByoBnEzLWOL/j30P/3w==
X-Received: by 2002:a17:902:8644:: with SMTP id y4-v6mr9699660plt.48.1538712862216;
        Thu, 04 Oct 2018 21:14:22 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:21 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 08/16] of: overlay: reorder fields in struct fragment
Date:   Thu,  4 Oct 2018 21:12:39 -0700
Message-Id: <1538712767-30394-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Order the fields of struct fragment in the same order as
struct of_overlay_notify_data.  The order in struct fragment is
not significant.  If both structs are ordered the same then when
examining the data in a debugger or dump the human involved does
not have to remember which context they are examining.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c113186e222c..29c33a5c533f 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -49,8 +49,8 @@ struct target {
  * @overlay:	pointer to the __overlay__ node
  */
 struct fragment {
-	struct device_node *target;
 	struct device_node *overlay;
+	struct device_node *target;
 };
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

