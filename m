Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757497AbeD0Rtr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:49:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:3692 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757225AbeD0Rtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:49:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,336,1520924400";
   d="scan'208";a="37575591"
Subject: [PATCH 0/9] [v3] x86, pkeys: two protection keys bug fixes
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, shakeelb@google.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 27 Apr 2018 10:45:27 -0700
Message-Id: <20180427174527.0031016C@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

This set is basically unchanged from the last post.  There was
some previous discussion about other ways to fix this with the ppc
folks (Ram Pai), but we've concluded that this x86-specific fix is
fine.  I think Ram had a different fix for ppc.

Changes from v2:
 * Clarified commit message in patch 1/9 taking some feedback from
   Shuah.

Changes from v1:
 * Added Fixes: and cc'd stable.  No code changes.

--

This fixes two bugs, and adds selftests to make sure they stay fixed:

1. pkey 0 was not usable via mprotect_pkey() because it had never
   been explicitly allocated.
2. mprotect(PROT_EXEC) memory could sometimes be left with the
   implicit exec-only protection key assigned.

I already posted #1 previously.  I'm including them both here because
I don't think it's been picked up in case folks want to pull these
all in a single bundle.

Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>p
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
