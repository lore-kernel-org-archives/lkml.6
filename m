Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2225C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EB721990
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EB721990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHHPMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHHPMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:12:37 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B44219EF;
        Wed,  8 Aug 2018 12:53:03 +0000 (UTC)
Date:   Wed, 8 Aug 2018 08:53:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     broonie@opensource.wolfsonmicro.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] ASoC: trace: track dapm type in snd_soc_dapm_widget
Message-ID: <20180808085301.2b0617c6@gandalf.local.home>
In-Reply-To: <20180808123921.GA145536@sofia>
References: <20180808092927.GA144203@sofia>
        <20180808082412.20f7bd92@gandalf.local.home>
        <20180808123921.GA145536@sofia>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 20:39:22 +0800
"Liu, Changcheng" <changcheng.liu@intel.com> wrote:

> > > -	TP_printk("widget=%s val=%d", __get_str(name),
> > > -		  (int)__entry->val)
> > > +	TP_printk("widget=%s dapm_id=%d val=%d", __get_str(name),
> > > +		  (int)__entry->id, (int)__entry->val)  
> > 
> > Not sure why it was there before, but the (int) typecast isn't needed
> > in either case. __field(int, val) makes __entry->val of type int. Same
> > for id.
> > 
> > -- Steve  
> 
> @Steve: This patch aims at tracking the dapm up/down sequence. For the
> (int) typecast format problem, what do you think of using another
> seperate patch to resolve it?

Yeah, I was just commenting on that as a general comment. It doesn't
affect the actual patch, which I don't see anything wrong with it from
a tracing point of view.

I agree the typecast removal should be done in a separate clean-up
patch.

-- Steve
