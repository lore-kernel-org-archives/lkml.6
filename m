Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D06C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A5E20895
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A5E20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeGZHiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:38:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbeGZHiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5726540216E6;
        Thu, 26 Jul 2018 06:22:43 +0000 (UTC)
Received: from krava (ovpn-204-138.brq.redhat.com [10.40.204.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id BA0AE2026D68;
        Thu, 26 Jul 2018 06:22:40 +0000 (UTC)
Date:   Thu, 26 Jul 2018 08:22:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl
Subject: Re: [PATCH 3/4] perf tools: Fix check-headers.sh output file
 variables
Message-ID: <20180726062239.GA24334@krava>
References: <20180720110036.32251-1-jolsa@kernel.org>
 <20180720110036.32251-3-jolsa@kernel.org>
 <20180720145745.GB4329@kernel.org>
 <20180720151518.GC27176@krava>
 <CAJ1xhMUeXAwZADxxJAALzwhnMFDQk0hMPeepRML+OLV92fmnJg@mail.gmail.com>
 <20180723070145.GB7523@krava>
 <CAJ1xhMUZc88fJwdLL-SitEasyVnomcVHV6+vTyJYAcXGo10C5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ1xhMUZc88fJwdLL-SitEasyVnomcVHV6+vTyJYAcXGo10C5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 26 Jul 2018 06:22:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 26 Jul 2018 06:22:43 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 08:20:07AM +0100, Alexander Kapshuk wrote:

SNIP

> > > % file1=file1; file2=file2
> > > % cmd="echo diff $file1 $file2"
> > > % test -f $file2 &&
> > > eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
> > > differs from latest version at '$file2'" >&2
> > > Warning: Kernel ABI header at 'tools/file1' differs from latest
> > > version at 'file2'
> > >
> > > Is this something you would rather leave as is, or perhaps use something
> > > along the lines of the code below instead:
> > >
> > > test -f $file2 && {
> > > eval $cmd ||
> > > echo "Warning: Kernel ABI header at 'tools/$file' differs from latest
> > > version at '$file'" >&2
> > > }
> >
> > hi,
> > yea, probably..  please feel free to post a patch.. just make sure all
> > the displayed files paths are based on the kernel root
> >
> > thanks,
> > jirka
> >
> 
> I'm away traveling till August 10th, and I may not be able to send the
> patch in until I get back. Is that OK?

sure, thanks

jirka
