Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224oQPEFLhziWUQTcVGfX7HbxpQaT4uZ5gUQii5FFIF4rWVlE7JXJujURS+p4cVTKL/MJ+ip
ARC-Seal: i=1; a=rsa-sha256; t=1518347506; cv=none;
        d=google.com; s=arc-20160816;
        b=Xnx3zEwg14076Vzz48VY/LyF86K2D7MJjcmz5gCVCMY2DzypayImJcaZkcSjX40opo
         mgiVldO9/RSQKEZ9FD7JtS4RWXn35MdLNIaXfUtYrLj2GJ7Q8LrAuEFOynD5Yxfyq++C
         GxtwMpN1tqdWZa7lgLh/DuLd+iv4FkJrFiWFDp0n2oizyqk+Dwaebj35rqymYHmduOzg
         s/yNFH0uBLRpYysk7WknT6PRIHuB5w4cRz0s40yJ2+TbNQ/Rl+ccwDd3TbtmC7mu3G/i
         /IhU2K/0h3p0U405Zj00wZTeXUc9U5xgRdtvs0odqcOV3bk9G8Dm68lVsHM+4/S+WT3B
         jFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=sFo9/1DIKp/yBJopafLQrb1rkSxEepOkheU8YDW7+dI=;
        b=Q/3uSFBCEb+a3Tvi27cI15gCr+sPsOPI+fM0Eoe0WK8Ifhdnz3lrjG6sBczI9G7Hzl
         F4TL1zBRPm3Gx/DZm4KFjehj6niDIIK9spt14gGtc1fFk+s7XpJSThgjmt7yBEJnzEke
         Iit7O2+Lg6fwMEp5KAh2D9vC7xLvTYg7XON3x2IhuH7YYD2z60KEouTpid5tcHSMzhla
         3vmLTBpsZur48z6uurpfZ330/FDP79mW7prDg+uVSQyJJmJ5H3ry2ANCKbYrvS+hqK90
         fLcg5KMHKIfqOoDqneWQ+JJlGljyp5obilsVEPZHMBQpeZeG1Ar2hi8v3pMjWWIvEQho
         dMcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeBKLLU (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:11:20 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:40658 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeBKLLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:11:05 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org
Subject: [PATCH 0/5] selftests/x86: fixes for !CONFIG_IA32_EMULATION and vsyscall=none
Date: Sun, 11 Feb 2018 12:10:08 +0100
Message-Id: <20180211111013.16888-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102754687804352?=
X-GMAIL-MSGID: =?utf-8?q?1592102754687804352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On systems with CONFIG_IA32_EMULATION disabled and vsyscall disabled, a
couple of selftests fail spectacularly.

Also throw in a fix for the Makefile, which still wants to build the moved
5lvl test.

Dominik Brodowski (5):
  selftests/x86: 5lvl test has been moved
  selftests/x86: fix vDSO selftest segfault for vsyscall=none
  selftests/x86: do not rely on int $0x80 in test_mremap_vdso.c
  selftests/x86: do not rely on int $0x80 in single_step_syscall.c
  selftests/x86: disable tests requiring 32bit support on pure 64bit
    systems

 tools/testing/selftests/x86/Makefile              | 24 +++++++----
 tools/testing/selftests/x86/single_step_syscall.c |  5 ++-
 tools/testing/selftests/x86/test_mremap_vdso.c    |  4 ++
 tools/testing/selftests/x86/test_vdso.c           | 50 +++++++++++++++++++----
 4 files changed, 67 insertions(+), 16 deletions(-)

-- 
2.16.1

