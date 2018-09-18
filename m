Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D39C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04E4214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0MvhCB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04E4214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeIRSr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbeIRSr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:47:56 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90025214FF;
        Tue, 18 Sep 2018 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537276522;
        bh=4wINaoylqFTSX3pYDbtz4QZKCX2PMKfeV8RDVP0uQho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0MvhCB2k7a+X98fydr6cDBPv+csdVyUjEa7TrVo6MoGAj+yvv+642XDLkv2ucWkP
         bH23kP7ef5XG4sfqUX/WutC4dG4Nkjk+249p+ESfPrfWSbWwEf6O71OxQFqebWewYI
         YwKD4njiZH9AA7eoTB912AKIjElau4ZwpdWkDHPk=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8A81E140260; Tue, 18 Sep 2018 10:15:17 -0300 (-03)
Date:   Tue, 18 Sep 2018 10:15:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC/fix] Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180918131517.GA32227@kernel.org>
References: <20180910172903.GB15516@kernel.org>
 <20180911122218.0d2eb3f9@cakuba>
 <20180911121543.GB22689@kernel.org>
 <20180911212451.hvnyfwyvcs4yojqy@ast-mbp>
 <20180913183240.GF30969@kernel.org>
 <20180913185629.su22fnimluoezntg@ast-mbp>
 <20180917151636.GA21790@kernel.org>
 <20180918005256.7uutwda4s3ofoxpd@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918005256.7uutwda4s3ofoxpd@ast-mbp>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 17, 2018 at 05:52:59PM -0700, Alexei Starovoitov escreveu:
> > +++ b/tools/lib/bpf/str_error.h
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.1
> 
> LGPL-2.1 in the above?

Sure, will fix.
 
> The rest looks good to me.

Will that that as an Acked-by: you, ok?

> Should we take it via bpf-next tree?

No need, I have it already in perf/urgent, will push shortly to Ingo.

Thanks,

- Arnaldo

> If you feel there is an urgency to fix musl build, we can take it via bpf tree too.
> 
> Jakub, thoughts? you've been messing with strerror last..
