Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3904C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83F320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfAQUmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:42:53 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:38677 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbfAQUmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:42:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 99C99182CF68D;
        Thu, 17 Jan 2019 20:42:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin26_7022ca1577405
X-Filterd-Recvd-Size: 1494
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Jan 2019 20:42:50 +0000 (UTC)
Message-ID: <46388f53a3790781f0c39bf3444140152caadab1.camel@perches.com>
Subject: Re: [PATCH] tracing: uprobes: fix typo in pr_fmt string
From:   Joe Perches <joe@perches.com>
To:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 12:42:49 -0800
In-Reply-To: <20190117133023.19292-1-andreas.ziegler@fau.de>
References: <20190117133023.19292-1-andreas.ziegler@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 14:30 +0100, Andreas Ziegler wrote:
> The subsystem-specific message prefix for uprobes was also
> "trace_kprobe: " instead of "trace_uprobe: " as described in
> the original commit message.
[]
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
[]
> @@ -5,7 +5,7 @@
>   * Copyright (C) IBM Corporation, 2010-2012
>   * Author:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>   */
> -#define pr_fmt(fmt)	"trace_kprobe: " fmt
> +#define pr_fmt(fmt)	"trace_uprobe: " fmt

Perhaps use the more common KBUILD_MODNAME instead

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt


