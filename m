Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E368C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098BD21479
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545962041;
	bh=qYH5nXiB7VtYJwX11IKtH8YK3mdVnesyo48B11TqTgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IKlgFDP4zWkxddXHc/DGyONbGcVIfcFbnlWDOa+y3TQLpoGo83C78tBfDgVAPL69k
	 b+vegjnQF6+y0zMs8pXB+SO+XDmD99XLA/fgSp5KmkcVwHMA9T1Roqifx260nL35wu
	 dh9Ss44b2pyHvy7gB7eK64uLYsR+oRUt1Jxb6WtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeL1Bx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:53:57 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42671 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeL1Bx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:53:57 -0500
Received: by mail-yb1-f196.google.com with SMTP id q145so6397565ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 17:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OH9MX3Sq0jk+b04xP5ckr2KqMpSRmTXQoGrW5fnfpcM=;
        b=nY8arMf0frjH/2g3XxKgiNF5g5BR7q095UWNgVVQvmAhXxgU47D5I95/Q9GE00yPtG
         B5Em7CwDVE3F0Zqybg2gQcEoUCSWpgFJMx1XbZx3GIYijZYbs8R4F5/ickH0RGpgdJRD
         32e9UG+Ke1j73hwq7WzbyIH1Gj86cj7xVkVU+eh9DcQI21ZFj/2I3Iuj+zfpJyJ7CB1j
         kzcEEFeUUKeJgdqkjaEvuDZQXgHt53qkPo0j1G8X785QWQ2pC3tprfQe6y60kd5ohWP9
         GjJd2RnssopurKA+P9jrGpzVvEkONYpSMSPOOB29f6le0veyQ/rrsG4+qZ60X+Q0GCMB
         T1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OH9MX3Sq0jk+b04xP5ckr2KqMpSRmTXQoGrW5fnfpcM=;
        b=txqZScloyZ98IisYOnqw6kaDlppVzXUGH47pyAkgkkmT4RVHOz1/wDtYmvjNbdSbVS
         CcRLfMV4Hv5ZMHI+WxH4tYsyrt1SkVmvJhQDRGAEZ5vAA7irrK6+/b8kPIArWewIOD6b
         2DlyUeMq0CzOSXdNJp+dSmmzwsD2bQInm+9cSb9/v3sT08H64C3Ho364K0e8siJZCDo3
         zcc0oQ450z3WVY1xwmx18Yq59945VPw6t4xRJXEEf65BRgMgW7MIVdooHprw8UNrS5wQ
         LLmmSyWDBzAPhCCqan7f8PFUB/q53BfYhNyuU+oH42w7xgznDvImGjxg+TqJwDQDX1hU
         Vghw==
X-Gm-Message-State: AA+aEWZisfTQKLjDLri4gsDTtd1XKngF+8gBh2VPEBJLRxntVbje+qmw
        clWpR0VcsvRMZ8vhF4a8b+o=
X-Google-Smtp-Source: AFSGD/XSHSiKusivYrLZNCd357i9zlM2CCIM1EvJUFXgPrBxPey6U2aTwZ0lyzYUsaL2pJBEunpv2w==
X-Received: by 2002:a25:4f89:: with SMTP id d131mr26272650ybb.218.1545962035919;
        Thu, 27 Dec 2018 17:53:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:7729])
        by smtp.gmail.com with ESMTPSA id c127sm16236550ywb.67.2018.12.27.17.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 17:53:54 -0800 (PST)
Date:   Thu, 27 Dec 2018 17:53:52 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
Message-ID: <20181228015352.GG2509588@devbig004.ftw2.facebook.com>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org>
 <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
 <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 27, 2018 at 05:36:47PM -0800, Linus Torvalds wrote:
> > Unless I'm totally confused, which is definitely possible, I don't
> > think there's a race condition and the only bug is the
> > tmp_alone_branch pointer getting dangled, which maybe doesn't happen
> > all that much?
> 
> Ahh. That would explain the list corruption. The next
> list_add_leaf_cfs_rq() could try to add to a removed entry.
> 
> How would you reset it? Do something like
> 
>        rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
> 
> for every removal, or make it conditional on it matching the removed entry?

Vincent knows that part way better than me but I think the safest way
would be doing the optimization removal iff tmp_alone_branch is
already pointing to leaf_cfs_rq_list.  IIUC, it's pointing to
something else only while a branch is being built and deferring
optimization removal by an avg update cycle isn't gonna make any
difference anyway.

Thanks.

-- 
tejun
