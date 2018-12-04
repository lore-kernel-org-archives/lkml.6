Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D492C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102BC2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppuJ132Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102BC2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeLDONA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:13:00 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ABF52081B;
        Tue,  4 Dec 2018 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543932779;
        bh=pgn9+3aeaYQLQxl7OYALM/8tdpbpKEi6v1y4TtLN2Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppuJ132Zv/m+G9flBHm98lxqj1xiaLmIyHMtF6pQK4gjAo3Kxfnk+wdxWi19nZ7dQ
         3qhu2KYYwiI+8mEA8I007FvB2wGFv0LT/f6aoNSAHEcTkOIG7fqTnklejKwEDnuxpw
         91nbaZ1K1Z7V+UZASeMuz1v3o7bF8c9imBsSBTcs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 371EE4042C; Tue,  4 Dec 2018 11:12:55 -0300 (-03)
Date:   Tue, 4 Dec 2018 11:12:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3] perf: tests: Disable breakpoint tests on ARM (32-bit)
Message-ID: <20181204141255.GC19069@kernel.org>
References: <20181203191138.2419-1-f.fainelli@gmail.com>
 <20181204140615.GB5837@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204140615.GB5837@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 04, 2018 at 02:06:16PM +0000, Will Deacon escreveu:
> On Mon, Dec 03, 2018 at 11:11:36AM -0800, Florian Fainelli wrote:
> > breakpoint tests on the ARM 32-bit kernel are broken in several ways.
> > 
> > The breakpoint length requested does not necessarily match whether the
> > function address has the Thumb bit (bit 0) set or not, and this does
> > matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
> > background.
> > 
> > [1]: https://lkml.org/lkml/2018/11/15/205
> > 
> > As Will indicated, the overflow handling would require single-stepping
> > which is not supported at the moment. Just disable those tests for the
> > ARM 32-bit platforms and update the comment above to explain these
> > limitations.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Changes in v3:
> > 
> > - directly incorporate Will's comment, Will can you add your
> >   Signed-off-by?
> 
> Of course:
> 
> Co-developed-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks, added those and applied the patch.

- Arnaldo
