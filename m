Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeBHURw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:17:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeBHURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:17:51 -0500
Date: Thu, 8 Feb 2018 12:17:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] mm: hwpoison: disable memory error handling on 1GB
 hugepage
Message-Id: <20180208121749.0ac09af2b5a143106f339f55@linux-foundation.org>
In-Reply-To: <87fu6bfytm.fsf@e105922-lin.cambridge.arm.com>
References: <20180130013919.GA19959@hori1.linux.bs1.fc.nec.co.jp>
        <1517284444-18149-1-git-send-email-n-horiguchi@ah.jp.nec.com>
        <87inbbjx2w.fsf@e105922-lin.cambridge.arm.com>
        <20180207011455.GA15214@hori1.linux.bs1.fc.nec.co.jp>
        <87fu6bfytm.fsf@e105922-lin.cambridge.arm.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Feb 2018 12:30:45 +0000 Punit Agrawal <punit.agrawal@arm.com> wrote:

> >
> > So I don't think that the above test result means that errors are properly
> > handled, and the proposed patch should help for arm64.
> 
> Although, the deviation of pud_huge() avoids a kernel crash the code
> would be easier to maintain and reason about if arm64 helpers are
> consistent with expectations by core code.
> 
> I'll look to update the arm64 helpers once this patch gets merged. But
> it would be helpful if there was a clear expression of semantics for
> pud_huge() for various cases. Is there any version that can be used as
> reference?

Is that an ack or tested-by?

Mike keeps plaintively asking the powerpc developers to take a look,
but they remain steadfastly in hiding.

Folks, this patch fixes a BUG and is marked for -stable.  Can we please
prioritize it?
