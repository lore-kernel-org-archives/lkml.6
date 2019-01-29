Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7D3C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464112184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bqv/NYzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfA2XTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:19:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42247 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfA2XTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:19:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so10422426pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVMgdFOdFa/I4N9PyKEfemOmqSGsE9eLQyaSPEIZUh4=;
        b=bqv/NYzz8Z3PfkBSZ0khR8s+Ikhv8bAjGDfZfAsKr0cYvLOvNl4p/lBENoK9jKtbBK
         0LGqePzhjJWF5MiCmkzcv4QzIsRtMaj5udtxUzNLGbf1T8Z0rfBSmwfVB/0+hTirJliZ
         iXCm6G6KehvWDNx9UXzEykSO/gvHCswwf9M0nQKFaCaNwiSUxJbqzhQ2I3/9ic7JNhTd
         db2AYu6ZHsP4Y06nGP0QrV8ql8TYVQLcqKVx2Fw/kY3ifjOcv2nzdy2OTKOORiDM0XBc
         m6dd0h9in9bbLz+V52UpSmW29qADs97NMsBJ+7ianAaBq+tX0zxyTy/YtZ4ScMR3YgFY
         nfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVMgdFOdFa/I4N9PyKEfemOmqSGsE9eLQyaSPEIZUh4=;
        b=EnAMJCJEAJLPac6WqaMhKdRsgTMpG7cHn8iDVL90q1W6tHZ7r8waJVxTFRBXKVFzbf
         +ihy2DDm+Z3K51F/lRvixsG1w/Sf6+s0J/Jr+oPp2/TXFczTuKp74/pgs8VRLwgi+VFp
         TOvBm5TUt0SHdgLwhU44Ute6K0plJDpJAPYOv8n2GFI80/3rUEyPN99guVSMvmCZcyZB
         eKXmI4bXkHf0NNQbL3vNBjBpxWc0RStHYZL8abaKxmgnVPQkrcV0e1M3RCbvegWnvTcq
         v3jX6JkBUE2t0LFkdf7nAfNRUQj+J23CiRpWUoM8W4fLpCIF9zanYiXMo/g9hGJgHiRA
         YjRA==
X-Gm-Message-State: AJcUukfCxil9rUYmbrqBW7Vzx3PSFKgRrNEvKySctm1dYkZycknjHVMQ
        9DPutANG0r7XNrOPiyKZJFrqLw==
X-Google-Smtp-Source: ALg8bN4vlgs6Ey3qXoCP5xMjiItYK8sdOidv0+c3ThlHFIF5qREgv8R63M+FeNhEYyAZGVWSBxZLZw==
X-Received: by 2002:a62:9719:: with SMTP id n25mr29096346pfe.240.1548803945424;
        Tue, 29 Jan 2019 15:19:05 -0800 (PST)
Received: from ziepe.ca ([64.141.16.251])
        by smtp.gmail.com with ESMTPSA id k129sm45370743pgk.29.2019.01.29.15.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:19:04 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gocel-0001Oi-7U; Tue, 29 Jan 2019 16:19:03 -0700
Date:   Tue, 29 Jan 2019 16:19:03 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
        dledford@redhat.com, jack@suse.de, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Message-ID: <20190129231903.GA5352@ziepe.ca>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-4-dave@stgolabs.net>
 <20190128233140.GA12530@ziepe.ca>
 <20190129044607.GL25106@ziepe.ca>
 <20190129185005.GC10129@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129185005.GC10129@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:50:05AM -0800, Ira Weiny wrote:
> > .. and I'm looking at some of the other conversions here.. *most
> > likely* any caller that is manipulating rlimit for get_user_pages
> > should really be calling get_user_pages_longterm, so they should not
> > be converted to use _fast?
> 
> Is this a question?  I'm not sure I understand the meaning here?

More an invitation to disprove the statement

Jason
