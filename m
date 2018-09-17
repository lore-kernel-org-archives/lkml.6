Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B1ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D1214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS5s00Ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860D1214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbeIQUsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeIQUsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:48:43 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3485206B8;
        Mon, 17 Sep 2018 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537197655;
        bh=g6WVRTHDL0UuoXsqHEnH0AJsBW+C268sFZgYKraE4c8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pS5s00Nemy4+3MBfS3HeO6IBEX5AzT/nndDNnZPXVeuod4tYF50be4M2h5usv3hWt
         teMM5FsDhVSZc6TbuWNh5MIB5QMOUYA2YqW6FZVOERzXdFKBs7VP/uP+yWciLmmgFe
         /qZ4ej6DOAYzdDoR1G0Emdg/ARNGIRo3ZUQAvg3I=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 62FFB140260; Mon, 17 Sep 2018 12:20:51 -0300 (-03)
Date:   Mon, 17 Sep 2018 12:20:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf Documentation: Fix out-of-tree asciidoctor man page
 generation
Message-ID: <20180917152051.GB21790@kernel.org>
References: <20180916151704.GF4765@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916151704.GF4765@decadent.org.uk>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 16, 2018 at 04:17:05PM +0100, Ben Hutchings escreveu:
> The dependency for the man page rule using asciidoctor incorrectly
> specifies a source file in $(OUTPUT).  When building out-of-tree, the
> source file is not found, resulting in a fall-back to the following
> rule which uses xmlto.
> 
> Fixes: ffef80ecf89f ("perf Documentation: Support for asciidoctor")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks, applied.

- Arnaldo
