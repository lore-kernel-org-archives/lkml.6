Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A7C2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xxOHXDUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A7C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQTHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbeGQTHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:07:22 -0400
Received: from jouet.infradead.org (179.176.5.34.dynamic.adsl.gvt.net.br [179.176.5.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E07F206B8;
        Tue, 17 Jul 2018 18:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531852409;
        bh=hldrYtCkeK6m/x0UY0ykSmP9n2xLpcRdb5FuugB6oGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxOHXDUVO6ZjQxj25aIrJ2QGOE9EEQ8SoM3tYdL6e2EBNm2D7UdK2FQXU2z11mz3K
         32OsfU3HxyF+vICsFvPj4A8jTzpY91Agx63pjER+vKf4Jh1ujjBs1i/LCR7rkiNCz6
         FixCj2K7uPxkstJoLya9ACITvmvR7PvomJRF9wpU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 6B3B814486C; Tue, 17 Jul 2018 15:33:26 -0300 (-03)
Date:   Tue, 17 Jul 2018 15:33:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sangwon Hong <qpakzk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf list: Document missing options
Message-ID: <20180717183326.GC3614@kernel.org>
References: <20180717110738.10779-1-qpakzk@gmail.com>
 <20180717182852.GB3614@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717182852.GB3614@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 17, 2018 at 03:28:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jul 17, 2018 at 08:07:38PM +0900, Sangwon Hong escreveu:
> > Add the missing options --desc and --debug on the man page.
> 
> Please describe how you tested this, i.e. what difference makes using
> this option you are describing?

Also please make the summary line more descriptive, I've changed it from:

  perf list: Document missing options

To:

  perf list: Add missing documentation for --desc and --debug options

So that when one uses:

  git log --oneline

we get this extra bit of info. Also what is missing is the documentation
for the options, not the options :-)

- Arnaldo
