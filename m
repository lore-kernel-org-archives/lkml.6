Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C04620685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C04620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeJaWBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbeJaWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:01:22 -0400
Received: from vmware.local.home (unknown [217.16.13.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD7820664;
        Wed, 31 Oct 2018 13:03:22 +0000 (UTC)
Date:   Wed, 31 Oct 2018 09:03:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kretprobe: produce sane stack traces
Message-ID: <20181031090317.4e211fdd@vmware.local.home>
In-Reply-To: <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
References: <20181026132210.12569-1-cyphar@cyphar.com>
        <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 10:12:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Anyway, until that merge happens, this patch looks good to avoid
> this issue for generic solution (e.g. for the arch which doesn't
> supports retstack).

I think its time to come up with an algorithm that makes function graph
work with multiple users, and have kretprobes be able to hook into it
just like kprobes hooks into function tracer.

I have some ideas on how to get this done, and will try to have an RFC
patch set ready by plumbers.

-- Steve
