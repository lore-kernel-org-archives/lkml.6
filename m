Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D41DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D9A222D0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hA9VncW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439908AbfBNUMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:12:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34540 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391479AbfBNUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:12:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id j18so3651874pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ccxzyt/RMKZ2OOmgM+tFIm3eRFm02Zizg0pcCDEvEpA=;
        b=hA9VncW7abr9v+2utX/VkY1ZMwjjXa+hwVTodjREfjCiB0K7/Kc1hdBbZP6VIclrft
         XOlV/kBSodmvMnJmU6S+VCif2RbCUEwe4jiK021/ptlayI1p9QvtTplnf6hXcgW17wb+
         QnehE0OatJE+W6+9FVvKXjsQS9WlMlC81CJMTIZkDJ4RfuKrLjfzhp/2YUPNRFY/w0Lc
         aUTkEhbENTvNIWFJCqAuRCY2ROYZ4dZzB+xqdPWBbhLmA24jTl0pTqeeCY5bZatXCoQw
         abmHXi9B7hQUHXsFEubY8QrdE6yffwStU9kEa6Ykk1vfsXxhwe1xCEIBVbJx8CT9RHfQ
         tu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ccxzyt/RMKZ2OOmgM+tFIm3eRFm02Zizg0pcCDEvEpA=;
        b=IyFSNOBHJPmdxAacpBeR4PLFC/xN6G9W9dw5WplqFxkK+CamLTjNGqfGqyYKsP9fhh
         jDsnblVMHeqUVTV5385SCR7FJ0C4BGRzOHv9VwMdSLfQU01H9X3OEc/iM2P3LbWHJ8at
         ixGDD9bQv4SK7dJ5ktCxGtOQHvcrv5AmitWCyE1Qc/5HRtgVcx2tU3Uy/UlApZSKh7XX
         izXL2zl/MXoq3bn13C0EYreJUzzXgFPPzxKdSf5llQaHaLAGAGxD/LhioDPFWFuGAqqe
         ROXJ0RTPZjRRMHRGA4x3iHfZz+gtktlVKHrP34uBHgObeI1gbJaU1chM23Sw54AAO88r
         qpVA==
X-Gm-Message-State: AHQUAuZ/yeUeuKxDoeOxfwyR+2luGs+OWoF7ToIpc5mY8QIXrNZOzvO1
        8lVDiVlF2SCKrunWcFrf1JSC0A==
X-Google-Smtp-Source: AHgI3IZWZ0MGPLsLn4wrH2r78+5Tb6L2fudxI7tZh+KJRQfM13M8w4S/vvhozZ+3+r9nH+nNGegkWw==
X-Received: by 2002:a62:a1a:: with SMTP id s26mr5944270pfi.31.1550175153085;
        Thu, 14 Feb 2019 12:12:33 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q21sm8921770pfq.138.2019.02.14.12.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:12:32 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1guNN1-0007Ay-MB; Thu, 14 Feb 2019 13:12:31 -0700
Date:   Thu, 14 Feb 2019 13:12:31 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214201231.GC1739@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:33:53AM -0800, Ira Weiny wrote:

> > I think it had to do with double accounting pinned and mlocked pages
> > and thus delivering a lower than expected limit to userspace.
> > 
> > vfio has this bug, RDMA does not. RDMA has a bug where it can
> > overallocate locked memory, vfio doesn't.
> 
> Wouldn't vfio also be able to overallocate if the user had RDMA pinned pages?

Yes
 
> I think the problem is that if the user calls mlock on a large range then both
> vfio and RDMA could potentially overallocate even with this fix.  This was your
> initial email to Daniel, I think...  And Alex's concern.

Here are the possibilities
- mlock and pin on the same pages - RDMA respects the limit, VFIO halfs it.
- mlock and pin on different pages - RDMA doubles the limit, VFIO
  respects it
- VFIO and RDMA in the same process, the limit is halfed or doubled, depending.

IHMO we should make VFIO & RDMA the same, and then decide what to do
about case #2.

> > Really unclear how to fix this. The pinned/locked split with two
> > buckets may be the right way.
> 
> Are you suggesting that we have 2 user limits?

This is what RDMA has done since CL's patch.

It is very hard to fix as you need to track how many pages are mlocked
*AND* pinned.

Jason
