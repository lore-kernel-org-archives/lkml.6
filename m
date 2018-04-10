Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDJRaG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:30:06 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:37753 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbeDJRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:30:05 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime and could not connect to lvmetad at some boot attempts
Date: Tue, 10 Apr 2018 19:30:03 +0200
Message-ID: <3388323.DMBn0mQjXY@merkaba>
In-Reply-To: <f6f20cd6-0d52-4501-f8ea-c4da9ec128cf@redhat.com>
References: <27165802.vQ9JbjrmvU@merkaba> <a3af4fed-a728-5be2-2224-6a0573406c5b@leemhuis.info> <f6f20cd6-0d52-4501-f8ea-c4da9ec128cf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans de Goede - 19.03.18, 10:50:
> > Martin (or someone else): Could you gibe a status update? I have this
> > issue on my list or regressions, but it's hard to follow as two
> > different issues seem to be discussed. Or is it just one issue? Did the
> > patch/discussion that Bart pointed to help? Is the issue still showing
> > up in rc6?
> 
> Your right there are 2 issues here:
[…]
> 2) There seem to be some latency issues in the MU03 version of the
> firmware, triggered by polling SMART data, which causes lvmetad to
> timeout in some cases. Note I'm not involved in that part of this
> thread, but I believe that issue is currently unresolved.

The second issue consists of what Hans described + an occassional hang on boot 
for resume from hibernation to disk.

The second issue is still unfixed as of 4.16 + [PATCH v2] block: Change a 
rcu_read_{lock,unlock}_sched() pair into rcu_read_{lock,unlock}() vom Bart Van 
Asche, which Jens Axboe accepted¹.

[1] https://patchwork.kernel.org/patch/10294287/

Currently compiling 4.16.1, but I do not expect a change, as there is nothing 
about blk-mq subsystem in the changelog as far as I saw.

Will update

[Bug 199077] [Possible REGRESSION, 4.16-rc4] Error updating SMART data during 
runtime and boot failures with blk_mq_terminate_expired in backtrace
https://bugzilla.kernel.org/show_bug.cgi?id=199077

as well about the current state. The bug report contains a screenshot of one 
of the boot hangs. I had two more on Monday, but did not take the chance to 
make another photo. I will do so next time in case its convenient enough and 
compare whether it reveals anything more than my first photo.

Thanks,
-- 
Martin
