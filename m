Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeBKPrv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 10:47:51 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34816 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 10:47:49 -0500
X-Google-Smtp-Source: AH8x225GI7kwG/gsnDTsObp4OTgPgkDirNG+PpXJjfdzwlK4v0TtlUshW7wZc52bn4q0K8Zk+LRG8A==
Date: Sun, 11 Feb 2018 18:47:46 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] mm/huge_memory.c: reorder operations in
 __split_huge_page_tail()
Message-ID: <20180211154746.j33vipgepv75dw3r@node.shutemov.name>
References: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
 <151835937752.185602.5640977700089242532.stgit@buzz>
 <20180211151433.xvza2mugfybyocoi@node.shutemov.name>
 <CALYGNiMjuW4BM2tSUOUmJUu7kX0HEL1EN-YFi=cvtstQi3YeHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiMjuW4BM2tSUOUmJUu7kX0HEL1EN-YFi=cvtstQi3YeHQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 06:32:10PM +0300, Konstantin Khlebnikov wrote:
> On Sun, Feb 11, 2018 at 6:14 PM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> > On Sun, Feb 11, 2018 at 05:29:37PM +0300, Konstantin Khlebnikov wrote:
> >> And replace page_ref_inc()/page_ref_add() with page_ref_unfreeze() which
> >> is made especially for that and has semantic of smp_store_release().
> >
> > Nak on this part.
> >
> > page_ref_unfreeze() uses atomic_set() which neglects the situation in the
> > comment you're removing.
> 
> Why? look into x86 smp_store_release
> for PPro it use same sequence smp_wb + WRITE_ONCE
> As I see spin_unlock uses exactly this macro.
> 
> Anyway if page_ref_unfreeze cannot handle races with
> get_page_unless_zero() then it completely useless,

Okay, fair enough.

But please call it out it the commit message.

-- 
 Kirill A. Shutemov
