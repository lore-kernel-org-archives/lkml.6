Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEOWdP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:33:15 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:39311 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeEOWdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:33:14 -0400
Date: Tue, 15 May 2018 23:32:11 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] MIPS: DSP ASE regset support
Message-ID: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526423542-853316-32019-19570-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 For years, quite oddly, we have been missing DSP ASE register state from 
core files.  These days regsets are used to define what goes into a core 
file, so here's a change adding one.

 As a side effect ptrace(2) can now also access this regset, however no 
complementing client implementation has been made.  Eventually that'll 
have to change though so that DSP ASE registers can be correctly accessed 
in n32 processes, which suffer from ptrace(2) 32-bit data types truncating 
contents exchanged by PTRACE_PEEKUSR and PTRACE_POKEUSR requests with 
64-bit registers and no means defined to access partial registers via this 
API.

 In the course of this implementation I came across two bugs affecting the 
area being updated and hence this has become a small patch series with the 
audience wider than originally expected.

 See individual commit descriptions for the details of changes made.  

 NB there is no strict functional dependency between 1/3 and 2/3-3/3, so 
the order of commits does not have to be preserved as far as these two 
subsets are concerned.  However 3/3 does trigger the problem addressed 
with 1/3 (and gracefully handles it), hence the grouping in a series.

 Please apply.

  Maciej
