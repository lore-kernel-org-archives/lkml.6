Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E17ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF1D21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF1D21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbeISAdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbeISAdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFF333082145;
        Tue, 18 Sep 2018 18:59:47 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58DD31001F56;
        Tue, 18 Sep 2018 18:59:46 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6A40C10BD; Tue, 18 Sep 2018 15:59:44 -0300 (BRT)
Date:   Tue, 18 Sep 2018 15:59:44 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] perf tools: Initialize perf_data_file fd field
Message-ID: <20180918185944.GA2695@redhat.com>
References: <20180829201648.19588-1-jeremie.galarneau@efficios.com>
 <20180905160918.GB29759@krava>
 <CA+jJMxvHN0-=vByU0=mdnDZJ0BsfCAf240ShQ=Obm1J=Nd=mpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+jJMxvHN0-=vByU0=mdnDZJ0BsfCAf240ShQ=Obm1J=Nd=mpQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 18 Sep 2018 18:59:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 18, 2018 at 02:07:41PM -0400, Jérémie Galarneau escreveu:
> Hi Arnaldo,
> 
> Anything I can do to help you with this patch?

Thanks for the reminder, will apply.

- Arnaldo
 
> Thanks,
> Jérémie
> 
> On 5 September 2018 at 12:09, Jiri Olsa <jolsa@redhat.com> wrote:
> > On Wed, Aug 29, 2018 at 04:16:48PM -0400, Jérémie Galarneau wrote:
> >> Building the perf CTF converter fails with gcc 4.8.4
> >> on Ubuntu 14.04 with the following error:
> >>
> >> error: missing initializer for field ‘fd’ of ‘struct perf_data_file’
> >> [-Werror=missing-field-initializers]
> >>
> >> Per 4b838b0d and the ensuing discussion on the mailing
> >> list, it appears that this affects other distributions
> >> and gcc versions.
> >>
> >> Signed-off-by: Jérémie Galarneau <jeremie.galarneau@efficios.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > thanks,
> > jirka
> >
> >> Cc: Jiri Olsa <jolsa@kernel.org>
> >> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> ---
> >>  tools/perf/util/data-convert-bt.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> >> index abd38abf1d91..f75d4aa612c5 100644
> >> --- a/tools/perf/util/data-convert-bt.c
> >> +++ b/tools/perf/util/data-convert-bt.c
> >> @@ -1578,7 +1578,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
> >>  {
> >>       struct perf_session *session;
> >>       struct perf_data data = {
> >> -             .file.path = input,
> >> +             .file      = { .path = input, .fd = -1 },
> >>               .mode      = PERF_DATA_MODE_READ,
> >>               .force     = opts->force,
> >>       };
> >> --
> >> 2.18.0
> >>
> 
> 
> 
> -- 
> Jérémie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
