Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A5C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E90820866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0EqXhLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E90820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJPXCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:02:40 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46021 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeJPXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:02:39 -0400
Received: by mail-wr1-f46.google.com with SMTP id q5-v6so25994749wrw.12;
        Tue, 16 Oct 2018 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=os7yITSbdycw4FtWMHMzor8Qmp5i56pB04eEadWuHqU=;
        b=W0EqXhLB0O8NfTAI56CTyGQo2nXO/MuXHjyGjjVa4atNkh2WNnfrvIktaqcsS3R+tX
         qHyFaE/vKdzkdHBVf05HUR/WUWlm9Gkb6FnGIIBYlf6gUEBJ/eJn3ngQvrMTxUYnDHaQ
         eP7WYWwLtZViLQRf4nT0gykc4pJZFfJBlN6Ef94qlIoHDfg2IIRSSenW0WN+WPjx07tN
         EpajyGMxB8qSaIdWBZOxGYI85QCyXodeCcbJDKgXFzmDRnQNFKZbi2U/gTDjTk8HFIrf
         /xwRob8emC3hTAlSP3HT66AIjDMbkfnzx0vU4pNjI82b6ZQulc8rRTLpjGLXPDMctXO0
         meGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=os7yITSbdycw4FtWMHMzor8Qmp5i56pB04eEadWuHqU=;
        b=tNKMD0MrD1ycGHkOxKF57zA56e9aVfiJbLIdaNnj/aSn+wPyAzxjf4P1EMbb7fQbf2
         ZcENtzRBQF1wuH3x2OHp+TicCXMNSh/9Dhe3ksMRIsSEnsJDkK9Z+9uELzR4PmK00xcF
         ahIbCrNaW4jYZxzZPd5EEuaAUZEWoelbq7V6OnNEZcMvC6RtYaSHaPPXA/du0YKE2WMo
         Il1WnR3Nath1Er7BeFu3a9A+BGsS5JFHFIFsKH/QoFVIfSOoGY5hVjWR/uow79OIYnrH
         Y7a/y14w2eszMmqkvY491iIhLOKHp7oFg4ugH7jcyJDJvxwYsFjj12Xt/WvjY48Eu84h
         ACXw==
X-Gm-Message-State: ABuFfojBArYociCITSaMH0gmD6gkdko+Q9TW3Aka2EzwyA6DpTje1A7C
        AuNAXUI8oQT2/2uHS+YA82JiVSwV
X-Google-Smtp-Source: ACcGV62PKoeIjxoG5nXX9wdFHGI7EQTcL9T2lTNX7lLBWihREZg/8s41qigZPAK37UHiI18hI9hEbw==
X-Received: by 2002:a5d:4208:: with SMTP id n8-v6mr17910826wrq.260.1539702703638;
        Tue, 16 Oct 2018 08:11:43 -0700 (PDT)
Received: from [10.0.20.135] (mail.jambit.com. [95.157.63.22])
        by smtp.gmail.com with ESMTPSA id k25-v6sm25540439wre.18.2018.10.16.08.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 08:11:42 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup v2 thread mode oddity: "domain invalid" cgroup with
 threaded controller enabled
To:     Tejun Heo <tj@kernel.org>
References: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4fd48929-69fa-f13b-0095-1d210068684d@gmail.com>
Date:   Tue, 16 Oct 2018 17:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

A ping on the below...

Thanks,

Michael

On 10/04/2018 09:40 PM, Michael Kerrisk (man-pages) wrote:
> Hello Tejun,
> 
> Suppose we have the following scenario:
> 
> x [d]    (pids)
>     y [dt]    (pids)
>         p [t]
>         q [t]
>         r [t]
>     z [d]
> 
> Here, x/y is a "domain threaded root" with a threaded controller
> (the 'pids' controller) enabled. (In this scenario, there are no
> member processes in any of the cgroups.)
> 
> Suppose we now convert x/z to "threaded" type:
> 
>      # echo threaded > x/z/cgroup.type
> 
> Now we end up in the following state:
> 
> x [dt]    (pids)
>     y [inv]    (pids)
>         p [t]
>         q [t]
>         r [t]
>     z [t]
> 
> This seems odd. x/y is now of "domain invalid" type with a controller
> enabled! This feels like a violation of the rules, since we can't
> in other circumstances do anything with a "domain invalid" cgroup
> except convert it to "threaded". In particular, we can't create
> child cgroups under a "domain invalid" cgroup, or add member processes
> to the cgroup, or *enable controllers in the cgroup*. In fact, when
> doing the 
> 
>     # echo threaded > x/z/cgroup.type
> 
> I had expected a write(2) error because the state of x/y should
> (I thought) not be permitted.
> 
> Your thoughts?
> 
> Thanks,
> 
> Michael
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
