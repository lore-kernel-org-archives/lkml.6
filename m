Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A1E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A1E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeGZQkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeGZQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:40:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28A920685;
        Thu, 26 Jul 2018 15:22:46 +0000 (UTC)
Date:   Thu, 26 Jul 2018 11:22:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180726112245.3c1bf91d@gandalf.local.home>
In-Reply-To: <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
References: <20180725202238.165314-1-salyzyn@android.com>
        <20180725210717.3b807191@vmware.local.home>
        <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 08:14:08 -0700
Mark Salyzyn <salyzyn@android.com> wrote:

> Thank you Steve, much appreciated feedback, I have asked the security 
> developers to keep this in mind and come up with a correct fix.
> 
> The correct fix that meets your guidelines would _not_ be suitable for 
> stable due to the invasiveness it sounds, only for the latest will such 
> a rework make sense. As such, the fix proposed in this patch is the only 
> one that meets the bar for stable patch simplicity, and merely(!) needs 
> to state that if the fix is taken, perf and trace are broken.
> 
> Posting this patch publicly on the lists, that may never be applied, may 
> be the limit of our responsibility for a fix to stable kernel releases, 
> to be optionally applied by vendors concerned with this CVE criteria?
>

The patch breaks the code it touches. It makes it useless. If you want
something for stable, add a command line parameter that just disables
the creation of that file. Otherwise you will break usespace and that
will be a definitely NAK from Linus, and for stable itself. This is a
very minor security issue, and does not justify breaking userspace
applications. I would be very upset if a new stable release broke both
perf and trace-cmd's ability to read certain trace events.

-- Steve
