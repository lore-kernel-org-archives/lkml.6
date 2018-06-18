Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50770C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8C220693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8C220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936930AbeFRVvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:51:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbeFRVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:51:17 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF855D67;
        Mon, 18 Jun 2018 21:51:16 +0000 (UTC)
Date:   Mon, 18 Jun 2018 14:51:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc: Limit sysctl value to IPCMNI
Message-Id: <20180618145114.4a50c378b38b639d7ea8ecdc@linux-foundation.org>
In-Reply-To: <b4162bb3-3cb2-bd86-63f5-da4f92079745@redhat.com>
References: <20180608134949.12672-1-tiwai@suse.de>
        <20180608141659.8a517b128c756b4d0b813c9e@linux-foundation.org>
        <s5ha7s43167.wl-tiwai@suse.de>
        <20180611161845.6164d3a6c2df353fe11895bf@linux-foundation.org>
        <s5htvq8zf2n.wl-tiwai@suse.de>
        <20180612163601.bef7f58dadda2832b36db3f6@linux-foundation.org>
        <b4162bb3-3cb2-bd86-63f5-da4f92079745@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 13:27:24 +0800 Waiman Long <longman@redhat.com> wrote:

> >>
> >> Maybe another possible solution would be to add another proc entry to
> >> handle this correctly, and make the old one only for compatibility.
> > Yes, I guess so.  Just leave the old tunable alone.  Possibly we
> > could add a printk_once("please switch to the new interface").
> 
> A problem with that is the fact that those sysctl parameters have been
> there for so long that it may be hard to persuade users to use the new
> sysctl parameters.

That's what a once-off warning could help with.  Tell them they're
using a deprecated interface.  It would take a few years, but when
people see the old interface is scheduled for removal, they'll switch,
over time.



