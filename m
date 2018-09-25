Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB9420842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sjQkco8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB9420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeIYQzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:55:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42841 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYQzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:55:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so10967035pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8FpidlBw8XsDPMFDJ/TQAPEhEZNcMoc00nevPCX9C8=;
        b=sjQkco8Ke11f5M/5k1LGAu4QHSsmIkkN4N3+3cQpo1HcS7iw5153FPNpN5y3UjDF3r
         JeIFBlWune9rMhzwRW2Pl1DwJAHAapwo9N1FDzLAKrmnpZy+47KfXRaXu0cM5aElYl4h
         Iwn6XuYaON/LA9G3onDruL31irpr+EF26vi/eDuqy+4G3w/3w+aE7DBnvdjdEZb23kFl
         V/gnXUiyu7mPcEwnWKNfNhj8XuEDMEgrVlIppQfNEBam+Zn5NHFrosVq5IuteUGo/7Ko
         6tl5K0oRSQHSdB2KaBVhfgNzICQcVD8gJ319pKOE+imCfBq4ZjIRoK+2URZP7ubKfNvk
         wKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8FpidlBw8XsDPMFDJ/TQAPEhEZNcMoc00nevPCX9C8=;
        b=ZiQF36eu+UaYiIW32UsbJzmIbOi5wiL7/0jKr2E6bdTYMLlM1eJ2jPw9bkP6JeYva1
         oSBXmQxCmEMmO/NkF1bqsjjKFhfko/9B6sBhrEZ3j0OXf/nw+450U04ALwsqAjpKj96X
         zSe0+jLdhzeVXLI2EHCjXiDWd5VT7VEs0pu8S9d4GTm/3t/kFviT7OUVQYVIa3lBE2+F
         Ug46+3pd1E+cVmgdM4gAklUwxR939mQ2t+AVbEvCy8Jr4eZqFfQMHulyb7IX53y3PeOQ
         l/5KPm2cG7RL1SPfj3WO6jW5mLIIDaYZqGuWI6CUd0mGPxk2jw4sHTyaUAnw0HDMvhNz
         EzTg==
X-Gm-Message-State: ABuFfoiKnXaz452hzcKu2f6MF7aSYv0+ysUdQG0cPXSSppsG6bkhyXw5
        g2vQKkJHHNA1M4zmMd049Ks2vQ==
X-Google-Smtp-Source: ACcGV62myqUgDWVKJyF8q+MEveFwS1h3En9ayml5lN5zXtKEV+OZatGuslm8jNYdGHmPc7ybHHZLOw==
X-Received: by 2002:a62:2e02:: with SMTP id u2-v6mr543380pfu.134.1537872515205;
        Tue, 25 Sep 2018 03:48:35 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id d63-v6sm2829542pfd.94.2018.09.25.03.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 03:48:34 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 0A05B3005E0; Tue, 25 Sep 2018 13:48:30 +0300 (+03)
Date:   Tue, 25 Sep 2018 13:48:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix COW faults after mlock()
Message-ID: <20180925104829.jld5xd6evr7uhwfw@kshutemo-mobl1>
References: <20180924130852.12996-1-ynorov@caviumnetworks.com>
 <20180924212246.vmmsmgd5qw6xkfwh@kshutemo-mobl1>
 <20180924234843.GA23726@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924234843.GA23726@yury-thinkpad>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:48:43AM +0300, Yury Norov wrote:
> On Tue, Sep 25, 2018 at 12:22:47AM +0300, Kirill A. Shutemov wrote:
> > External Email
> > 
> > On Mon, Sep 24, 2018 at 04:08:52PM +0300, Yury Norov wrote:
> > > After mlock() on newly mmap()ed shared memory I observe page faults.
> > >
> > > The problem is that populate_vma_page_range() doesn't set FOLL_WRITE
> > > flag for writable shared memory in mlock() path, arguing that like:
> > > /*
> > >  * We want to touch writable mappings with a write fault in order
> > >  * to break COW, except for shared mappings because these don't COW
> > >  * and we would not want to dirty them for nothing.
> > >  */
> > >
> > > But they are actually COWed. The most straightforward way to avoid it
> > > is to set FOLL_WRITE flag for shared mappings as well as for private ones.
> > 
> > Huh? How do shared mapping get CoWed?
> > 
> > In this context CoW means to create a private copy of the  page for the
> > process. It only makes sense for private mappings as all pages in shared
> > mappings do not belong to the process.
> > 
> > Shared mappings will still get faults, but a bit later -- after the page
> > is written back to disc, the page get clear and write protected to catch
> > the next write access.
> > 
> > Noticeable exception is tmpfs/shmem. These pages do not belong to normal
> > write back process. But the code path is used for other filesystems as
> > well.
> > 
> > Therefore, NAK. You only create unneeded write back traffic.
> 
> Hi Kirill,
> 
> (My first reaction was exactly like yours indeed, but) on my real
> system (Cavium OcteonTX2), and on my qemu simulation I can reproduce
> the same behavior: just mlock()ed memory causes faults. That faults
> happen because page is mapped to the process as read-only, while
> underlying VMA is read-write. So faults get resolved well by just
> setting write access to the page.

mlock() doesn't guarntee that you'll never get a *minor* fault. Write back
or page migration will get these pages write-protected.

Making pages write protected is what we rely on for proper dirty
accounting: filesystems need to know when page gets dirty and allocate
resources for properly write back the page. Once page is written back to
storage the page gets write protected again to catch the next write access
to the page.

I guess we can situation a bit better for shmem/tmpfs: we can populate
such shared mappings with FOLL_WRITE. But this patch is not good for the
task.

-- 
 Kirill A. Shutemov
