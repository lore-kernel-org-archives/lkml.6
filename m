Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAABFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F6320658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F6320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIEXOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:14:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:51616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbeIEXOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:14:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E64EAACDB;
        Wed,  5 Sep 2018 18:42:54 +0000 (UTC)
Date:   Wed, 5 Sep 2018 20:42:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
In-Reply-To: <20180905184018.GC11625@redhat.com>
Message-ID: <nycvar.YFH.7.76.1809052041380.15880@cbobk.fhfr.pm>
References: <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm> <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com> <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809042046180.15880@cbobk.fhfr.pm> <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com> <nycvar.YFH.7.76.1809050725390.15880@cbobk.fhfr.pm> <20180905155823.GL27886@tassilo.jf.intel.com> <20180905180459.GB11625@redhat.com>
 <nycvar.YFH.7.76.1809052026470.15880@cbobk.fhfr.pm> <20180905184018.GC11625@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Andrea Arcangeli wrote:

> Perhaps you didn't sandbox KVM inside selinux by default?

We by default do not enable selinux, so that's probably why.

Thanks again, will go through the code in mainline and adapt the patch 
before sending v4.

-- 
Jiri Kosina
SUSE Labs

