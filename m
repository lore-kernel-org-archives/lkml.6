Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62655C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3078F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3078F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeKSXtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:49:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:45800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729214AbeKSXtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:49:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFBA2AD55;
        Mon, 19 Nov 2018 13:26:12 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:26:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     David Herrmann <dh.herrmann@gmail.com>
cc:     ebiggers@kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
In-Reply-To: <CANq1E4QDP9EiJZG2pqfKtA_ESoBgNb5ECjause2tTUdYWaqYZA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811191425280.21108@cbobk.fhfr.pm>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <nycvar.YFH.7.76.1811191351020.21108@cbobk.fhfr.pm> <CANq1E4QDP9EiJZG2pqfKtA_ESoBgNb5ECjause2tTUdYWaqYZA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, David Herrmann wrote:

> > Thanks for the patch. I however believe the fix below is more generic, and
> > would prefer taking that one in case noone sees any major flaw in that
> > I've overlooked. Thanks.
> 
> As Andy rightly pointed out, the credentials check is actually needed.
> The scenario here is using a uhid-fd as stdout when executing a
> setuid-program. This will possibly end up reading arbitrary memory
> from the setuid program and use it as input for the hid-descriptor.

Ah, right, that's a very good point indeed; I've overlooked that (valid) 
concern in the thread. Thanks for spotting that, Andy.

I've now applied Eric's patch. Thanks everybody,

-- 
Jiri Kosina
SUSE Labs

