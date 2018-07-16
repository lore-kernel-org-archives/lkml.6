Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A33FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4B4208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="JPrF96ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4B4208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeGPPPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:15:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33795 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeGPPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:15:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so7593702pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/RrlAjlBz4vL/Kcd/+7/yrkfS4tpEbnBeA0cVabvIUI=;
        b=JPrF96kyx8xqknUqfl70ci7syj2UBphdKlZ1mwHj/M/GGdUWcR62N4ZHgN9i8z9Cal
         OqAlO1HZ6qXVV+Thw5cZQe1BvRtIrwV+G/8vMNtirbjsXVXKlXmBRm1Q1gdBDqDByBAO
         tI8a+vLUHAoplrFYhJl5JxPo+Ib8doRjoK53IInIiCK2fmxHOJudEz894QPiiDf9QeKJ
         aQnNUMRCcF4KBhwDevAyBTNY6u9EvCFP6g0WGWkEySl1AhuqGTiyWtD4R+FftPMhJmER
         lftaV22oQyBNWzTBCjTBfRA/f8oL3dlSbvqK05HSnhBHl0gFGMtf1ak4vJHs+XrlF3tL
         0TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RrlAjlBz4vL/Kcd/+7/yrkfS4tpEbnBeA0cVabvIUI=;
        b=Vrh9kbznukCdKlEgm+yd9KS/LWRI29Q3jGUfkxPT4QWlRFxFEuMOpWrNVPOd02KPRy
         8T/Rmd7g+Guu5NGuXdadjObWRcy/la/MvH85rZ/W41Eczc+Fy4QYf5/le4AvtKG78xSb
         x9BbHPIQO74ulr/jEFg/MofyaUWUh8hA5pd82DNWjgUcdSZGSb4zXUw2xXZac+Cr/1+j
         SnIln184vO6tE7UrHbbBhxSLRNuCjY0d9Q4Pm9+St4FWsmNI797WSbpnK+NgPWGcTyqb
         WVbvQecmiZawFLiFFusB5865RiU6F3HzzBXrzzvN8ZpMKjkH5Z1u9PfPRfhJC0T049E2
         q47Q==
X-Gm-Message-State: AOUpUlHpisIl1TtKeLvKFf8MTraprGyByhdbYymGv/WtcJvWv7f5xDCf
        xZxuKRLWJxR3UXPDPosS67LWjg==
X-Google-Smtp-Source: AAOMgpfloj1RL7NfCCre4aZAvlnp4P3t7u/1qz9M0KuQG8gicZmsOz9xlejtcMQZ531GHdr0kDfh2Q==
X-Received: by 2002:a63:8f03:: with SMTP id n3-v6mr15917672pgd.166.1531752465520;
        Mon, 16 Jul 2018 07:47:45 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id q25-v6sm8115212pfk.96.2018.07.16.07.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 07:47:44 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B35E83001F8; Mon, 16 Jul 2018 17:47:39 +0300 (+03)
Date:   Mon, 16 Jul 2018 17:47:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Fix vma_is_anonymous() false-positives
Message-ID: <20180716144739.que5362bofty6ocp@kshutemo-mobl1>
References: <20180710134821.84709-1-kirill.shutemov@linux.intel.com>
 <20180710134821.84709-2-kirill.shutemov@linux.intel.com>
 <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
 <20180716133028.GQ17280@dhcp22.suse.cz>
 <20180716140440.fd3sjw5xys5wozw7@black.fi.intel.com>
 <20180716142245.GT17280@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716142245.GT17280@dhcp22.suse.cz>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 04:22:45PM +0200, Michal Hocko wrote:
> On Mon 16-07-18 17:04:41, Kirill A. Shutemov wrote:
> > On Mon, Jul 16, 2018 at 01:30:28PM +0000, Michal Hocko wrote:
> > > On Tue 10-07-18 13:48:58, Andrew Morton wrote:
> > > > On Tue, 10 Jul 2018 16:48:20 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> > > > 
> > > > > vma_is_anonymous() relies on ->vm_ops being NULL to detect anonymous
> > > > > VMA. This is unreliable as ->mmap may not set ->vm_ops.
> > > > > 
> > > > > False-positive vma_is_anonymous() may lead to crashes:
> > > > > 
> > > > > ...
> > > > > 
> > > > > This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> > > > > on it being NULL.
> > > > > 
> > > > > If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> > > > > dummy_vm_ops. This way we will have non-NULL ->vm_ops for all VMAs.
> > > > 
> > > > Is there a smaller, simpler fix which we can use for backporting
> > > > purposes and save the larger rework for development kernels?
> > > 
> > > Why cannot we simply keep anon vma with null vm_ops and set dummy_vm_ops
> > > for all users who do not initialize it in their mmap callbacks?
> > > Basically have a sanity check&fixup in call_mmap?
> > 
> > As I said, there's a corner case of MAP_PRIVATE of /dev/zero.
> 
> This is really creative. I really didn't think about that. I am
> wondering whether this really has to be handled as a private anonymous
> mapping implicitly. Why does vma_is_anonymous has to succeed for these
> mappings? Why cannot we simply handle it as any other file backed
> PRIVATE mapping?

Because it's established way to create anonymous mappings in Linux.
And we cannot break the semantics.

-- 
 Kirill A. Shutemov
