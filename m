Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C22C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16E220C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G3us9/xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16E220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeJAWJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:09:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35816 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbeJAWJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:09:24 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so4948960itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=egz5UaCHM4kavXJolPXkFKphUnyDndM4NLb6iC9iBcQ=;
        b=G3us9/xzO7czjVNMLY+S9Z1vjhgR85+fm9VrhLhfBJfzFOxkrGyli0WNOTc6E66OFf
         6b5mo08qVw6HLOdGiCRjzjUPAzN9R3i8GSjog+n9coaBALIQTkdUkPcaJhIweG4GPZ+R
         a4/VInlPpnSJv2bnnxd6U1ZYG93ObUKmXA1Obb/Pje2Ez5hqCJODBzR0b4pt8dW16DtG
         RjWXkCC36Yq3cliInFCKnOcYx0Zm/IGEReF3eZJdbqAjaZ6JJEtLT/wYRF0Rn7wQxC6y
         ZhWuB7e9L0UyT+ueVtV+Hlw2ZJL0pxxEt76S8/kFwRLbe4vrFJVf+0XYnz43JGxhm8tT
         WAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=egz5UaCHM4kavXJolPXkFKphUnyDndM4NLb6iC9iBcQ=;
        b=kQlgkOi0l/EoyeDMstS/5lPhz8/spK6m2OZfbz+9Em6meib0+EMA57yrsqgjugRQe7
         BhBVm0qBEQbY/FZpC3LW+kW7eIfaWR3KoU84lp4Wg30nQI6Nz0LMF5HOZg2ZXWmOqcjz
         aPOnpwpfXPzeSaD1pmVDgvRvCuVK1z3c3bdEpwObl9yfR010q5CsFeLh3qol7dv3ozSb
         mFNTUGQkydUlj5lFyr1lF1RZRsQXz+FZGM+5QSCaCKLYgdt9am9cLLHBlTJCyJEp93vM
         fPZaMWZZZia05pkxNSIrUb7DCeP4znMi0m8VBKhIpYzNvV/b/NsC1nxBuL2Zj2uZXE8V
         hMSw==
X-Gm-Message-State: ABuFfojD8a7Lc3XH41TD3MzA1oZPn4fB0skcoGoJzJpALW6aLMltXVdj
        x26fUH/j6R9uazgBwgXhlM721Q==
X-Google-Smtp-Source: ACcGV607DdKJYv99zEkgeCdk7fAnfuvb1o43Gv0ra9gFr+MUik2Pkk75hK0fPy+asQznD6zyNx/g+Q==
X-Received: by 2002:a02:129d:: with SMTP id 29-v6mr8771876jap.126.1538407863283;
        Mon, 01 Oct 2018 08:31:03 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q205-v6sm2555646itc.2.2018.10.01.08.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 08:31:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g70A1-0006Me-Lp; Mon, 01 Oct 2018 09:31:01 -0600
Date:   Mon, 1 Oct 2018 09:31:01 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/4] get_user_pages*() and RDMA: first steps
Message-ID: <20181001153101.GA23286@ziepe.ca>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928152958.GA3321@redhat.com>
 <4c884529-e2ff-3808-9763-eb0e71f5a616@nvidia.com>
 <20180928214934.GA3265@redhat.com>
 <dfa6aaef-b97e-ebd4-6cc8-c907a7b3f9bb@nvidia.com>
 <20180929084608.GA3188@redhat.com>
 <20181001061127.GQ31060@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001061127.GQ31060@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:11:27PM +1000, Dave Chinner wrote:

> This reminds me so much of Linux mmap() in the mid-2000s - mmap()
> worked for ext3 without being aware of page faults, so most mm/
> developers at the time were of the opinion that all the other
> filesystems should work just fine without being aware of page
> faults.

This is probably because RDMA was introduced around that time, before
page_mkwrite was added.. It kind of sounds like page_mkwrite() broke
all the writing get_user_pages users and it wasn't realized at the
time.

BTW, we are hosting a session on this at Plumbers during the RDMA
track, hope everyone interested will be able to attend.

Jason
