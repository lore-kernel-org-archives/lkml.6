Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7BECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA5E20840
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA5E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbeGNU4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:56:30 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:45981
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727955AbeGNU4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:56:30 -0400
X-IronPort-AV: E=Sophos;i="5.51,353,1526335200"; 
   d="scan'208";a="273004277"
Received: from 76.8.75.174.nyc.electricfiber.net (HELO hadrien.local) ([76.8.75.174])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2018 22:36:11 +0200
Date:   Sat, 14 Jul 2018 16:36:09 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com
Subject: Re: [PATCH v2] coccinelle: strncpy+truncation by strscpy
In-Reply-To: <20180714130800.GA15334@nautica>
Message-ID: <alpine.DEB.2.20.1807141633010.3283@hadrien>
References: <20180714130800.GA15334@nautica>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2018, Dominique Martinet wrote:

> Julia Lawall wrote on Sat, Jul 14, 2018:
> > Not a big deal, but actually the v2 goes below the ---
>
> I've seen both being done (if you look at the git log of the linux
> kernel and search for 'v2' you will have some matches)

I guess.  Normally I would conseider that since the v1 is not in the git
history, no one care about the delta between the v1 and v2. If there is
important information it should just be in the commit message.

> The list was a bit long in this case, but I think it's worth at least
> mentioning that the previous version used strlcpy and why I changed in
> the commit message.

I guess, but you could say that strlcpy was not used for a certain reason,
without making it historical information.

>
> > > +msg = "SUGGESTION: strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
> > > +coccilib.report.print_report(p[0], msg)
> >
> > This is the first SUGGESTION.  I don't know if anyone out there is relying
> > on it always being WARNING or ERROR.
>
> Eh, I must have been really unlucky with the scripts I looked at, one
> just happened to have SUGGESTION used like this (misc/warn.cocci), but
> now you said that I can see it's the only one!
>
> I'm not sure on what to do here, if you think there could be scripts
> relying on that then I'll change this to WARNING, but the wording feels
> a bit strong and "suggestion" leaves more room for interpretation.

I guess that if there is already one, then another won't hurt.

>
>
> > Copyright stuff in the other sub-thread
>
> Replying here instead to limit the number of mails sent,
> I think people would look at git blame/log if there is no name in the
> file, but I can understand it is simpler if a name is present.

One less command to type.

>
> Just a nitpick on format, all copyright comments on cocci scripts end
> with the license; since that will be added as an SPDX tag instead do you
> mind if I do not list it again there?

I know nothing about SPDX tags.  If something is added, I don't know how
it is done.

julia

>
>
> Also just a head's up, I'll be AFK for the next ~48 hours; I'll post a
> v3 of the patch with license/copyright added, possibly suggestion
> changed, and whatever else comes up by then :)
>
> Thanks,
> --
> Dominique Martinet
>
