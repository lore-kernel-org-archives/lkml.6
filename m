Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32CB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfAIRId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:08:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfAIRIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:08:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75BE12D7E1;
        Wed,  9 Jan 2019 17:08:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.47])
        by smtp.corp.redhat.com (Postfix) with SMTP id 43D8C6013A;
        Wed,  9 Jan 2019 17:08:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  9 Jan 2019 18:08:32 +0100 (CET)
Date:   Wed, 9 Jan 2019 18:08:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: release ptraced tasks before zap_pid_ns_processes
Message-ID: <20190109170829.GA15302@redhat.com>
References: <20190102205939.26231-1-avagin@gmail.com>
 <20190108165043.GA10240@redhat.com>
 <20190108203612.GA19454@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108203612.GA19454@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 09 Jan 2019 17:08:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08, Andrei Vagin wrote:
>
> No, you don't. The patch looks really nice. Thanks!
>
> BTW: We probably need to add the "Fixes:" tag, but I am not sure to which
> commit, it looks like the issue is here for years.

I hate you ;) Ok, OK, this was broken by me in 7c8bd2322c7fd973d089b27de55e29c92c667a06
"exit: ptrace: shift "reap dead" code from exit_ptrace() to forget_original_parent()"

> Acked-by: Andrei Vagin <avagin@gmail.com>

Thanks, but if you agree with this patch may I ask you to send v2?

You found the real problem, my version is only slightly better than yours,
I don't want to steal the "From" tag. Feel free to add mine signed-of-by.

Oleg.

