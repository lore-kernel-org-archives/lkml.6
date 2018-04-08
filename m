Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeDHUSh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeDHUSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2D321785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201708.346970379@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 00/23] ktest: Updates for 4.17
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long overdue, lots of these patches were either in my inbox or
being used by my local machines. Finally, they are getting out
to the public!

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: c2d84ddb338c829e3ee9d1af6a55325998fcdb82


Scott Wood (4):
      ktest: Clarify config file usage
      ktest: Set buildonly=1 for CONFIG_BISECT_TYPE=build
      ktest: Set do_not_reboot=y for CONFIG_BISECT_TYPE=build
      ktest: Use config-bisect.pl in ktest.pl

Steven Rostedt (Red Hat) (1):
      ktest: Add standalone config-bisect.pl program

Steven Rostedt (VMware) (14):
      ktest: Wait for console process to exit
      ktest: Add CONNECT_TIMEOUT to change the connection timeout time
      ktest: Comment about other names than just ktest.conf
      ktest.pl: Allow for the config-bisect.pl output to display to console
      ktest.pl: Use diffconfig if available for failed config bisects
      ktest.pl: Have ktest.pl pass -r to config-bisect.pl to reset bisect
      ktest.pl: Make finding config-bisect.pl dynamic
      ktest.pl: Detect if a config-bisect was interrupted
      ktest.pl: No need to print no mailer is specified when mailto is not
      ktest.pl: Add MAIL_PATH option to define where to find the mailer
      ktest.pl: Kill test if mailer is not supported
      ktest.pl: Allow dodie be recursive
      ktest.pl: Use run_command to execute sending mail
      ktest.pl: Add MAIL_COMMAND option to define how to send email

Tim Tianyang Chen (4):
      Ktest: Add email support
      Ktest: Add SigInt handling
      Ktest: Use dodie for critical falures
      Ktest: add email options to sample.config

----
 tools/testing/ktest/config-bisect.pl | 770 +++++++++++++++++++++++++++++++++++
 tools/testing/ktest/ktest.pl         | 531 ++++++++++++------------
 tools/testing/ktest/sample.conf      |  60 +++
 3 files changed, 1090 insertions(+), 271 deletions(-)
 create mode 100755 tools/testing/ktest/config-bisect.pl
