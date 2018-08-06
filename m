Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF87C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3096021A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO8ESIhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3096021A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbeHFRSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeHFRSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:18:30 -0400
Received: from jouet.infradead.org (unknown [177.79.81.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B1521A51;
        Mon,  6 Aug 2018 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568138;
        bh=K3Vmooe6lHn83m5GszMZ2Du3HfHizpO4xd9Xt7AcBbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IO8ESIhAF075sw8j2p0V4bizWIouGk/PZat2L6PmzThKVeRAQxrIRKcsiajYNJrG3
         6Vko5kOJ377wPAASZIIj4uFShOomx/IEswBAT7Qr/AJUR3LFSnLVzsZBuiNSNImvDO
         2iRZvaoEHJC2JKmfndrCEWO5y8KOiLYXPtmF7s9Q=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 5AB54140A1C; Mon,  6 Aug 2018 12:08:56 -0300 (-03)
Date:   Mon, 6 Aug 2018 12:08:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 04/20] perf annotate: Rename struct
 annotation_line::samples* to data*
Message-ID: <20180806150856.GL7996@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 04, 2018 at 03:05:05PM +0200, Jiri Olsa escreveu:
> The name 'samples*' is little confusing because we have
> nested 'struct sym_hist_entry' under annotation_line struct,
> which holds 'nr_samples' as well.
> 
> Also the holding struct name is 'annotation_data' so the
> 'data' name fits better.

Applied,

- Arnaldo
