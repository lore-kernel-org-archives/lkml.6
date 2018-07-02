Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BF3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DFE2517D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFbJ+2gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DFE2517D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeGBPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:55:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44187 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbeGBPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:55:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id r1-v6so1632475pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oP7Blqg5YFV958P+hSooTbrCKgN30DN99I+YXoTjruw=;
        b=lFbJ+2gEV9p4bx6UYGF379wwDQgOM3+smOxwJnwqlW689pt7XWieiAXLNZG13cgF47
         +yu5VciI613rhblDxbms5/Vrrid7DYOQpWL29DFuiTcCSvssV8dp2wYiq3fVsaJ6UpOk
         yy9/fupwWhQtY/RMNTyj8U2lG9C0/h8fO2ko4+ZXkpwLLU/tOSIttLj+Tr5SNsXiHGlR
         BgwHVMMHGpJfUit3kS6IwaF9OK6mYx0XLJ0ZBiF77e0ru3txwqzJ0N2AEq73T+4weGSS
         rSJioBZZuCw3W547HZmrbVPTv2yE8z9UWIdCdOXNBlyU9seJgvTEZD/XyUagazFDGNea
         4RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oP7Blqg5YFV958P+hSooTbrCKgN30DN99I+YXoTjruw=;
        b=Z3KqEdgxt6iIIwB4k3CNXseaPpGl9gCpwPi0mcb4b5MC1CgkHIg4y0r+0Qn1Oppam9
         pATiDZBKShSwkV4ER/09pMAUjlTlTqM2OQjSA6LJHv6ggUPKC3gM632awFVDf7hz4Ruj
         dPq72Ro3k2qmO5qnViFoSmTTug2YmJmfrE9/19Wya771HFULi/kZHNASYYVdp0fyzRne
         XdFSUiLqsNEJsZl+3AhcW1oq11sgVgfemvQs5Dyqhe3NshsuObI8kaM+lrkdtJl4aW2p
         0zxRGC3i2TP7fXxHGxBiU1NhfPXaFZ44JZYL0qkcuLeHkBFtFvqL1/T924O/0K81DKj6
         +AjQ==
X-Gm-Message-State: APt69E0nb6EkZtglyWRbIR0g64Ue4vO16xHowdDrjQ6gKhNICpZba11v
        IpV8iFlYqtGhFl1HCw0lPnBaMw==
X-Google-Smtp-Source: AAOMgpf4TAIDBFg+2azWrkdDTW8VgJSe9azRLv3CVkeLAu2mnxrMjF4cKpdPuwJzq9d2L43aId5zbg==
X-Received: by 2002:a63:4a07:: with SMTP id x7-v6mr3245093pga.34.1530546932295;
        Mon, 02 Jul 2018 08:55:32 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id g2-v6sm29542502pgn.92.2018.07.02.08.55.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 08:55:30 -0700 (PDT)
Date:   Mon, 2 Jul 2018 21:28:01 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     alexander.shishkin@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwtracing: intel_th: Change return type to vm_fault_t
Message-ID: <20180702155801.GA4010@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

see commit 1c8f422059ae ("mm: change return type to
vm_fault_t") for reference.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index dfb57ea..0ac84eb 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1190,7 +1190,7 @@ static void msc_mmap_close(struct vm_area_struct *vma)
 	mutex_unlock(&msc->buf_mutex);
 }

-static int msc_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 {
 	struct msc_iter *iter = vmf->vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
--
1.9.1

