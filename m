Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99488C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC10222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550157410;
	bh=0z5xZ1mep1QRc+jvfTZb3wHD/P9rRZ0MyFoyAJmem2A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=vH6fqQHBEgNW5h7Tj5VsbwmtIL6meGRjEGQOVJjUdWihLiGohXLb4itH9g7QDT7pA
	 R+/us7/4zSUZmQQSgdM4hPNiP0hv7u4GEfTmZm9+IHB8/lqcqb6SjhdbltdK9kU+mO
	 8m+FoODwRsbgY0ZT6AE5f7Ud9oO0Z6GwqJXrEJH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407498AbfBNPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389467AbfBNPQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:16:48 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56154222C9;
        Thu, 14 Feb 2019 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550157408;
        bh=0z5xZ1mep1QRc+jvfTZb3wHD/P9rRZ0MyFoyAJmem2A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=etfQzo3cqLEIhTES6+kcgATHCMMnmnYqMNEE/dxBTZMIhmjoqxcTCm3IwDgkKrqP4
         I2KIBSrR280b97wranOMTjhpic7P0yz4ECwwvp0Pgt85oI2XwfsIhCuhvcQWcEkWbm
         Gnl5hthF76m+xMuJFZSoBWzzGmSbbFKuEgr6bJqo=
Message-ID: <1550157406.2498.4.camel@kernel.org>
Subject: Re: [RFC PATCH v2 4/5] tracing: Use tracing error_log with kprobe
 events (incomplete)
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Thu, 14 Feb 2019 09:16:46 -0600
In-Reply-To: <20190214121359.fff5e00e036fec5bfe39351e@kernel.org>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
         <db931dea3818fb79a710f7b83cb53b06cf565de1.1550074795.git.tom.zanussi@linux.intel.com>
         <20190214121359.fff5e00e036fec5bfe39351e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, 2019-02-14 at 12:13 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed, 13 Feb 2019 12:17:55 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Here are a few examples of replacing kprobe_events error handling
> > with
> > tracing_log_err() from the new tracing error_log mechanism.  Only a
> > few example errors are converted, and even these are incomplete,
> > since
> > I didn't know where to get the current command and used a dummy
> > string
> > for those.  Also, these are completely untested, just provided for
> > RFC purposes.
> 
> OK, can I take this over? I would like to try to use this framework.
> 

Sure, be my guest. ;-)

Thanks,

Tom

