Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6365C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDE0217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545125037;
	bh=7cdVCrxP7GB+O+PB95PHzQLlLFvRGRv9nksy/CtwW08=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=EhFOePanbcn7hY6/SBB4jEqR8pZSVbEqw+pswyZs79VviQhItR9QpX1U1NU6VjyAY
	 KwTM/JsSvTE0bQ0+qVuuNrFU2oA3WnDVDMdRIXGBjsQ2V+p2DMdfHNHJjHQO28fysR
	 CMxLVyKuh/s4MpN7IVXvpD5c3yr6RbApKAcO1TKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLRJX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:23:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeLRJXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:23:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE1AAAC3C;
        Tue, 18 Dec 2018 09:23:53 +0000 (UTC)
Date:   Tue, 18 Dec 2018 10:23:53 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] livepatch: check kzalloc return values
In-Reply-To: <1544806570-21299-2-git-send-email-hofrat@osadl.org>
Message-ID: <nycvar.YFH.7.76.1812181023230.17216@cbobk.fhfr.pm>
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org> <1544806570-21299-2-git-send-email-hofrat@osadl.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Nicholas Mc Guire wrote:

> kzalloc() return should always be checked - notably in example code
> where this may be seen as reference. On failure of allocation in
> livepatch_fix1_dummy_alloc() respectively dummy_alloc() previous
> allocation is freed (thanks to Petr Mladek <pmladek@suse.com> for
> catching this) and NULL returned.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 439e7271dc2b ("livepatch: introduce shadow variable API")

Applied to for-4.21/upstream, thanks.

-- 
Jiri Kosina
SUSE Labs

