Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D3CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBEF20647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBEF20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeGTG6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:58:44 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29553
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbeGTG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:58:44 -0400
X-IronPort-AV: E=Sophos;i="5.51,377,1526335200"; 
   d="scan'208";a="273562197"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 07:49:59 +0200
Date:   Fri, 20 Jul 2018 07:49:59 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: suggest replacing strncpy+truncation by
 strscpy
In-Reply-To: <20180720054050.GA32233@nautica>
Message-ID: <alpine.DEB.2.20.1807200745400.2349@hadrien>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org> <1532047018-23754-1-git-send-email-asmadeus@codewreck.org> <alpine.DEB.2.20.1807200731240.2349@hadrien> <20180720054050.GA32233@nautica>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Jul 2018, Dominique Martinet wrote:

> Julia Lawall wrote on Fri, Jul 20, 2018:
> > > strscpy does however not clear the end of the destination buffer, so
> > > there is a risk of information leak if the full buffer is copied as is
> > > out of the kernel - this needs manual checking.
> >
> > As fasr as I can tell from lkml, only one of these patches has been
> > accepted?  There was also a concern about an information leak that there
> > was no response to.  Actually, I would prefer that more of the generated
> > patches are accepted before accepting the semantic patch, for something
> > that is not quite so obviously correct.
>
> As I'm pointing to the script which generated the patch in the generated
> patches, I got told that it would be better to get the coccinelle script
> accepted first, and asked others to hold on taking the patches at
> several places - I didn't resend any v2 of these with strscpy yet mostly
> for that reason.

I can't accept a semantic patch for which I can't judge the correctness.
It would be better to put a proper commit message in the individual
patches and get them accepted first.

The actual change is made by a script that is only a few lines long.  You
can put those lines in your commit message if you like.

> There were concerns for information leaks that I believe I adressed in
> the specific patch that was pointed out by the concern (I might have
> missed some?), but I'll take the time to check all the patches
> individually before resending as well as filling in better commit
> messages which also was one of the main concerns.
>
> I'm however a bit stuck if I'm waiting for the cocinelle script to be
> accepted to resend the patches, but you're waiting for the individual
> patches to be accepted to take the script... :)
>
>
> I guess there is no value in the script landing first by itself, I'll
> just remove the script path from the commit messages and resend the
> first few this weekend.

It's not that there is no value to the script.  The problem is that I
don't know if the script is correct - I'm not familiar with these string
functions.  Once the script is in the kernel, it stays there beyond your
patches, so I would prefer to know that it is correct up front, rather
than having to remove it afterwards.

julia
