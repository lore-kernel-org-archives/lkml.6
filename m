Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB90ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834A32098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mnFy5ViE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834A32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeGPVH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:07:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33085 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbeGPVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:07:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so26853258pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74IgO7O1+XGaIUnPGKmTWjiSRgVD7KzkCVGStQEIRbE=;
        b=mnFy5ViEtIyHEO3a+cmzptJAa5lGSHV6Xgy+Sg6ofwB9sPXPaGUxe6/3fqRvnYCIlm
         9e8hAyFVy0/bvJiOajRuK989ewoYEHL6lOWcF0KQ5jeMXf9+R5VJlF4GvW1J9D9SLCW+
         2Hu8S2eakloblByZ6Re/2ZwBK1U7ngzrBvdf3JdYDZnu14Issiw9b0KXCAWu66jIOR4S
         xGNsZ//kbUPAc7FuDtaD1UOe2v4KTUkK47fgyvLU9rAMEelj+YwYQa+4+NXfwdYypp3S
         r2qHv8+Sdf9SNcHeSf6qv5ofHvvgByqI0SCW+7Zk8xtDV/TzXeKAkfcDdi/aHWyBCJcH
         T9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74IgO7O1+XGaIUnPGKmTWjiSRgVD7KzkCVGStQEIRbE=;
        b=YQ06wQM3Pc/tsx/hqBWWH2ishSc6Nzits1WOFC0xWuvbmI7dmimac+kio5xvdXaK5Z
         2+LqZF5zxtQRWJ3Ji5ISwVMto/3fWNzQ8v7vajglqom+fk88luDtiYI0TLcGkgSTvoXr
         6jwBH7RAcIQXVMw2Lqn/GXK9asEvaueB5Ub1Qj0DKBpd/cfud4Rw7kBM1xgv9l0qjlRc
         zcIaAroC6bGtVcRdlxlskv8VMjHN4ImPCLROv3wxAErvkcoMXf+feOUEv3THBEZukMwk
         Gjle5LhD+nYrAYBqJl9WsZJ0CKFI7dqH24PYwzb/cMMvO+sEmSprrXg5qftzPlZgjSXn
         dUdw==
X-Gm-Message-State: AOUpUlFbENBh/zom3op6mzb0Tiyt90eYYisIPF0O3EokUHhkm5Hluy47
        Ye0iFTwHm8rpQQAzAckPbmBpTw==
X-Google-Smtp-Source: AAOMgpdHwQj4sLriJbEqo5WH7lrZybfkEn1PYHqhneWEeP6g4XbLPhBE1da4fhsWk30emQLt8sZvqA==
X-Received: by 2002:a63:2ec3:: with SMTP id u186-v6mr2883371pgu.225.1531773532474;
        Mon, 16 Jul 2018 13:38:52 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id q5-v6sm18721825pgv.61.2018.07.16.13.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 13:38:51 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A99EA3001F8; Mon, 16 Jul 2018 23:38:46 +0300 (+03)
Date:   Mon, 16 Jul 2018 23:38:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Fix vma_is_anonymous() false-positives
Message-ID: <20180716203846.roolhtesloabxr2g@kshutemo-mobl1>
References: <20180710134821.84709-1-kirill.shutemov@linux.intel.com>
 <20180710134821.84709-2-kirill.shutemov@linux.intel.com>
 <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
 <20180716133028.GQ17280@dhcp22.suse.cz>
 <20180716140440.fd3sjw5xys5wozw7@black.fi.intel.com>
 <20180716142245.GT17280@dhcp22.suse.cz>
 <20180716144739.que5362bofty6ocp@kshutemo-mobl1>
 <20180716174042.GA17280@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716174042.GA17280@dhcp22.suse.cz>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:40:42PM +0200, Michal Hocko wrote:
> On Mon 16-07-18 17:47:39, Kirill A. Shutemov wrote:
> > On Mon, Jul 16, 2018 at 04:22:45PM +0200, Michal Hocko wrote:
> > > On Mon 16-07-18 17:04:41, Kirill A. Shutemov wrote:
> > > > On Mon, Jul 16, 2018 at 01:30:28PM +0000, Michal Hocko wrote:
> > > > > On Tue 10-07-18 13:48:58, Andrew Morton wrote:
> > > > > > On Tue, 10 Jul 2018 16:48:20 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> > > > > > 
> > > > > > > vma_is_anonymous() relies on ->vm_ops being NULL to detect anonymous
> > > > > > > VMA. This is unreliable as ->mmap may not set ->vm_ops.
> > > > > > > 
> > > > > > > False-positive vma_is_anonymous() may lead to crashes:
> > > > > > > 
> > > > > > > ...
> > > > > > > 
> > > > > > > This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> > > > > > > on it being NULL.
> > > > > > > 
> > > > > > > If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> > > > > > > dummy_vm_ops. This way we will have non-NULL ->vm_ops for all VMAs.
> > > > > > 
> > > > > > Is there a smaller, simpler fix which we can use for backporting
> > > > > > purposes and save the larger rework for development kernels?
> > > > > 
> > > > > Why cannot we simply keep anon vma with null vm_ops and set dummy_vm_ops
> > > > > for all users who do not initialize it in their mmap callbacks?
> > > > > Basically have a sanity check&fixup in call_mmap?
> > > > 
> > > > As I said, there's a corner case of MAP_PRIVATE of /dev/zero.
> > > 
> > > This is really creative. I really didn't think about that. I am
> > > wondering whether this really has to be handled as a private anonymous
> > > mapping implicitly. Why does vma_is_anonymous has to succeed for these
> > > mappings? Why cannot we simply handle it as any other file backed
> > > PRIVATE mapping?
> > 
> > Because it's established way to create anonymous mappings in Linux.
> > And we cannot break the semantics.
> 
> How exactly would semantic break? You would still get zero pages on read
> faults and anonymous pages on CoW. So basically the same thing as for
> any other file backed MAP_PRIVATE mapping.

You are wrong about zero page. And you won't get THP. And I'm sure there's
more differences. Just grep for vma_is_anonymous().

-- 
 Kirill A. Shutemov
