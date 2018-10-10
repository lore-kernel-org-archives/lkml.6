Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93067C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5659F214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m71kslpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5659F214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJJNLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:11:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeJJNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:11:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id l6-v6so3778280wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hkp+ch1zuhZ/k99xKJ8KCt8lOnOib9i8r2xb7jyZ7E4=;
        b=m71kslpaRLBGEDLY/ng3xg5DqFLPLz1pbDIr8k5GUyPGox/1EOFtqA0wzN9NvGxS9l
         YtfhUf3UDobC1pDX7zb683e/aEkkVEbYIsYG0Pl1pwLs/hVUzwg9JV65xQm5X2Q07s+g
         u/3/0T5r2oW68DTuJ7mXI2yq6XzaBMbdauUpOhgWwtsrRinS/ieMezBhv11dMCg68PhA
         St87bgq3UoMke44iFo59lY8qIaxy/HBWpU0FQU3zJ1glGboYkbycd/iHm0yl7dSmNlQp
         KQZpir3SZs5sfNMxIzzsi7uO9rqXc+j3iAR6fdK3isTnf536S1xviRn58NknrEKJVGr7
         la/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hkp+ch1zuhZ/k99xKJ8KCt8lOnOib9i8r2xb7jyZ7E4=;
        b=oNqfKuPFZIame2NRzWlwtZ9ssoITKDTKWi35jE1XCO2WFfLt/IXWTfsKk4WCIjD1yx
         GsZgQlwFkV0nTa+0DlWqAYgYY3zlGtSw/ZP5paB8vVs3+ZQ4OEkUJy0+f1FmMUsG++bC
         mBOiNxSJ2OaNWo0QJgs2BjvVaVxjeltQJR7T0cdW0Z21RCAv/vGZHd8QbjQHgnaeGukI
         C7eRGkHPgesiNa7L1zuxZm4t0nB5VCwqWyZXUPjYEJNfDKpNJbmoI9gWCoGkB1kAYqaI
         rvaJx9awgu43NoBJ3WbEUuV3js30CPRIYtsemnGFW9nO+/eYAczNxTXKFZYzgHwn+St4
         blLw==
X-Gm-Message-State: ABuFfog/3LWwKEHXIr3k3ydkwX2+ExulIj4L4ErgsDr/wyhWZxp+Ivnq
        yWTpr3BhfkN4DsxJ39z0lQnvDb9f
X-Google-Smtp-Source: ACcGV63+W/qBju/x3rFItAICDVscEbNppZhf/161DcfMHCYq/QaOYZr1xixL/Qa+423EqytMnzQlag==
X-Received: by 2002:a5d:5501:: with SMTP id b1-v6mr21362594wrv.228.1539150629557;
        Tue, 09 Oct 2018 22:50:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e6-v6sm19905120wrc.70.2018.10.09.22.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 22:50:28 -0700 (PDT)
Date:   Wed, 10 Oct 2018 07:50:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Sun <yi.y.sun@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        jgross@suse.com, chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v4 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Message-ID: <20181010055026.GA17688@gmail.com>
References: <1538987374-51217-1-git-send-email-yi.y.sun@linux.intel.com>
 <1538987374-51217-3-git-send-email-yi.y.sun@linux.intel.com>
 <20181009105427.GA102322@gmail.com>
 <20181010022536.GH11769@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010022536.GH11769@yi.y.sun>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yi Sun <yi.y.sun@linux.intel.com> wrote:

> On 18-10-09 12:54:27, Ingo Molnar wrote:
> > 
> > * Yi Sun <yi.y.sun@linux.intel.com> wrote:
> > 
> > > Follow PV spinlock mechanism to implement the callback functions
> > > to allow the CPU idling and kicking operations on Hyper-V.
> > 
> > > +#if defined(CONFIG_SMP)
> > > +	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> > > +#endif
> > 
> > What's wrong with using the common pattern of:
> > 
> > 	#ifdef CONFIG_SMP
> > 
> > ?
> 
> There is no difference between "#ifdef" and "#if defined". I just copied
> it from "hv_smp_prepare_boot_cpu()". Do you need me submit a fix patch
> after this set is merged?

It's equivalent code, my point was that '#ifdef CONFIG_XYZ' is the shorter, more canonical 
pattern we use in the kernel most of the time, it's shorter, easier to read. We only use 
defined() for longer preprocessor directive conditions, and it's a pattern for "there's 
something more complex here than a simple CONFIG_XYZ dependency".

Anyway, Thomas fixed it up in the latest iteration.

Thanks,

	Ingo
