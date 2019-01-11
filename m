Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C19FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562D920836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfAKPjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:39:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbfAKPjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:39:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3EA58666B;
        Fri, 11 Jan 2019 15:39:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.47])
        by smtp.corp.redhat.com (Postfix) with SMTP id CCBDD5D9C7;
        Fri, 11 Jan 2019 15:39:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 11 Jan 2019 16:39:17 +0100 (CET)
Date:   Fri, 11 Jan 2019 16:39:16 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] kernel: release ptraced tasks before
 zap_pid_ns_processes
Message-ID: <20190111153915.GA31013@redhat.com>
References: <20190110175200.12442-1-avagin@gmail.com>
 <20190110153747.75787a99b380f415ee38d145@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110153747.75787a99b380f415ee38d145@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 11 Jan 2019 15:39:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10, Andrew Morton wrote:
>
> > Fixes: 7c8bd2322c7f ("exit: ptrace: shift "reap dead" code from exit_ptrace() to forget_original_parent()")
> >
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
>
> Does this warrant a -stable backport?  7c8bd2322c7f was 4+ years ago...

Agreed, the problem is trivially reproducible.

Oleg.

