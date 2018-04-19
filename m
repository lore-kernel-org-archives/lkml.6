Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeDSNAT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:00:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57639 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbeDSNAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:00:17 -0400
Date: Thu, 19 Apr 2018 15:00:11 +0200
From: Borislav Petkov <bp@suse.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
Message-ID: <20180419130011.GG3896@pd.tnic>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
 <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
 <20180418121403.GA3434@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418121403.GA3434@pd.tnic>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 02:18:57PM +0200, Borislav Petkov wrote:
> Btw, even with Jörg's fix,
> 
> fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")

Some updates.

1. current linus master with Joerg's fix triple-faults on the IVB laptop
during resume from disk.

2. current linus master with Joerg's fix + those two:

C Apr 17               Dave Hansen ( :  67) [PATCH 1/2] x86, pti: fix boot problems from Global-bit setting
C Apr 17               Dave Hansen ( :  81) └─>[PATCH 2/2] x86, pti: fix boot warning from Global-bit setting

triplefaults too.

Bisection confirms again fb43d6cb91ef is the first bad:

fb43d6cb91ef x86/mm: Do not auto-massage page protections <--- NOT OK
6baf4bec02db x86/espfix: Document use of _PAGE_GLOBAL   <--- OK

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
