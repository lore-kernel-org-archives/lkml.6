Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4E62064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0O4shfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4E62064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeI2We1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:34:27 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:36955 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbeI2We1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:34:27 -0400
Received: by mail-pf1-f172.google.com with SMTP id x26-v6so6306326pfn.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ph56kULd+6XC9QQea7UMRDVKt0R26kCKBZtJlCSDhWI=;
        b=k0O4shfG77Xw20j0o5jHYbmAUNRNuIEaStecYkm2abBb7H3r8HQ8+YiFFD9wA6tErn
         1Qz6834h8mRkqcDGclq/TlDBVVOrT9qybzIGv0ZLKFzUpojO84BkTrrItr6pUmSWQG1q
         iwW25ZZaHFXgAgmoaeaCve4/eFLuYrCvmeMdF7yH8be1Q0IvUebKTvxCFQSuhkbqeNnf
         qhccceYE5g4t6OcitcASBjPafsdjEgw9Igicn2X6LEW6jhPK0oYq/xfExZTy5pTY/mXm
         luQBRhyeHwzYJteOCCm5Y8daHHGZI7sZmsuT3MI31xuQ6vRfJqjV6AHz7YSRBGhsVdJk
         glig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ph56kULd+6XC9QQea7UMRDVKt0R26kCKBZtJlCSDhWI=;
        b=lA8Aqjv3FQ709kXMR1Eix0tlr7mkAWNzN7mwcWYjAGL8gOc5tMGBeRE4jvOMyQ8NUv
         SOlY30tOVxm/f5cTLQAPzPBztjW3zQ7l/Ez6XJ0jwMsdeSwOUZGcGJ2xPmzDkmyzqgLh
         Z+4fp8X+hlW3qZTZmV0o9peZZ0Iz7RkTMkP/JteuKwZCnWl7pvO0/gvCaR+SAn3GmesR
         9PBKbaGuBAOTiWES1i4O7yuzNt7K7WgGFTOKTPst7d9u2jLlISJGKrmO6kFGcBv5n0wF
         VqkeLGpbstcZdIsZ3FHsRMKA1tXwRrNzL5RoDnhFvQ+kHgL/8jJKFn2wfyna3vr3U5NO
         ZOEg==
X-Gm-Message-State: ABuFfohP4ZlkwW5bUppmJepOUNDs471sdpSse+jyu8x3mxDT5CXvnfft
        zTZv82UZsyS8hUZN+Q1Lrwk=
X-Google-Smtp-Source: ACcGV62xuaYJ3EqkoodEuxJcBsIgVaHNMPOQ7ivicPX2EhVfnqWeQBeCzqLvzNNfV2Aes8Vm0/PInQ==
X-Received: by 2002:a65:5188:: with SMTP id h8-v6mr3402433pgq.288.1538237129917;
        Sat, 29 Sep 2018 09:05:29 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id r18-v6sm11037165pgj.51.2018.09.29.09.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 09:05:28 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 30 Sep 2018 01:05:22 +0900
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] printk: Add KBUILD_MODNAME
Message-ID: <20180929160522.GA573@tigerII.localdomain>
References: <1538232529-72706-1-git-send-email-zhe.he@windriver.com>
 <1538232529-72706-3-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538232529-72706-3-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/29/18 22:48), zhe.he@windriver.com wrote:
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +

Plus this one

---

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c9068074dd09..e32f93a2fa84 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2732,7 +2732,7 @@ void register_console(struct console *newcon)
 
 	if (newcon->flags & CON_EXTENDED)
 		if (!nr_ext_console_drivers++)
-			pr_info("printk: continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
+			pr_info("continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/*

---

	-ss
