Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE336C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901B020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF8FsOnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901B020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLJFq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:46:27 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46633 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJFq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:46:27 -0500
Received: by mail-pl1-f179.google.com with SMTP id t13so4691604ply.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 21:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23+9ug+dFHS69gqg3+qO7txAJ1pBcynL5Z/20oRtL5M=;
        b=OF8FsOnklLFzvDTUTUENVZY5Aoh4rxQKFFrjqgydCL5lnhI6o6Hc1Zi1PtdRwpxSTW
         qezrYhUb0ifCemaKidqrsPiWWsFV5Mf/Z+HlxOrBRnw+h5EbCuC23rzcTS8B3y4HI9gU
         LtFpk1yLwJzhyeSAdjIv45P3STdHbas8bxWMds+6VB5vWmDqKxdzK2+BCerVEHSJnrn+
         EYcgIeElXhwNR6aOpsxn9Kc6XAWNtV5XDG2Mnk6QlBiK5UmHAFFQjqatgSuDfGO1LR5k
         4KD92YUzw9X1WuxugI82lej+UtDxU69nFt0t2/kCVG+HSUi8x9uDV4xHFKULVO57cmiD
         ui8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23+9ug+dFHS69gqg3+qO7txAJ1pBcynL5Z/20oRtL5M=;
        b=OmlVKM575X8XOLSdoFvEjTB/kQW7p4Xe3XiPpq1vzpHKs7CFwemTUuxKxlzEwMW8CJ
         srgBSuFT8H/smeIG7Lx5k2rmMFhmlxz6Pumzpr3GDEXv/ZLt4FRWXRAyvt1bfyW6/zF1
         OcVcB0IENpfumOhjFVT6ArJmYBQYA3IHbqNCTjnpfzGuO61tzWmOWZlls3zzjQEt6ddc
         Chiv2YiyfG89ZqOOHgZRpop9z7cubdHUvb0FKi3S03m50h6nPOhEm4yPyizcuvynMeAy
         l5RSlZ4fgDWs8A15PWk2OAsWBZ7xoUtgOJwgOUqIitcZOdleAv8r/2vBhKTe9FaiUsaO
         7fpg==
X-Gm-Message-State: AA+aEWaXkPezf/xsgtrXiaXXlr9jvR/zf0VpApMTUG+21R6OwoAyLAV1
        RQLW98sehNf5M4jB8NJ5u3U=
X-Google-Smtp-Source: AFSGD/VzDD5gcicp6VFc1MJQ8yMBb3VYMc6iQumlYvMPjDSGpwkIZ4xmkfFu+fFEx1xYkkZJPb6ycQ==
X-Received: by 2002:a17:902:b7c7:: with SMTP id v7mr10988614plz.75.1544420786740;
        Sun, 09 Dec 2018 21:46:26 -0800 (PST)
Received: from localhost ([175.223.21.78])
        by smtp.gmail.com with ESMTPSA id t12sm16143835pfi.45.2018.12.09.21.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 21:46:25 -0800 (PST)
Date:   Mon, 10 Dec 2018 14:46:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Message-ID: <20181210054622.GA6291@jagdpanzerIV>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/10/18 05:40), Liu, Chuansheng wrote:
> @@ -130,6 +130,13 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>                         init_utsname()->version);
>                 pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
>                         " disables this message.\n");
> +               /* When sysctl_hung_task_panic is set, we have to force
> +                * ignore_loglevel to get really useful hung task
> +                * information.
> +                */
> +               if (sysctl_hung_task_panic && !ignore_loglevel)
> +                       ignore_loglevel = true;

		console_verbose()?

	-ss
