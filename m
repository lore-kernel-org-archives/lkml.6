Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B84522404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEENNbEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B84522404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeHJPso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbeHJPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:48:43 -0400
Received: from jouet.infradead.org (179.176.1.0.dynamic.adsl.gvt.net.br [179.176.1.0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6796922402;
        Fri, 10 Aug 2018 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533907130;
        bh=s8GEecCTn5VcKmdzttf5EtdY24lIlMkzaIuE+3RKqSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEENNbEuckvRr+6+yl4Jj22ryTkUQCg+WmoHMh0ZtO8QoJWptAhiIsT7Z3wlIirQu
         fopcT15MeSVbwp2feRLA0m6BatTtaDEh3+KemhnVbf0cuN5Ymgd5oslasJXn8X8w4h
         veakl38GVqviy9WemCt0Ly2FwBkn02TVSrnxy0cI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D0F5C140A1C; Fri, 10 Aug 2018 10:18:47 -0300 (-03)
Date:   Fri, 10 Aug 2018 10:18:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Benno Evers <bevers@mesosphere.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] perf tools: Check for null when copying nsinfo.
Message-ID: <20180810131847.GG5395@kernel.org>
References: <20180809215349.24299-1-bevers@mesosphere.com>
 <20180810045537.GA479@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810045537.GA479@sejong>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 10, 2018 at 01:55:37PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Thu, Aug 09, 2018 at 11:53:48PM +0200, Benno Evers wrote:
> > The argument to nsinfo__copy() was assumed to be valid, but some code paths
> > exist that will lead to NULL being passed.
> > 
> > In particular, running 'perf script -D' on a perf.data file containing an
> > PERF_RECORD_MMAP event associating the '[vdso]' dso with pid 0 earlier in
> > the event stream will lead to a segfault.
> > 
> > Since all calling code is already checking for a non-null return value,
> > just return NULL for this case as well.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> It seems you missed the Signed-off-by though.

Yeah, please collect Namhyung's Acked-by and provide yours, i.e. your
patch should end with the following lines:


Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Benno Evers <bevers@mesosphere.com>

My git-am scripts will collect the Cc from the e-mail message and add
the Link:  with the Message-id.

Thanks,

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/namespaces.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> > index 5be021701f34..cf8bd123cf73 100644
> > --- a/tools/perf/util/namespaces.c
> > +++ b/tools/perf/util/namespaces.c
> > @@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
> >  {
> >  	struct nsinfo *nnsi;
> >  
> > +	if (nsi == NULL)
> > +		return NULL;
> > +
> >  	nnsi = calloc(1, sizeof(*nnsi));
> >  	if (nnsi != NULL) {
> >  		nnsi->pid = nsi->pid;
> > -- 
> > 2.17.1
> > 
