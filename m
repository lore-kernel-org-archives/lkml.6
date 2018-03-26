Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeCZR3g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:29:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:9406 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbeCZR3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:29:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="214995863"
Subject: [PATCH 0/9] [v2] x86, pkeys: two protection keys bug fixes
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, shakeelb@google.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 26 Mar 2018 10:27:21 -0700
Message-Id: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
