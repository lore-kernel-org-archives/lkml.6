Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FAAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9217B208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="roIWkkGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9217B208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeHWAh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:37:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43359 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeHWAh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:37:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so1550768pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hMoRtvMtKzqDcppxJwSXR72qFfIxkSn/5dSaKwDzVo=;
        b=roIWkkGgOA4kJzrGNa+ndmUkRiJuf7Fca9uRLXFQspDNMCPQHWx93sTc56+gQLaFRe
         uCnCFO0r1wWB95J4N5mCqumv8aqoVyX+Jqt2n7zyV0KNwFdn72mVAeFwlPF6rlWDaQ19
         e7azwt0WWW4Xo4dfOALnVGwmR9476YPMRDsUa47dbZqRL4a7fDZkakOADOqtscShN8pB
         IMLZ0uDzumvnztcfUZbWc/jj0WjQt7r+gcrZTu5IsTIHUGXB0uJM1ecB/5n3Go4a6a/K
         O4ThoHpzz2L6m9SZvmgKD63HoxHj9Iy7zTCJm+IyAXZh8Y+CidDdd15LmCoDwLNlhpHB
         4h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hMoRtvMtKzqDcppxJwSXR72qFfIxkSn/5dSaKwDzVo=;
        b=fk0CIwJqOQxhcpEVuVNxUkyXIi2L7Ys3+LOiOcpXcVf+wbaPz8Z2eBUCIaCkdMKB/U
         pU8uHT6eseh1nWcsKgk98dloclp3Co64QcIX6bp8tnfpxrpDK9k5ChZZi2Z+jWCbvT1N
         z63cA6M6ooBuQRHk8ZmTK5kMjcmaNcMfbRXejz7JpVhnJEISBQauke8cpOu4HUKMBlEC
         r9e7L2gPU/OpH0OIh97XQoF+z5h00k5sh9hTt3Sy19yxjjRIqfkE+pB/rTu8caxUzvp+
         jGsQka3koOgwqYgCG+fKfx1V4ENlXl4B2cJGcCyrj5P2z7xYoXrPvSFhoVG+hqA4UFuG
         6Ljw==
X-Gm-Message-State: AOUpUlFLEtaAcRMK7bOWPJFauAazh5RNKp4guxs++5kpWZgb7z21lJTJ
        zPi5q9ZJuda01e74g3cNv2LH1w==
X-Google-Smtp-Source: AA+uWPxuFEqe8rfVwDi5JzhBhnpQCUyEloaVswdkQSNdKAqBHzGNTIvf2e3MhcNKlPVuoxpmOb0wgQ==
X-Received: by 2002:a63:1e63:: with SMTP id p35-v6mr14495912pgm.376.1534972258633;
        Wed, 22 Aug 2018 14:10:58 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id b76-v6sm3782432pfj.184.2018.08.22.14.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 14:10:57 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B331C3000C4; Thu, 23 Aug 2018 00:10:53 +0300 (+03)
Date:   Thu, 23 Aug 2018 00:10:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v8 PATCH 3/5] mm: mmap: zap pages with read mmap_sem in
 munmap
Message-ID: <20180822211053.qg3dlzf6pok2x4yk@kshutemo-mobl1>
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
 <e691d054-f807-80ad-9934-a1917d8e2e77@suse.cz>
 <3c62f605-2244-6a05-2dc4-34a3f1c56300@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c62f605-2244-6a05-2dc4-34a3f1c56300@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 01:45:44PM -0700, Yang Shi wrote:
> 
> 
> On 8/22/18 4:19 AM, Vlastimil Babka wrote:
> > On 08/15/2018 08:49 PM, Yang Shi wrote:
> > > +	downgrade_write(&mm->mmap_sem);
> > > +
> > > +	/* Zap mappings with read mmap_sem */
> > > +	unmap_region(mm, start_vma, prev, start, end);
> > > +
> > > +	arch_unmap(mm, start_vma, start, end);
> > Hmm, did you check that all architectures' arch_unmap() is safe with
> > read mmap_sem instead of write mmap_sem? E.g. x86 does
> > mpx_notify_unmap() there where I would be far from sure at first glance...
> 
> Yes, I'm also not quite sure if it is 100% safe or not. I was trying to move
> this before downgrade_write, however, I'm not sure if it is ok or not too,
> so I keep the calling sequence.
> 
> For architectures, just x86 and ppc really do something. PPC just uses it
> for vdso unmap which should just happen during process exit, so it sounds
> safe.
> 
> For x86, mpx_notify_unmap() looks finally zap the VM_MPX vmas in bound table
> range with zap_page_range() and doesn't update vm flags, so it sounds ok to
> me since vmas have been detached, nobody can find those vmas. But, I'm not
> familiar with the details of mpx, maybe Kirill could help to confirm this?

I don't see anything obviously dependent on down_write() in
mpx_notify_unmap(), but Dave should know better.

-- 
 Kirill A. Shutemov
