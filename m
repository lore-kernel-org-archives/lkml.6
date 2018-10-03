Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB21C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00D521473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00D521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeJDGRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:17:54 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57344 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbeJDGRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:17:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C0B9022A90;
        Wed,  3 Oct 2018 19:27:18 -0400 (EDT)
Date:   Thu, 4 Oct 2018 09:27:16 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Leonardo Bras <leobras.c@gmail.com>
cc:     Robert Richter <rric@kernel.org>, lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v3 0/7] Remove errors building drivers/DRIVERNAME
In-Reply-To: <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1810040915040.8@nippy.intranet>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20181001075607.GA3776@rric.localdomain> <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018, Leonardo Bras wrote:

> 
> Sorry, I was not very clear at my reasons why this change is important, 
> I will try to briefly explain the whole story.
> 
> Some weeks ago I was trying to solve a task that needed to change some 
> compiling options, build the whole kernel (allyesconfig) and look for 
> errors. The problem was: It would take a long time to build everything 
> in my computer. And many friends with slimmer laptops would take much 
> longer.
> 

It seems to me that you shouldn't need expensive optimization for 
continuous integration. In theory that could make a big difference though 
I admit to no experience of build farms.

Have you looked at ccache? It will save you from having to recompile any 
files not changed.

You could also leverage all of your laptops together using distcc.

HTH.

-- 
