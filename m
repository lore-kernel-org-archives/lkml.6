Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AC2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA458260CA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA458260CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965107AbeF0NMw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:12:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56183 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753493AbeF0NMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:12:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3F50EB021;
        Wed, 27 Jun 2018 13:12:49 +0000 (UTC)
Date:   Wed, 27 Jun 2018 15:12:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Jefferson Carpenter <jeffersoncarpenter2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory zeroed when made available to user process
Message-ID: <20180627131248.GA3032@dhcp22.suse.cz>
References: <71d13d76-4591-9206-ebbb-5e9599f10c7c@gmail.com>
 <CAFLxGvyJsjWum34Q67UP+EGkg9+W0nPsMpu8mS9PaH8wL3Rd9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvyJsjWum34Q67UP+EGkg9+W0nPsMpu8mS9PaH8wL3Rd9g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-06-18 13:29:05, Richard Weinberger wrote:
> On Wed, Jun 27, 2018 at 11:34 AM, Jefferson Carpenter
> <jeffersoncarpenter2@gmail.com> wrote:
> > Is there a way for a user process to mark memory as 'sensitive' or
> > 'non-sensitive' when it is allocated?  That could allow it not to have to be
> > zeroed before being allocated to another process.
> 
> Isn't this what we have Meltdown and Spectre for? ;-)
> 
> No, memory from the kernel is always zeroed.
> libc offers malloc() and calloc() for this purpose.

Well, except for the weird MAP_UNINITIALIZED. Anyway agreed that this is
a bad idea and the flag should have never been merged. I've just
mentioned it for completness.

-- 
Michal Hocko
SUSE Labs
