Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA2FFF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9EC20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9EC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeG2NSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:18:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:42235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeG2NSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:18:09 -0400
Received: from homer.simpson.net ([185.221.148.245]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvUwp-1gAJbL3RR5-010bKs; Sun, 29
 Jul 2018 13:47:48 +0200
Message-ID: <1532864867.1618.32.camel@gmx.de>
Subject: Re: candidates for @devel-rt localversion-rt++
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 29 Jul 2018 13:47:47 +0200
In-Reply-To: <1532847330.1618.8.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DdeYjcAecvzKWsJbo+d8cMoZY+ntwcGolLTYNPMW4wNJvOderCm
 2RrwZYnh9LwZhoOAC5RC3020qW3xGQw7xM2hFeH7iNpL4s4jlMAc9FE4pItaGkoEXPCswxM
 ieD4fn9EK8hbPhKgJbxy38FCXuItYefFQ++Dz/pTOhiw9omcvCymxsbnRLCYW4M9FaEPhlR
 PrfcPM+JStDPBYnMITdgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D+litNtwTts=:mxLEb/tPapnRQBlumM+l8T
 X006n3tMsbNpejcq1LxNd0gQXnujYB54W/tsN73P0dP38Juglqt3GRmJtBvoJx36cwUq715NL
 5SdkLWSrgyPF31IA6O/QOOeQAjYNTboz4r8xl0psVRx5cTsOtmXopb44+qRz15QJ6UWtYZpsB
 CK+1Z2XltUyAP6HNd7ThNsm+Yy6Kr6Sf08IRec5DDAQNxfShR3Z1E8tXyYgt1KJtm94fpcvXv
 hc6DmBHYYA1fGCQJ37aTKiN2Jlp9ZVQmsK6Mmw7XuvFhZjppdF+Yf9utMNVGdQ9L+B4sPvBCv
 ml+NKpTeRuPR1wVCyPr8v4NUJvr2JwvJXktwciaV6FhMYrmF8cySusZTDSIPcHmpHojR0S445
 wW24wssMmAt8G9wuu+Ykg0byOaHQnWs8lrmdibCgk2W7CAO2wNmkzaj6ORNTh0NB9QgXPNy8x
 VAln3ggb06nHT8aVRO5608bsu3FXQ3jgaSuL68dcdxI7tYLo+U/ftbRnAvPB8vEyeDHgepcHo
 tj1IefmljqDNLVnqSlJolK3GTEfOQlK1gfD9ycBVnl8t1DRAzGYAg3Ftd4abZnyBctISvK7mu
 ubwc1G48PMCU+sivNMCjHaw2vjRfSDL0XUoNwuJnz3V5AAZV2/nc/TwShDh+prJ0MmzX447iw
 a48WR5uuRnLHI0TWk9ISQySrNqRnTW4ab+3IVVbdR2LtZCabboS+msrZdkMTXhht27t4h6j4v
 2Wt7/KP3nin4/OPjJy9Ua4vn6dKEUa5ZZbqZqEpr6iZV2v6getaMoctGAC9DPLNx2yOYnmoe4
 QvxLNHQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, per kvm unit tests, 4.16-rt definitely has more kvm issues.

huawei5:/abuild/mike/kvm-unit-tests # uname -r
4.16.18-rt11-rt
huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
PASS selftest-setup (2 tests)
FAIL selftest-vectors-kernel 
FAIL selftest-vectors-user 
PASS selftest-smp (65 tests)
PASS pci-test (1 tests)
PASS pmu (3 tests)
FAIL gicv2-ipi 
FAIL gicv3-ipi 
FAIL gicv2-active 
FAIL gicv3-active 
PASS psci (4 tests)
FAIL timer 
huawei5:/abuild/mike/kvm-unit-tests #

4.14-rt passes all tests.  The above is with the kvm raw_spinlock_t
conversion patch applied, but the 4.12 based SLERT tree I cloned to
explore arm-land in the first place shows only one timer failure, and
has/needs it applied as well, which would seem to vindicate it.

huawei5:/abuild/mike/kvm-unit-tests # uname -r
4.12.14-0.gec0b559-rt
huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
PASS selftest-setup (2 tests)
PASS selftest-vectors-kernel (2 tests)
PASS selftest-vectors-user (2 tests)
PASS selftest-smp (65 tests)
PASS pci-test (1 tests)
PASS pmu (3 tests)
PASS gicv2-ipi (3 tests)
PASS gicv3-ipi (3 tests)
PASS gicv2-active (1 tests)
PASS gicv3-active (1 tests)
PASS psci (4 tests)
FAIL timer (8 tests, 1 unexpected failures)
huawei5:/abuild/mike/kvm-unit-tests #
