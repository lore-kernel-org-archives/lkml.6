Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E053C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4751C262BF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4751C262BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigma-star.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965351AbeF0NTC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:19:02 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:48600 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965216AbeF0NTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:19:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 7757E18198DEB;
        Wed, 27 Jun 2018 15:19:00 +0200 (CEST)
From:   Richard Weinberger <richard@sigma-star.at>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Jefferson Carpenter <jeffersoncarpenter2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory zeroed when made available to user process
Date:   Wed, 27 Jun 2018 15:18:52 +0200
Message-ID: <2634793.Cb5OrAPIO5@blindfold>
In-Reply-To: <20180627131248.GA3032@dhcp22.suse.cz>
References: <71d13d76-4591-9206-ebbb-5e9599f10c7c@gmail.com> <CAFLxGvyJsjWum34Q67UP+EGkg9+W0nPsMpu8mS9PaH8wL3Rd9g@mail.gmail.com> <20180627131248.GA3032@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. Juni 2018, 15:12:48 CEST schrieb Michal Hocko:
> On Wed 27-06-18 13:29:05, Richard Weinberger wrote:
> > On Wed, Jun 27, 2018 at 11:34 AM, Jefferson Carpenter
> > <jeffersoncarpenter2@gmail.com> wrote:
> > > Is there a way for a user process to mark memory as 'sensitive' or
> > > 'non-sensitive' when it is allocated?  That could allow it not to have to be
> > > zeroed before being allocated to another process.
> > 
> > Isn't this what we have Meltdown and Spectre for? ;-)
> > 
> > No, memory from the kernel is always zeroed.
> > libc offers malloc() and calloc() for this purpose.
> 
> Well, except for the weird MAP_UNINITIALIZED. Anyway agreed that this is
> a bad idea and the flag should have never been merged. I've just
> mentioned it for completness.

Oh, I forgot about the crazy nommu world. :-)

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
