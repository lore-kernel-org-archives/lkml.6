Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD56C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01392215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ9akfxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01392215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeI1PYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:24:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35653 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbeI1PYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:24:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so3894780pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O09vzjwHWw+WWJWREqPhlZsqMNEB5sDf6xCLrkuFad8=;
        b=lQ9akfxNyoDUh5Ncr8SZKySmSXO586Y1rynuq6PFaTEos1R+GWnG67NfLATVeY9XgG
         ikwwzAHmy7DkbkHyiK97uUxJu053tRydHRQv1GoojWHlge2K+1a0VVrGFaA/3ekyEv90
         6I75GYt3gGsaK9t62QXVw+Uw/HHTZboCe1ybVu7TOOh4eoHIxyq/Z5z7leEcZ9GxmEkS
         qUrfvakBPCt5E9tsiGcSsGH/7tC8LWzWf7F5AeUy9IktzKvQGG17viIf+U5FAGa1f5Dr
         H0RUuKQX0r/+jLGpbe6EpzIstDc7DS6s03QTCNm7nwLyr8rGCVCYceja4yXrsJNuBQxv
         jDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O09vzjwHWw+WWJWREqPhlZsqMNEB5sDf6xCLrkuFad8=;
        b=aoXPhdKcDFbJn76g92iV7EOVZqWBrXIS9Bn4+8E2U5MBJkJxKarIN9bfvLeIs2a1N2
         R7mSUWzMUegBgk2RqlDnft8+wK72aobouMTGLKBu2z6ge4GC1sXeWmL3wwFc6G/HqzR4
         eRQ9BQRc6pISf+Zm5Zghb9kH3BkYkkCjlhi8TdeSvx/xLOPZHlNPOnwEdehIdThuLYH3
         6SVBTTvFSpOoSIKGv4Wr9AqwedglBdlCAI+Rq21fXoNRe9cIqK+873nAG/2+PhYs29jz
         1f8L/6CDucNKUuEWUY/LXUVq79K3LEtY9YCCrIIEO0hIJuCHaCT498afFKrLnps8a0TA
         nqZA==
X-Gm-Message-State: ABuFfoifTacY3M3zjcJ7yTw7pRZARwGFwd58baaieW/NGetaOEta/m7a
        w1JXk6Pj7resXM7YucgakDQ=
X-Google-Smtp-Source: ACcGV60PYPr/2tac8ifexoteTDFIZgDBNyivged5o2q5i7aOH92i7ZfxP96yREnYwbpjIgQSlCfK/w==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3-v6mr15102885plo.218.1538125329353;
        Fri, 28 Sep 2018 02:02:09 -0700 (PDT)
Received: from localhost ([110.70.14.151])
        by smtp.gmail.com with ESMTPSA id p1-v6sm6390936pfn.53.2018.09.28.02.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 02:02:08 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:02:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180928090204.GD1160@jagdpanzerIV>
References: <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <758bcf74-f9d6-d3c9-be10-34046166504b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758bcf74-f9d6-d3c9-be10-34046166504b@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/28/18 01:10), Tetsuo Handa wrote:
> 
> Therefore, I think that "Either we need to require synchronization - umm... and
> document it - or to provide some means of synchronization in pr_line()." is a
> pointless worry. It is only existing printk() API which needs synchronization. I
> think that line buffered printk() API does not need to talk about synchronization.
> Just saying "don't share DEFINE_PR_LINE()/DEFINE_PR_LINE_BUF() variables" will be
> sufficient.

Agreed. My conclusion at the end was that - "pr_line is going to do as much
as seq_buf does". So pr_line won't provide any additional synchronization
mechanisms.

	-ss
