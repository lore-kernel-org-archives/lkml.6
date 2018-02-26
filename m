Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeBZHug (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:50:36 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35431 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeBZHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:50:31 -0500
X-Google-Smtp-Source: AG47ELtdUsl9Q9phKfDs+4jU6JQ1lXIUNd4SMfDUsNxBYpY/ENuTjxbZII0K86yne07bN/vRasrLgg==
Date: Mon, 26 Feb 2018 08:50:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Borislav Petkov <bp@suse.de>, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, luto@amacapital.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180226075027.r5n5j6jvfum5o3z6@gmail.com>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
 <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
 <20180226073552.xabt55ukp24inut5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226073552.xabt55ukp24inut5@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> We need to re-do this as we have now run into _exactly_ the kind of difficult to 
> debug bug that I was worried about when I insisted on the many iterations of 
> this patch-set...

Ok, so I rebased tip:x86/mm and removed these two commits:

adf9ca9c69a2: x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G

 arch/x86/boot/compressed/head_64.S | 127 ++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 38 deletions(-)

b91993a87aff: x86/boot/compressed/64: Prepare trampoline memory

 arch/x86/boot/compressed/head_64.S    | 24 ++++++++++-
 arch/x86/boot/compressed/pgtable.h    | 18 ++++++++
 arch/x86/boot/compressed/pgtable_64.c | 79 +++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)

The other 5-level paging related commits tested out fine and are properly 
fine-grained.

Please split these two patches up - the first patch can probably be split up into 
5 parts or so. Let's start with no more than 5 patches per iteration, ok?

Thanks,

	Ingo
