Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3471C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BF12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B1ITolKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfBKUkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:40:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39038 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfBKUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:40:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so108013pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmT5nD2I7+KtQoUhHdkWUj1QqpObX7iHadIUM12uKwc=;
        b=B1ITolKJ1NS4xWfX0ir0qavniH14XixPsbTXipQBHAPuub4IrbOyhFf0bD4uP6LHdP
         yS1+dqUDzMVRvcvJyextDm7A370NcmuJxo2Gaef7ePt0XpBqOhxFxX2iUaAV1qVgKD0x
         8m6rTHR7HFmADoOKyZvx1yyE1yoP+SI6StmEGtj2HeWi9jPom6Dy0b1cc6gXri860E8S
         kQHnEctpa1aRKDiRprtEqWIL+49NLbsmfIpDYRnY35OR5Uu8inRWQLauyDfY8jHwPyGK
         jQ5I0OxQrq32U5sCooP0X45Cvj7bJfLsaMeLrt/1ey7bbz7qywYulUwwn2Yi6R+AfX6q
         36Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmT5nD2I7+KtQoUhHdkWUj1QqpObX7iHadIUM12uKwc=;
        b=NOtlIRJKlXgDLBmrCqqrgiMsl+j8Lo+07Vpb1BmtlhJ6hJlIaN6eClH1YIexxgiKnR
         D4v03uSeYnnZBl5zHz5rN/nbzhevpx4UtrVR8tMQEp58FP5MxPcPbCjny93B/82ICPNr
         WotQvaDv7dm9aUh7h9Llc4J3WDGmSF/y0EZqSTyNLfmhpjuQqMnt9ynSYAaPsD9fetX2
         x+TEzZzW3KyrTvOE/bbakHc8mdf/jSN0oi6alVMmAZ3MAyJm9CTgvRjvcmYO85A5iDbP
         SD0qCETjzg3Qtc+ZMlyWR+skNUca7Zj2nm2sBfzIU0kxpWSG+8Ut+Xw+xTKGTaqJ7GaP
         FPBw==
X-Gm-Message-State: AHQUAuYXQhl+KZYo1Sbd3ICN/kakb+QiU16yBO5d0A1Crk2rvJh2hzfS
        rJpPBp9fwUy4oLtDV6jpYP8RsQ==
X-Google-Smtp-Source: AHgI3IarME8mMwsDqp9azcXs3o7IJfhcXGKpA1KdQX8w0bLUJH9217uYklkSnkg2apnHfTrwcJGclg==
X-Received: by 2002:a65:5243:: with SMTP id q3mr66002pgp.385.1549917650694;
        Mon, 11 Feb 2019 12:40:50 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m67sm19694020pfm.73.2019.02.11.12.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:40:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtINl-0000l1-L6; Mon, 11 Feb 2019 13:40:49 -0700
Date:   Mon, 11 Feb 2019 13:40:49 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>, netdev@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Message-ID: <20190211204049.GB2771@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211201643.7599-1-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:16:40PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> NOTE: This series depends on my clean up patch to remove the write parameter
> from gup_fast_permitted()[1]
> 
> HFI1 uses get_user_pages_fast() due to it performance advantages.  Like RDMA,
> HFI1 pages can be held for a significant time.  But get_user_pages_fast() does
> not protect against mapping of FS DAX pages.

If HFI1 can use the _fast varient, can't all the general RDMA stuff
use it too? 

What is the guidance on when fast vs not fast should be use?

Jason
