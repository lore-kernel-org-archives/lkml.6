Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A210FC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5F207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 21:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC5F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeJ1G13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 02:27:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728532AbeJ1G13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 02:27:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7419EAFA6;
        Sat, 27 Oct 2018 21:45:07 +0000 (UTC)
Date:   Sat, 27 Oct 2018 23:45:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     joe@perches.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Another HID problem this merge window..
In-Reply-To: <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1810272338590.23511@cbobk.fhfr.pm>
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com> <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com> <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2018, Linus Torvalds wrote:

> I wonder if there is some truly old historical legacy there, ie the old 
> PC keyboard support would have been configurable out only for expert 
> users to avoid errors, and maybe the HID Kconfig file started getting 
> ideas from that...

This really goes waaay back to times when we extracted all the quirks from 
the generic driver (which became unmaintainable exactly because quirks 
being sprinkled left and right) into specialized drivers, but didn't want 
to cause too many user surprises that all of a sudden their configuration 
regressed when it comes to hardware support.

We've had exactly this discussion multiple times before, see for example

	https://lkml.org/lkml/2010/5/20/227

So I guess there is no need for replaying it, I think we're in complete 
agreement.

That being said, benff Kconfig setting definitely escaped attention. That 
should never ever have been set to default y, I take blame for not 
noticing that while applying the patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

