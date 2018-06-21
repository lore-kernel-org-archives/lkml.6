Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EAFC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514120874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D514120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeFUAuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:50:11 -0400
Received: from ozlabs.org ([203.11.71.1]:36105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754235AbeFUAuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:50:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41B35B2zB3z9s2L;
        Thu, 21 Jun 2018 10:50:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Build regressions/improvements in v4.18-rc1
In-Reply-To: <CAMuHMdUfHJS-ykNr-vPPUDfGLsGr62c4R=EThw33-DFNj9ZQNg@mail.gmail.com>
References: <20180618091729.11091-1-geert@linux-m68k.org> <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com> <87vaafxp0k.fsf@concordia.ellerman.id.au> <CAMuHMdUfHJS-ykNr-vPPUDfGLsGr62c4R=EThw33-DFNj9ZQNg@mail.gmail.com>
Date:   Thu, 21 Jun 2018 10:50:05 +1000
Message-ID: <87efh1vu82.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On Tue, Jun 19, 2018 at 8:35 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
>> > <geert@linux-m68k.org> wrote:
>> >> Below is the list of build error/warning regressions/improvements in
>> >> v4.18-rc1[1] compared to v4.17[2].
...
>
>> Relatedly I might move all the randconfig targets from Linus' tree into
>> a separate "linus-rand" tree, so that they don't pollute the results, as
>> I've done for linux-next.
>
> Sounds look a good thing.

OK done.

See eg:
  http://kisskb.ellerman.id.au/kisskb/head/14180/


At the moment the "head" page shows the progress/successful for that
head across all branches, so the linus-rand results get counted together
with the linus results which is a bit annoying.

I'm working on a change so that you can view a head *on a branch* so
that you only see the progress/successful for that branch. I'll try and
polish that up and get it pushed RSN.

cheers
