Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030530AbeEYVlA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:41:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:57884 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030314AbeEYVk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:40:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="scan'208";a="231897493"
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] x86/mce fixes
Date: Fri, 25 May 2018 14:40:58 -0700
Message-Id: <cover.1527283897.git.tony.luck@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two just get better error messages when we refuse to recover
from an error that the h/w says is recoverable because the error occurred
in a non-recoverable part of the kernel.

The third improves identification of Skylake SKUs that support
recovery.

Tony Luck (3):
  x86/mce: Improve error message when kernel cannot recover.
  x86/mce: Fix incorrect "Machine check from unknown source" message
  x86/mce: Check for alternate indication of machine check recovery on
    Skylake

 arch/x86/kernel/cpu/mcheck/mce-severity.c |  5 +++++
 arch/x86/kernel/cpu/mcheck/mce.c          | 26 ++++++++++++++++-------
 arch/x86/kernel/quirks.c                  | 11 ++++++++--
 3 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.17.0
