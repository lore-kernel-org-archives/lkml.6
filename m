Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeFEQns (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:43:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46799 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeFEQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:43:46 -0400
From: Michal Suchanek <msuchanek@suse.de>
To: Jonathan Corbet <corbet@lwn.net>, Michal Suchanek <msuchanek@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Aaron Wu <Aaron.Wu@analog.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt," <rostedt@goodmis.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Ilya Matveychikov <matvejchikov@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/5] Kernel parameter parser cleanup/enhancement
Date: Tue,  5 Jun 2018 18:43:07 +0200
Message-Id: <cover.1528215659.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

due to work on the fadump_extra_args I looked at the kernel parameter parser
and found its grammar rather curious.

It supports double quotes but not any other quoting characters so double quotes
cannot be quoted. What's more, the quotes can be anywhere in the parameter
name or value and are interpteted but are removed only from start and end of
the parameter value.

These are the patches not specific to fadump which somewhat straighten the
qouting grammar to make it on par with common shell interpreters.

Specifically double and single quotes can be used for quoting as well as
backslashes with the usual shell semantic. All quoting characters are removed
while the parameters are parsed.

Previous versions (including the fadump part) can be found here:

https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg126148.html
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg123639.html

Thanks

Michal

Michal Suchanek (5):
  lib/cmdline.c: Add backslash support to kernel commandline parsing.
  Documentation/admin-guide: backslash support in kernel arguments.
  init/main.c: simplify repair_env_string.
  lib/cmdline.c: Implement single quotes in commandline argument
    parsing.
  Documentation/admin-guide: single quotes in kernel arguments.

 Documentation/admin-guide/kernel-parameters.rst |  5 +-
 init/main.c                                     | 13 ++---
 lib/cmdline.c                                   | 63 +++++++++++++++----------
 3 files changed, 46 insertions(+), 35 deletions(-)

-- 
2.13.6
