Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16887C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCCE21A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRpzG8lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCCE21A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbeHFU6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeHFU6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:58:43 -0400
Received: from jouet.infradead.org (unknown [177.79.80.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D5B21A16;
        Mon,  6 Aug 2018 18:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533581299;
        bh=b2akAkfBQkugpAbX+dIHKvat3J97jEurDFRRUrCxKNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRpzG8lRFp8OmYQJWBQpvswQ6ztk+Vm5DHORIaKzq7ogx8E9R5tNBg52y2FPPh5TD
         h0DmrL9UL6m1eT6tH+bsk7pfAxkRS4XgrokuqwSUSnr3n5ZUmvTa4IycaK0+Fp3xe4
         mx+cDGJlG4DcFsFFklvp0jbBm7akE2I5V6AztOUs=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D4BBC140A1C; Mon,  6 Aug 2018 15:48:14 -0300 (-03)
Date:   Mon, 6 Aug 2018 15:48:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 20/20] perf report: Add --percent-type option
Message-ID: <20180806184814.GF22917@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-21-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-21-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 04, 2018 at 03:05:21PM +0200, Jiri Olsa escreveu:
> Set annotation percent type from following choices:
>   global-period, local-period, global-hits, local-hits
> 
> With following report option setup the percent type will be
> passed to annotation browser:
> 
>   $ perf report --percent-type period-local
> 
> The local/global keywords set if the percentage is computed
> in the scope of the function (local) or the whole data (global).
> The period/hits keywords set the base the percentage is computed
> on - the samples period or the number of samples (hits).

Tested, applied,

- Arnaldo
