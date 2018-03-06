Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbeCFHME (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:12:04 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:55676 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeCFHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:12:03 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, kernel test robot <shun.hao@intel.com>
Date: Tue, 06 Mar 2018 01:11:03 -0600
Message-ID: <87woypy8zc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1et6lC-0000DE-7J;;;mid=<87woypy8zc.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ahY7TXcJrmDGu8J2M0JzG8TmdfEbm/xE=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4974]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15017 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.66 (0.0%), parse: 0.63 (0.0%),
        extract_message_metadata: 2.4 (0.0%), get_uri_detail_list: 0.88 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.22 (0.0%), tests_pri_-900:
        0.95 (0.0%), tests_pri_-400: 15 (0.1%), check_bayes: 15 (0.1%), b_tokenize:
        4.2 (0.0%), b_tok_get_all: 4.8 (0.0%), b_comp_prob: 1.59 (0.0%),
        b_tok_touch_all: 2.3 (0.0%), b_finish: 0.58 (0.0%), tests_pri_0: 99 (0.7%),
        check_dkim_signature: 0.39 (0.0%), check_dkim_adsp: 3.9 (0.0%),
        tests_pri_500: 14885 (99.1%), poll_dns_idle: 14879 (99.1%), rewrite_mail:
        0.00 (0.0%)
Subject: [GIT PULL] siginfo fix for v4.16-rc5
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: f6a015498dcaee72f80283cb7873d88deb07129c signal/x86: Include the field offsets in the build time checks

The kbuild test robot found that I accidentally moved si_pkey when I was
cleaning up siginfo_t.  A short followed by an int with the int having 8
byte alignment.  Sheesh siginfo_t is a weird structure.

I have now corrected it and added build time checks that with a little
luck will catch any similar future mistakes.  The build time checks were
sufficient for me to verify the bug and to verify my fix.  So they are
at least useful this once.

Eric W. Biederman (2):
      signal: Correct the offset of si_pkey in struct siginfo
      signal/x86: Include the field offsets in the build time checks

 arch/x86/kernel/signal_compat.c    | 65 ++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h             |  4 +--
 include/uapi/asm-generic/siginfo.h |  4 +--
 3 files changed, 69 insertions(+), 4 deletions(-)
