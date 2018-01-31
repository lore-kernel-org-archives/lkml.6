Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeAaNYw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:24:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeAaNYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:24:51 -0500
Date: Wed, 31 Jan 2018 07:24:49 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: mingo@kernel.org, hpa@zytor.com, tim.c.chen@linux.intel.com,
        dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [tip:x86/pti] x86/speculation: Use Indirect Branch Prediction
 Barrier in context switch
Message-ID: <20180131132449.qnfj32gufhgjc262@treble>
References: <1517263487-3708-1-git-send-email-dwmw@amazon.co.uk>
 <tip-18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7@git.kernel.org>
 <20180131070300.GA28206@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180131070300.GA28206@light.dominikbrodowski.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 08:03:00AM +0100, Dominik Brodowski wrote:
> On Tue, Jan 30, 2018 at 02:39:45PM -0800, tip-bot for Tim Chen wrote:
> > Commit-ID:  18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
> > Gitweb:     https://git.kernel.org/tip/18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
> > Author:     Tim Chen <tim.c.chen@linux.intel.com>
> > AuthorDate: Mon, 29 Jan 2018 22:04:47 +0000
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Tue, 30 Jan 2018 23:09:21 +0100
> > 
> > x86/speculation: Use Indirect Branch Prediction Barrier in context switch
> > 
> > Flush indirect branches when switching into a process that marked itself
> > non dumpable. This protects high value processes like gpg better,
> > without having too high performance overhead.
> 
> For the record, I am still opposed to limit this to non-dumpable processes.
> Whether a process needs protection by IBPB on context switches is a
> different question to whether a process should be allowed to be dumped,
> though the former may be a superset of the latter. In my opinion, IBPB
> should be enabled on all context switches to userspace processes, until we
> have a clear mitigation strategy for userspace against Spectre-v2 designed
> and implemented.
> 
> Thanks,
> 	Dominik
> 
> --------------------------
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Date: Wed, 31 Jan 2018 07:43:12 +0100
> Subject: [PATCH] x86/speculation: Do not limit Indirect Branch Prediction Barrier to non-dumpable processes
> 
> Whether a process needs protection by IBPB on context switches is a
> different question to whether a process should be allowed to be dumped,
> though the former may be a superset of the latter. Enable IBPB on all
> context switches to a different userspace process, until we have a clear
> mitigation strategy for userspace against Spectre-v2 designed and
> implemented.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
