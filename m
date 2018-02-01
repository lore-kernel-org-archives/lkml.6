Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBAJGb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:06:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52096 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeBAJG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:06:28 -0500
Date: Thu, 1 Feb 2018 10:05:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bpetkov@suse.de>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>, Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Rik van Riel <riel@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Eduardo Valentin <eduval@amazon.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] x86/mm: Rename flush_tlb_single() and flush_tlb_one()
Message-ID: <20180201090553.GV2269@hirez.programming.kicks-ass.net>
References: <3303b02e3c3d049dc5235d5651e0ae6d29a34354.1517414378.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3303b02e3c3d049dc5235d5651e0ae6d29a34354.1517414378.git.luto@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 08:03:10AM -0800, Andy Lutomirski wrote:
> flush_tlb_single() and flush_tlb_one() sound almost identical, but
> they really mean "flush one user translation" and "flush one kernel
> translation".  Rename them to flush_tlb_one_user() and
> flush_tlb_one_kernel() to make the semantics more obvious.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bpetkov@suse.de>
> Cc: Kees Cook <keescook@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Eduardo Valentin <eduval@amazon.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Linux-MM <linux-mm@kvack.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> 
> I was looking at some PTI-related code, and the flush-one-address code
> is unnecessarily hard to understand because the names of the helpers are
> uninformative.  This came up during PTI review, but no one got around to
> doing it.

Right, got as far as making it consistent and putting a comment on :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
