Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeEOLsF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:48:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeEOLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:48:04 -0400
Date: Tue, 15 May 2018 13:47:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boaz Harrosh <boazh@netapp.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
Message-ID: <20180515114755.GY12217@hirez.programming.kicks-ass.net>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:43:23PM +0300, Boaz Harrosh wrote:
> Yes I know, but that is exactly the point of this flag. I know that this
> address is only ever accessed from a single core. Because it is an mmap (vma)
> of an O_TMPFILE-exclusive file created in a core-pinned thread and I allow
> only that thread any kind of access to this vma. Both the filehandle and the
> mmaped pointer are kept on the thread stack and have no access from outside.
> 
> So the all point of this flag is the kernel driver telling mm that this
> address is enforced to only be accessed from one core-pinned thread.

What happens when the userspace part -- there is one, right, how else do
you get an mm to stick a vma in -- simply does a full address range
probe scan?

Something like this really needs a far more detailed Changelog that
explains how its to be used and how it is impossible to abuse. Esp. that
latter is _very_ important.
