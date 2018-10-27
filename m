Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A3ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D909A20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D909A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeJ1BBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 21:01:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728262AbeJ1BBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 21:01:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B24B7AEED;
        Sat, 27 Oct 2018 16:20:20 +0000 (UTC)
Date:   Sat, 27 Oct 2018 18:20:19 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Julian Sax <jsbc@gmx.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops in current tree in i2c
In-Reply-To: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1810271813120.23511@cbobk.fhfr.pm>
References: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2018, Linus Torvalds wrote:

> I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
> isn't terminated by a NULL entry, and I will test that next.

Hm, that almost certainly is indeed the issue, thanks a lot for reporting 
it.

> What makes me *very* unhappy about this is that if I'm right, I think it 
> means that code was literally not tested at all by anybody who didn't 
> have one of the entries in that list.

Honestly, my autotesting of HID tree is running on HW that doesn't have 
i2c transport at all, only USB a Bluetooth. Something to improve I guess; 
will fix that next week.

Benjamin, do you have something for that in place already?

Thanks,

-- 
Jiri Kosina
SUSE Labs

