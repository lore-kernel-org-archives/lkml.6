Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7E0ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3942D2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3942D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeKAE3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeKAE3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 383873082E07;
        Wed, 31 Oct 2018 19:29:54 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADADE600C0;
        Wed, 31 Oct 2018 19:29:53 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6618D440F; Wed, 31 Oct 2018 17:29:51 -0200 (BRST)
Date:   Wed, 31 Oct 2018 17:29:51 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
Message-ID: <20181031192951.GE6669@redhat.com>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-18-acme@kernel.org>
 <s5hlg6ehwzk.wl-tiwai@suse.de>
 <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 31 Oct 2018 19:29:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 31, 2018 at 10:27:02AM -0700, Joe Perches escreveu:
> On Wed, 2018-10-31 at 18:00 +0100, Takashi Iwai wrote:
> > On Wed, 31 Oct 2018 17:44:57 +0100,
> > Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > To silence this perf build warning:
> > > 
> > >   Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> > >   diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
> > > 
> > > Due to this cset:
> > > 
> > >   a98401518def ("ALSA: timer: fix wrong comment to refer to 'SNDRV_TIMER_PSFLG_*'")
> > > 
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > Link: https://lkml.kernel.org/n/tip-76gsvs0w2g0x723ivqa2xua3@git.kernel.org
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Thanks for the correction.
> > 
> > That's bad to have duped files that have to be synced manually...
> > At least, some checkpatch addition would help to suggest always
> > correct both places?
> 
> How could that work in checkpatch?

No need for changes.
 
> Wouldn't a symlink be simpler?

That would be equivalent to using it directly, see my response to
Takashi for a few of the reasons this is done this way.

- Arnaldo
