Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FB5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957FE21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957FE21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=s5r6.in-berlin.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeIRTuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:50:13 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:59317 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRTuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:50:13 -0400
X-Greylist: delayed 885 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 15:50:10 EDT
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id w8IE25iP024816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Sep 2018 16:02:05 +0200
Date:   Tue, 18 Sep 2018 16:02:05 +0200
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Jann Horn <jannh@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux1394-devel@lists.sourceforge.net,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firewire: nosy: don't read packets bigger than
 requested
Message-ID: <20180918160205.1e636d40@kant>
In-Reply-To: <cbf4c05d-94f2-6ef0-0c90-1f5823329bbb@infradead.org>
References: <20180706151649.31119-1-jannh@google.com>
        <CAG48ez1etiHmD-e9szTEApia9YhUFomCcZM3Yp9wj9xrDWKmzg@mail.gmail.com>
        <cbf4c05d-94f2-6ef0-0c90-1f5823329bbb@infradead.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 03 Randy Dunlap wrote:
> On 09/03/2018 08:55 AM, Jann Horn wrote:
> > On Fri, Jul 6, 2018 at 5:16 PM Jann Horn <jannh@google.com> wrote:  
> >> In general, accessing userspace memory beyond the length of the supplied
> >> buffer in VFS read/write handlers can lead to both kernel memory corruption
> >> (via kernel_read()/kernel_write(), which can e.g. be triggered via
> >> sys_splice()) and privilege escalation inside userspace.
> >>
> >> Fixes: 286468210d83 ("firewire: new driver: nosy - IEEE 1394 traffic sniffer")
> >> Signed-off-by: Jann Horn <jannh@google.com>
[...]
> >>  drivers/firewire/nosy.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
[...]
> > Ping. I sent this about two months ago, I haven't received a reply,
> > and from what I can tell, it hasn't landed in any tree so far...
> >   
> 
> :(
> I have that same problem with some Firewire documentation patches.
> I plan to ask someone else to merge my patches.

Jann,

sorry for not responding in July (was buried in other work and been
effectively absent from maintainership for many months).  And sorry for
missing your ping in September (it must have been misplaced into the spam
folder and I apparently overlooked it there).

This week is another one in which I will not be able to check your patch.
Next week I will have a vacation of sorts and will use it to (a) review
and merge your patch and (b) clean out my mailbox and update my mail
sorting filters (long overdue after my mail service provider changed
backends).

Again sorry, and thank you for your extraordinary patience.
-- 
Stefan Richter
-======---=- =--= =--=-
http://arcgraph.de/sr/
