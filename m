Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EBEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9D120652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9D120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbeFTJPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:15:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:57425 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754238AbeFTIdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9E9AAC1E;
        Wed, 20 Jun 2018 07:15:55 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:15:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hans de Goede <hdegoede@redhat.com>, Julian Sax <jsbc@gmx.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] HID fixes
In-Reply-To: <CA+55aFwCt9WZoBHEbsR65h=BRJ-GhqwWgU87wd2o4A_TzxQW2Q@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1806200913420.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm> <CA+55aFx1o8+ZTAqVQNH7Wq8tm90XYTUEx5By2wWo3KJDR3g2MQ@mail.gmail.com> <nycvar.YFH.7.76.1806200611290.6203@cbobk.fhfr.pm> <b952c1f6-5866-d25e-32c2-ac0ded1812e2@redhat.com>
 <CA+55aFwCt9WZoBHEbsR65h=BRJ-GhqwWgU87wd2o4A_TzxQW2Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Linus Torvalds wrote:

> But what is the *source* of this binary crud?
> 
> Because no way in hell do we take binary crud from random places, and
> then add it to the kernel.
> 
> NOT EVEN IF IT WENT THROUGH SOME "hidrd-convert" PHASE!
> 
> And yes, now that I google for that hidrd-convert pattern, I see that
> we already have other broken chunks like this.
> 
> Not ok. At least some of them seem to mention where the data comes from, 
> eg
> 
>    "This is the original report descriptor as reported by lsusb -vd 046d:c294"
> 
> but this one has no such information.
> 
> So guys, you need to think about where things come from, and document
> how some random garbage came to be. Not just add it to the kernel.

Well, at least for the ones I've done myself in the past, those are 
hand-written from scratch.

It's not really a firmware / code, it's just a description of the data in 
the reports, so that HID parser can interpret it properly.

-- 
Jiri Kosina
SUSE Labs

