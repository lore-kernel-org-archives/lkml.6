Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B3FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31720870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr2jj5So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A31720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeLLN7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:59:44 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34836 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeLLN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:59:44 -0500
Received: by mail-pg1-f173.google.com with SMTP id s198so8385557pgs.2;
        Wed, 12 Dec 2018 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ocy3BxddtOw7VSwPu0UaJqeOH9gYQ8a0j480/bqb1kg=;
        b=Xr2jj5SoZG1oHGgi/ZJ6zOYhMoes60FF33L4PVtZB8ZFhxHN7Mqo8BvFXcaxP2ufEH
         ZlZKxxb73yaCeBp137o1Ada4p3wkOvJcqO4vKNXLAf5Rz7jcpEdwxmv6PMjv7hHG5EXA
         HesD3YxD7lhfhOQc5QPuxS6xTsakCDuB6aiA6E4QdAkPG3/PkqHVg3RmGX6uNXvITpyB
         SeIY80twX8aczE662eAgP2WCnCZuKPoHFc7ZI8PlmMu6bQ7OqfHXy5OinU1EO4FXCLrz
         SeLqpYZquXUHUjqN3fSqHFzpYFItTgU25NRX45ZXDLpyoIwbKWKO+9xKj313tfMffqBv
         9kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ocy3BxddtOw7VSwPu0UaJqeOH9gYQ8a0j480/bqb1kg=;
        b=qxe9qmEJIg9SWTKJYKg1oAX/Rw1Byo5PyeJ0QtOfvykul1ouSxbCjcL9+6DY1M0Jky
         kcrrbz1N4bDcf9/qx0PLdcRWNmBHMDpxYRD+dnesqiOlySpU1gXpF8YatYeJh9JFaESj
         L6IzJB/YWd7jc3jmoR5F3FccVo/9R6z1uM77Ga/EX0bgFUV/mAzBmyFIxFGtPWz4bm32
         77XpiKo1gioQY4YAvCazFbAzknKU6fsXGp/IFFAXSzzdPEGiFDF/+KSVDd4xNQmNOaT1
         oTJu+Oe6MBnagJ1UaC4Rga5wjpa3zj2dHiJDIvGq0YVYqXbqbHCS6JAMCoEzwS8SBrNM
         yNOg==
X-Gm-Message-State: AA+aEWbEX+b60cOKXyk9l9zg1J89zl2SbFbrsGAcVd/gyQBBOQyiy6Gg
        EchKGuQcXuuaungcwcsAvyQ=
X-Google-Smtp-Source: AFSGD/Xvse4KAS7y4bfbg6If5RJXPd/HBPJdStcoecc55bqpVsWs5VwmPt7OmiNMxPrK8hAmEefaRw==
X-Received: by 2002:a63:2784:: with SMTP id n126mr18793876pgn.48.1544623183122;
        Wed, 12 Dec 2018 05:59:43 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 85sm24874894pfw.17.2018.12.12.05.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 05:59:42 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 12 Dec 2018 22:59:39 +0900
To:     Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>,
        Daniel Wang <wonderfly@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20181212135939.GA10170@tigerII.localdomain>
References: <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
 <20181212081034.GA32687@jagdpanzerIV>
 <20181212133603.yyu2zvw7g454zdqd@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212133603.yyu2zvw7g454zdqd@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 14:36), Petr Mladek wrote:
> > OK, really didn't know that! I wasn't Cc-ed on that AUTOSEL email,
> > and I wasn't Cc-ed on this whole discussion and found it purely
> > accidentally while browsing linux-mm list.
> 
> I am sorry that I did not CC you. There were so many people in CC.
> I expected that all people mentioned in the related commit message
> were included by default.

No worries! I'm not blaming anyone.

> > So if you are willing to backport this set to -stable, then I wouldn't
> > mind, probably would be more correct if we don't advertise this as a
> > "panic() deadlock fix"
> 
> This should not be a problem. I guess that stable does not modify
> the original commit messages unless there is a change.

Agreed.

> > In the meantime, I can add my Acked-by to this backport if it helps.
> 
> I am fine with back-porting the patches now. They have got much more
> testing in the meantime and nobody reported any regression. They
> seems to help in more situations than we expected. Finally, there is
> someone requesting the backport who spent non-trivial time
> on tracking the problem and testing.

Great!


Sasha, here is
	Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
from me.

And expect another backport request in 1 or 2 weeks - the patch
which eliminates the existing "panic CPU != uart_port lock owner CPU"
limitation.

	-ss
