Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9837C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F5B208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F5B208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeGaRMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732269AbeGaRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:12:47 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780F620841;
        Tue, 31 Jul 2018 15:31:55 +0000 (UTC)
Date:   Tue, 31 Jul 2018 11:31:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Zubin Mithra <zsm@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2] tracefs: Annotate tracefs_ops with __ro_after_init
Message-ID: <20180731113153.67471c20@gandalf.local.home>
In-Reply-To: <CAGXu5j+Zk564SijO=eXxryUTNojO7h-rgf_BuQMKesWb+zPOJg@mail.gmail.com>
References: <20180725171901.4468-1-zsm@chromium.org>
        <CAGXu5jJhgbDYK4ZQtkZtpNPMMYwz-iH4224eULmLDdrvp-s4BA@mail.gmail.com>
        <CAGXu5j+Zk564SijO=eXxryUTNojO7h-rgf_BuQMKesWb+zPOJg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 17:25:06 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Jul 25, 2018 at 11:00 AM, Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Jul 25, 2018 at 10:19 AM, Zubin Mithra <zsm@chromium.org> wrote:  
> >> tracefs_ops is initialized inside tracefs_create_instance_dir and not
> >> modified after. tracefs_create_instance_dir allows for initialization
> >> only once, and is called from create_trace_instances(marked __init),
> >> which is called from tracer_init_tracefs(marked __init). Also, mark
> >> tracefs_create_instance_dir as __init.
> >>
> >> Signed-off-by: Zubin Mithra <zsm@chromium.org>  
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>  
> 
> Steve, do you have a tree for this or should we rope akpm in? :)
>

I'll pull it in. I'm currently working on a bunch of small patches for
the merge window now anyway.

Thanks!

-- Steve
