Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB58C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56B82146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546000493;
	bh=KNCJG6mnd6j3VmQ3J9wajzhy/8LqmnPHYBIb2fA5Obk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ecJfaLNXSfnsVTzF1CYm/NLTQdsnAbimvshWGmtvTtPv9s+cXmcTWnLwZJ98yBFBH
	 wi4+nWfzZCWaCi0CSwd2wstw9bPe8/QJj8n5R+G9g8z0BTUb2ZX9RiRi/OaGtFUEzt
	 IV+knEHYMWcYUbLJp1qUX3eF7R9N5WiTsqiy2egM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeL1Mew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeL1Mev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:34:51 -0500
Received: from quaco.ghostprotocols.net (unknown [177.159.8.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3ECC20879;
        Fri, 28 Dec 2018 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546000491;
        bh=KNCJG6mnd6j3VmQ3J9wajzhy/8LqmnPHYBIb2fA5Obk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tAZCtJtO2Ok2CEyKehuSoPkok3epmhIBsCkHAtOn7sjOax4XuPvMkttAMNwvwXp2Z
         xPDsI7EbdEw/cwlR75mOaB2cv7QXcl5OiX8mZC9cOt0yB4Ie0MVXbihlpJG4wfm1wF
         Fqz1fPFejCKtbkuvipspGRimpkEp3YkFJL1ue/X0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E73D40F61; Fri, 28 Dec 2018 09:34:44 -0300 (-03)
Date:   Fri, 28 Dec 2018 09:34:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH 1/2] perf c2c: Change the default coalesce setup
Message-ID: <20181228123444.GD25753@kernel.org>
References: <20181228101820.28010-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228101820.28010-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 28, 2018 at 11:18:19AM +0100, Jiri Olsa escreveu:
> Joe suggested to have the coalesce default set just to 'iaddr',
> because it's easier to read on the (default) c2c report run.
> 
> By removing pid from -c option, the c2c report will group all
> the relevant pids under instruction address bucket. User can
> always run -c pid,iaddr for more grained output on particular
> pids.

Thanks, applied.

- Arnaldo
