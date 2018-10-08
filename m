Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17422C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D340921471
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCJ8e+1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D340921471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJIApX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJIApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:45:23 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF64213A2;
        Mon,  8 Oct 2018 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539019956;
        bh=m1cy465tGbP9LvOAiJIeud5XZo/ckxyYUvBKDGWYjQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCJ8e+1RmyUhBOO9EpoonEhyaRJ+4TgNcGSDD2LVeLWzF1aLFNkDMHSc7gs9fJLf/
         /9ZPqkJONygHJm5W2y77SUwcqfWdN4DrJIgFYUpq0dMESCfOZ6t5NafF1UinMQtayr
         paA1iA9LKWe85Qm2HhDMjtVgQPGBir7oxlb14/ak=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9E22F141DDC; Mon,  8 Oct 2018 14:32:24 -0300 (-03)
Date:   Mon, 8 Oct 2018 14:32:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tools/lib/traceevent, tools/perf: Move struct
 tep_handler definition in a local header file
Message-ID: <20181008173224.GP3541@kernel.org>
References: <20181005122225.522155df@gandalf.local.home>
 <20181005122846.4b974dbd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005122846.4b974dbd@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 05, 2018 at 12:28:46PM -0400, Steven Rostedt escreveu:
> On Fri, 5 Oct 2018 12:22:25 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > +/**
> > + * tep_get_first_event - returns the first event in the events array
> > + * @tep: a handle to the tep_handle
> > + *
> > + * This returns pointer to the first element of the events array
> > + * If @tep is NULL, NULL is returned.
> > + */
> > +struct tep_event_format *tep_get_first_event(struct tep_handle *tep)
> > +{
> > +	if(tep && tep->events)
> > +		return tep->events[0];
> > +
> > +	return NULL;
> > +}
> > +
> 
> Hold off on pulling this in. This patch has some whitespace issues that
> need to be cleaned up.

Ah, that if( thing? ?I can fix it here, holler if there is more than
that.
