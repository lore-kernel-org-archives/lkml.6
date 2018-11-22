Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3141CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00572081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00572081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395564AbeKWBLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:11:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbeKWBLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:11:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6727307D84E;
        Thu, 22 Nov 2018 14:32:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.142])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FE1B17D64;
        Thu, 22 Nov 2018 14:32:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 22 Nov 2018 15:32:12 +0100 (CET)
Date:   Thu, 22 Nov 2018 15:32:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: uprobe support mix of ftrace and perf
Message-ID: <20181122143209.GE28270@redhat.com>
References: <20181120220156.7d94d8c707570411870222fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120220156.7d94d8c707570411870222fd@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 22 Nov 2018 14:32:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 11/20, Masami Hiramatsu wrote:
>
> Hello Oleg,
>
> I have a question about the (revert) commit 48212542067a
> ("tracing/uprobes: Revert "Support mix of ftrace and perf""). I found
> this limitation still exists on uprobe events.

Yes...

> Would you have any plan or idea to fix this issue? I thought this revert
> patch was a tentative one, and should be fixed afterwards.

To be honest, I was going to fix this "soon" many years ago, but today I simply
can't recall how this code actually works and what exactly we need to do to
support ftrace/perf at the same time...

I'll try to read this code later, but I can't promise anything :/

Oleg.

