Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC1F21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hleXiu0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC1F21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeIYOkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:40:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42012 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeIYOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:40:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id b11-v6so6158303wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Dy1Ja4gXW5mpcYa09YV9C9RPIHm8jQC2ppDhQxUJk0=;
        b=hleXiu0iU3Df1ekpjDXiFSFH9ganBydaxLNnrv1kh3dQAJuckKzSoq0IqwwRhdrsbg
         Aer79ZSMz56qntDTtMzzXwp7h4OWmA0t4OWFQ0dfMRFpIG5kQYaKZO8BSeSJ9DTqTVLW
         JypZlS7aTT0gFrjkf0NITibbW5HLxDQCbB3MWFQiaLa3dIOM4UUxEIQe+hqIfPytDZsG
         6VmQ/NqpXVqFX4tUuV8WnAfDHF8OOs6uSc+7qMe9QhkPJa2HEEJ4KWdsjTTk0oU1Q0D9
         sCDHs149DgFIUoAJ375A7QQEGsSUdfVDnm25YecYhMwLxs3JTIlHFxf+rcU+ieoloK/r
         +/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Dy1Ja4gXW5mpcYa09YV9C9RPIHm8jQC2ppDhQxUJk0=;
        b=CHg2PyEOpDTnjqD7MI9ppytVDVdVPHHhzquNTXuVWb4T2MaOTjUCjT9dhk5uni/fXY
         DctDe9jqq9LiypU/gXunOy8EAmXam37b9TmtPfEeSVM72JEtnKuDi4lwJ90I5PgS5I5x
         eMeTbnbRK7jn7beXTjPQsjxZ44Mw82rlbz1ypo/ZXmvk8m/wLHVBoj54IXeLTf81k8Qg
         WKUdZfAZaqgy2LjNG4UKubglLnFedQwonH3XiFEofs8F76Gt2hQ+P7AAh+u+VRXilyDw
         NqW1gYRssSVqD+umEP+wGoOC2DMMBsLoGiGZ5Rw55HXtjUtWjewLNGCTA2PK0BqZMVBy
         t9ag==
X-Gm-Message-State: ABuFfojVovbx10/JUhLnfEmwhyEufN3jHiSx7L3nUf7C8ZtZF4D2tDI3
        5Ub3nRtL/vrcIK+10pbfwVg=
X-Google-Smtp-Source: ACcGV62gmGcAr8dN7BBY6l1JxVq3wuJlq9SCjc9nU3oqlICQShR+e74Y1VJzkYx8zyjJex4mkSl/7A==
X-Received: by 2002:adf:f045:: with SMTP id t5-v6mr1954193wro.92.1537864460953;
        Tue, 25 Sep 2018 01:34:20 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id 94-v6sm2115538wrc.10.2018.09.25.01.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:34:20 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: bcm2835-camera: Remove unused header
Date:   Tue, 25 Sep 2018 09:34:00 +0100
Message-Id: <20180925083401.22533-6-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the asm/cacheflush.h header include from mmal-vchiq.c. This
dependency was removed in:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations")

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 51e5b04ff0f5..6e5c1d4ee122 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
 #include <media/videobuf2-vmalloc.h>
 
 #include "mmal-common.h"
-- 
2.17.1

