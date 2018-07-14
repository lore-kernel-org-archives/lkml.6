Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470C2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3F620896
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3F620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeGNN1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:27:20 -0400
Received: from nautica.notk.org ([91.121.71.147]:42516 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeGNN1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:27:19 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E2698C009; Sat, 14 Jul 2018 15:08:15 +0200 (CEST)
Date:   Sat, 14 Jul 2018 15:08:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com
Subject: Re: [PATCH v2] coccinelle: strncpy+truncation by strscpy
Message-ID: <20180714130800.GA15334@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807140750040.3356@hadrien>
 <alpine.DEB.2.20.1807140743550.3356@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall wrote on Sat, Jul 14, 2018:
> Not a big deal, but actually the v2 goes below the ---

I've seen both being done (if you look at the git log of the linux
kernel and search for 'v2' you will have some matches)

The list was a bit long in this case, but I think it's worth at least
mentioning that the previous version used strlcpy and why I changed in
the commit message.

> > +msg = "SUGGESTION: strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
> > +coccilib.report.print_report(p[0], msg)
> 
> This is the first SUGGESTION.  I don't know if anyone out there is relying
> on it always being WARNING or ERROR.

Eh, I must have been really unlucky with the scripts I looked at, one
just happened to have SUGGESTION used like this (misc/warn.cocci), but
now you said that I can see it's the only one!

I'm not sure on what to do here, if you think there could be scripts
relying on that then I'll change this to WARNING, but the wording feels
a bit strong and "suggestion" leaves more room for interpretation.


> Copyright stuff in the other sub-thread

Replying here instead to limit the number of mails sent,
I think people would look at git blame/log if there is no name in the
file, but I can understand it is simpler if a name is present.

Just a nitpick on format, all copyright comments on cocci scripts end
with the license; since that will be added as an SPDX tag instead do you
mind if I do not list it again there?


Also just a head's up, I'll be AFK for the next ~48 hours; I'll post a
v3 of the patch with license/copyright added, possibly suggestion
changed, and whatever else comes up by then :)

Thanks,
-- 
Dominique Martinet
