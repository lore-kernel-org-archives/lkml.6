Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032821AbeBONZ5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:25:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:55155 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032283AbeBONZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:25:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="17900715"
Subject: [PATCH 0/3] Use global pages with PTI
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        luto@kernel.org, torvalds@linux-foundation.org, keescook@google.com,
        hughd@google.com, jgross@suse.com, x86@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 15 Feb 2018 05:20:53 -0800
Message-Id: <20180215132053.6C9B48C8@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later verions of the KAISER pathces (pre-PTI) allowed the user/kernel
shared areas to be GLOBAL.  The thought was that this would reduce the
TLB overhead of keeping two copies of these mappings.

During the switch over to PTI, we seem to have lost our ability to have
GLOBAL mappings.  This adds them back.

Did we have some reason for leaving out global pages entirely?  We
_should_ have all the TLB flushing mechanics in place to handle these
already since all of our kernel mapping changes have to know how to
flush global pages regardless.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
