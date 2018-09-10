Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F73C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF94820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF94820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeIKAbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:31:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbeIKAbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:31:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12CCEAF8B;
        Mon, 10 Sep 2018 19:36:14 +0000 (UTC)
Date:   Mon, 10 Sep 2018 21:36:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com>
Message-ID: <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Schaufler, Casey wrote:

> Yes, It would require that this patch be tested against all the existing 
> security modules that provide a ptrace_access_check hook. It's not like 
> the security module writers don't have a bunch of locking issues to deal 
> with.

Yeah, that was indeed my concern.

So can we agree on doing this in the 2nd envisioned step, when this is 
going to be replaced by LSM as discussed [1] previously?

[1] http://lkml.kernel.org/r/99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com

Thanks,

-- 
Jiri Kosina
SUSE Labs

