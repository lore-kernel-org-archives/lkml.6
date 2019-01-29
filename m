Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5034C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688C120881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548805837;
	bh=XAuxQaJjIX4bV3TFPEDE6QnuExB2Ni9coaAoODm6xCM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=YNo7bmkrXW7nEnITDYCV8Q8R2inOEVoRas7j8HbQESXMy7RFRzqJKADwVs4ze8EBq
	 QpkXzErF2rQU0cumJ0ucW0G9LRvQF/TkzEwHnacjavwBElQCqb+wKRmjied9p1ngoO
	 47VZZVzOIisLblS43My3/YTPLvsg4tpMqsUrz3DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfA2Xuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:50:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:58118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbfA2Xuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:50:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C00A8AE4B;
        Tue, 29 Jan 2019 23:50:33 +0000 (UTC)
Date:   Wed, 30 Jan 2019 00:50:32 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 0/4] powerpc/livepatch: reliable stack unwinder fixes
In-Reply-To: <20190122155724.27557-1-joe.lawrence@redhat.com>
Message-ID: <nycvar.YFH.7.76.1901300049470.6626@cbobk.fhfr.pm>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019, Joe Lawrence wrote:

> This patchset fixes a false negative report (ie, unreliable) from the
> ppc64 reliable stack unwinder, discussed here [1] when it may
> inadvertently trip over a stale exception marker left on the stack.
> 
> The first two patches fix this bug.  Nicolai's change clears the marker
> from the stack when an exception is finished.  The next patch modifies
> the unwinder to only look for such on stack elements when the ABI
> guarantees that they will actually be initialized.
> 
> The final two patches consist of code cleanups that Nicolai and I
> spotted during the development of the fixes.
> 
> Testing included re-running the original test scenario (loading a
> livepatch module on ppc64le) on a 5.0.0-rc2 kernel as well as a RHEL-7
> backport.  I ran internal tests on the RHEL-7 backport and no new test
> failures were introduced.  I believe that Nicolai has done the same
> with respect to the first patch.
> 
> [1] https://lore.kernel.org/lkml/7f468285-b149-37e2-e782-c9e538b997a9@redhat.com/
> 
> Joe Lawrence (3):
>   powerpc/livepatch: relax reliable stack tracer checks for first-frame
>   powerpc/livepatch: small cleanups in save_stack_trace_tsk_reliable()
>   powerpc/livepatch: return -ERRNO values in
>     save_stack_trace_tsk_reliable()
> 
> Nicolai Stange (1):
>   powerpc/64s: Clear on-stack exception marker upon exception return

Michael, are you fine with this going through LP tree, or do you plan to 
take it through yours?

Thanks,

-- 
Jiri Kosina
SUSE Labs

