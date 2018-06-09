Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id u5DNJ1TiG1tUfwAAmS7hNA
	; Sat, 09 Jun 2018 14:21:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2A0EA608BA; Sat,  9 Jun 2018 14:21:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A235D601C3;
	Sat,  9 Jun 2018 14:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A235D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeFIOVR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:21:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56622 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeFIOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:21:15 -0400
Received: from localhost (unknown [209.117.102.182])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 21836136B6558;
        Sat,  9 Jun 2018 07:21:15 -0700 (PDT)
Date: Sat, 09 Jun 2018 10:21:14 -0400 (EDT)
Message-Id: <20180609.102114.1940060150406660652.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 09 Jun 2018 07:21:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is a merge conflict here, just take the "HEAD" hunks and it
will all work out.  It's because I applied a signal code fix that
was already merged and then other cleanups/changes happend on top.

Other than that, this adds the privileged ADI driver from Tom
Hromatka.

Please pull, thanks a lot!

The following changes since commit fff75eb2a08c2ac96404a2d79685668f3cf5a7a3:

  Merge tag 'errseq-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux (2018-04-30 16:53:40 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 1c1ff29da6c86864e73b05d4301a2df1d161f2da:

  sparc: fix compat siginfo ABI regression (2018-06-05 11:29:42 -0700)

----------------------------------------------------------------
David S. Miller (1):
      Merge branch 'adi-driver'

Dmitry V. Levin (1):
      sparc: fix compat siginfo ABI regression

Tom Hromatka (2):
      char: sparc64: Add privileged ADI driver
      selftests: sparc64: char: Selftest for privileged ADI driver

 arch/sparc/include/uapi/asm/siginfo.h                   |   7 -
 arch/sparc/kernel/traps_32.c                            |   2 +-
 arch/sparc/kernel/traps_64.c                            |   2 +-
 drivers/char/Kconfig                                    |  12 ++
 drivers/char/Makefile                                   |   1 +
 drivers/char/adi.c                                      | 239 +++++++++++++++++++++++++++
 tools/testing/selftests/Makefile                        |   1 +
 tools/testing/selftests/sparc64/Makefile                |  46 ++++++
 tools/testing/selftests/sparc64/drivers/.gitignore      |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile        |  15 ++
 tools/testing/selftests/sparc64/drivers/adi-test.c      | 721 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/sparc64/drivers/drivers_test.sh |  30 ++++
 tools/testing/selftests/sparc64/run.sh                  |   3 +
 13 files changed, 1071 insertions(+), 9 deletions(-)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c
 create mode 100755 tools/testing/selftests/sparc64/drivers/drivers_test.sh
 create mode 100755 tools/testing/selftests/sparc64/run.sh
