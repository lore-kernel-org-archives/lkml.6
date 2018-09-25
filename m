Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD45FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F420645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8b7og9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1F420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeIYUoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbeIYUoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:44:44 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA63D20645;
        Tue, 25 Sep 2018 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537886216;
        bh=tny+gSzjmdwE72pJ3yle5vpd2KVUl8AtCIeIbpoElWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8b7og9eR87FX2PEIRErExXeRGN0y5PRh1y0W1TIX8zoZObirYeb9pSGt90h5Mogi
         03kSDRDdO49HlRX8KzKX2YJyMmLxoNRk3Wh5rd2Ur/pcDvC4U/jTBRS6mPbRAyycFg
         yddeFWyUAJ0uxnv55K6u5x1JDgT/zaW3QXydKpvY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8C3E11401A1; Tue, 25 Sep 2018 11:36:53 -0300 (-03)
Date:   Tue, 25 Sep 2018 11:36:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf script python: Database export fixes
Message-ID: <20180925143653.GA3541@kernel.org>
References: <20180911114504.28516-1-adrian.hunter@intel.com>
 <b7a7a61a-9b2b-5f93-9d12-01b52d6034e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a7a61a-9b2b-5f93-9d12-01b52d6034e4@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 25, 2018 at 02:08:06PM +0300, Adrian Hunter escreveu:
> On 11/09/18 14:45, Adrian Hunter wrote:
> > Hi
> > 
> > Here are a couple of database export fixes.
> > 
> > 
> > Adrian Hunter (2):
> >       perf script python: Fix export-to-postgresql.py occasional failure
> >       perf script python: Fix export-to-sqlite.py sample columns
> > 
> >  tools/perf/scripts/python/export-to-postgresql.py | 9 +++++++++
> >  tools/perf/scripts/python/export-to-sqlite.py     | 6 +++++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> Please consider these

Applied to perf/urgent, please consider using the Fixes: tag, so that
the stable guys have a easier time (automatically even) figuring out how
far back the patch should be applied.

Thanks!

- Arnaldo
