Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41882081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e2pDqiEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41882081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeK2DvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:51:23 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:45639 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeK2DvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:51:23 -0500
Received: by mail-lj1-f171.google.com with SMTP id s5-v6so24050600ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSdzNyrZlNLknvXmeCxFm5B+Uf7bGShovX12Q+EAsk4=;
        b=e2pDqiEvjGn1QB9LOZPjxu+3ikT3Oa4B7iL5UvxyJG3kAB+0lUF5SZ9podtul/jft8
         XDKCP2HEtjSiu4lLX3kw4KaSLiPwgwQKhJlZiDbgougf+nTGYDSUotE9XSzr7nGqOrRe
         uq8ys2WtuBt6ReA7X0okyK3fCXtAnB8C35P34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSdzNyrZlNLknvXmeCxFm5B+Uf7bGShovX12Q+EAsk4=;
        b=GIai/rr4JNSdtWaTTdMUG9FIhTP0Tf0YU3kqX18xzk+tplN00Tj1vMLqthOK6wG/VU
         yhJ/KsKOeAsYbslyoKP80VtSxLkvr7zcATnHd6QJY5AUeXjjjwqfSl30r/Ac+UpyibrM
         YlMM0b0Lm7Eb0BYcTJfGxasydWf1+es6KvVphj60HGRXUXFUoZU8dYfoaPRGfjPI8d//
         Q4w8U67Mq2m4jJVd50+CY9pbhyC0hQ03rN0gD9+CRl9ncU1rETawo4R2lfcMbNbdUX/n
         ue5fdDHrl27sN1GTtbdfwgcfd1DIqE2nMKzCEgh8ufaZYzk+nEAgLfCBIejIh5uJHiE0
         KcrA==
X-Gm-Message-State: AA+aEWZz+eWNYsPbBxwTSCy9NtR7XElM0H4V1tBJE9kPC9LQ193gnIaX
        YRAxyQ3lz8hx/sskalvKubR6MD3L4aw=
X-Google-Smtp-Source: AFSGD/UZWkF33KLWjzZ8HpSs8HWeGips4F+eh8dO7M/9fQXzhsP3F/qqCTmDUm661ZmFdWsZZCXQCg==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr25602442lju.8.1543423744295;
        Wed, 28 Nov 2018 08:49:04 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 11-v6sm1186272ljv.1.2018.11.28.08.49.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:49:03 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u18so19867872lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:49:02 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr20753342lff.16.1543423742419;
 Wed, 28 Nov 2018 08:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com>
In-Reply-To: <87tvk1yjkp.fsf@yhuang-dev.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Nov 2018 08:48:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
Message-ID: <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     ying.huang@intel.com
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, rientjes@google.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 7:20 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> From the above data, for the parent commit 3 processes exited within
> 14s, another 3 exited within 100s.  For this commit, the first process
> exited at 203s.  That is, this commit makes memory allocation more fair
> among processes, so that processes proceeded at more similar speed.  But
> this raises system memory footprint too, so triggered much more swap,
> thus lower benchmark score.
>
> In general, memory allocation fairness among processes should be a good
> thing.  So I think the report should have been a "performance
> improvement" instead of "performance regression".

Hey, when you put it that way...

Let's ignore this issue for now, and see if it shows up in some real
workload and people complain.

                     Linus
