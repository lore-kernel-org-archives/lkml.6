Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A95C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755EC20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755EC20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeKAC0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:26:03 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:46337 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727991AbeKAC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:26:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D25B0181D341C;
        Wed, 31 Oct 2018 17:27:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer18_77d21690f7202
X-Filterd-Recvd-Size: 2270
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Oct 2018 17:27:03 +0000 (UTC)
Message-ID: <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
From:   Joe Perches <joe@perches.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date:   Wed, 31 Oct 2018 10:27:02 -0700
In-Reply-To: <s5hlg6ehwzk.wl-tiwai@suse.de>
References: <20181031164508.4784-1-acme@kernel.org>
         <20181031164508.4784-18-acme@kernel.org> <s5hlg6ehwzk.wl-tiwai@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 18:00 +0100, Takashi Iwai wrote:
> On Wed, 31 Oct 2018 17:44:57 +0100,
> Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > To silence this perf build warning:
> > 
> >   Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> >   diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
> > 
> > Due to this cset:
> > 
> >   a98401518def ("ALSA: timer: fix wrong comment to refer to 'SNDRV_TIMER_PSFLG_*'")
> > 
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Link: https://lkml.kernel.org/n/tip-76gsvs0w2g0x723ivqa2xua3@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Thanks for the correction.
> 
> That's bad to have duped files that have to be synced manually...
> At least, some checkpatch addition would help to suggest always
> correct both places?

How could that work in checkpatch?

Wouldn't a symlink be simpler?


