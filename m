Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9F6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3A420843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3A420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeGYQyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbeGYQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:54:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E272520843;
        Wed, 25 Jul 2018 15:42:35 +0000 (UTC)
Date:   Wed, 25 Jul 2018 11:42:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Artem Savkov <asavkov@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2] tracing/kprobes: Fix trace_probe flags on
 enable_trace_kprobe() failure
Message-ID: <20180725114234.5b8b7860@gandalf.local.home>
In-Reply-To: <20180726004113.d578f6e6a2fa59adf1efb4ea@kernel.org>
References: <20180725142038.4765-1-asavkov@redhat.com>
        <20180726004113.d578f6e6a2fa59adf1efb4ea@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 00:41:13 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 25 Jul 2018 16:20:38 +0200
> Artem Savkov <asavkov@redhat.com> wrote:
> 
> > If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
> > it returns an error, but does not unset the tp flags it set previously.
> > This results in a probe being considered enabled and failures like being
> > unable to remove the probe through kprobe_events file since probes_open()
> > expects every probe to be disabled.
> >   
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Masami,

-- Steve

