Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1052C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F120205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F120205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCNBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:01:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33953 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:01:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g7aQg-0000QB-3B; Wed, 03 Oct 2018 00:14:38 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g7aQe-0005AX-LL; Wed, 03 Oct 2018 00:14:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, avagin@virtuozzo.com,
        dima@arista.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        0x7f454c46@gmail.com, adrian@lisas.de,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        gorcunov@openvz.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>, xemul@virtuozzo.com,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org
References: <20180919205037.9574-1-dima@arista.com>
        <874lej6nny.fsf@xmission.com>
        <20180924205119.GA14833@outlook.office365.com>
        <874leezh8n.fsf@xmission.com>
        <20180925014150.GA6302@outlook.office365.com>
        <87zhw4rwiq.fsf@xmission.com>
        <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
        <87mus1ftb9.fsf@xmission.com>
        <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
        <877ej2xc23.fsf_-_@xmission.com>
        <alpine.DEB.2.21.1810012047520.32062@nanos.tec.linutronix.de>
        <CAK8P3a2zTqrCGURE3XVpn3_w6C4R5O+cq8TdtbyKCMGyRk9_jw@mail.gmail.com>
        <alpine.DEB.2.21.1810022205080.1435@nanos.tec.linutronix.de>
        <87in2jskew.fsf@xmission.com>
        <alpine.DEB.2.21.1810030711520.1435@nanos.tec.linutronix.de>
Date:   Wed, 03 Oct 2018 08:14:25 +0200
In-Reply-To: <alpine.DEB.2.21.1810030711520.1435@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Wed, 3 Oct 2018 07:25:35 +0200 (CEST)")
Message-ID: <87in2jo8u6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g7aQe-0005AX-LL;;;mid=<87in2jo8u6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18EXT0eot4PmYqwIsbJFcW/UPiz6Fuc6mk=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Setting monotonic time?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, 3 Oct 2018, Eric W. Biederman wrote:
>> Direct access to hardware/drivers and not through an abstraction like
>> the vfs (an abstraction over block devices) can legitimately be handled
>> by hotplug events.  I unplug one keyboard I plug in another.
>> 
>> I don't know if the input layer is more of a general abstraction
>> or more of a hardware device.  I have not dug into it but my guess
>> is abstraction from what I have heard.
>> 
>> The scary difficulty here is if after restart input is reporting times
>> in CLOCK_MONOTONIC and the applications in the namespace are talking
>> about times in CLOCK_MONOTONIC_SYNC.  Then there is an issue.  As even
>> with a fixed offset the times don't match up.
>> 
>> So a time namespace absolutely needs to do is figure out how to deal
>> with all of the kernel interfaces reporting times and figure out how to
>> report them in the current time namespace.
>
> So you want to talk to Arnd who is leading the y2038 effort. He knowns how
> many and which interfaces are involved aside of the obvious core timer
> ones. It's quite an amount and the problem is that you really need to do
> that at the interface level, because many of those time stamps are taken in
> contexts which are completely oblivious of name spaces. Ditto for timeouts
> and similar things which are handed in through these interfaces.

Yep.  That sounds right.

Eric
