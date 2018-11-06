Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A20C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CB520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CB520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbeKGAyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:54:07 -0500
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:26399 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbeKGAyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:54:06 -0500
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA6FQ49I057756;
        Tue, 6 Nov 2018 17:26:06 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-c8-5be1b28b8872
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 98.49.03682.B82B1EB5; Tue,  6 Nov 2018 17:26:03 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA6FQ1r4031576;
        Tue, 6 Nov 2018 17:26:01 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 06 Nov 2018 17:26:01 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Damien.LeMoal@wdc.com,
        alankao@andestech.com, zong@andestech.com, anup@brainfault.org,
        palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Organization: FORTH
In-Reply-To: <20181106141331.GA28458@e107155-lin>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
Message-ID: <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXSHc2orNuz6WG0wd0ci21LVrNatHx4x2qx
        aMV3FovW9m9MFvOPnGO1OD1hEZPF5V1z2Cy2fW5hs1h6/SKTRfO7c+wWmycsYLVo3XuE3WL5
        qR0sFps3TWW2eL6yl82B32PP6VnMHmvmrWH0mPr7DIvHw02XmDw2r9Dy2LSqk83j3blz7B6b
        l9R7XGq+zu7xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujI2L4gqey1b8OanVwPhKvIuRk0NC
        wETiy6l2NhBbSOAIo8S2C9pdjFxA9kFGidkX+5ghikwlZu/tZASxeQUEJU7OfMICYjMLWEhM
        vbKfEcKWl2jeOhusnkVAVeLO1SZ2EJtNQFNi/qWDYPUiAuoSS85uYQRZwCzQyyyxd9NNsCJh
        AT2Jpg03WUFsfgFhiU93L4LZnAKGEk82z2eEuGgpo0TnqudADgfQFS4Sj7dxQBynIvHh9wOw
        OaICyhIvTkxnncAoNAvJrbOQ3DoLya0LGJlXMQoklhnrZSYX66XlF5Vk6KUXbWIEx+Nc3x2M
        5xbYH2IU4GBU4uHlKHgQLcSaWFZcmXuIUYKDWUmE9/Tqh9FCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeQ+/CA8SEkhPLEnNTk0tSC2CyTJxcEo1MLq2OM4pfsvSeuDDBdbOSt+ZDG/krfNOrz9S
        ptm7OX1W6adbi5J4xD/Ucp19WdY4t+yf/87Ad5OX6HhLRMzInfF0EUuikpwDi4ipSPAD7jAD
        RZaTd1iOv4yWOF/1bvKDB+s33tX+5WP5N/VZe5lx3Nvd/NtOfr7wcW3gwY0yN8UFH620zT53
        dqUSS3FGoqEWc1FxIgBlESQSwwIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2018-11-06 16:13, Sudeep Holla έγραψε:
> On Fri, Nov 02, 2018 at 08:58:39PM +0200, Nick Kossifidis wrote:
>> Hello All,
>> 
>> Στις 2018-11-02 01:04, Atish Patra έγραψε:
>> > This patch series adds the cpu topology for RISC-V. It contains
>> > both the DT binding and actual source code. It has been tested on
>> > QEMU & Unleashed board.
>> >
>> > The idea is based on cpu-map in ARM with changes related to how
>> > we define SMT systems. The reason for adopting a similar approach
>> > to ARM as I feel it provides a very clear way of defining the
>> > topology compared to parsing cache nodes to figure out which cpus
>> > share the same package or core.  I am open to any other idea to
>> > implement cpu-topology as well.
>> >
>> 
>> I was also about to start a discussion about CPU topology on RISC-V
>> after the last swtools group meeting. The goal is to provide the
>> scheduler with hints on how to distribute tasks more efficiently
>> between harts, by populating the scheduling domain topology levels
>> (https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
>> What we want to do is define cpu groups and assign them to
>> scheduling domains with the appropriate SD_ flags
>> (https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).
>> 
> 
> OK are we defining a CPU topology binding for Linux scheduler ?
> NACK for all the approaches that assumes any knowledge of OS scheduler.
> 

Is there any standard regarding CPU topology on the device tree spec ? 
As far as
I know there is none. We are talking about a Linux-specific Device Tree 
binding
so I don't see why defining a binding for the Linux scheduler is out of 
scope.
Do you have cpu-map on other OSes as well ?

>> So the cores that belong to a scheduling domain may share:
>> CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
>> Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
>> Power domain (SD_SHARE_POWERDOMAIN)
>> 
> 
> Too Linux kernel/scheduler specific to be part of $subject
> 

All lists on the cc list are Linux specific, again I don't see your 
point here
are we talking about defining a standard CPU topology scheme for the 
device tree
spec or a Linux-specific CPU topology binding such as cpu-map ?

Even on this case your point is not valid, the information of two harts 
sharing
a common power domain or having the same or not capacity/max frequency 
(or maybe
capabilities/extensions in the future), is not Linux specific. I just 
used the
Linux specific macros used by the Linux scheduler to point out the code 
path.
Even on other OSes we still need a way to include this information on 
the CPU
topology, and currently cpu-map doesn't. Also the Linux implementation 
of cpu-map
ignores multiple levels of shared resources, we only get one level for 
SMT and
one level for MC last time I checked.

>> In this context I believe using words like "core", "package",
>> "socket" etc can be misleading. For example the sample topology you
>> use on the documentation says that there are 4 cores that are part
>> of a package, however "package" has a different meaning to the
>> scheduler. Also we don't say anything in case they share a power
>> domain or if they have the same capacity or not. This mapping deals
>> only with cache hierarchy or other shared resources.
>> 
> 
> {Un,}fortunately those are terms used by hardware people.
> 

And they are wrong, how the harts are physically packed doesn't imply 
their
actual topology. In general the "translation" is not always straight 
forward,
there are assumptions in place. We could use "cluster" of harts or 
"group" of
harts instead, they are more abstract.

Regards,
Nick

