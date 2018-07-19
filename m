Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEC5206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEC5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbeGSJHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:07:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeGSJHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DBF687AAA;
        Thu, 19 Jul 2018 08:25:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D5F9111AF0C;
        Thu, 19 Jul 2018 08:25:39 +0000 (UTC)
Date:   Thu, 19 Jul 2018 10:25:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC] perf annotate: option to report global percentage
Message-ID: <20180719082539.GB18667@krava>
References: <CABPqkBT0P=GKNb6ypjaPxe4dEwShHk37mdrX0RtodMm44gaE+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBT0P=GKNb6ypjaPxe4dEwShHk37mdrX0RtodMm44gaE+Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 08:25:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 08:25:40 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:55:14PM -0700, Stephane Eranian wrote:
> Hi Jiri,
> 
> As far as I know, once you go into annotate mode, via perf report TUI
> mode, the percentage you see per instruction is relative to the
> function. I would like the option to display the total percentage,
> i..e, the importance of the instruction for the entire run. Right now,
> if I want that, I need to do function_percentage * insn_percentage by
> hand. This is not convenient. Having a key toggle would be very
> useful, worst case a cmdline option.
> 
> What do you think?

hi,
that should be simple to add, we already have the 'F' in the
main browser window to toggle among full/filtered scale

I'll try to add something similar for annotation window

jirka
