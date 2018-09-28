Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9530C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4327D2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gwuhanni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4327D2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeI1IoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:44:06 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:31762 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1IoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:44:06 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8S2MHwk026665;
        Fri, 28 Sep 2018 11:22:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8S2MHwk026665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538101338;
        bh=c/aRiv1BNJbK/3IVRPMKrLaPYrCikdpTmFye7LMSGb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gwuhanniCZ/A6DGC/f/Q47P9XpzzgOLmJBYjIuDFk/mnIZpaYywhHI7vMl9oeLZnM
         4KozSCTQK8IRb4Gg8sr5cDeGsTI0ijdPyh1j+Cb4rQSsDHDR4cNFMn64pckek6dtEQ
         c9jOrGoTGT7evAZ4jFi3rQ0jY8hFy4NJK5k0+KNgBMXGaufgV4iIVb3BMzPq/1+lLa
         CpXeEHRnDrs5FfRhoSKf9xxF3zr5wlgbG+vcWnbvUtC4z2ibcBih5YKw4CqFqE4jp8
         5VlcWp6hHJlm5iYIzlqsJ8lmclNIWZ+KxfZosJcfHcQpAFWmw/bzd20m6ZfMD0KUVS
         83SnBgD1+soeQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id z130-v6so2704521vsc.7;
        Thu, 27 Sep 2018 19:22:18 -0700 (PDT)
X-Gm-Message-State: ABuFfohELsMnhEJVzJc7tfHmBpjPG6O1IczfL0LKda9F6sIi9nsv6NL2
        iuIClUCKMSXNqPBEbyzukS7YY4RtuDLLsKcW/qQ=
X-Google-Smtp-Source: ACcGV61XaMJ3iMSdoazqdDkifZERYI19aRS6L7oLslIn7GT7PDC0kqKxuZOOXPTBruNdaq+kbAy+vmD8NxdW5wY3Hp0=
X-Received: by 2002:a67:6e02:: with SMTP id j2-v6mr3191778vsc.215.1538101337229;
 Thu, 27 Sep 2018 19:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180815142749.18804-1-linux@rasmusvillemoes.dk> <CAKwiHFj5yGtsR+s0Ukjy0Pe1pDpd_euyT0MRZdTt0H3ssXqYXQ@mail.gmail.com>
In-Reply-To: <CAKwiHFj5yGtsR+s0Ukjy0Pe1pDpd_euyT0MRZdTt0H3ssXqYXQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 28 Sep 2018 11:21:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmw1Tic2mDybRd-5CbZK_6J1+=3j31q8K9hONVoRHrdA@mail.gmail.com>
Message-ID: <CAK7LNATmw1Tic2mDybRd-5CbZK_6J1+=3j31q8K9hONVoRHrdA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Kbuild: Some fixdep tweaks
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,


2018=E5=B9=B49=E6=9C=8827=E6=97=A5(=E6=9C=A8) 3:58 Rasmus Villemoes <linux@=
rasmusvillemoes.dk>:
>
> On 15 August 2018 at 16:27, Rasmus Villemoes <linux@rasmusvillemoes.dk> w=
rote:
> > These patches eliminate two (albeit tiny and shortlived) processes
> > from the cmd_and_fixdep rule, i.e. from every TU being
> > compiled. Whether the diffstat below is worth it I'll leave to Kbuild
> > maintainers to decide.
>
> Ping.


Sorry for delay.
As far as I tested, the performance improvement was not noticeable level.

This patch set actually sits on the fence.
I tend to choose not-apply when I cannot make up my mind.


If you have something more to convince me, please let me know.


--=20
Best Regards
Masahiro Yamada
