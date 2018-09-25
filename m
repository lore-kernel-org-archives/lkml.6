Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730D7214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/ps8iRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730D7214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeIYTjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:39:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46434 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbeIYTjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:39:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so11552902wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tKkpyHDNFbJ7ClbAahRXzw/RkiZ4V/XPfMwdY67lOUM=;
        b=X/ps8iRrdTCpQcVvuhiXuOWdjdtrgzAUOwwKUB0GEEvEXI6xNj1Yj3PdrQhF2xXObX
         rmO+UjxTCXlX5IWQzMm1t2WEH9fDr8cXlWaYg2V/X/V4bce3VBS2cu0E+7BUKlzcjlC0
         7JJ/LaDygqvtS3aboo0VZ5Qrtm5TAfmJe307HhjWG9z8COkllrmDr/2/K9xPqkU2l6sj
         lvyoYu9tUVOvgrAig9QhMTTimTrvXQzKqmy9Y20MOSGOXUaLBFDP8cBxUqORJUUiYLeF
         cWkRGxNhowx/4ia4b9DWKn3jkU1j5UcmFVHAnzX4TxeEutld87aW5w/b27QARxh5CHYo
         5UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKkpyHDNFbJ7ClbAahRXzw/RkiZ4V/XPfMwdY67lOUM=;
        b=LF4/6cd3AJtjwq8XtZs3UNefOTri7V3V70ju85Q0yjdZRJ5mq6udd27dcDoYrPm1tf
         L0T92LTe0HPlUOCHG08yWkpfbqWyWSkYoFKIkHq2tm4Et3cnduVexcex38SM3Yj4P7n7
         raXtJmkNZt7CwBP6+S0bPjoquBqRoKPRPTJ0lffgH5ss7KfSxRKzQxqZyhmFTmWrRp7K
         3RMi6PxAK2VqejsKGWsro3BGnXohtD9m1kh048yQ/EBtIi9mtyTCQO1yAc6ZhTW3M/Uc
         QFaOb9u7JmEHKJICylRQwICDG++mNg0C0Mdq/mUEN1ib330TI9msoVzw4saP4w41ZNsL
         gALw==
X-Gm-Message-State: ABuFfog4v1M9buFiApxnmOR6rNTKg+nxhCiis97V94pdr9KtEUGc/8gy
        8XnChNhLOIyEXTKcZ62KCEo=
X-Google-Smtp-Source: ACcGV61HcX/5GpjUEzvj31XVmMre+EVu40G/pYCzfpXFz9HKXSwO1P7tiX6Nq4CFTbEEc6vaD0RzDQ==
X-Received: by 2002:a5d:6586:: with SMTP id q6-v6mr1032762wru.141.1537882307669;
        Tue, 25 Sep 2018 06:31:47 -0700 (PDT)
Received: from localhost ([178.121.95.75])
        by smtp.gmail.com with ESMTPSA id l40-v6sm441752wre.38.2018.09.25.06.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 06:31:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 25 Sep 2018 22:31:43 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        He Zhe <zhe.he@windriver.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180925133143.GB601@tigerII.localdomain>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
 <20180925120135.GB523@tigerII.localdomain>
 <20180925122300.qq5w4skwmxbzi6sy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925122300.qq5w4skwmxbzi6sy@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/25/18 14:23), Petr Mladek wrote:
> The 32GB was mentioned as an example one year ego. This is not enough
> for a new syscall from my point of view.

I agree. I didn't think of syslog(); was merely thinking about logbuf
and flushing it to the consoles. syslog() stuff is a bit complex. We
sort of don't expect user space to allocate 64G to read all log_buf
messages, do we.

I'm wondering if we can do something like this

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cf275f4d7912..1b48b61da8fe 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1110,9 +1110,15 @@ static void __init log_buf_len_update(unsigned size)
 /* save requested log_buf_len since it's too early to process it */
 static int __init log_buf_len_setup(char *str)
 {
-	unsigned size = memparse(str, &str);
+	u64 size = memparse(str, &str);
 
-	log_buf_len_update(size);
+	if (size > UINT_MAX) {
+		size = UINT_MAX;
+		pr_err("log_buf over 4G is not supported. "
+			"Please contact printk maintainers.\n");
+	}
+
+	log_buf_len_update((unsigned int)size);
 
 	return 0;
 }

---

So we could know that "the day has come".

	-ss
