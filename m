Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98330C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 04:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A966217BD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 04:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A966217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeHEG4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 02:56:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:47835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeHEG4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 02:56:34 -0400
Received: from homer.simpson.net ([185.221.151.118]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcT2M-1gAp8W1qSM-00joyQ; Sun, 05
 Aug 2018 06:52:58 +0200
Message-ID: <1533444777.9157.10.camel@gmx.de>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
From:   Mike Galbraith <efault@gmx.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sun, 05 Aug 2018 06:52:57 +0200
In-Reply-To: <1533385520.5602.31.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <1533192980.11791.8.camel@gmx.de>
         <20180802123104.7fed73b4@gandalf.local.home>
         <1533228650.12550.15.camel@gmx.de> <1533231816.12550.54.camel@gmx.de>
         <1533385520.5602.31.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bFU7AozI/I+9ClIcQLKd9I891EVj9KidFWdtVPI8vTqD6rXsKwb
 fJEjN90vwrt/sGzXFKQfpGLFwbE9xkI+VTABujAp6mkClu+zTfw84d9vkXr3PktrqT9ffJZ
 1Rtp7Wn+VqOSF9Z8uxLrczdqGzO3I8w+/dMfVyv1U+itSv+/lJLuTldkbZtbEnf0nBZeBPQ
 TYAPrg9REtROMckzcP5ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wY6qf4oKuWc=:lKcE8SDNN4DqA0joxOT0QT
 zvTgW3nP0Q88m41ZUQVfq00zOWqCBN7sXuVhV+Mqy1WtVdJp3IqzCyJjSkq1K4T3a3YlxJTb/
 t4csM3ifbdD8+3BG+yShpwS9QrCJSCZy5qzVdg/t7DJXm3GtMb+4Cf/Sj1xrquiAJKbZQvRlH
 UbNErrffSugS0iLeblXzJ22PgRmKaoKBsnnLp1vMca5o+8his3CVh0QgTiIHDm8fX+X5gtRk6
 X49e0Zq4qnKwvfs872/fj9E/+gTK1AgYCC9IGu1GQvCg/HLRw11loYp57KYsLzZevhtOA/WWf
 l0EqrJq2QgDOvKmG62bPKP5unRH37eazdV1GhxmJR7vy72en75TJIfnd/HVta0m/9qZQ2JXK9
 Bpb9QkcjI2Z/C49nu3c5H55pota1s7R7lgu3BHq/qhHsy4IL3aDHlX/sQK6rmfGGx1l78+Ppk
 JcvKJr5OaC3jezRdBOyx+VoGyZKuX5Cw5EF+bcjZCBywMFZpagKvhKcqCmtgxZJL20Q75uD4x
 7gbencaFtODd2hieeioX17xy26Am3xtW6xBvBhH8IdRWDHaQ/qE+ePRh/BsNmAJK+vx6z9ucT
 m4JLsbB9msH0cexzegwjKk65o+Ao2d33MZWd7FhlwXbZzYOKKimvfMgB7zBwwtYWRuu5ATkQ1
 1XVd8KQ4plMCKkP6Hpq9ZLek0oDWea0MkiNLD39KRseCnQI2oqqiy7AI/BxG/zbDtAfbNLTeS
 ETqb/W6WWR/HhsNjJHKkZnzd3jc192e1GjTbes3uIc0Hw4P8bWeoyRzVBf1ZQ48RsTMSyJdwB
 dI6LPdQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 14:25 +0200, Mike Galbraith wrote:
> 
> Besides, there are more interesting fish in the arm64 sea than kvm.
> 
> virgin 4.16.18-rt12-rt
> 
> [  537.236131] ITS queue timeout (65440 65504 4640)
> [  537.236150] ITS cmd its_build_inv_cmd failed

FWIW, I had thought that something 4.16..master had made that business
go entirely away, but it only became much more infrequent.  So much for
plan to slowly sneak up on whatever than was via ~bisect.

