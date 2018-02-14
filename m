Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161613AbeBNSAi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:00:38 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47272 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161494AbeBNSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:00:36 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        torvalds@linux-foundation.org
Cc: luto@kernel.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [PATCH 0/2] x86/entry: xorq->xorl; idtentry size reduction
Date: Wed, 14 Feb 2018 18:59:22 +0100
Message-Id: <20180214175924.23065-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches apply on top of tip/pti.

The first one cuts the idtentry macro as suggested by Linus.
I'm not sure whether this patch yet needs an explicit SOB by
him though. It was previously sent as RFC / testing only patch
"8/7" to the previous x86/entry-related series, cf.
http://lkml.kernel.org/r/20180211104949.12992-9-linux@dominikbrodowski.net

The other one replaces the xorq-based register cleaning with an
equivalent xorl-based version, which is supposed to be faster on
some architectures.

Thanks,
	Dominik

Dominik Brodowski (2):
  x86/entry: reduce static footprint of idtentry
  x86/entry/64: use xorl for register clearing

 arch/x86/entry/calling.h         | 27 +++++++++++++-------
 arch/x86/entry/entry_64.S        | 18 ++++++--------
 arch/x86/entry/entry_64_compat.S | 54 ++++++++++++++++++++--------------------
 3 files changed, 53 insertions(+), 46 deletions(-)

-- 
2.16.1
