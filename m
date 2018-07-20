Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849CFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E6F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E6F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeGTG1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:27:37 -0400
Received: from nautica.notk.org ([91.121.71.147]:46847 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeGTG1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:27:36 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 1F8FCC009; Fri, 20 Jul 2018 07:41:05 +0200 (CEST)
Date:   Fri, 20 Jul 2018 07:40:50 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: suggest replacing strncpy+truncation by
 strscpy
Message-ID: <20180720054050.GA32233@nautica>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
 <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
 <alpine.DEB.2.20.1807200731240.2349@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807200731240.2349@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall wrote on Fri, Jul 20, 2018:
> > strscpy does however not clear the end of the destination buffer, so
> > there is a risk of information leak if the full buffer is copied as is
> > out of the kernel - this needs manual checking.
> 
> As fasr as I can tell from lkml, only one of these patches has been
> accepted?  There was also a concern about an information leak that there
> was no response to.  Actually, I would prefer that more of the generated
> patches are accepted before accepting the semantic patch, for something
> that is not quite so obviously correct.

As I'm pointing to the script which generated the patch in the generated
patches, I got told that it would be better to get the coccinelle script
accepted first, and asked others to hold on taking the patches at
several places - I didn't resend any v2 of these with strscpy yet mostly
for that reason.


There were concerns for information leaks that I believe I adressed in
the specific patch that was pointed out by the concern (I might have
missed some?), but I'll take the time to check all the patches
individually before resending as well as filling in better commit
messages which also was one of the main concerns.

I'm however a bit stuck if I'm waiting for the cocinelle script to be
accepted to resend the patches, but you're waiting for the individual
patches to be accepted to take the script... :)


I guess there is no value in the script landing first by itself, I'll
just remove the script path from the commit messages and resend the
first few this weekend.

-- 
Dominique Martinet
