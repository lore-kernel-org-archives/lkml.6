Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A771C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70202064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="u2sX5DMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70202064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJXVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:12:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40284 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJXVMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:12:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id o14-v6so2261144pgv.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/vR+1XVJRF6KSaibQS2hUtXZ9xgUWhlKcqs3fkgpDM=;
        b=u2sX5DMCFbXZ6WoE4OBfdrE13/orMDoM0ITclmiakIEen8h+EWfiL8BEHdGmfzYeLf
         HAkY5obS8sNIgP8bCdtJhbbIEMr4V+w3MppPSxMt2TokRs7bzO25h+RnE7dzwrjmlzie
         kQK4MURVKKcxQXjwqG/uWbr0rYPICaYv3ZyYgOBX5W9qq6jbG4YZNbonbUqRVzf0MrM3
         LBkBjDXaGC92nSbICXIabkbNdBxuu8u5/SZZsre3EPdEcLTJehnFJynYevfXvZGaMC+Y
         7e7RSWIWki4NfFy5TEqz+Ps6oG+4LZovkc/bI68J1+QEw+EL0XwVdhzIokU8eN+LDVle
         FMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/vR+1XVJRF6KSaibQS2hUtXZ9xgUWhlKcqs3fkgpDM=;
        b=hYUmlAyg3PzZkE31PFRziv58eZTzro9xrL7R6xi+qsNTrCaMaNKsO1EfGHunUjSnwo
         FVL0EFP7vo0VfC/R/uYTW7rh19px9PKren5m4kxEai218IwqFWCBfhb/uD8LFlzGjWi6
         ZVcAKqaC+WSCvVTQL9i3z9tptMN0L7W4HihDwVQcUZNGLKMc8X7hXtp3SNhqeq2DrSZc
         9VTJTBvQRr8Bw2hPJqtu+VoFduTjfHLCHw6pCgjpRilui6ICZ4dGP0cKyqaOxfWtNCq9
         GU+ys0+r47bgXO2kRKDJBM4NyTb9f448yDXv461/TI/EXqfVHaBYgNPnYHEDVwNht7h0
         jcDA==
X-Gm-Message-State: AGRZ1gL8wRLQ9as6bKeNcQ/adJpnU5B5TJRG0XwgF+FOSHlxZgvKScfM
        zmdzXNauDWnulgiDPzdwS503BvkeIsg5AVPb
X-Google-Smtp-Source: AJdET5fiM46I1o/1qme0jBXc2r21xy5a2UJctG/+6cuW6R2Cf8ARu63D52aeLuFYVXm+iyqJ5fzdew==
X-Received: by 2002:a63:6883:: with SMTP id d125-v6mr2391675pgc.451.1540385089599;
        Wed, 24 Oct 2018 05:44:49 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id p11-v6sm5629714pfo.65.2018.10.24.05.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 05:44:48 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C35F5300225; Wed, 24 Oct 2018 15:44:43 +0300 (+03)
Date:   Wed, 24 Oct 2018 15:44:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181024124443.husnnxgligsncm5t@kshutemo-mobl1>
References: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
 <20181023163157.41441-2-kirill.shutemov@linux.intel.com>
 <20181024115447.GE25444@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024115447.GE25444@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:54:47AM -0700, Matthew Wilcox wrote:
> On Tue, Oct 23, 2018 at 07:31:56PM +0300, Kirill A. Shutemov wrote:
> > -ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
> > +ffff888000000000 - ffff887fffffffff (=39 bits) LDT remap for PTI
> 
> I'm a little bit cross-eyed at this point, but I think the above '888'
> should be '880'.
> 
> > @@ -14,7 +15,6 @@ ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
> >  ... unused hole ...
> >  				    vaddr_end for KASLR
> >  fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
> > -fffffe8000000000 - fffffeffffffffff (=39 bits) LDT remap for PTI
> 
> ... and the line above this one should be adjusted to finish at
> fffffeffffffffff (also it's now 40 bits).  Or should there be something
> else here?
> 
> >  ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
> >  ... unused hole ...
> >  ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
> > @@ -30,8 +30,8 @@ Virtual memory map with 5 level page tables:
> >  0000000000000000 - 00ffffffffffffff (=56 bits) user space, different per mm
> >  hole caused by [56:63] sign extension
> >  ff00000000000000 - ff0fffffffffffff (=52 bits) guard hole, reserved for hypervisor
> > -ff10000000000000 - ff8fffffffffffff (=55 bits) direct mapping of all phys. memory
> > -ff90000000000000 - ff9fffffffffffff (=52 bits) LDT remap for PTI
> > +ff10000000000000 - ff10ffffffffffff (=48 bits) LDT remap for PTI
> > +ff11000000000000 - ff90ffffffffffff (=55 bits) direct mapping of all phys. memory
> 
> What's at ff910..0 to ff9f..f ?
> 
> Is there any way we can generate this part of this file to prevent human
> error from creeping in over time?  ;-)

In current Linus' tree this part of the documentation was re-written. I've
rebased to it and rewrote the documenation for the change.

I believe I've fixed all mistakes you've noticied. Please check out v2. I
will post it soon.

-- 
 Kirill A. Shutemov
