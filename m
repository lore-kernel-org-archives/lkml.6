Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD72DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0962084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqHdJYOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0962084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeGSQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbeGSQkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:40:02 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7792084C;
        Thu, 19 Jul 2018 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532015774;
        bh=JZQfMZwFh/m4sczDTwk8dtoWtJkhwflaCcep78JR+SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqHdJYOhEqhW/frJ+LPvt8bOKATruc2EhTCzp2METs3y30SOK1zQEB8I6hW8Tm7y4
         /JEVPRVAs5l74D/BdVKHN/Y9Y7GuBTTcGCZlZBMyBb7OUEzXUGdRdgni35qce6JDvH
         GdmW2ym0ZfL7WPGLN7BnUMioX+JahSH5FEH1KwzQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CE89514486C; Thu, 19 Jul 2018 12:56:11 -0300 (-03)
Date:   Thu, 19 Jul 2018 12:56:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Synthesize GROUP_DESC feature in pipe mode
Message-ID: <20180719155611.GE4070@kernel.org>
References: <20180712135202.14774-1-jolsa@kernel.org>
 <CABPqkBQsecn6Tp3q5fG1KgqF49Js0cA7KPY=dRkWV37jsqDXmg@mail.gmail.com>
 <20180712164941.GA8420@krava>
 <CABPqkBRObtG6ODH4N9psNKsknGYAJxgEKXGU3h84qyUvOB5iWw@mail.gmail.com>
 <20180719142854.GB4070@kernel.org>
 <CABPqkBR7Ot+XS1v5vPNXha=Z98FQ5cKFMg9aqND2Q+ZagnU0_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBR7Ot+XS1v5vPNXha=Z98FQ5cKFMg9aqND2Q+ZagnU0_w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 19, 2018 at 08:17:03AM -0700, Stephane Eranian escreveu:
> Hi Arnaldo,
> On Thu, Jul 19, 2018 at 7:29 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Jul 12, 2018 at 11:18:05PM -0700, Stephane Eranian escreveu:
> > > Hi Jiri,
> > > On Thu, Jul 12, 2018 at 9:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 12, 2018 at 09:34:45AM -0700, Stephane Eranian wrote:
> > > > > Hi Jiri,
> > > > > On Thu, Jul 12, 2018 at 6:52 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > >
> > > > > > Stephan reported, that pipe mode does not carry the group
> > > > > > information and thus the piped report won't display the
> > > > > > grouped output for following command:
> > > > > >
> > > > > Thanks for fixing this quickly.
> > > >
> > > > could I have your tested/acked by?
> >
> > > Acked-by: Stephane Eranian <eranian@google.com>
> >
> > Applying, Stephane, please consider providing a
> >
> Sorry about that.
> 
> Tested-by: Stephane Eranian <eranian@google.com>

Just replaced the Acked-by with this one.

Thanks!

- Arnado
