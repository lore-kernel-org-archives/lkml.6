Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeEaXhT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 19:37:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39171 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeEaXhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 19:37:18 -0400
X-Google-Smtp-Source: ADUXVKL4HytjJ5fW/k5Q6eF69U3HoWwx0IBNbCcT4ON0rRAY6zxarhYnnhCYJVgIBGyIwiR0mPVv1Q==
Date: Thu, 31 May 2018 16:37:10 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Andrew Morton <akpm@linux-foundation.org>
cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Zero out unused vma fields in
 shmem_pseudo_vma_init()
In-Reply-To: <20180531155256.a5f557c9e620a6d7e85e4ca1@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.1805311635410.13735@eggly.anvils>
References: <20180531135602.20321-1-kirill.shutemov@linux.intel.com> <20180531155256.a5f557c9e620a6d7e85e4ca1@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018, Andrew Morton wrote:
> On Thu, 31 May 2018 16:56:02 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > shmem/tmpfs uses pseudo vma to allocate page with correct NUMA policy.
> > 
> > The pseudo vma doesn't have vm_page_prot set. We are going to encode
> > encryption KeyID in vm_page_prot. Having garbage there causes problems.
> > 
> > Zero out all unused fields in the pseudo vma.
> > 
> 
> So there are no known problems in the current mainline kernel?

Correct - if we limit ourselves to the area of the shmem pseudo-vma :)

Hugh
