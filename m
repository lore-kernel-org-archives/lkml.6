Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7824720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nVsa7lI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7824720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeHaTfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:35:10 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44179 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeHaTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:35:10 -0400
Received: by mail-qt0-f174.google.com with SMTP id k38-v6so14931200qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ehQWXVB9CUEK8Dd/OdxgyGILgSG54iuToHUqmjdn1ck=;
        b=nVsa7lI1KmWNAA1Dx6R13JKqqhSud5b+177hLCUxcUSeQx0KU4G755vYcDRPyWZkzp
         ZX1jKHBOHGcaGA6FxRuwI1UlaXmsS7UyHaHYbIcChjNqONYPkuxtlRFcTmlbQAUVv/Dk
         rBqugJeJvCttbgtYbzsbDPekpVSuOJ6VwWE+W38ENqrorTbS+703QJUo/oWWHVH2vBk9
         /ko0jJCj9WFIpZA6cHyleYPiUqXe2T/Z/1srrGRdEf12DwD/bgIY/mhZoV5D2CRTmqUL
         DLBQ88unB5WpChALu37MzvXD8j+yDjtFUEGP5qo0b/ZlwKQyYw8e0xAQdNuc4FoJYBoR
         WorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ehQWXVB9CUEK8Dd/OdxgyGILgSG54iuToHUqmjdn1ck=;
        b=Okk/brCivRNafGx0OvMsngqYqih960LIf92QsNCbm/KJDtUq05l7gRykwGQerJ/bmd
         XG88Esdz1yjwEwYz2n6OyVrx1TzvU839gZBG0FwCbmikDHOOc9Pxn2sbVd9KrZN8iYm/
         9Zub1O6KqRnlbE9bvW0JCq0d7pPJWC3/U3lZb+FfHxql1GJPRJad0BUOqHhaYbcs3ZAw
         zKrKJB7Nt92TieICNjoDciaIiXIqgZBEu8Als5d/8mSNyPCgRP9Ot/CD7eT3anLq42X4
         KtVhZsQTnxZ6bPj8NCqVsliMx4EDITxxV1dN868elgqXSpE23T9nIE7mk2dwoWdSb9FX
         zQPw==
X-Gm-Message-State: APzg51AKxBcv6UJrWzVI6tJSxEP20zp12bgfaXZy8gOIxiRObC+ddDzo
        o+47/aewFm+gSsD8iVcrYvb3ww==
X-Google-Smtp-Source: ANB0Vdb4irYBtKvvxAM9gKbx5TwQj+gn6kJLY7vljWylpgaXJf1xqTVI35svc4CYagEPcg/TAxm4Ow==
X-Received: by 2002:a0c:8b11:: with SMTP id q17-v6mr15943460qva.193.1535729229327;
        Fri, 31 Aug 2018 08:27:09 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w30-v6sm5772674qtc.51.2018.08.31.08.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:27:08 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:27:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 02/15] blkcg: delay blkg destruction until after
 writeback has finished
Message-ID: <20180831152705.4mjm7xo6jq7ptdqn@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-3-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-3-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:43PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, blkcg destruction relies on a sequence of events:
>   1. Destruction starts. blkcg_css_offline() is called and blkgs
>      release their reference to the blkcg. This immediately destroys
>      the cgwbs (writeback).
>   2. With blkgs giving up their reference, the blkcg ref count should
>      become zero and eventually call blkcg_css_free() which finally
>      frees the blkcg.
> 
> Jiufei Xue reported that there is a race between blkcg_bio_issue_check()
> and cgroup_rmdir(). To remedy this, blkg destruction becomes contingent
> on the completion of all writeback associated with the blkcg. A count of
> the number of cgwbs is maintained and once that goes to zero, blkg
> destruction can follow. This should prevent premature blkg destruction.
> 
> The new process for blkcg cleanup is as follows:
>   1. Destruction starts. blkcg_css_offline() is called which offlines
>      writeback. Blkg destruction is delayed on the nr_cgwbs count to
>      avoid punting potentially large amounts of outstanding writeback
>      to root while maintaining any ongoing policies.
>   2. When the nr_cgwbs becomes zero, blkcg_destroy_blkgs() is called and
>      handles destruction of blkgs. This is where the css reference held
>      by each blkg is released.
>   3. Once the blkcg ref count goes to zero, blkcg_css_free() is called.
>      This finally frees the blkg.
> 
> It seems in the past blk-throttle didn't do the most understandable
> things with taking data from a blkg while associating with current. So,
> the simplification and unification of what blk-throttle is doing caused
> this.
> 

So the general approach is correct, but it's sort of confusing because you are
using nr_cgwbs as a reference counter, because it's set at 1 at blkg creation
time regardless of wether or not there's an assocated wb cg.  So instead why not
just have a refcount_t ref, set it to 1 on creation and make the wb cg take a
ref when it's attached, and then just do the get/put like normal and cleanup as
you have below?  What you are doing is a reference counter masquerading as a
count of the wb cg's, just add full ref counting to the blkcg and call it a day,
it'll be much less confusing.  Thanks,

Josef
