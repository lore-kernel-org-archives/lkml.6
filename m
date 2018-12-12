Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB7E20879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFJPU4DE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB7E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeLLG2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:28:47 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:42032 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLG2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:28:46 -0500
Received: by mail-pl1-f170.google.com with SMTP id y1so8119968plp.9;
        Tue, 11 Dec 2018 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRmzXqCIhnys+n0WDduCZmgYrUmpTh2H9E8iwHftF0g=;
        b=fFJPU4DEGjoUnsQbZcQc5c0H2j+ZU5rioR9xE5ath5vjhblWn6fV4MHM4aHXvmxiSo
         9Y+qaRaVKatYwK51XsVooAs+uJSIfxpCwLt4o8EHJlVvmmpUWfyMrxxmzNob0x8i82+c
         TnL5SF2+6QdMAQsTlF2X7apvX2lz6NDC7xNexnjDy8or01LbQB/u3YAw6rcSl6A2sn+d
         +zM+FlRtw9XisuI0k9GLo4BdDw/9j/YemwDcbnyQ4Ei96mZG2yYCpzefc+ywei9TPYuP
         mVp2O+xGjqM7ADhGdXlP55DEWzq+qLmdIgv5S4YUk+2A8/grrRqE4CFVBmDpZmxrif9s
         /SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRmzXqCIhnys+n0WDduCZmgYrUmpTh2H9E8iwHftF0g=;
        b=DJ+hRQ+bq+UzTAWTxL+sCRV08mIcot9r5Lf1lV8JCREKEIFTg4hRpjTw9ivHzdoEAq
         yrQSJDr3UguI5vyHSIqAduN9W3sN3pud0LFobFy2JJ92sDPSbuY1aO2yg4Qum9/Jtm+X
         jkU4z3jz7YL4ia7ASuP7w5scTtRUR60EWw8A/GPVPgZ01GOmf2iAdkqsh6GmS57tqQFL
         z0kjZgiio7zHMIdWOF1e7vnfxc9cmRGxOynUPXRrz1Gv4BOdyhnJofXvFYUmxw/cP9SR
         xKaLJy7/wBAavSLWMe/yLVPu8oAeCc96fGh8bs+HmCw7tAw0luTdQbu2ra8umZ6Z0CPR
         ASVg==
X-Gm-Message-State: AA+aEWYpPpsyzJlC1NgP1QK5R6VLi7Rvjc0M+zDU0J/X2XAc688WIYzI
        3hzheZTjoK1YBh5a/y821KM=
X-Google-Smtp-Source: AFSGD/WzGLwckU5XDUkQv8N0MYfyD4SPUa5r2DEeq80NbbqeSr6Ft7H/9UVfHAfaUiA7ISbkVAshDg==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr18882029plb.192.1544596125706;
        Tue, 11 Dec 2018 22:28:45 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id a90sm33542561pfj.109.2018.12.11.22.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 22:28:44 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:28:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181212062841.GI431@jagdpanzerIV>
References: <20181004074442.GA12879@jagdpanzerIV>
 <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
 <20181004085515.GC12879@jagdpanzerIV>
 <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
 <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/11/18 22:08), Daniel Wang wrote:
>
> I've been meaning to try it but kept getting distracted by other
> things. I'll try to find some time for it this week or next. Right now
> my intent is to get Steven's patch into 4.14 stable as it evidently
> fixed the particular issue I was seeing, and as Steven said it has
> been in upstream since 4.16 so it's not like backporting it will raise
> any red flags. I will start another thread on -stable for it.

OK.

> > I guess we still don't have a really clear understanding of what exactly
> is going in your system
> 
> I would also like to get to the bottom of it. Unfortunately I haven't
> got the expertise in this area nor the time to do it yet. Hence the
> intent to take a step back and backport Steven's patch to fix the
> issue that has resurfaced in our production recently.

No problem.
I just meant that -stable people can be a bit "unconvinced".

> Which two sets are you referring to specifically?

I guess I used the wrong word:

The first set (actually just one patch) is the one that makes consoles
re-entrant from panic().
The other set - those 4 patches (Steven's patch, + Petr's patch + a
patch that makes printk() atomic again).

	-ss
