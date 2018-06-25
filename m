Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BADC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7B125B6C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCoVoJjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7B125B6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934562AbeFYOgF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:36:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37125 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934437AbeFYOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:36:02 -0400
Received: by mail-pg0-f65.google.com with SMTP id o11-v6so270782pgv.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptkRAqqJ+GD8j8B2umTRKR7dh50A4/POXZVoU0yr1/k=;
        b=jCoVoJjwtuk5WII59uKQfpLktpC9dfW4JCw7dqRLjM33di+ixz+2S1QoHOAcccLaxt
         DOa6mEFNeD+NiUwLFk36hpYqSenPJvzXKqFxv9mDKQRreW0x0kAgkER176KdRM+YV+Hf
         +yih2p9xfM+Jc/ObWPDIgnhQviBPDnW7Zy2K/Gfwt49zGEaK+GFO3PUAFohoskY8hPG6
         w61YsKdLqqxojBAPSLNjaKPLpxVkzM8qw6KzP6DvrNLrmbryhR0Gnaftt9gDbOPJvKsq
         EcEhbtKMd8BSNH4pBIK7u6PITo8tN33PnOsR5lXlgyhYUBXCDeTzC1Ze0ukshKuYLTFM
         4Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptkRAqqJ+GD8j8B2umTRKR7dh50A4/POXZVoU0yr1/k=;
        b=lqdrNczfvmm0MF25cETpmyXOzyJBX+DOSWrxlu51NeKoprsOQigokrkkbTwtgsM4Vh
         ZGHn5+hJHNGkahVU0y488tnu1fW/ZCINGThpwUj0kBrYTIXKruIvDAi0ZUuk8SYFUm4w
         CrTtGLYRhfE6r8ohFIDv95HzJpWUMQAt8HsCXHP5eb9qv8M6Gk6cIKsKgzjsS7RLb7bZ
         rV2NksG0DG4sso0okfUZs3Sh1I7JuX1/q88OWZQelD9hwzJGi/PlLLKICt7QoE467ZAd
         00G2tSRbQl8YwMsgT+jKB9RqIi9aO14T4SQFxgSGUKoJoF+OzMaGUThGwSlg6EHCa2nR
         ELlA==
X-Gm-Message-State: APt69E0GqPEok53AfDcZEet/VAdsBJLkOP1FZxaXL7omltbo+uA9RIQL
        fiXRcvKbHIZSI9py2Hr9d4Y=
X-Google-Smtp-Source: ADUXVKK3SFgy0XiJc/N9tKUnmkAU6FfCt+jHdsJuPT8iJoDhmGiQA8IhbLHBKZMtvGpd5AymbosnmQ==
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr10889766pgp.237.1529937361857;
        Mon, 25 Jun 2018 07:36:01 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id r7-v6sm22434431pfh.52.2018.06.25.07.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 07:36:00 -0700 (PDT)
Date:   Mon, 25 Jun 2018 23:35:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Namit Gupta <gupta.namit@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180625143558.GA443@tigerII.localdomain>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
 <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
 <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/18 15:37), Petr Mladek wrote:
> 
> I pushed a bit different version into printk.git, branch for-4.19,
> see below. It removes the code duplication. Also it keeps the original
> indentation. IMHO, it helped to better distinguish the code for printing
> and clearing.

Agreed. Good job.

	-ss
