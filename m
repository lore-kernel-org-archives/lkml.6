Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966835AbeEYPi2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:38:28 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:44036 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966023AbeEYPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:38:27 -0400
Date: Fri, 25 May 2018 15:38:26 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: "Huang, Ying" <ying.huang@intel.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andi Kleen <andi.kleen@intel.com>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH -V2 -mm 0/4] mm, huge page: Copy target sub-page last
 when copy huge page
In-Reply-To: <20180524005851.4079-1-ying.huang@intel.com>
Message-ID: <0100016397f379e8-f651e3ed-3646-4423-8cd3-9ea61666a12b-000000@email.amazonses.com>
References: <20180524005851.4079-1-ying.huang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.25-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Huang, Ying wrote:

> If the cache contention is heavy when copying the huge page, and we
> copy the huge page from the begin to the end, it is possible that the
> begin of huge page is evicted from the cache after we finishing
> copying the end of the huge page.  And it is possible for the
> application to access the begin of the huge page after copying the
> huge page.

Isnt there a better way to zero the remaining pages? Something that has no
cache impact like a non temporal store? So the remaining cache will not be
evicted?

https://www.felixcloutier.com/x86/MOVNTI.html
