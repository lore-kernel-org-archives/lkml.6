Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756889AbeDZVgY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753964AbeDZVgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:36:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4827C21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH 0/3] PM / core: Clean up suspend/resume diagnostic messages
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Apr 2018 16:36:20 -0500
Message-ID: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are pretty minor cleanups to the suspend/resume diagnostic messages.

The first two are trivial.  The third may break scripts that parse dmesg
output.  I looked at scripts/bootgraph.pl, and I don't think it is
affected, but there may be others I don't know about.  Let me know if there
are.

---

Bjorn Helgaas (3):
      PM / core: Remove unused initcall_debug_report() arguments
      PM / core: Simplify initcall_debug_report() timing
      PM / core: Use dev_printk() and symbols in suspend/resume diagnostics


 drivers/base/power/main.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)
