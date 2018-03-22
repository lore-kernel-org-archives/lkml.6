Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeCVB7q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:59:46 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:33819 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754486AbeCVB7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:59:42 -0400
X-Google-Smtp-Source: AG47ELuAXKpRqnSGqgjrY19vf0KMqICxK01vK9X31BBZl9/mDI3qu1BNS4sV2f/Dj1fjMbHZIkDw4w==
Date: Wed, 21 Mar 2018 19:00:14 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: mm/hmm: a simple question regarding devm_request_mem_region()
Message-ID: <20180322020013.GA26480@Asurada-Nvidia>
References: <20180321222357.GA31089@Asurada-Nvidia>
 <20180321225632.GI3214@redhat.com>
 <20180322002352.GA12673@Asurada-Nvidia>
 <20180322003253.GL3214@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322003253.GL3214@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 08:32:54PM -0400, Jerome Glisse wrote:

> > I am testing with drivers/char/hmm_dmirror.c from your git repository.
> > 
> > The addr I got (before "- size") is actually 0x7fffffffff, so equally
> > (1 << 40).
> > 
> > So from your reply, it seems to me that HMM is supposed to request a
> > region like it.
> 
> The dummy driver by default test the private memory, i had patches to
> make it test public memory too somewhere in a branch. So yes this is
> expected from the dummy driver. HMM here is trying to get a region that
> will not collide with any known existing resources. Idealy we would
> like a platform/arch function for that but it is hard to justify it
> nor is there a safe way to find such thing either from arch/platform
> specific code (there isn't for x86 at least).
> 
> For real device driver of pcie devices, the advice is to use the pci
> bar region of the device. This way we know for sure we do not collide
> with anything (ie use hmm_devmem_add_resource() not hmm_devmem_add()
> but this need some code change for res->desc).

I see. Thank you!
