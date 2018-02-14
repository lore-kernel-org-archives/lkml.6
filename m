Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161877AbeBNSWg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:22:36 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48078 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161747AbeBNSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:22:34 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: torvalds@linux-foundation.org, luto@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, dan.j.williams@intel.com
Subject: [RFC PATCH 0/4] x86/entry/64: interrupt entry size reduction
Date: Wed, 14 Feb 2018 19:21:09 +0100
Message-Id: <20180214182113.27247-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of the two other tip/pti-related patches
I sent out moments ago,[*] and try to implement what Linus suggested a
few days ago[+].

[+] http://lkml.kernel.org/r/20180214175924.23065-1-linux@dominikbrodowski.net
[*] http://lkml.kernel.org/r/CA+55aFwLTF3EtaQ4OpDv2UM41J=EU7gfemv=eVq+uQi31-usSg@mail.gmail.com .

Overall, these patches provide for a sizeable cutting of up to 4.35k:

   text	   data	    bss	    dec	    hex	filename
  20987	      0	      0	  20987	   51fb	entry_64.o-orig
  16621	      0	      0	  16621	   40ed	entry_64.o

They are split up in four small steps to easen the review. Another
advantage is that we can decide whether each additional step is really
worth it in relation to an increase in code complexity.

NOTE / WARNING: As usual, please be extremely stringent in reviewing these
patches.

Thanks,
	Dominik

Dominik Brodowski (4):
  x86/entry/64: move PUSH_AND_CLEAR_REGS from interrupt macro to helper
    function
  x86/entry/64: move ENTER_IRQ_STACK from interrupt macro to helper
    function
  x86/entry/64: move switch_to_thread_stack to interrupt helper function
  x86/entry/64: remove interrupt macro

 arch/x86/entry/entry_64.S | 99 +++++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 37 deletions(-)

-- 
2.16.1
