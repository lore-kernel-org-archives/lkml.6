Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376E6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E8420645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="hWd534qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E8420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeICULZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:11:25 -0400
Received: from one.firstfloor.org ([193.170.194.197]:54682 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeICULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:11:24 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id CBED286F02; Mon,  3 Sep 2018 17:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1535989839;
        bh=Ex3fZ9aqVBOO55P7kKQ2fflPpMGiUIhF/B+E5R4B2oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWd534qo/ASy3K6l/TzeEzqRRkBq+8NbEY1rVtPtFugRTxn75e2HpItWveNiLwCOD
         JGK4VuZgJROy7hHFftUsP8FB/TWWq07OLwNHKuSXsJU9HKoqic+F+aydgcXm6nxMwt
         wmarYRghUy7KEV7QunXNqD9ZwFMLK1rBi7zEi898=
Date:   Mon, 3 Sep 2018 08:50:39 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Make perf script easier to use for itrace
Message-ID: <20180903155039.hjwfznoxpmaqoghy@two.firstfloor.org>
References: <20180831220206.28351-1-andi@firstfloor.org>
 <20180831175453.7378c5dd74d498b6d9002512@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831175453.7378c5dd74d498b6d9002512@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (Ubuntu 18.04):
> 
> builtin-script.c: In function ‘parse_output_fields’:
> builtin-script.c:2571:22: error: array subscript is above array bounds [-Werror=array-bounds]
>      output[j].fields &= ~all_output_options[i].field;
>                       ^~
> builtin-script.c:2571:22: error: array subscript is above array bounds [-Werror=array-bounds]
>      output[j].fields &= ~all_output_options[i].field;
>      ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> builtin-script.c:2574:10: error: array subscript is above array bounds [-Werror=array-bounds]
>     output[j].user_set = true;
>     ~~~~~~^~~
> builtin-script.c:2575:10: error: array subscript is above array bounds [-Werror=array-bounds]
>     output[j].wildcard_set = true;
>     ~~~~~~^~~

These were fixed earlier in -3.

> ...
> util/cs-etm.c: In function ‘cs_etm__process_auxtrace_info’:
> util/cs-etm.c:1436:14: error: ‘struct perf_session’ has no member named ‘itrace_synth’; did you mean ‘itrace_synth_opts’?
>      session->itrace_synth.default_no_sample);
>               ^~~~~~~~~~~~
>               itrace_synth_opts

For some reason my x86 targetted build doesn't seem to cover this file, so
I missed it. What do I need to do to enable it?

-Andi
