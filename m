Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF49C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EADE2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EADE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJ3GNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:13:17 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44780 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3GNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:13:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHEzk-0001wC-0U; Mon, 29 Oct 2018 15:22:44 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHEzU-00010P-8x; Mon, 29 Oct 2018 15:22:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "criu\@openvz.org" <criu@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180919205037.9574-1-dima@arista.com>
        <874lej6nny.fsf@xmission.com>
        <20180924205119.GA14833@outlook.office365.com>
        <874leezh8n.fsf@xmission.com>
        <20180925014150.GA6302@outlook.office365.com>
        <87zhw4rwiq.fsf@xmission.com>
        <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
        <87mus1ftb9.fsf@xmission.com> <20181021014121.GA23474@gmail.com>
        <alpine.DEB.2.21.1810292026040.5984@nanos.tec.linutronix.de>
Date:   Mon, 29 Oct 2018 16:21:57 -0500
In-Reply-To: <alpine.DEB.2.21.1810292026040.5984@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Mon, 29 Oct 2018 21:33:14 +0100 (CET)")
Message-ID: <87y3ag5tze.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gHEzU-00010P-8x;;;mid=<87y3ag5tze.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+dUC6N5uK9wc0m7Y2qv4oGFCrlAGyeNw8=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Andrei,
>
> On Sat, 20 Oct 2018, Andrei Vagin wrote:
>> When a container is migrated to another host, we have to restore its
>> monotonic and boottime clocks, but we still expect that the container
>> will continue using the host real-time clock.
>> 
>> Before stating this series, I was thinking about this, I decided that
>> these cases can be solved independently. Probably, the full isolation of
>> the time sub-system will have much higher overhead than just offsets for
>> a few clocks. And the idea that isolation of the real-time clock should
>> be optional gives us another hint that offsets for monotonic and
>> boot-time clocks can be implemented independently.
>> 
>> Eric and Tomas, what do you think about this? If you agree that these
>> two cases can be implemented separately, what should we do with this
>> series to make it ready to be merged?
>> 
>> I know that we need to:
>> 
>> * look at device drivers that report timestamps in CLOCK_MONOTONIC base.
>
> and CLOCK_BOOTTIME and that's quite a few.
>
>> * forbid changing offsets after creating timers
>
> There are more things to think about. What about interfaces which expose
> boot time or monotonic time in /proc?
>
> Aside of that (I finally came around to look at the series in more detail)
> I'm really unhappy about the unconditional overhead once the Time namespace
> config switch is enabled. This applies especially to the VDSO. We spent
> quite some time recently to squeeze a few cycles out of those functions and
> it would be a pity to pointlessly waste cycles for the !namespace case.
>
> I can see the urge for this, but please let us think it through properly
> before rushing anything in which we are going to regret once we want to do
> more sophisticated time domain management, e.g. support for isolated clock
> real time. I'm worried, that without a clear plan about the overall
> picture, we end up with duct tape which is hard to distangle after the
> fact.
>
> There have been a few other things brought up versus time management in
> general, like the TSN folks utilizing grand clock masters which expose
> random time instead of proper TAI. Plus some requirements for exposing some
> sort of 'monotonic' clocks which are derived from external synchronization
> mechanisms, but should not affect the regular time keeping clocks.
>
> While different issues, these all fall into the category of separate time
> domains, so taking a step back to the drawing board is probably the best
> thing what we can do now.
>
> There are certainly a few things which can be looked at independently,
> e.g. the VDSO mechanics or general mechanisms to avoid plastering the whole
> kernel with these name space functions applying offsets left and right. I
> rather have dedicated core functionality which replaces/amends existing
> timer functions to become time namespace aware.
>
> I'll try to find some time in the next weeks to look deeper into that, but
> I can't promise anything before returning from LPC. Btw, LPC would be a
> great opportunity to discuss that. Are you and the other name space wizards
> there by any chance?

I will be and there are going to be both container and CRIU
mini-conferences.  So there should at least some of us around.

Eric
