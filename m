Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3045CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E838F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoKWNFpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfBYDRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 22:17:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42896 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBYDRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 22:17:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so3782500pgl.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 19:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3hqHXO72C1pMmktCE8lDSqZjAXGOL5gPjm/u1LuEqsY=;
        b=WoKWNFpeqO+9fJm+2Yykir+w7q1YpgJzrgrV1TLQpDdpFmIRO1Yb3HtpcNunjefWyi
         XrGUEdpzhQus31HR1KKKggztb5ep5ykid5pc/fHos8M3Qy/Ps8+Blv6tBCVl62WqgC0a
         0cf/NA5ognbk8avb0S5nsdadfj7+dxgThg2P04Ig7eagYQ1zU9NTNpWbJ8LFhObHmAni
         /CG2wPPAcPTYl02+k3+y8p39P3RjArvOZRwaFAvkG183MdeYw9VOQFxYGWlPXZEXbmkd
         f3X+Ca9qpXCk+FqSuj/QKHlzViXfMOCf3wKPN7brAcmBf8AZc6Tjqlx6xGZSQBIy1F2t
         LmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3hqHXO72C1pMmktCE8lDSqZjAXGOL5gPjm/u1LuEqsY=;
        b=aBkpEzQ/Xl3CMBzmAm4YWShw104I6PISzJLNrzVr9pvzNw3oHqfMxcOm0FRuL4yCaO
         L3bhqxpA+eS0eSyRmomwsOpo/ggmoGaqV3292Vte5ITmOmnv5w5dPma7CYYhi4i5l7U/
         52QtYqG8VEpAKG129vjy3DynyF/tt8kzkMSZAQl+pJihlt99dZkx9x3uD8We50pZjHeu
         kQuwRirSp9s6WOG6mGpJ7LAdsp5Q+IXRxp3Q7cAMmWkH+r/SvN7Xolp0Twcf+IEs/mwH
         0sprMCon100C397CY+axqU5bDyCn2I2uJWpXG7RIMv7NJoG0hu0RHmBVLtpdUyIuhP4V
         UtOA==
X-Gm-Message-State: AHQUAubDg7N2VMrC5UIHmDxnPL6bTU3qdEEzVqZLauQa+BlAVT0ufNZ2
        UBiUvOaksWEP4+dy4AAkqNZfzw==
X-Google-Smtp-Source: AHgI3IarpUOFmYuEpyRHfr1TTUj3VJC5J9dXE2KcUUmtr5uYHVHSVePdSPA9VM7bLBhpyy9RGPODUQ==
X-Received: by 2002:a62:864c:: with SMTP id x73mr17991591pfd.49.1551064667030;
        Sun, 24 Feb 2019 19:17:47 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 10sm15814929pfq.146.2019.02.24.19.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 19:17:46 -0800 (PST)
Date:   Sun, 24 Feb 2019 19:17:45 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        n-horiguchi@ah.jp.nec.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
In-Reply-To: <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
Message-ID: <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com> <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019, Mike Kravetz wrote:

> > User can change a node specific hugetlb count. i.e.
> > /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
> > the calculated value of count is a total number of huge pages. It could
> > be overflow when a user entering a crazy high value. If so, the total
> > number of huge pages could be a small value which is not user expect.
> > We can simply fix it by setting count to ULONG_MAX, then it goes on. This
> > may be more in line with user's intention of allocating as many huge pages
> > as possible.
> > 
> > Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> 
> Thank you.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> > ---
> >  mm/hugetlb.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index afef616..6688894 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2423,7 +2423,14 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
> >  		 * per node hstate attribute: adjust count to global,
> >  		 * but restrict alloc/free to the specified node.
> >  		 */
> > +		unsigned long old_count = count;
> >  		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> > +		/*
> > +		 * If user specified count causes overflow, set to
> > +		 * largest possible value.
> > +		 */
> > +		if (count < old_count)
> > +			count = ULONG_MAX;
> >  		init_nodemask_of_node(nodes_allowed, nid);
> >  	} else
> >  		nodes_allowed = &node_states[N_MEMORY];
> > 

Looks like this fixes the overflow issue, but isn't there already a 
possible underflow since we don't hold hugetlb_lock?  Even if 
count == 0, what prevents h->nr_huge_pages_node[nid] being greater than 
h->nr_huge_pages here?  I think the per hstate values need to be read with 
READ_ONCE() and stored on the stack to do any sane bounds checking.
