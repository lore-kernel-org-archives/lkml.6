Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2473C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8718B21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8718B21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJDOjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:39:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727287AbeJDOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:39:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 569FFAE0B;
        Thu,  4 Oct 2018 07:47:26 +0000 (UTC)
Date:   Thu, 4 Oct 2018 09:47:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jann Horn <jannh@google.com>
cc:     Casey Schaufler <casey.schaufler@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
In-Reply-To: <CAG48ez1+9Bfadu4y4TzPYJfFpLk+N8w7GdCE+xwNCM5TfQ8W8Q@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1810040942110.14430@cbobk.fhfr.pm>
References: <20180926203446.2004-1-casey.schaufler@intel.com> <20180926203446.2004-3-casey.schaufler@intel.com> <CAG48ez3_XJYCURiCurDeCousGguGUdPego30j5+UF8FebWxUtA@mail.gmail.com> <99FC4B6EFCEFD44486C35F4C281DC673214625EA@ORSMSX107.amr.corp.intel.com>
 <CAG48ez1+9Bfadu4y4TzPYJfFpLk+N8w7GdCE+xwNCM5TfQ8W8Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Jann Horn wrote:

> > Yes. Since the PTRACE_MODE_NOAUDIT was in PTRACE_MODE_IBPB in Jiri's 
> > previous patch set and not in PTRACE_MODE_SCHED in this one I assumed 
> > that there was a good reason for it.
> 
> Jiri, was there a good reason for it, and if so, what was it?

[ FWIW PTRACE_MODE_NOAUDIT being in PTRACE_MODE_IBPB goes back to original 
  Tim's pre-CRD patchset ]

Well, we can't really call out into audit from scheduler code, and the 
previous versions of the patchsets didn't have PTRACE_MODE_SCHED, so it 
had to be included in PTRACE_MODE_IBPB in order to make sure we're not 
calling into audit from context switch code.

Or did I misunderstand the question?

Thanks,

-- 
Jiri Kosina
SUSE Labs

