Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5FAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0628F2082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpM+JcFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0628F2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbeJ2VWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbeJ2VWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:22:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD932082B;
        Mon, 29 Oct 2018 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540816439;
        bh=I8bwBmMz1NeqlVg9sZMAb14RbF/o81b8sD5TzH5WR/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpM+JcFQ3yju16e1Y8zKeoWk719fY5iFll9ImhAvr1H3cJTnV1bbqwTnG3Z2v3qf4
         fzJGM3miC27x2SbURvFcCpUs5VtTL611vGAWKMaetWYBJ8vxaoeaI/dBUuHu9PqJQg
         6U93tzG1YA4SBDaPSF4Mx2cpo8hbibmjYfk5NjJY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 63390142C5F; Mon, 29 Oct 2018 09:33:57 -0300 (-03)
Date:   Mon, 29 Oct 2018 09:33:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181029123357.GA21857@kernel.org>
References: <20181026175839.4565-1-colin.king@canonical.com>
 <20181029122854.GB20813@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029122854.GB20813@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 29, 2018 at 09:28:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 26, 2018 at 06:58:39PM +0100, Colin King escreveu:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Trivial fix to a spelling mistake of the error access name EACCESS,
> > rename to EACCES
> 
> Thanks, applied.
> 
> And I also took the chance to fix another spelling mistake, on this same
> line:
> 
> -        *  -EACCESS    -- @event is for this PMU, @event is valid, but no privilidges
> +        *  -EACCES     -- @event is for this PMU, @event is valid, but no privilidges
>                                                                                  ^
>                                                                                  ^
>                                                                                  ^
>                                                                                  ^

But I see Ingo has already merged your patch, lets fix that one later
then :-)

- Arnaldo
