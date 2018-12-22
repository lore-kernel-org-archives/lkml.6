Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAEBC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DC82195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="U8KLfy8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbeLVWOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:14:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42718 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeLVWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:14:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so7741711lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 14:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ncu1Cm23KvKzQIdOjPI4IN2RDVfRz4HN3W3I5484QLI=;
        b=U8KLfy8pyDTEJDbEjZsHe+smXF8nJI6EkKolk9SunqqDRyM87IGMrVb9UgTTeetHE2
         dSIKE0ccOHdytMmghW9JDyif/KbNY44fQUvIPwXu5p6c/VoVoE3Vtor7LG8YDFRD4YTh
         OfBHBeDymgnwEX68qbMhk4wZL5/i0NUlcdYYl8MEut1FKdoLyHcLndYCdL8Gl9abMzWB
         45U2smCsyX+60idZ0r8fz3SrTmDBFvmT6PsLysjVOMGj4TGGAs5VP0/mYcjlNTlw46NN
         CrqDLJI1jYr9wRAj4BlkqeaG+LN2ugOY5QFyngpx7yCIshzdvEfYQmP8ouIS/kKDz2D+
         tnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ncu1Cm23KvKzQIdOjPI4IN2RDVfRz4HN3W3I5484QLI=;
        b=Mx5XH2yfEog42h33QLMbdg8xw3dDEWCh7kzn4rmzN+jvYDPZdRevEsu1iBlmcdtfM2
         woiwyWDGC0HNrmyVs+BNo2A6RupInfSaOXfFfAFBY6XpEQGdb09G7lzhcKMeWx38H03p
         zjLq2R6dxP8PuhXz2yFc5qHDu6m3XhYDJvjtpRYlZdsue9f39oa2FZmxK8EIZVW5R2tu
         QP5dppIRzEXVgIpQk8CvWL8IKKkEXEpfK7rdBoaYkMvIEQN+xKxdNrb1/7nzmHoEyNEa
         kfE0WzWYZ8k4ZFSq+wPmvFWZDazNe4oOFbx342H1GwHl6KaZXKXHeL16GOAfEnbKUrI7
         5aew==
X-Gm-Message-State: AJcUukcoRtctyrFya4rgfWRLKgNplsXshS9zjNottQyuiAhDq7Risx/o
        +vODxWa0At4UMaF6XSmOFJlxGQ==
X-Google-Smtp-Source: ALg8bN7lMn7+xOHD+0sTBIyW6jrOcGZjDi+u3Fl+BwRJBLB1j2XbG+yElRmLuwdPyrFR+C19/xVtRw==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr4556373ljb.176.1545516854759;
        Sat, 22 Dec 2018 14:14:14 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-127-199-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.199.127])
        by smtp.gmail.com with ESMTPSA id 10sm5486741lff.62.2018.12.22.14.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 14:14:13 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1DE02300816; Sun, 23 Dec 2018 01:14:12 +0300 (+03)
Date:   Sun, 23 Dec 2018 01:14:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
Message-ID: <20181222221411.ktm5qeebi43lvce5@kshutemo-mobl1>
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
 <20181218223557.5202-3-mike.kravetz@oracle.com>
 <20181221102824.5v36l6l5t2zthpgr@kshutemo-mobl1>
 <849f5202-2200-265f-7769-8363053e8373@oracle.com>
 <20181221202136.crrwojz3k7muvyrh@kshutemo-mobl1>
 <732c0b7d-5a4e-97a8-9677-30f3520893cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732c0b7d-5a4e-97a8-9677-30f3520893cb@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:17:32PM -0800, Mike Kravetz wrote:
> Am I misunderstanding your question/concern?

No. Thanks for the clarification.

> 
> I have decided to add the locking (although unnecessary) with something like
> this in hugetlbfs_evict_inode.
> 
> 	/*
> 	 * The vfs layer guarantees that there are no other users of this
> 	 * inode.  Therefore, it would be safe to call remove_inode_hugepages
> 	 * without holding i_mmap_rwsem.  We acquire and hold here to be
> 	 * consistent with other callers.  Since there will be no contention
> 	 * on the semaphore, overhead is negligible.
> 	 */
> 	i_mmap_lock_write(mapping);
> 	remove_inode_hugepages(inode, 0, LLONG_MAX);
> 	i_mmap_unlock_write(mapping);

LGTM.

-- 
 Kirill A. Shutemov
