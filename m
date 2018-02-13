Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966083AbeBMXXq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:23:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:2586 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965783AbeBMXXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:23:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="31185434"
Subject: [PATCH 0/3] Use global pages with PTI
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 13 Feb 2018 15:19:27 -0800
Message-Id: <20180213231927.32581D84@viggo.jf.intel.com>
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
