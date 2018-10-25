Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6812C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5656320847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVrxm94l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5656320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeJYPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:37:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37202 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJYPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:37:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so3723626pfi.4;
        Thu, 25 Oct 2018 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oKHBG7ghWNYtmmLTKDORXb520ZscZSXkKHXyVRxiwGE=;
        b=QVrxm94lphHo9Pay8WfaYzbbdhCPmr+H/bHZ9fmmwsBxC5jLZvX+4XYPQV9v6hvedH
         45hSCp+zWeCcGf/VZUW4ogz8Ipr8O5yOf12+DgpvN0MlH4p4mO5LldHTPSvaA38ssyft
         1g35I3AOAGMM7QubJqQKHdyo/axhRXeMHGSsjwd8lpNO8j60RFvNgIkBMY6gV6yRh1AS
         XxdRr+9UmA7N68T5P4RN2eIeu2w66ck7psjLeNI1MYcPQSA3KbAwClZYh2V9oXKXC0tq
         4gEmb5NKITWHIZLpTzYYv4EhnOEL2rSBme0Ma1A+43f8OmSYdtCtwQLUO+RDqupp9hEi
         hImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oKHBG7ghWNYtmmLTKDORXb520ZscZSXkKHXyVRxiwGE=;
        b=aMuKT24gi3nfygUp3ZYTXlEmiRnU2rkqTMMjJJx7uQGpKokyzVv3EFY0uC6PpJlMjL
         KIIlZD8fPw/JGWnX0BvobXfSAXIpfon1vOywbHIw76EtT+RL99MxOxUqwNxuP5xxY7WO
         bWTSBB8ARR4DGsx7Ni7HAjuHJXiqqWjS9xZtr91955JuwkK0uVRritj+a6jua+l9+qxS
         bfqVt8yr1AeuI+EVJRqW/fNSzp8eyfax/1djAqnXNmCkxl7O6vpbsifdR4J/3j07tXxo
         qGXcu38K9IaLQhx6Zvd9K/M1hRfAgB//6CxhBF38Y3P3YTO3l4kDpOYF1e8oNAXy0hlZ
         1aBw==
X-Gm-Message-State: AGRZ1gJ1nn3dsgMbjIH5t/eFgR1yakvLhIUVmFud3ngNl5QLpKcr/4z2
        LJ2nGTHROZS66IdT6dba3sBSvNWm
X-Google-Smtp-Source: AJdET5c9uq7hvW9QaL34rwpDe9UXSHRVh9NkvTdaJbi0k+UmLbSTr+c4Sh556iHmhBSD0UVki2L4IQ==
X-Received: by 2002:a65:6144:: with SMTP id o4-v6mr357020pgv.387.1540451148273;
        Thu, 25 Oct 2018 00:05:48 -0700 (PDT)
Received: from localhost ([175.223.22.26])
        by smtp.gmail.com with ESMTPSA id y71-v6sm12730899pfk.70.2018.10.25.00.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 00:05:47 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:05:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181025070543.GB20702@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
 <20181025062800.GB4037@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025062800.GB4037@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/25/18 08:28), Heiko Carstens wrote:
> 
> With your patch this looks nearly like the common code variant. I did
> some code archaeology and this function is unchanged since ~17 years.
> When it was introduced it was close to identical to the x86 variant.
> All other architectures use the common code variant in the
> meantime. So if we change this I'd prefer that we switch s390 to the
> common code variant as well.
> 
> Right now I can't see a reason for not doing that, but I might be
> wrong of course. So, could you please provide a new version which just
> removes this variant and makes s390 use the generic one too.
> 
> We'll see if there is any fallout...

Heiko, if this one works for you then I'll submit a format patch.
Let me know. Thanks.

====

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] arch/s390: use common bust_spinlocks()

s390 is the only architecture that is using own bust_spinlocks()
variant, while other arch-s seem to be OK with the common
implementation.

Heiko Carstens [1] said he would prefer s390 to use the common
bust_spinlocks() as well:
  I did some code archaeology and this function is unchanged since ~17
  years. When it was introduced it was close to identical to the x86
  variant. All other architectures use the common code variant in the
  meantime. So if we change this I'd prefer that we switch s390 to the
  common code variant as well. Right now I can't see a reason for not
  doing that

This patch removes s390 bust_spinlocks() and drops the weak attribute
from the common bust_spinlocks() version.

[1] lkml.kernel.org/r/20181025062800.GB4037@osiris
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/s390/mm/fault.c | 24 ------------------------
 lib/bust_spinlocks.c |  6 +++---
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b8f32f56e0c..11613362c4e7 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -81,30 +81,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 	return ret;
 }
 
-
-/*
- * Unlock any spinlocks which will prevent us from getting the
- * message out.
- */
-void bust_spinlocks(int yes)
-{
-	if (yes) {
-		oops_in_progress = 1;
-	} else {
-		int loglevel_save = console_loglevel;
-		console_unblank();
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;
-		printk(" ");
-		console_loglevel = loglevel_save;
-	}
-}
-
 /*
  * Find out which address space caused the exception.
  * Access register mode is impossible, ignore space == 3.
diff --git a/lib/bust_spinlocks.c b/lib/bust_spinlocks.c
index ab719495e2cb..8be59f84eaea 100644
--- a/lib/bust_spinlocks.c
+++ b/lib/bust_spinlocks.c
@@ -2,7 +2,8 @@
 /*
  * lib/bust_spinlocks.c
  *
- * Provides a minimal bust_spinlocks for architectures which don't have one of their own.
+ * Provides a minimal bust_spinlocks for architectures which don't
+ * have one of their own.
  *
  * bust_spinlocks() clears any spinlocks which would prevent oops, die(), BUG()
  * and panic() information from reaching the user.
@@ -16,8 +17,7 @@
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 
-
-void __attribute__((weak)) bust_spinlocks(int yes)
+void bust_spinlocks(int yes)
 {
 	if (yes) {
 		++oops_in_progress;
-- 
2.19.1

