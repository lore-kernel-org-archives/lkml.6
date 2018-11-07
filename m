Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CB320818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CB320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeKHFew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:34:52 -0500
Received: from air.basealt.ru ([194.107.17.39]:39056 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKHFew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:34:52 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id C26E9589A96; Wed,  7 Nov 2018 20:02:57 +0000 (UTC)
Received: from akathisia (ip4-83-240-49-150.cust.nbox.cz [83.240.49.150])
        by air.basealt.ru (Postfix) with ESMTPSA id 502C558959F;
        Wed,  7 Nov 2018 20:02:55 +0000 (UTC)
Date:   Wed, 7 Nov 2018 21:02:51 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, ldv@altlinux.org,
        esyr@redhat.com, luto@kernel.org, strace-devel@lists.strace.io
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181107210251.542cf8a1@akathisia>
In-Reply-To: <20181107164443.GA8726@redhat.com>
References: <20181107042751.3b519062@akathisia>
        <20181107112100.GA20419@redhat.com>
        <3BDB914D-12F3-4703-A033-EBE02226EC45@amacapital.net>
        <20181107164443.GA8726@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 17:44:44 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> To me PT_IN_SYSCALL_STOP makes no real sense, but I won't argue.
> 
> At least I'd ask to not abuse task->ptrace. ptrace_report_syscall() can clear
> ->ptrace_message on exit if we really want PTRACE_GET_SYSCALL_INFO to fail after  
> that.

I really would not like to rely on ->ptrace_message remaining empty;
this looks too fragile.
