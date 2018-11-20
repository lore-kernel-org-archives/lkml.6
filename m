Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA77C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA2120851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="O6Ibvyg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA2120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKTTjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:39:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42415 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeKTTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:39:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so684119pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xTqK6uabaMx+0Xv52VCA9sDUvXO27AaAVGz4Z/6W2Q0=;
        b=O6Ibvyg7G8XjMwEI/Ge59VwsIW3XHEz9BZB2WDLt+aoDiUOh/Cul71RFOUU6iN9jZh
         vfQeJKP+Li+3S318vCoSNJIJtNsGLNBXaTef3xIYX/W76WBb+WZcrdbg3OHxrPG1mneB
         8rxyP3s8YkfYK+Ca1/JdxMAZVTqcW01zqgQGiS/MIjsV2p/QHdavwvkBFukVRjpQKtGp
         SJLIAiR/QEY5qPRtjGe/kE0yed68ce8wsahoOziEzfDUEkLj2tG48Rqq6dYbbLcPN9/d
         s75cRZWZe98vwM/PfH1cxN9frD6xyAOAI7BaEsMzWBjOuMVl+PlbKU6hIC/hKoi7Gw40
         nGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTqK6uabaMx+0Xv52VCA9sDUvXO27AaAVGz4Z/6W2Q0=;
        b=A/zISORxN7t6106fORTUQ6l2QY5Q4OIgTRk4xo9byzZcwf/BblrvF4G8Rwhd2Hw/dc
         314dXzeND+vBCYHqTcueHt6bxG/JnLwtkpRfRnL8KeOuONKF9yseF2EmPBEQWlNQMl/q
         15w3lUImxQFPzbx2z/v2uL4nLZy3LzltmmJU0yONTseHtpb6AnWCPWn+OQGZMNKaqBDe
         A4392uncpIItpkvvKanxqd+Z0i0kBWuyT8AZq3VnxWrYUIqXaEjd8bz1+Jn4xBmf2bJ8
         tjIq0QGcLpqCFwRg9ZacZE8TsdPGlZJHV8sfWOUBmSSOiZEwpMTW2jbg/XDdojO29Fta
         mbCQ==
X-Gm-Message-State: AA+aEWb2W0HfVrRhtNeha1AknFmXbncM66xIIKXU6m0Grx8gS29Q1Wtn
        01dIlGRgLwXJf4+6tM4nNky/0A==
X-Google-Smtp-Source: AFSGD/VAhJYfG7v46S/qoHjtqjZLp/7WmWiPMDjekLj5suJe+bMc2I0QOWL4xkfnbnqkf6PX4RWwDQ==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr1305591plq.275.1542705087402;
        Tue, 20 Nov 2018 01:11:27 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id g26sm11120747pfh.61.2018.11.20.01.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:11:26 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E6A60302653; Tue, 20 Nov 2018 12:11:22 +0300 (+03)
Date:   Tue, 20 Nov 2018 12:11:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        mhocko@kernel.org, minchan@kernel.org, peterz@infradead.org,
        rientjes@google.com, vbabka@suse.cz, willy@infradead.org,
        ying.huang@intel.com, nitingupta910@gmail.com
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
Message-ID: <20181120091122.3dxlgff3vivwilrg@kshutemo-mobl1>
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
 <20181109195150.GA24747@redhat.com>
 <20181110132249.GH23260@techsingularity.net>
 <20181110164412.GB22642@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110164412.GB22642@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:44:12AM -0500, Andrea Arcangeli wrote:
> I would prefer to add intelligence to detect when COWs after fork
> should be done at 2m or 4k granularity (in the latter case by
> splitting the pmd before the actual COW while leaving the transhuge
> pmd intact in the other mm), because that would save CPU (and it'd
> automatically optimize redis). The snapshot process especially would
> run faster as it will read with THP performance.

I would argue we should switch to 4k COW everywhere. But it requires some
work on khugepaged side to be able to recover THP back after multiple 4k
COW in the range. Currently khugepaged is not able to collapse PTE entires
backed by compound page back to PMD.

I have this on my todo list for long time, but...

-- 
 Kirill A. Shutemov
