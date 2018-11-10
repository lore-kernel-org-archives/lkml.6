Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312342081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RivphdJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312342081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeKJLy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:54:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39373 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbeKJLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:54:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id e4so5043639qkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 18:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mSp2o3TWDZ70zWO0CmvtqB3/VvSLxNKIO8y1G9VIxjc=;
        b=RivphdJnxwm9lBeQCNhxPYj1T1YFxcuY9PvgDRd3Lf42onfUJwGDsj8snErxU/OQEU
         ydU4DFtazXJJWObp0NvXppQ6hLPNIH3JP3I7QqQQyDbnNQTRcKlccOZ0X/04VSEYfv2l
         wJpOsb4mjK8DeVcdOMU+a7JYfndlBhctcWyiuAFyNHKkL28HQMHrMFkXj1847bav5gwX
         3hcwAn1hX4XGUTwwemO/e4zkt6SyoFDpiUYf+j/Qm50HB0d0TwauKGcLlrhHSc0+vVrr
         1rdkvnGkf/wNprueea+o/EqIAwR9Jt70apyJ6UmDd/VXto1N3wNEa4O0hcXI7VM3YJCk
         xS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mSp2o3TWDZ70zWO0CmvtqB3/VvSLxNKIO8y1G9VIxjc=;
        b=aXepzIcbg3TL0g7uNx/vL73R394uPqmWDfqtxrRs5Mf01Kf9e03ZRxjm1rIfGhOEZl
         BOH2yGZb8y09x4AW1QF6vcqj3Vo9YSzXfRL3Pg+OGf/Cz9c690H2rQmaC4NtktZq+tiO
         aNQWJVl6aQRT1jiMNxu4NqMskrgrIWgtIlMLn6TEq0lLfW5hu4TzIhBbpa4Y5F+6ROvC
         zlp4OfrxeWYFltff7adOofnTkoAu97ZSi4o/5BQpyz8BlaqrVCY8dBAX3/O1G8FpGZ7O
         29LnH71bwjc7YrNUnxD14LckMkOra3mcGOU891SOVZyNlk4HwoC56ZkJLk4bKyvvTXBo
         jGhA==
X-Gm-Message-State: AGRZ1gK67AS44ZB8CjdTVeAy9BqafMnBT3fjk9qYk4eOD6/kdHNqgNDV
        SiwwkEBa7gteIqdgmuIrPqiAgw==
X-Google-Smtp-Source: AJdET5f6l2Xpitck8MasW1uCvzG0P9fL8Id9FZu0wBegBrw+ARqZe662B1AgOXvJ3FmjwP1k3r22jA==
X-Received: by 2002:aed:2e86:: with SMTP id k6mr10546238qtd.292.1541815870523;
        Fri, 09 Nov 2018 18:11:10 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v3-v6sm6920142qth.74.2018.11.09.18.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 18:11:07 -0800 (PST)
Date:   Fri, 9 Nov 2018 21:11:05 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 6/7] mm: Add reserved flag setting to set_page_links
Message-ID: <20181110021105.ln7geexvln5ap5fg@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145279604.30046.5646399488589213615.stgit@ahduyck-desk1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154145279604.30046.5646399488589213615.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-05 13:19:56, Alexander Duyck wrote:
> This patch modifies the set_page_links function to include the setting of
> the reserved flag via a simple AND and OR operation. The motivation for
> this is the fact that the existing __set_bit call still seems to have
> effects on performance as replacing the call with the AND and OR can reduce
> initialization time.
> 
> Looking over the assembly code before and after the change the main
> difference between the two is that the reserved bit is stored in a value
> that is generated outside of the main initialization loop and is then
> written with the other flags field values in one write to the page->flags
> value. Previously the generated value was written and then then a btsq
> instruction was issued.
> 
> On my x86_64 test system with 3TB of persistent memory per node I saw the
> persistent memory initialization time on average drop from 23.49s to
> 19.12s per node.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
