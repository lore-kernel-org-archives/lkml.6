Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1272FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D680D20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D680D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeK0BvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0BvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:51:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CCCE6EB95;
        Mon, 26 Nov 2018 14:56:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id A250E19C7F;
        Mon, 26 Nov 2018 14:56:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 26 Nov 2018 15:56:46 +0100 (CET)
Date:   Mon, 26 Nov 2018 15:56:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Elvira Khabirova <lineprinter@altlinux.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/3] ptrace: pass type of a syscall-stop in
 ptrace_message
Message-ID: <20181126145643.GD1660@redhat.com>
References: <20181125022150.46258a20@akathisia>
 <20181125022227.55e8caf7@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125022227.55e8caf7@akathisia>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Nov 2018 14:56:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25, Elvira Khabirova wrote:
>
> + * These values are stored in task->ptrace_message by tracehook_report_syscall_*
> + * to describe current syscall-stop.
> + *
> + * Values for these constants are chosen so that they do not appear
> + * in task->ptrace_message by other means.
> + */
> +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	0x80000000U
> +#define PTRACE_EVENTMSG_SYSCALL_EXIT	0x90000000U

Stupid question, why not

	#define PTRACE_EVENT_SYSCALL_ENTRY	8
	#define PTRACE_EVENT_SYSCALL_EXIT	9

right after other PTRACE_EVENT_* constants?

The next 3/3 tries to detect PTRACE_EVENT_SECCOMP case anyway, so I am not sure
I understand what "do not appear in task->ptrace_message by other means" actually
means...

Oleg.

