Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2332C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC0A2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="cSG9ZZA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbeLUK2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:28:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36413 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbeLUK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:28:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so2418281pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MgbpNXZ6syJHgHjQ8P1oZ35HgImgeEw19kIRzY6x14U=;
        b=cSG9ZZA3fT8HYV/V9anzC5xuETlC9Aib/IxtvWOWI2Nhq0RklUAvHyM0uIMIMK3WZg
         GYtK1unGm577Sa2IcIYo8tA3SXjFCTRBkpPf5+6Zx1CGIvcIS9icWHqLAsQNUYHMaIWa
         eEO0Qin2XepxyOoW8z5+DZE8aSVn/5w7ytRXogLhtScCU66HQBKi1HcsWOvj5sJpauQT
         IIqm1+D+/i112y4e4Iq+bYDvfnuVdMS7RS/03MNZcII398DR+kdZ2RgTrttTUAn0mK5y
         ngbjnJwd3m7rFp59k8vV6MD9R3dpY6GoajZqgNV/MInCYnqNQ4vOYGn8u+HgEnsnw3JQ
         5sIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgbpNXZ6syJHgHjQ8P1oZ35HgImgeEw19kIRzY6x14U=;
        b=KCvqo8zEV6x4B5Rbtux5hyhCo8Khq63A0zBy7ku5KyIXnv43ohq2QeAUsa1py2F0NA
         YpKmZn4bY5xGjBpX/N9HPq9EeaVDBM4ezN26mp9Bdkg875NLYDvQ0kCzA+O+rzhL6wZO
         uJhLt6dEi9FzX3F1gcCmALLywH6Y5akOU0lvfz22Sjl0D0KbI/CQp34b1YTLgDmTfLqa
         oqJNNIqB8QXI0Bc8nbFg+dTAPgvK9RAvYWF0wzP+/aAlfKNjWRLq/6E/o+v1NMIVsfdZ
         kKOnuM7/YiB/VjAP/xHdIfAHHwmRD+a0hbUaDEJjewnGR54OUsyqBcaEMhSRZ9WkbXcd
         jlaw==
X-Gm-Message-State: AJcUuke4cweECNXowgOQ/ucPtrEQ+CEcMFm5YdIA2Ru5gM50LEpX4CEZ
        aqn/dCQI6Pkt+fVPD46xLZyJuA==
X-Google-Smtp-Source: ALg8bN7neVcA9AyznbeQA/+AEASrdVOx3pWQWTYxFrg4kai4vlauWcjPXwi6ZWnFCRAu6drNKoD55g==
X-Received: by 2002:a65:448a:: with SMTP id l10mr1823475pgq.387.1545388109580;
        Fri, 21 Dec 2018 02:28:29 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id s190sm30628986pfb.103.2018.12.21.02.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 02:28:28 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 90C24300816; Fri, 21 Dec 2018 13:28:24 +0300 (+03)
Date:   Fri, 21 Dec 2018 13:28:24 +0300
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
Message-ID: <20181221102824.5v36l6l5t2zthpgr@kshutemo-mobl1>
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
 <20181218223557.5202-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218223557.5202-3-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:35:57PM -0800, Mike Kravetz wrote:
> Instead of writing the required complicated code for this rare
> occurrence, just eliminate the race.  i_mmap_rwsem is now held in read
> mode for the duration of page fault processing.  Hold i_mmap_rwsem
> longer in truncation and hold punch code to cover the call to
> remove_inode_hugepages.

One of remove_inode_hugepages() callers is noticeably missing --
hugetlbfs_evict_inode(). Why?

It at least deserves a comment on why the lock rule doesn't apply to it.

-- 
 Kirill A. Shutemov
