Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2088C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CE1218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546616475;
	bh=2RCyvZTuOBAJTLHyYX35Lf2E5kpX+i9W/tgsEyiYjbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AFn7j33cUFeJWKt7LqrCOFZyoj9HkyR7dZYk3wKZmQ5ooz87ndt6iSZhXe9RrGzEs
	 vqBObObXjh06QlOy7j+8zqFf+CN1eyRDTdxz3mdG307H8XMoa9Jd1vhUKkJndtfH5x
	 oSpvnC1zKz19VIwqm8LmW1sfDVMyVD7+Yz3VlWNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfADPlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfADPlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:41:14 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E59721872;
        Fri,  4 Jan 2019 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546616473;
        bh=2RCyvZTuOBAJTLHyYX35Lf2E5kpX+i9W/tgsEyiYjbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lt5JjbS6L+2UfZZ93U9q+JxOLZmhjw4kSnCieUAjcRB4NVdaXQ1czIW9Gn1gHfHn6
         ey86I5AQ0jBIvny4SumIK/L6KKO54fmlUXb/8RfgSEFbtq837Bb1vn4dLrMcETld6r
         CHKLwVFU4ceom16l6k0b/u7wJneqW2SXBKailTD4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F86940341; Fri,  4 Jan 2019 12:41:01 -0300 (-03)
Date:   Fri, 4 Jan 2019 12:41:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ivan Krylov <krylov.r00t@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: pass filename to objdump via execl
Message-ID: <20190104154101.GB9833@kernel.org>
References: <20181014111803.5d83b806@Tarkus>
 <20181014140451.GB24104@krava>
 <20181230173743.55b85189@Tarkus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230173743.55b85189@Tarkus>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 30, 2018 at 05:37:43PM +0300, Ivan Krylov escreveu:
> On Sun, 14 Oct 2018 16:04:51 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Is there anything I could do to improve the patch? Should I wrap the
> path to objdump executable in a similar way?

Nope, just fell thru the holidays crack, processing it now.

- Arnaldo
