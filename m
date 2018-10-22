Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A5C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72E72064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4of0xHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72E72064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeJVX2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbeJVX2N (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:13 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762B820645;
        Mon, 22 Oct 2018 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540220957;
        bh=Hml9t6jSXI6FfvzP74mubplpIN1ss9eUH64BLEwAlqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4of0xHgI6T+mi1p+tFiA9EywbAGtw02DLE687vDcWMWuLUY9dJy2NAwlbBbRX8sa
         4YS081zx4S9GQKpaXMGShg8Fg/Ph8gv4aBFP8n32JPiPrqvxdZdgoHs4cPYr7dDLU+
         BWh9nCZsIO2XjUZutGG27+C5RaqCBnzZ2h7q54Dk=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3EE6D142C5E; Mon, 22 Oct 2018 12:09:15 -0300 (-03)
Date:   Mon, 22 Oct 2018 12:09:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: allow extended console debug output
Message-ID: <20181022150915.GJ3849@kernel.org>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <20181022094033.GF2452@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022094033.GF2452@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 22, 2018 at 11:40:33AM +0200, Jiri Olsa escreveu:
> On Sun, Oct 21, 2018 at 09:14:23PM +0200, Milian Wolff wrote:
> > The script tool isn't using a browser, yet use_browser
> > wasn't set explicitly to zero. This in turn lead to confusing
> > output such as:
> > 
> > ```
> > $ perf script -vvv ...
> > ...
> > overlapping maps in /home/milian/foobar (disable tui for more info)
> > ...
> > ```
> > 
> > Explicitly set use_browser to 0 now, which gives us the extended
> > debug information now in perf script as expected.
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
