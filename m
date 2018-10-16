Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892E3208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892E3208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJPXSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:18:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42693 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:18:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCRFV-0005At-E3; Tue, 16 Oct 2018 09:27:09 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCRFU-00088y-Gi; Tue, 16 Oct 2018 09:27:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Enke Chen <enkechen@cisco.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky \(kamensky\)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <87va62lri4.fsf@xmission.com>
        <6211eeaa-ce07-a909-e4c2-172618ddfb95@cisco.com>
Date:   Tue, 16 Oct 2018 10:26:50 -0500
In-Reply-To: <6211eeaa-ce07-a909-e4c2-172618ddfb95@cisco.com> (Enke Chen's
        message of "Mon, 15 Oct 2018 17:54:43 -0700")
Message-ID: <87ftx5kj45.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gCRFU-00088y-Gi;;;mid=<87ftx5kj45.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18cBUikD1RZP+LoIb4Y7J0pKV0OWDGySyw=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enke Chen <enkechen@cisco.com> writes:

> Hi, Eric:
>
> On 10/15/18 4:28 PM, Eric W. Biederman wrote:

>> With that said I think the best solution would be to figure out how to
>> allow the coredump to run in parallel with the usual exit signal, and
>> exit code reaping of the process> 
>> That would solve the problem for everyone, and would not introduce any
>> new complicated APIs.
>
> That would certainly help. But given the huge deployment of Linux, I don't
> think it would be feasible to change this fundamental behavior (signal post
> coredump).

Of course it will be feasible to change.  Make it a sysctl and keep the
current default and no one will even notice.  Waiting for something that
is happening asynchronously is not be difficult so having the wait
optional should not be a problem.

Right now the default in most distributions is to disable core dumps
entirely.   Which means that you are going to have to find a very
specific situation in which people and applications care about core
dumps happening to break an existing setup.

Then all you have to do to get the non-blocking behavior is to just do:
echo 1 > /proc/sys/kernel_core_async

Then everything else works without modifications and everyone is happy.
Maybe I am wearing rose colored glasses but that looks like all that is
needed and it should be much easier to work with and maintain than
having to modify every manager process to listen for unreliable signals,
and then take action on those unreliable signals.

Eric
