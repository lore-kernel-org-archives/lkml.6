Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C95C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE052081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpc/xs9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfBLXjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:39:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52714 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfBLXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:39:01 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so1253532itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzWjMapjpHtL53gMYeYkX51A6xddEI4xv6rvmvwj2Y8=;
        b=qpc/xs9wOLlkmb0meKC6FJ4tHHCLwOYiuTAtd9Jcd44iX8RcPbsjFQl1D5LXp2BaX0
         IjrAVGZU5xhGg4v4bjXbd9iYBWXjN2hOzGXh7YkWFIumGYXM0PpC+XTnfN/yo+Vl6cED
         anICUkhTT3LpULayddUzpgUhwJ8cKmNW75SO3E4qygXJST+sFZyLi9N19Kyhe1l084CB
         i+JZVRf2kxRNM637Eek0AO56n9qF0MSuelzgO96HH9mbKV9YUCxLpDpBK+sNFm6ynLyv
         aybZByVB17I6nLomlP6HDugC5222sDt5H+qYEwIIxSgJO7d8OHOXvBGklwhkGt3gW/dO
         j53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzWjMapjpHtL53gMYeYkX51A6xddEI4xv6rvmvwj2Y8=;
        b=Zm6J6jGopJ69V8ckEunZk4skrril/yA5HfCD125YLvD4aTWNqa33F1XHmsdynXMKlW
         zQurRBU79dOPClvp9hIuTKZtmsv/MvItg2rjQmcJ+BgCxF0iVkWZ1xgLJBFTbN1rCod2
         be9F1DUgSdSAOHBXMr5EYmjmgvVFRU2RpyvNdfaxTalWB04fqCII9XKTLNsnOdeHxiBF
         lqbcax7XWjalFzH7QKZNHFyylbTBioARp9HbtJoxNHSykdIOgpIVzpDwwtn196+4EAIN
         R7co5ukVkjZv37ErA2Cuj0wZqEZNQ7tvO0loxbvRNU8MZExbiSGhKmRCBJ+2Y22tlDxm
         aSGw==
X-Gm-Message-State: AHQUAuYolFs3VeCVIJzj1lrwDCTNrnWOQc+Y1o7oG7Vbx3jaBJ749Hbs
        ZSAzZPxB16EoGxpa3VsiELHYEg//9yHNww==
X-Google-Smtp-Source: AHgI3IZIL9KMsQ3+LVt7/qFsKjAHiWCiADAHvidShmN5/0ux8jJUd9wdU5VmvvH2XUe0BCQaFNGdCQ==
X-Received: by 2002:a24:5f4c:: with SMTP id r73mr932306itb.25.1550014740954;
        Tue, 12 Feb 2019 15:39:00 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id m25sm6601078ioh.74.2019.02.12.15.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 15:39:00 -0800 (PST)
Date:   Tue, 12 Feb 2019 16:38:58 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix potential build error in compaction.h
Message-ID: <20190212233858.GA95899@google.com>
References: <20190208080437.253322-1-yuzhao@google.com>
 <20190212120358.GC7584@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212120358.GC7584@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 01:03:58PM +0100, Michal Hocko wrote:
> On Fri 08-02-19 01:04:37, Yu Zhao wrote:
> > Declaration of struct node is required regardless. On UMA system,
> > including compaction.h without proceeding node.h shouldn't cause
> > build error.
> 
> Anybody requiring struct node shouldn't depend on compaction.h to get
> the declaration.

Yes, but the problem is the other way around. Build error happens
when somebody includes compaction.h without definition or
declaration of struct node, if CONFIG_NUMA is not set.

compaction.h already has struct node declaration to avoid the error
when CONFIG_NUMA is set, but we need it for both cases.

> Anyway have you seen an actual build breakage?

Yes. I ran into the problem while trying to include compaction.h
in this order, and had to move it to the bottom as a workaround.

#include <linux/backing-dev.h>
#include <linux/compaction.h>
#include <linux/ctype.h>
#include <linux/freezer.h>
#include <linux/hugetlb.h>
#include <linux/kstaled.h>
#include <linux/kthread.h>
#include <linux/mm_inline.h>
#include <linux/mm_types.h>
#include <linux/module.h>
#include <linux/pagemap.h>
#include <linux/sched/task_stack.h>
#include <linux/swap.h>
