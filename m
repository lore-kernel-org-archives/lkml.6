Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8665DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EA52175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o3gYsD7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbfBFKrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:47:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbfBFKrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:47:41 -0500
Received: from zn.tnic (p200300EC2BCEF100E462A2470AE7196B.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:e462:a247:ae7:196b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00AC21EC014B;
        Wed,  6 Feb 2019 11:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549450060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9j9ridPilZ9o93SYAOltVR2t+jBzlF0oG4VkJ/lo2jY=;
        b=o3gYsD7p87Fh+iIDiD4xf7C1nBrvF69ynYt8stqNFhXf2eOxBCBe50pg3+7ECaDJ0vFUvd
        bxBP8jW2xjhz3H0r0vXQKM1nLlcNi6T0F00HLks+Mgo3bMgJvJDptVO9zpSm7/VcUe6Er3
        gNG1v2ALPN7+EIrtTZvHceqVWHouekQ=
Date:   Wed, 6 Feb 2019 11:47:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
Message-ID: <20190206104729.GC7314@zn.tnic>
References: <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
 <20190201094217.GB31854@zn.tnic>
 <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic>
 <20190201103648.GF31854@zn.tnic>
 <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
 <20190201151139.GK31854@zn.tnic>
 <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
 <20190202144227.GC27822@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190202144227.GC27822@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 03:42:27PM +0100, Borislav Petkov wrote:
> On Sat, Feb 02, 2019 at 10:48:00PM +0900, Masahiro Yamada wrote:
> > '?=' is the same as '=' here.
> 
> Sure but if the slowdown disappears, then make does something else for
> '?=' apparently vs for '='.

Ok, let me ask a different question then: would a separate target which
will be used to generate only clean asm for debugging purposes ala

make <path-to-file>.asm

or so be an acceptable approach?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
