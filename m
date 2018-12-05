Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BB5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0052084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="G06wlS80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0052084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeLEO6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:58:13 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:36698 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLEO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:58:13 -0500
Received: by mail-yw1-f50.google.com with SMTP id y194so8644569ywg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=auCTWlcBjnZ+Hn8L2m/MKYXaykQkLs6fYQGWnJfDqd8=;
        b=G06wlS80R/aeh5J7gjZYQAXa0mGnQ/irpfOV5ac7TN9h9gJPRYVAvfEB/mpKa2l3W0
         UzrJpvlx4qR4+yD64hS1Txbrhw347fl6LGK8HHU4XETZDuhgWq9q1LK90jIu+ccbQvN1
         wz9lx5NuSJo7yyBjQ55V1+QEbMi6GPJ216yg/pzJTIs0ivzPKptyCi/XTMQMQYsVnyrr
         y1w/ZSzTovWUg3SKQJSY0LNmvhJqHG9Fi6uD8VF/iMjJzGje1JJId8HBxh5rkLxP9zEZ
         Z5l/Ju1jTTDtwRzPOxvy55dzqzU8N9OGfDFdB3vZ+WGgKVkPJYJdwqd7z+hlpoFdTKC0
         4xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=auCTWlcBjnZ+Hn8L2m/MKYXaykQkLs6fYQGWnJfDqd8=;
        b=gK3lb8r6tagPShO+Ir3KCwFB86SG2OGPKvp+RtUAZ6GNmP4lOXB10B9bHgFgOTVTYo
         230Xurvik9K8IMJQ3Rh9JaaiZgQ1d+r7a4aKyg4/oFlaGxXLNUibxPYQy87njPDe7h17
         cQdf1OSWXxrelLJ8d3n9mfL8i3aac+nEOPx+YcvnRdhTt03kgYnBv53/ukzqIbZMEG0r
         CsIFK+JAIxxi/tVijdknmNeJaggy7q82ytRvESlwf9PAH0WglBaJXpL0bOOpcMEJB/NW
         hheDEhq+Mn4Xe4UACUhEzxNbZ0x3kWUDbxWVVpqnZAtZdn8xYnBdD+bafSc40SPebcYr
         LM2w==
X-Gm-Message-State: AA+aEWYEM0BpIsZJZfPNH0CpqrloQNFkVqvuAKvfq056B/+hpQ4faHkI
        NKgwnC4KZ13x8h8L2RDXecE7pg==
X-Google-Smtp-Source: AFSGD/X0x81SoZxA4f43JIlp0hPQPGrdc0IX1fTbGQRDLGgfdcDxaVllc9xpvVfU6eFsFl8cHJSW/Q==
X-Received: by 2002:a81:4853:: with SMTP id v80mr24708584ywa.266.1544021892203;
        Wed, 05 Dec 2018 06:58:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j186sm6185858ywg.36.2018.12.05.06.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:58:11 -0800 (PST)
Date:   Wed, 5 Dec 2018 09:58:10 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: Re: [PATCH 4/4] mm: use the cached page for filemap_fault
Message-ID: <20181205145808.kzsro4a7vqaxx3cu@MacBook-Pro-91.local>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-5-josef@toxicpanda.com>
 <20181204145034.4b69bdea36506be45946f8c9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204145034.4b69bdea36506be45946f8c9@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:50:34PM -0800, Andrew Morton wrote:
> On Fri, 30 Nov 2018 14:58:12 -0500 Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > If we drop the mmap_sem we have to redo the vma lookup which requires
> > redoing the fault handler.  Chances are we will just come back to the
> > same page, so save this page in our vmf->cached_page and reuse it in the
> > next loop through the fault handler.
> > 
> 
> Is this really worthwhile?  Rerunning the fault handler is rare (we
> hope) and a single pagecache lookup is fast.
> 
> Some performance testing results would be helpful here.  It's
> practically obligatory when claiming a performance improvement.
> 
> 

Honestly the big thing is just not doing IO under the mmap_sem.  I had this
infrastructure originally for the mkwrite portion of these patches that I
dropped, because I was worried about the page being messed with after we did all
the mkwrite work.  However since I'm not doing that anymore there's less of a
need for it.  I have no performance numbers for this, just seemed like a good
idea since we are likely to just have the page again, and this keeps us from
evicting the page right away and causing more thrashing.

I'll try and set something up to see if there's a difference.  If there's no
difference do you want me to drop this?  Thanks,

Josef
