Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F2FC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E505D2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne+Ikb4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbeL3DEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 22:04:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42097 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeL3DEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 22:04:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so11508674plp.9;
        Sat, 29 Dec 2018 19:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z5NeTonKbmm4KLxp0VKuPZcNIK3JG7O+DEdA5MYvr9k=;
        b=ne+Ikb4rkyluSGZ8cckJjZqFbFtxXrYytqUK/XcUyhwMGJQYQ1CjeR7wa0i0VDOfwS
         1rxi11G2+2vjafRycU2sjcrkszb4ccbtkpOXfYZ60YMRjRVhXfRUpWeqfRkjbq60GYLM
         mo30a6RpRFyNzy+2DVJbJq48NB8KGNjXIAYOfzhXYZ8rfTmnuwWktDuQ7cpluBM+ZYJt
         xWFkazo+dKcVltryTVRp2cSWyY8kSzZvGiW1dNg7gD018kw5H4BK2zqdRxe4CHZl8z9A
         MDqJWFILCZKSi0Z2rykEVmHzNl79OqcHy8ZMplCMctAbmxroNVtwXSEFEepAQ/FHKH6k
         fisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5NeTonKbmm4KLxp0VKuPZcNIK3JG7O+DEdA5MYvr9k=;
        b=RTT1vv10kg1qaFUolALF4CYgwDAqH9LRmju9L+Ja3me4h79ydZs+y67wDvJxJxgnNR
         SGoPD12RYbmPMw7h5UuMMKTlC5d4Yc75UFpa666991d52DGgz5pnmTjPv8TeGCSt62Zy
         yjZwSQElnKLpWvzoUDftSjdE+mKEVcawZeWG+Sx6Ranec2Lnq2JxCCAKtNwlbG7F5Ns2
         mjJzAzjfblMzlHvZ2AfypEr/5ZYGYMRQU38PG09jsNjCZH7GBIsv5hncQv7OqqR5HY5k
         hUwSJr6QdKOKNUfJ7XeJ7APnT4IYjYhhbynO+ObE/VjP1Sfnmn8E/W2vXTelIRgcsPAG
         +Edg==
X-Gm-Message-State: AJcUukfAq/II8qS+ydA58DeYRHW9gcoJRtb2lDsXRyCR7n8+qzyPeOwi
        r4UMNABCyisOWoaaf1UnLyc=
X-Google-Smtp-Source: ALg8bN5+3qtrZPq8Un6HFruoqJzh4Ta9nW3d1egQkwT7DWlUU89dBVffsxntmduHt2AA3M1kZ0lpBQ==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr32365540plt.98.1546139075495;
        Sat, 29 Dec 2018 19:04:35 -0800 (PST)
Received: from localhost (node-hau.pool-101-108.dynamic.totbb.net. [101.108.87.150])
        by smtp.gmail.com with ESMTPSA id v14sm109010779pgf.3.2018.12.29.19.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 19:04:34 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 30 Dec 2018 12:03:41 +0900
To:     Daniel Wang <wonderfly@google.com>
Cc:     Greg KH <greg@kroah.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
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
Message-ID: <20181230030150.GA5082@tigerII.localdomain>
References: <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
 <20181212081034.GA32687@jagdpanzerIV>
 <20181228001651.GA514@jagdpanzerIV>
 <20181228082749.GA28315@kroah.com>
 <CAJmjG2_U3fJKsZ4FgF+ihyoNUxxQ+d79Gh-eMZJ_6pHr+Bn0CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG2_U3fJKsZ4FgF+ihyoNUxxQ+d79Gh-eMZJ_6pHr+Bn0CA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/28/18 16:03), Daniel Wang wrote:
> Thanks. I was able to confirm that commit c7c3f05e341a9a2bd alone
> fixed the problem for me. As expected, all 16 CPUs' stacktrace was
> printed, before a final panic stack dump and a successful reboot.

Cool, thanks!

	-ss
