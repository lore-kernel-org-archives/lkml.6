Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA9320675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547613463;
	bh=OgWAlbGFvddeYXhzDL6rDt7pPTpLzWJd6UIGIlserEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xGdAHDiISgz01B9btRPpOxumYyS6cW9/D5T7VJN6kAQqVzF7gpalBWr37AuJGjx+a
	 sswKlKpRiTOOBxJm6gwTs7mjgHyDq2IgDj3vmoikce9GK7dxwB7kGLSKfuZKz36Zp8
	 ymAipoSCc/6txOvE1y3su4nG4BRHazMPNaQhqKfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfAPEhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:37:41 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:45642 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728227AbfAPEhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:37:41 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 16 Jan 2019 13:37:38 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 16 Jan 2019 13:37:36 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Wed, 16 Jan 2019 13:37:35 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@lge.com
Subject: Re: [RFC] perf tools: Filter out hidden symbols from labels
Message-ID: <20190116043735.GA31070@sejong>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
 <20190115163540.GA20159@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115163540.GA20159@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 15, 2019 at 01:35:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 15, 2019 at 04:13:16PM +0000, Nick Clifton escreveu:
> > Hi Jiri,
> > 
> > > When perf is built with annobin plugin (RHEL8 build) extra symbols
> > > are added to its binary:
> > 
> >   A bit of background for those wondering why annobin is creating
> >   these symbols:  Annobin is a plugin for gcc that records data 
> >   about how object file were built.  It is specifically designed 
> >   to be able to cope with files that are built using multiple
> >   different sets of optimization options.  (Eg because of #pragma
> >   directives or function specific optimization attributes).  It
> >   generates notes to cover each compiled region of code, and it
> >   needs the symbols in order to be able to determine exactly which
> >   areas in a linked binary were compiled with which options.
> 
> Humm, it would be nice for perf annotate to show those options when one
> navigates the annotation, something like press some hotkey and see the
> optimization flags used. Is there any library that gets those
> annotations and put them in some linked list that we could use in
> tools/perf/?

If it's just an ELF note, we could parse it directly.

https://developers.redhat.com/blog/2018/02/20/annobin-storing-information-binaries/

Thanks,
Namhyung
