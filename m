Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6163C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D542084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D542084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJZSDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:03:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61560 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeJZSDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:03:18 -0400
Received: from 79.184.255.63.ipv4.supernova.orange.pl (79.184.255.63) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 99ef6b1410ac41fe; Fri, 26 Oct 2018 11:26:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4] kernel/hung_task.c: disable on suspend
Date:   Fri, 26 Oct 2018 11:23:34 +0200
Message-ID: <1827523.RqSiaKuRRv@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0iJmn4x+zqNhQ4zfYCucnZhYb2hK3o096xPX6Ju2zV2oQ@mail.gmail.com>
References: <20181017112355.12763-1-vkuznets@redhat.com> <CAJZ5v0iJmn4x+zqNhQ4zfYCucnZhYb2hK3o096xPX6Ju2zV2oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 18, 2018 9:32:42 AM CEST Rafael J. Wysocki wrote:
> On Wed, Oct 17, 2018 at 1:24 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > It is possible to observe hung_task complaints when system goes to
> > suspend-to-idle state:
> >
> >  # echo freeze > /sys/power/state
> >
> >  PM: Syncing filesystems ... done.
> >  Freezing user space processes ... (elapsed 0.001 seconds) done.
> >  OOM killer disabled.
> >  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> >  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >  INFO: task bash:1569 blocked for more than 120 seconds.
> >        Not tainted 4.19.0-rc3_+ #687
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >  bash            D    0  1569    604 0x00000000
> >  Call Trace:
> >   ? __schedule+0x1fe/0x7e0
> >   schedule+0x28/0x80
> >   suspend_devices_and_enter+0x4ac/0x750
> >   pm_suspend+0x2c0/0x310
> >
> > Register a PM notifier to disable the detector on suspend and re-enable
> > back on wakeup.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Thanks for your patience with this!
> 
> Are there any objections or concerns regarding this patch?

Seeing none, so applied.

Thanks,
Rafael

