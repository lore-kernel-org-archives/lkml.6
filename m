Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAC8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115D3214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546967086;
	bh=iAGMvqEh4T3VJnjlbLL9BrMT+cRwthIvVtFtPI0f43Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2sAkQAoZLQv7DWs7fI9dnTQBFfD2vnjafZx7FLKXBD7l1SuiCcfAgJECogJff6xRt
	 OCm0M6VfVMjDiZ4OljbPKwafSS82kwA/qu9wEHZ/8F7+YSjdlIFOWqWY6A+F5gYcdf
	 TSX44F6/mnunlMVySURMSDc33hVv2yQmQFcmLWf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfAHREp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfAHREp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:04:45 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6829220883;
        Tue,  8 Jan 2019 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546967084;
        bh=iAGMvqEh4T3VJnjlbLL9BrMT+cRwthIvVtFtPI0f43Y=;
        h=Date:From:To:Cc:Subject:From;
        b=nqTYsk69X0nMq+/7XJp7hBIggKvqMfXDUpfm5Q5e8kTmkRIeTXiTKVF8YLPrZzFTf
         7IPYUBqr6iAQ/FT0GTDn7p6CW3S/ALuHExucKt+MmVLD0Q/TTKiogy9WS51o1aRy00
         k46mwN/5BawrQXcvn2l6Y4Xr7OiehsQPGFiKnq0M=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A940140355; Tue,  8 Jan 2019 14:04:40 -0300 (-03)
Date:   Tue, 8 Jan 2019 14:04:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: perf trace syscall table generation for powerpc with syscall.tbl
Message-ID: <20190108170440.GF28965@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

	I noticed that in:

  commit ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5
  Author: Firoz Khan <firoz.khan@linaro.org>
  Date:   Mon Dec 17 16:10:36 2018 +0530

    powerpc: generate uapi header and system call table files

powerpc now generates its syscall tables headers from a syscall.tbl just
like x86 and s390, could you please switch to using it, taking the x86
and s390 scripts as a starting point, then test on your systems
everything works?

Thanks,

- Arnaldo
