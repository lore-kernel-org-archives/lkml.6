Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeDJAr4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 20:47:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJArz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 20:47:55 -0400
Date: Mon, 9 Apr 2018 17:47:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jerome Glisse" <jglisse@redhat.com>,
        Daniel Colascione <dancol@google.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH -mm] mm, pagemap: Fix swap offset value for PMD
 migration entry
Message-Id: <20180409174753.4b959a5b3ff732b8f96f5a14@linux-foundation.org>
In-Reply-To: <20180408033737.10897-1-ying.huang@intel.com>
References: <20180408033737.10897-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Apr 2018 11:37:37 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> From: Huang Ying <ying.huang@intel.com>
> 
> The swap offset reported by /proc/<pid>/pagemap may be not correct for
> PMD migration entry.  If addr passed into pagemap_range() isn't

pagemap_pmd_range(), yes?

> aligned with PMD start address,

How can this situation come about?

> the swap offset reported doesn't
> reflect this.  And in the loop to report information of each sub-page,
> the swap offset isn't increased accordingly as that for PFN.
> 
> BTW: migration swap entries have PFN information, do we need to
> restrict whether to show them?

For what reason?  Address obfuscation?
