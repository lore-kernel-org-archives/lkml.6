Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647AEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0429E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0429E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967082AbeFSQdo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966692AbeFSQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:33:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DFB20020;
        Tue, 19 Jun 2018 16:33:31 +0000 (UTC)
Date:   Tue, 19 Jun 2018 12:33:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Add TRACE_EVENTs in pwc_isoc_handler()
Message-ID: <20180619123329.52bf6216@gandalf.local.home>
In-Reply-To: <CAJs94EZAAuUS4rznPDmD=1aD8B72P0mLft+YDoNs+74pRXr+KA@mail.gmail.com>
References: <20180617143625.32133-1-matwey@sai.msu.ru>
        <20180618145854.2092c6e0@gandalf.local.home>
        <CAJs94EZAAuUS4rznPDmD=1aD8B72P0mLft+YDoNs+74pRXr+KA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 19:23:04 +0300
"Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:

> Hi Steven,
> 
> Thank you for valuable comments.
> 
> This is for measuring performance of URB completion callback inside PWC driver.
> What do you think about moving events to __usb_hcd_giveback_urb() in
> order to make this more generic? Like the following:
> 
>         local_irq_save(flags);
> // trace urb complete enter
>         urb->complete(urb);
> // trace urb complete exit
>         local_irq_restore(flags);
> 
> 

If that can work for you, I'm fine with that. Trace events may be
cheap, but they do come with some cost. I'd like to have all trace
events be as valuable as possible, and limit the "special case" ones.

-- Steve
