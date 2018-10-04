Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30176C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0115C206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0115C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJDXSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:18:31 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:18:30 -0400
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1M3DeV-1g9SvX1hgz-003gkw; Thu, 04 Oct 2018 18:23:54 +0200
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1M3DeV-1g9SvX1hgz-003gkw; Thu, 04 Oct 2018 18:23:54 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Reboot using an i2c power-system-controller ?
Date:   Thu,  4 Oct 2018 18:23:37 +0200
Message-Id: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MzYMGwwuLO+p2I7a6F6PzvAV4pJl+SM8l3Ci6m6Cg6QCi9NQy7/
 sbfLUFpo/Y2aSx8DMcB7AWoKfZT3eVBgf5jclcvLxvydkfI1wE3vcyNdUzmmIO/G2os2kEu
 1jR/7RH3I0m9Pq1krBCTQ6QMeY7bzqhB1H+OLIq86ozL245oplI31Yfv5qYU50jyztBFmUL
 dSU/vIgC9A9q3MKWrgCeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:75rjvQXd2wM=:U1kuO1wdRmCE8lc05Oxtxy
 sMTwtOskhsmb0mXsdQXguH1Bw5fijcHAKQEw/pvxQ/d+bcGn4lQ1qJ+G0WQEyZv2CudgFiv/k
 jYzqCOl7510DJNKeOGKlOV58maQ6cXXS0FqLEket33o3hE0Axy3hLzhRbBBjBGG5ue009y/me
 jY0UdzkxBBjUXrUj6EYNQOUKeGthg0Yg/tKPO5W6KRb88rIlFR2jCiveb+ZbemIVSUCyvb7XG
 uv/EYygzHh8dmti2YFAvjn59w4nUpp1gzRoVg6f4jiwQxh/QsWHWGLDScThFqVvAfTcIPo0w3
 yARBh1fSu+MCDBUSyYFP2wAWM/NBGbIqV/+AyBNi5EhiFjpvjYiYaAWMpbC8kNh6g2rgf70ad
 T6Zm7IAXTKms7hBOXCaxSnvhtpyQZssT8zg6FB14bsj8zTdmqfgCAt/gEck8DhrbpwxkqgdMk
 ivtppcPE1XNVZaL0bN6xs8HQFC7F9sLES2w/kYMOAFgpmhD/uY220X6sPheSBdvmOMWzpT1RX
 RBVd56bTjFcwO25KfS2vJ2UOHAHQS90bbx+6Z/+t8XAklJe16kH5qI36U/x0KyhWKLXQ+C8Xa
 IJcaFpiE/JNGLFBYic5UkhxC8o3aDMeaysVk5/Mo/47N90zGcoCufq1bsQOcIwC/aOMF6Ci/s
 PmsZThf0z+m/z6iJS8Kp3YZRfNciqrMdcOmSws1WAOhvkd+byl75B7Md355Fnea2EO747kte1
 4KF2B8MzMs9VRpIt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So i got this ARM board with a rtc controlled by i2c that can also cut
power.  I want to use it to reboot, because it will also cut power to
clumsy USB and MMC devices.
So the natural thing to do would be to just register a restart_handler
that will kindly do i2c (saw at least a driver doing it), or use
arm_pm_restart and be done with it.

Well that what I though.  Most of my naive attempts were met with
occasional failures and now my understanding is that I do not
understand why anything works in the first place.

So the first thing I saw while doing i2c in a restart_handler are
kernel splats about sleeping in a RCU critical section.
Since i2c is slow, most i2c controllers either sleep until the i2c
transfer is complete or they wait for an interrupt.  restart_handler
is an atomic notifier chain, so sleeping in there should be bad.

So I looked at drivers to see what they do and it seems many of them
sleep inside their restart_handler callbacks.  Some even have infinite
loops.  And there is the rn5t618 driver which does i2c (as well as a
small mdelay(1)), which is used in some meson8 boards, whose i2c
controller wait for completion of interrupts.  So I'm wondering why am I
the only one with these problems.

So i cobbled a patch that turns restart_handler into a notifier call
chain that can block.  It removes the splat, but reboot still
occasionally fails.

By the time we get to arm_pm_restart() or do_machine_restart(),
interrupts are disabled and only one processor is running.
The first thing i did was to enable interrupts on the remaining
processor, so that i2c could work, but it turns out my i2c controller
does not use interrupts, so that didn't change anything.  Still, i would
consider this to be desirable anyway.

The remaining problems turns out to be timers that never fires. sysrq Q
shows:

active timers:
 #0: <e5d80165> , hrtimer_wakeup , S:01
 # expires at 349641289373-349641389373 nsecs [in -1000130841786 to -1000130741786 nsecs]
 #1: <b06a222c> , tick_sched_timer , S:01
 # expires at 349650000000-349650000000 nsecs [in -1000122131159 to -1000122131159 nsecs]
 #2: sched_clock_timer , sched_clock_poll , S:01
 # expires at 715827882841-715827882841 nsecs [in -633944248318 to -633944248318 nsecs]

with no matching .next_timer in any clockevent device.

I think it is because when we call send_smp_stop(), we don't unregister the
twd clockevent of the affected CPU and we may still allocate timers on
it.

I noticed that the CPU hotplug code handles this fine, so my current
workaround is to enable CPU hotplug in the kernel and manually
deactivate CPUs in the init system before rebooting

So did I missing something ? What would be the correct to fix all this ?


