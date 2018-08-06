Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36981C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C5021A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKnzOQy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C5021A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbeHFRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732423AbeHFRQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:16:45 -0400
Received: from jouet.infradead.org (unknown [177.79.84.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B212621A54;
        Mon,  6 Aug 2018 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568034;
        bh=J4EDM4882KMOnIh6208o9JoK2gTVkKmnDmd4UGkFeBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKnzOQy+VD9NRACZFKbhOsae6HYidUlyHKg32AU79Dj0uysJYraKHTaa6+x/7XNrw
         zz9PkVnCyYpNuvPyhLHTnN6PvYUoGHzedSGKL8QpxdEzdv0p+wyroMvySs0IGJ+Tra
         9JFGxN+qPGXsl/YkADQcU6vBVFEoSadROZf/+CF0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 183C9140A1C; Mon,  6 Aug 2018 12:07:12 -0300 (-03)
Date:   Mon, 6 Aug 2018 12:07:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 03/20] perf annotate: Get rid of
 annotation__scnprintf_samples_period
Message-ID: <20180806150712.GK7996@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 04, 2018 at 03:05:04PM +0200, Jiri Olsa escreveu:
> We have more current function tto get the title for annotation,
> which is hists__scnprintf_title. They both have same output as
> far as the annotation's header line goes.
> 
> They differ in counting of the nr_samples, hists__scnprintf_title
> provides more accurate number based on the setup of the
> symbol_conf.filter_relative variable.
> 
> Plus it also displays any uid/thread/dso/socket filters/zooms
> if there are set any, which annotation__scnprintf_samples_period
> does not.

Thanks, tested and applied.

- Arnaldo
