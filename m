Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FABFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD71C2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDoZV4fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeHWU7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:59:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34464 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeHWU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:58:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so3136490pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDEi4YTRmS/kLVmzG2dkJI4dgbS0KsG4B5fqGPHfa5o=;
        b=UDoZV4fr/ilml0sqKKNPFp0hszW0fbnTtYzZEhucrVAPkLXiyg8JtKAcQi0gYMkF30
         NFijlRgQvRLQDMcQ3XHgp03o8aI+5kKBwTeZ7nuFV4n2SGPXoS0p8umZsXaOUfSjMob+
         wzIl2ETBWDs1ARoCN0b87+PUMNRZCsrj/djxaJqtMW21BvV5XjbI4aUz/d3vpmJyrLro
         dSSeKhHLTl1X60NMzCBMFTvkmJ8NhmzGNvZqoCJYNbdsZ7KwGgJjXOe7Xo/IVem5UoUa
         w+MEZDMT26rJctHMqf099NGysdti5NTVWsG3pJ9PTf3RH9zkqZnl3p3rvlxiJUDxbhDu
         QPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDEi4YTRmS/kLVmzG2dkJI4dgbS0KsG4B5fqGPHfa5o=;
        b=BlkbdtKP36EO4g36ulxD0jMfS8NZLxN/TX1A+HGFCL+lssSZ0cZgSt2BP3JpwKfTKY
         g06Cuc4Yp/V8+lZSsebNRRrMtbp5k8Ta/gq6K8PyKpBbhANS9hbROGY8c6zjd2MtUYJ+
         bdFkoEa8eCEmp52ufmuKywXVvKzzcMidzYOFhwFP83DGFZYarvdcsRXJz/624HsBDcSW
         KMPUcK5L1CoVvIN04XSn2lNak9S6QJOncR1a3yYRxebjVXg+1idVqX7MCknY4hr2y6zB
         /OoQ9o2KyUZuztEZwNsRYbakk9ycJMEKssbqKqgueoJj4uv0ouE4oTVoL9VMRBEFAZp9
         X8Qg==
X-Gm-Message-State: AOUpUlFEkyn8xQGIqoEohbb5OqftY0ZKJJCWUV0VYgGzcDw4TKlp6G7K
        RkmxdJLKcHyMqcKApNbMYtk=
X-Google-Smtp-Source: AA+uWPwb2U+Jahm0JVrOke8IrVWn2nAmUpM/92hu/kfqqkeS6OxYVVTcrxi8MCjOpj5PidjozhY3pg==
X-Received: by 2002:a17:902:28c7:: with SMTP id f65-v6mr15789786plb.240.1535045296108;
        Thu, 23 Aug 2018 10:28:16 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id t15-v6sm8450826pfa.158.2018.08.23.10.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:28:15 -0700 (PDT)
Date:   Thu, 23 Aug 2018 22:58:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 1/4] staging: mt7621-mmc: Remove commented code for N_MSG
Message-ID: <21d3ce50f8bba68348c478e4a7520ee22d7b765c.1535038494.git.nishadkamdar@gmail.com>
References: <cover.1535038494.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535038494.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the dead code for N_MSG().

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v5:
  - Remove commented code for N_MSG()
---
 drivers/staging/mt7621-mmc/dbg.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 2f2c56b73987..6f6b4505337f 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -103,14 +103,6 @@ do { \
 #endif /* end of +++ */
 
 #define N_MSG(evt, fmt, args...)
-/*
-do {    \
-    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
-        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
-    } \
-} while(0)
-*/
 
 #define ERR_MSG(fmt, args...) \
 do { \
-- 
2.17.1

