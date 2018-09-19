Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEE7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BB9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAl/9swK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BB9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbeISXor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732450AbeISXor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:44:47 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBD6214DA;
        Wed, 19 Sep 2018 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537380343;
        bh=YH4RfmdMgqjcyVkhKmqN4XGhbBu0bS64uO3+HHzj/pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAl/9swKz1RijHQE16/gee8oOVoAgjPO31hipojC3Pvaa5Sk+o1KmAcS/pYfLyDWd
         Y3Fw5CT34gweOe8JHUoE2/ZwpOjAJGHyzk3v9c3xNliygfo2r5i2e+ttmXmVDeKzrU
         2ulw041iwbTsu28FMcYl7tBpFY9wxAXTm6LqY55k=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1CBF0140260; Wed, 19 Sep 2018 15:05:41 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:05:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sangwon Hong <qpakzk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH] perf tool: Add missing subcommand `version`
Message-ID: <20180919180541.GB31812@kernel.org>
References: <20180919074911.41931-1-qpakzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919074911.41931-1-qpakzk@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 19, 2018 at 12:49:11AM -0700, Sangwon Hong escreveu:
> There isn't subcommand `version` when typing `perf help`.
> 
> Before :
> 
> $ perf help | grep version
>  usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
> 
> So add perf-version in command-list.txt for listing it
> when typing `perf help`.
> 
> After :
> 
> $ perf help | grep version
>  usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
>    version         display the version of perf binary

Thanks, applied.

- Arnaldo
