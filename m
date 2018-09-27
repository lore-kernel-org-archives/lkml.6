Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E58C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5897021708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="woKPMmgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5897021708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeI1B1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbeI1B1a (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:27:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF6A215F0;
        Thu, 27 Sep 2018 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538075267;
        bh=aHJ2j5XOK512K1SCz1AackvRAd9yEdcQFH7EJdWEgHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=woKPMmgP5HB6VqXiyH7YowEcEm3j3VZ3LMwMoPZQj1mlqB9ohfz2k21Cad3e+raMr
         k7iEKuv7ndg9gnfMIeZULypQA3Vo/I1taMj7cYZgP2s+HQC0LiGSABFC45OqfXgEXJ
         dSddQu8XksWpx+2LLLJfiTXGPjFT+Kz1o0hWynHM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1BF0B1401A1; Thu, 27 Sep 2018 16:07:44 -0300 (-03)
Date:   Thu, 27 Sep 2018 16:07:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH 1/3] perf report: don't try to map ip to invalid map
Message-ID: <20180927190744.GF25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926141819.GD25764@kernel.org>
 <2962236.ln4BiC7fMR@milian-kdab2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2962236.ln4BiC7fMR@milian-kdab2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 26, 2018 at 04:41:23PM +0200, Milian Wolff escreveu:
> On Wednesday, September 26, 2018 4:18:19 PM CEST Arnaldo Carvalho de Melo 
> wrote:
> > Em Wed, Sep 26, 2018 at 03:52:05PM +0200, Milian Wolff escreveu:
> > > Fixes a crash when the report encounters an address that
> > 
> > > could not be associated with an mmaped region:
> > Milian, can you spot which cset introduced this problem? So that we can
> > add a "Fixes: sha" tag in this (and the others, if needed) to help the
> > stable kernel maintainers to find which kernels this has to be
> > backported to?
> 
> The issue was introduced by
> 
> perf script: Show correct offsets for DWARF-based unwinding
> 
> This in turn got backported already a few times, at which point the 
> 2a9d5050dc84fa2060f08a52f632976923e0fa7e sha was used when referencing the 
> "Upstream commit".
> 
> Is that enough, or do you need me to find all the backported shas too?

I think it is enough, and I hope that the stable guys already handle
fixes to fixes :-)

- Arnaldo
