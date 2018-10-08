Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF07C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3125C20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3125C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJHWxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:53:12 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:36248 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbeJHWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:53:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 789768368EE1;
        Mon,  8 Oct 2018 15:40:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: voice63_24766164a462c
X-Filterd-Recvd-Size: 2707
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Oct 2018 15:40:50 +0000 (UTC)
Message-ID: <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Jason@zx2c4.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Oct 2018 08:40:49 -0700
In-Reply-To: <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
         <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 09:31 +0200, Miguel Ojeda wrote:
> On Mon, Oct 8, 2018 at 4:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > The shiny new .clang-format file lists a number of nice iterators in
> > the ForEachMacros category, the consequence being that there is a
> > space between the iterator name and the opening parenthesis. This
> > strikes me as the right thing to do.
 
It does not strike me as the right thing to do.

Keeping an exhaustive list current is a continuing
burden and the list generally goes stale over time.

> > However, checkpatch.pl complains about it:
> > 
> > WARNING: space prohibited between function name and open parenthesis '('
> > #65: FILE: ratelimiter.c:65:
> > +               hlist_for_each_entry_safe (entry, temp, &table_v4[i], hash) {
> > 
> > It would seem that .clang-format is right and checkpatch.pl is wrong?
> 
> Checking quickly, it would seem most of the kernel does not put a
> space there (a minority does), e.g.:
> 
>   git grep 'list_for_each[a-zA-Z0-9_]* (' | wc -l # 67
>   git grep 'list_for_each[a-zA-Z0-9_]*(' | wc -l # 13892
> 
> So in that sense, checkpatch.pl is right (even if it is not a function call).

As a general rule, I believe any dominant coding style
is correct. These things are just a convention.

.clang-format is a work in progress and should be updated
where possible to reflect the kernel dominant styles.

> We would probably need to implement SpaceBeforeForEachMacros (or a new
> option for SpaceBeforeParens). I haven't had the time to look into
> adding the missing support for the few things that the kernel style
> requires, sadly, but it is in my TODO list.

Good luck and as you are the .clang_format maintainer,
I hope you find the time.



