Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A2D214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545238737;
	bh=urrz9TBcuU3LLlu/sHTe3oQtJ7NKWOto+9N1dSopK7A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Uyq/hoGp91UH4mLR3D1KZYYvP8Vpq/mfnfpokDy2boFuO5lM5OZC5eabHzxmUPt5q
	 NoSDBKj/0gwUosqf2HGcRn1rG2YUAu7OJWdVIaiClyO2Q2CWixjb7FFYG0wLQX2aeK
	 S3pFqI17fVRbo2TR5Ix40uRHtG9NtAJPaH4QFfm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbeLSQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:58:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:36892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbeLSQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:58:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66C31B141;
        Wed, 19 Dec 2018 16:58:54 +0000 (UTC)
Date:   Wed, 19 Dec 2018 17:58:53 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Miroslav Benes <mbenes@suse.cz>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, jeyu@kernel.org, pmladek@suse.com,
        linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
In-Reply-To: <20181219165428.5udrppedpdvf2u7k@treble>
Message-ID: <nycvar.YFH.7.76.1812191756450.17216@cbobk.fhfr.pm>
References: <20181219141744.32392-1-mbenes@suse.cz> <20181219165428.5udrppedpdvf2u7k@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018, Josh Poimboeuf wrote:

> This option only makes sense for source-based patch generation, so isn't 
> it a bit premature to make this change without proper source-based patch 
> tooling?

The reality is though that before the full-fledged patch tooling exists, 
people are actually already writing livepatches by hand, so this option is 
useful for them.

> Also the commit message needs an analysis of the performance impacts.

Agreed. Especially as it's expected (*) to be completely in the noise 
particularly for the kernel, it'd be good to have that documented in the 
changelog.

(*) actually measured already for some subset of the IPA optimizations

Thanks,

-- 
Jiri Kosina
SUSE Labs

