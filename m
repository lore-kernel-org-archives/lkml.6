Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D5AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3580B217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQ8LJ/UC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBLG1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:27:36 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50969 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfBLG1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:27:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AA32222C95;
        Tue, 12 Feb 2019 01:27:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Feb 2019 01:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=YagqWmujk0sC9c2dFTNj0vFRqsvKEpyJT6iTwXrEk
        M0=; b=sQ8LJ/UCZIDzQM/PF9ZFxlWZtbVSuZrrmoKUi8QBUoT+PUp0LELXnEPkz
        NVONiD3PQkyuNX/lODNaR+FAQglMxT+77E44lrfYyLBYu+jUwocgxnf0o6ABljPK
        QzHrFQ/E09hPLgxcmSZdgduTuGFCs5UdqVO0rzfa7LrncmTQtID84uIUdfpSvR89
        7hbX3583BbYMovheBLY1UEnetlLeftFpp/+BXwHcEepEibhYCW8zzWfRm8g/g+c+
        sVqLNPKPRAAWy/m9MSfk/dcZINBPublvWuc6FkOxniMEDcCbEH9dJastGOP9GkoF
        eN2JLYWIklktNeeRWdCbeDeIz+xeA==
X-ME-Sender: <xms:VmdiXBnO6AfJWLnSnllLMePFFe4IXC-EpK82LCLqleG5F77VdUJZfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffujghffg
    ffkfggtgfgsehtqhertddtreejnecuhfhrohhmpeeuvghnucfhihhnnhgvhicuoegsihhg
    nhhoshgvseguvggsihgrnhdrohhrgheqnecuffhomhgrihhnpehumhhitghhrdgvughune
    cukfhppeduuddtrddvfedvrdduuddvrdduieelnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsihhgnhhoshgvseguvggsihgrnhdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:VmdiXJIjAfazBVKDScq77Q1HLckP8b6tTkFEC7LlSCLF1cjOXLclpQ>
    <xmx:VmdiXKZaCDp2bPa7ysv_09TkdPreFqZNbcictv_8ZTx0AcL3NG4-3A>
    <xmx:VmdiXDZcm5Spq1wax0xDmnmYe3XGRmfV9AGWbTnY3okcAbPe1gNtYQ>
    <xmx:VmdiXEirN2mEk3a1snV05lvaPeFxI5Vv4s_8NzEGN5o_UwC7IAN2Tg>
Received: from localhost (illuin.whitetree.org [110.232.112.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id C146D100E5;
        Tue, 12 Feb 2019 01:27:33 -0500 (EST)
From:   Ben Finney <bignose@debian.org>
To:     Martin Steigerwald <Martin.Steigerwald@proact.de>
Cc:     Domenico Andreoli <cavok@debian.org>, 919356@bugs.debian.org,
        Kristian Fiskerstrand <k_f@gentoo.org>,
        Ben Finney <bignose@debian.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "debian-legal\@lists.debian.org" <debian-legal@lists.debian.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: Bug#919356: Licensing of include/linux/hash.h
In-Reply-To: <2977287.v5rPGuGa1n@merkaba> (Martin Steigerwald's message of
        "Mon, 11 Feb 2019 10:50:45 +0000")
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
        <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
        <20190211072259.GA19224@nouveau>
        <20190115083241.6c6ftrw73xuv26j6@dumbo> <2977287.v5rPGuGa1n@merkaba>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
X-Public-Key-ID: 0xAC128405
X-Public-Key-Fingerprint: 517C F14B B2F3 98B0 CB35  4855 B8B2 4C06 AC12 8405
X-Public-Key-URL: http://www.benfinney.id.au/contact/bfinney-pubkey.asc
Date:   Tue, 12 Feb 2019 17:27:31 +1100
Message-ID: <86wom57c8c.fsf@benfinney.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Steigerwald <Martin.Steigerwald@proact.de> writes:

> Well the file has in its header:
>
> /* Fast hashing routine for a long.
>    (C) 2002 William Lee Irwin III, IBM */
>
> /*
>  * Knuth recommends primes in approximately golden ratio to the maximum
>  * integer representable by a machine word for multiplicative hashing.
>  * Chuck Lever verified the effectiveness of this technique:
>  * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
>  *
>  * These primes are chosen to be bit-sparse, that is operations on
>  * them can use shifts and additions instead of multiplications for
>  * machines where multiplications are slow.
>  */
>
> It has been quite a while ago. I bet back then I did not regard this
> as license information since it does not specify a license. Thus I
> assumed it to be GPL-2 as the other files which have no license boiler
> plate. I.e.: Check file is it has different license, if not, then
> assume it has license as specified in COPYING.
>
> Not specifying a license can however also mean in this context that it
> has no license as the file contains copyright information from another
> author.

If a work (even one file) =E2=80=9Chas no license=E2=80=9D, that means no s=
pecial
permissions are granted and normal copyright applies: All rights
reserved, i.e. not redistributable. So, no license is grounds to
consider a work non-free and non-redistributable.

If, on the other hand, the file is to be free software, there would need
to be a clear grant of some free software license to that work.

Given the confusion over this file, I would consider it a significant
risk to just assume we have GPLv2 permissions without being told that
explicitly by the copyright holder. Rather, the reason we are seeking a
clearly-granted free license for this one file, is because we are trying
to replace a probably non-free file with the same code in it.

It seems we need to keep looking, and in the meantime assume we have no
free license in this file.

--=20
 \      =E2=80=9CIf the desire to kill and the opportunity to kill came alw=
ays |
  `\      together, who would escape hanging?=E2=80=9D =E2=80=94Mark Twain,=
 _Following |
_o__)                                                     the Equator_ |
Ben Finney <bignose@debian.org>
