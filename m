Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FD02241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FD02241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeKLVit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:38:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728394AbeKLVit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:38:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31FEBB086;
        Mon, 12 Nov 2018 11:45:54 +0000 (UTC)
Date:   Mon, 12 Nov 2018 12:45:53 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: hidraw: enforce minors_lock locking via lockdep
In-Reply-To: <CAO-hwJJehHLJfgrQvbrW0_bOTTeH-v1qhZK0p0WZCuVDR1wsKw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811121244070.27368@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1811082237460.21975@cbobk.fhfr.pm> <CAO-hwJJehHLJfgrQvbrW0_bOTTeH-v1qhZK0p0WZCuVDR1wsKw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018, Benjamin Tissoires wrote:

> On Thu, Nov 8, 2018 at 10:38 PM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > From: Jiri Kosina <jkosina@suse.cz>
> >
> > lockdep is much more powerful enforcing the locking rules than code comments,
> > so let's switch to it.
> >
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > ---
> 
> Looks good to me.
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I actually missed the comment removal for hidraw_get_report(). I've 
ammeded the patch and comitted, keeping your tag, please shout if you 
disagree :)

Thanks.

-- 
Jiri Kosina
SUSE Labs

