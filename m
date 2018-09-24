Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97EBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EC020C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v3CCIgEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EC020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeIXUS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbeIXUS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:18:58 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38FE20C0A;
        Mon, 24 Sep 2018 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537798597;
        bh=ycBzMbuOAyqFSW10X7x0Z0ouceRsg7EcA6/fcdZS8j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v3CCIgEnTC6AbHuWmyj6srwYKkSdg/CRYxWFl+N5rMVipJOYidw/LOqzN73mn0P8y
         kIoyaxL0ZGI4dkK/PdvjXjPmgdXppHnw74AqvbK4i4MxRsLGrWhJV/2lTVsK37ACGc
         ykbW5RSHPI0WP2Sb2xpNAboHypB0q9056wC2ZZNg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CCFE71401A1; Mon, 24 Sep 2018 11:16:32 -0300 (-03)
Date:   Mon, 24 Sep 2018 11:16:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH 00/15] tools/lib/traceevent: Namespace updates to make
 traceevent into a library
Message-ID: <20180924141632.GA4640@kernel.org>
References: <20180919185643.358126338@goodmis.org>
 <20180923185626.GC30923@krava>
 <20180924045523.2c15be13@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924045523.2c15be13@vmware.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 24, 2018 at 04:55:23AM -0400, Steven Rostedt escreveu:
> On Sun, 23 Sep 2018 20:56:26 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > 
> > Steven,
> > is there still something left to rename, or we can start moving it into public rpm?
> > 
> 
> We're testing it as a external library, and we did find something. Did
> you get this patch?
> 
>  https://lore.kernel.org/lkml/20180921152037.1e23c7f4@gandalf.local.home

I'm finishing tests with the patchset before this last patch, will push
to Ingo soon, then will check if the patch with the private copy of the
strerror_r() wrapper passes on the systems that made that wrapper came
to be, i.e. systems using the musl libc (https://www.musl-libc.org/).
 
> We're testing it against powertop and mceutils, when we get it working
> well with them, then I think it's time to start going ahead and making
> it into an rpm.

At some point would be nice if you guys provided patches to make
tools/perf/ link dynamicly to libtraceevent as well.

- Arnaldo
