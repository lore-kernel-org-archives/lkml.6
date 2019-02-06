Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E814EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88E9218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="giZRZAzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfBFRbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:31:19 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:37925 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBFRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:31:18 -0500
Received: by mail-pl1-f180.google.com with SMTP id e5so3402496plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M7ZESgA117Kl6LnfeqS2MCqLt1s/mI0gTcjYckq38ug=;
        b=giZRZAzkmkBVhWAM/uex9MysvKvmQpTztwKM934OeE1o/Q7yWdaLaCT6lguXWRg+ZU
         dghk+jIylKwaKSON158y74S80W1v/+3yT8yJ+nwSPDTVqkR/AysyVUc60XyNcsDkIWhb
         nCq7NLI6EkXzNIXqLz7LxxgLg6pA/r+Zho4Wv0N3jN/mGs4Yf4OgiTDkBamT9bGzonup
         F01e85T0DM+FsQPHGLZ97HGEDnXEQeox4Z0txw11pAy0qwEJ75FT+q+C3znRJgfmBq1S
         7JWd+Myu3MSWS2UbuYGZ6rA4sHQQhZeKWkWONJoLxl0zmjiGnd+BnuD4ApXWZQ5Qm/CE
         z2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M7ZESgA117Kl6LnfeqS2MCqLt1s/mI0gTcjYckq38ug=;
        b=ojSFQE3N0sWpCfDr8WCvk/yYjgaUv/ImST4M1CGEUUYAfdzYbRkhY9dWwTZiRaLgKC
         NKRMTMPRMmmiYXDa6kpg24KfqLZPlCYYPqLgzKL8EUstKF6s5iSeXNCcxMDI1kq6G3+X
         M1C4bg+2zGr6Jmv0rfweBBcjlHT2LOGzNFw1fKN21mUUA4e84gbwavtZJ2qrk0mEGqdq
         4viO0p7f0h/JfQJo4wkTCzLwu4PS3TAgVvxyb3tLHTmiIOwhsUGgNwyUxQBF6H3jRB1N
         1l6Yytovgvp5T8H0dWr4G5qe9tIr1Pa8av+y1cdGA+s+EHVrSbFcZSaWA8uIBeEX+JYJ
         RqfA==
X-Gm-Message-State: AHQUAua6EogOB3VO92h05JyX9pGpRGCK/7RqW+pdfZoPWLRZIm+axMOR
        5ocTBiTXpBHx3nESSsmXSf7Rcg==
X-Google-Smtp-Source: AHgI3IZ124Xx0Cv7NJbPpRtVN9SOU/LG8DcJ+7oWMiz0MTcLVc/s2Ua3HZpgbB4LTQuLG6XqjooUwA==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr12090872pll.305.1549474277444;
        Wed, 06 Feb 2019 09:31:17 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id d11sm8242868pgi.25.2019.02.06.09.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 09:31:16 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grR2Y-0003x0-U1; Wed, 06 Feb 2019 10:31:14 -0700
Date:   Wed, 6 Feb 2019 10:31:14 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, lsf-pc@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206173114.GB12227@ziepe.ca>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206095000.GA12006@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:50:00AM +0100, Jan Kara wrote:

> MM/FS asks for lease to be revoked. The revoke handler agrees with the
> other side on cancelling RDMA or whatever and drops the page pins. 

This takes a trip through userspace since the communication protocol
is entirely managed in userspace.

Most existing communication protocols don't have a 'cancel operation'.

> Now I understand there can be HW / communication failures etc. in
> which case the driver could either block waiting or make sure future
> IO will fail and drop the pins. 

We can always rip things away from the userspace.. However..

> But under normal conditions there should be a way to revoke the
> access. And if the HW/driver cannot support this, then don't let it
> anywhere near DAX filesystem.

I think the general observation is that people who want to do DAX &
RDMA want it to actually work, without data corruption, random process
kills or random communication failures.

Really, few users would actually want to run in a system where revoke
can be triggered.

So.. how can the FS/MM side provide a guarantee to the user that
revoke won't happen under a certain system design?

Jason
