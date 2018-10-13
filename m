Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC82CC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3420895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nAzmCR1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA3420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeJMS70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 14:59:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36693 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeJMS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 14:59:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id a85-v6so9217352qkg.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t6XY8jAo259QHqFpGkugyhLS2yjq9bXTVFY8Nipgs98=;
        b=nAzmCR1pDJumPylSoILdDl4qIfZ/pMk/E6icRWRO2nbqjr42couuKgzoco+ZgXwtrE
         Bx1EZzkVoMA3vARR2nQAFVOdXeIsn4L6iY7FHLC5+OmGf4vNDZ1jHqcNDx5HKbGphx3S
         s700Ym/WF9AgYMI0TFPQrEcD6DDwy1KyjEwJ5rkG34IaRBnOMjyD5z1/io9N8C2kPaQG
         hJ4JK3VgWcnfvOdHcEugWVdoumC+7eD6pjd+dcejaViNkP5EeQzcniPLS2Vx2zGW1OAI
         MJtHNMqhPGNnXbfih+21uxmUo5yyMFwhyGmd7ZwA7q3BNjYbg9mT9+Q5z2RIwFZnMh1C
         QELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t6XY8jAo259QHqFpGkugyhLS2yjq9bXTVFY8Nipgs98=;
        b=jG3g+wJVbK5+5ri/Wot+IrqBZBX7/IkI9fTYV1LPTqLfYUqZVYTjUTp8ommyrXr+Aa
         sGcLjL12qeeJKc9bTm/pm+o09ixzo9n33kd+GqDwALj2Hn+yxdchBNGYM6FuzjgpX3nk
         ARzmirQ4vUPv7tnZ1Js/fHXZ0R0ElNb1QX3ZwcuhpElvAcjqhjkZrNtQ1IQvDep0AASm
         MowhSVW0xnf9ZxGTTdFCDQi+OATd3ZqlS4hhGPqD/woIamqc+p286XycakVUBaAkg8wh
         DdtWcT4OWk23Sun6EB5tIbuKgCZDL1nAZk8FFiJVcUmkQWGvqK7BW2AkbNMyseJLEHVA
         7Ymw==
X-Gm-Message-State: ABuFfoh8PJi+PLBBxix1hPu+MaBr22gqdFBEaRiGg4qE6BDPI1Otb+L9
        CQKJdPQg5ve5TiXA980X1ahHGA==
X-Google-Smtp-Source: ACcGV60u5JG3OOaWotDuooKNkvol89ADpCDcHWT2K62SLl2CaQTwNdOc1ZpVxuLKfkjSPRZmuDD8cA==
X-Received: by 2002:a37:f8c:: with SMTP id 12-v6mr9173212qkp.224.1539429761581;
        Sat, 13 Oct 2018 04:22:41 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id o185-v6sm2403012qke.34.2018.10.13.04.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 04:22:40 -0700 (PDT)
Date:   Sat, 13 Oct 2018 07:22:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
Message-ID: <20181013112238.GA762@cmpxchg.org>
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
 <20181012112008.GA27955@cmpxchg.org>
 <20181012120858.GX5873@dhcp22.suse.cz>
 <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
 <20181012124137.GA29330@cmpxchg.org>
 <0417c888-d74e-b6ae-a8f0-234cbde03d38@i-love.sakura.ne.jp>
 <bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 08:09:30PM +0900, Tetsuo Handa wrote:
> ---------- Michal's patch ----------
> 
> 73133 lines (5.79MB) of kernel messages per one run
> 
> [root@ccsecurity ~]# time ./a.out
> 
> real    3m44.389s
> user    0m0.000s
> sys     3m42.334s
> 
> [root@ccsecurity ~]# time ./a.out
> 
> real    3m41.767s
> user    0m0.004s
> sys     3m39.779s
> 
> ---------- My v2 patch ----------
> 
> 50 lines (3.40 KB) of kernel messages per one run
> 
> [root@ccsecurity ~]# time ./a.out
> 
> real    0m5.227s
> user    0m0.000s
> sys     0m4.950s
> 
> [root@ccsecurity ~]# time ./a.out
> 
> real    0m5.249s
> user    0m0.000s
> sys     0m4.956s

Your patch is suppressing information that I want to have and my
console can handle, just because your console is slow, even though
there is no need to use that console at that log level.

NAK to your patch. I think you're looking at this from the wrong
angle. A console that takes almost 4 minutes to print 70k lines
shouldn't be the baseline for how verbose KERN_INFO is.
