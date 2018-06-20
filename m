Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFEDC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684A020875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684A020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeFTNJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeFTNJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:09:27 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937E120836;
        Wed, 20 Jun 2018 13:09:25 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:09:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Add TRACE_EVENTs in pwc_isoc_handler()
Message-ID: <20180620090923.10255bb5@gandalf.local.home>
In-Reply-To: <CAJs94EZTyfh7vuNt3Dsz6wYdhwc93Np6-UbpDKFupHKaHqxgJQ@mail.gmail.com>
References: <20180617143625.32133-1-matwey@sai.msu.ru>
        <20180618145854.2092c6e0@gandalf.local.home>
        <CAJs94EZAAuUS4rznPDmD=1aD8B72P0mLft+YDoNs+74pRXr+KA@mail.gmail.com>
        <20180619123329.52bf6216@gandalf.local.home>
        <CAJs94EZTyfh7vuNt3Dsz6wYdhwc93Np6-UbpDKFupHKaHqxgJQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 11:05:51 +0300
"Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:


> > If that can work for you, I'm fine with that. Trace events may be
> > cheap, but they do come with some cost. I'd like to have all trace
> > events be as valuable as possible, and limit the "special case" ones.  
> 
> What is the cost for events? I suppose one conditional check when
> trace is disabled? There is already similar debugging stuff related to
> usbmon in __usb_hcd_giveback_urb(), so I don't think that another
> conditional check will hurt performance dramatically there. When
> discussing second patch in this series I see that the issue that it is
> intended to resolve may be common to other USB media drivers.

The cost isn't just about performance. In fact, the performance
overhead of trace events is pretty negligible. The cost I'm worried
about is bloat. Each event can take up to 5K of memory. That can add up
quickly when we add a bunch of events without thinking about that cost.

-- Steve

