Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F38C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D2220660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="C0kEFKUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D2220660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLAJO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:14:59 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44974 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeLAJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:14:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 22E598EE287;
        Fri, 30 Nov 2018 14:04:13 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4srXcmRn0mJE; Fri, 30 Nov 2018 14:04:12 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 424318EE0C3;
        Fri, 30 Nov 2018 14:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1543615452;
        bh=sHv1RuC29Ah0kUwJuQCHZNr6Jhi+2ezuorzmimNMwt0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C0kEFKUvIhIzDBoocFKvVsTT1hITFvBoAmIfY0sJLItZbzjY14IDL9ZTy65jVnhoy
         JnkEMNwf1Q10IkOZor5wVcv7CcLkeOnzm0OjnpZRJ8K9+8yOnklNU4UqElw2kABlya
         UllDfjAYZmzNXXGdwjH8EH2ciIu6wyJJyV6bonus=
Message-ID: <1543615449.3031.32.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Miller <davem@davemloft.net>
Cc:     dave@stgolabs.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        dja@axtens.net, linux@dominikbrodowski.net,
        dri-devel@lists.freedesktop.org, edumazet@google.com,
        federico.vaga@vaga.pv.it, geert+renesas@glider.be, deller@gmx.de,
        corbet@lwn.net, kumba@gentoo.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        pabeni@redhat.com, paul.burton@mips.com, pmladek@suse.com,
        robh@kernel.org, sean.wang@mediatek.com,
        sergey.senozhatsky@gmail.com, shannon.nelson@oracle.com,
        sbrivio@redhat.com, rostedt@goodmis.org, me@tobin.cc,
        makita.toshiaki@lab.ntt.co.jp, willemb@google.com, yhs@fb.com,
        yanjun.zhu@oracle.com
Date:   Fri, 30 Nov 2018 14:04:09 -0800
In-Reply-To: <20181130215429.GA24415@linux.intel.com>
References: <20181130205521.GA21006@linux.intel.com>
         <1543611662.3031.20.camel@HansenPartnership.com>
         <20181130214405.GG23772@linux.intel.com>
         <20181130.134808.1785785556132211918.davem@davemloft.net>
         <20181130215429.GA24415@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 13:54 -0800, Jarkko Sakkinen wrote:
> On Fri, Nov 30, 2018 at 01:48:08PM -0800, David Miller wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Date: Fri, 30 Nov 2018 13:44:05 -0800
> > 
> > > On Fri, Nov 30, 2018 at 01:01:02PM -0800, James Bottomley wrote:
> > > > No because use of what some people consider to be bad language
> > > > isn't
> > > > necessarily abusive, offensive or degrading.  Our most heavily
> > > > censored
> > > > medium is TV and "fuck" is now considered acceptable in certain
> > > > contexts on most channels in the UK and EU.
> > > 
> > > This makes following the CoC extremely hard to a non-native
> > > speaker as
> > > it is not too explicit on what is OK and what is not. I did
> > > through the
> > > whole thing with an eye glass and this what I deduced from it.
> > 
> > It would be helpful if you could explain what part of the language
> > is unclear wrt. explaining how CoC does not apply to existing code.
> > 
> > That part seems very explicit to me.
> 
> Well, now that I re-read it, it was this part to be exact:
> 
> "Maintainers have the right and responsibility to remove, edit, or
> reject comments, commits, code, wiki edits, issues, and other
> contributions that are not aligned to this Code of Conduct, or to ban
> temporarily or permanently any contributor for other behaviors that
> they deem inappropriate, threatening, offensive, or harmful."
> 
> How this should be interpreted?

Firstly, this is *only* about contributions going forward.  The
interpretation document says we don't have to look back into the
repository and we definitely can't remove something from git that's
already been committed.

As a Maintainer, if you feel bad language is inappropriate for your
subsystem then you say so and reject with that reason patches that come
in containing it (suggesting alternative rewordings).  However, your
determination about what is or isn't acceptable in your subsystem isn't
binding on other maintainers, who may have different standards ... this
is identical to what we do with coding, like your insistence on one
line per variable or other subsystem's insistence on reverse christmas
tree for includes ...

James


> I have not really followed the previous CoC discussions as I try to
> always use polite language so I'm sorry if this duplicate.
> 
> /Jarkko
> 

