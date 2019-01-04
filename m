Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A027C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F821871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuc8PutC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfADAYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:24:13 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40748 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfADAYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:24:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so29162320oie.7;
        Thu, 03 Jan 2019 16:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBH/k1gV88UNXJ8tAR3xJ8HD/3YGqjMZpG93TUnJ2YM=;
        b=Vuc8PutCyKkggR0oUnVlppEVOqmTkwFuTKm9CErzS/n7YgSQ6neFz8cFhuGtfs1RnZ
         PM2ESPn2u5mFoRppWzGDDpP10sFAcI/0vrMF1OAzrVgxaERPHiYk4s6ZgJJMpl85Z/yk
         D2avyHVW4wSCBn6bS+5dsSHHgXlGWT6qPcr3qmE1QmoZYGxk6g0rY0EbqK1SgUGeMCGw
         V7xjchQjQ9ailMGJqDDW8r0zRlraR/s/cyb+BHwSkStqrKQ6kiondV3xYltDQwzHA0u0
         MLKjp59cdDgam9m1/Mk247tzUh1ziHDq0ej8CPWLjZORSjj1IY0zioklL8e5QkDjYJTe
         RBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBH/k1gV88UNXJ8tAR3xJ8HD/3YGqjMZpG93TUnJ2YM=;
        b=aHH5zAd5lKXetv7sK8osQC5RdOvIlYsVdomFW/6HMFpT3AlAs0xbNvDpbHSK310H0e
         Ojl9APE5uGyzfKAAPakiUrF+azFz7TFytVnOiRTsBA+HxlVoMbVF7fUEM+gLDSe/qeTZ
         5GgXKoa8vB25FrpFMorgw53ENDn11VYam6tHxc4qtDS57k0N2aUhr2Idsd0y7baQNsHu
         zB6KXOPjP66xmSAK+4pwjLf2H0Znq8hfgI6PcrxqgrqNgw1C9LyTGs6picN3UCF2ZEVr
         kPPX+miz5Gfue0vfoeqWE8Z6HVQseZCXrMSdX4B8B15fS6EVFkO9juTM9RgGJeNQ7wDV
         MdMA==
X-Gm-Message-State: AA+aEWYYOwVn1Okdh4vBBcIeoGAwjfLkQ9ez5+3OjG90ClXqdMUG0gNz
        cfSPkShJHNPQfgx79qkLwYQXF59vIUDeuSfKSKyG
X-Google-Smtp-Source: AFSGD/XjaIVcJGEIAtGdwOLCpktWbf35Gy4Z97eTNIT4aYE1HSQdKyck7euGs1UoqHzAMDhX1U5Kx7NaPF52ZTTixiA=
X-Received: by 2002:aca:5d57:: with SMTP id r84mr34436637oib.243.1546561451903;
 Thu, 03 Jan 2019 16:24:11 -0800 (PST)
MIME-Version: 1.0
References: <1546525491-5724-1-git-send-email-junchangwang@gmail.com> <20190103170405.GF4170@linux.ibm.com>
In-Reply-To: <20190103170405.GF4170@linux.ibm.com>
From:   Junchang Wang <junchangwang@gmail.com>
Date:   Fri, 4 Jan 2019 08:24:00 +0800
Message-ID: <CABoNC821utTm8gU3AjQDC-W-b3tizNG+Q5XWDwgxN3meFgaaeQ@mail.gmail.com>
Subject: Re: [PATCH] RCU/torture.txt: remove section MODULE PARAMETERS
To:     Paul McKenney <paulmck@linux.ibm.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 1:03 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Thu, Jan 03, 2019 at 10:24:51PM +0800, Junchang Wang wrote:
> > The supported module parameters are detailed in both RCU/torture.txt and
> > admin-guide/kernel-parameters.txt, and the latter is actively maintained.
> > So this patch removes section MODULE PARAMETERS in torture.txt and
> > adds a reference to the information in kernel-parameters.txt.
> >
> > Signed-off-by: Junchang Wang <junchangwang@gmail.com>
>
> Queued and pushed, thank you!
>
> I made some small updates, first capitalizing the word following the
> colon (":") in the subject line and second adding a search string
> for Documentation/admin-guide/kernel-parameters.txt.  Please see below
> and please let me know if I messed anything up.
>

Hi Paul,

Your updated version is definitely much better. Thanks a lot for
helping review the patch.


--Junchang

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 150c2476dd32126505dc26f644fa8eb643630d9c
> Author: Junchang Wang <junchangwang@gmail.com>
> Date:   Thu Jan 3 22:24:51 2019 +0800
>
>     RCU/torture.txt: Remove section MODULE PARAMETERS
>
>     The supported module parameters are detailed in both RCU/torture.txt and
>     admin-guide/kernel-parameters.txt, and the latter is actively maintained.
>     So this patch removes section MODULE PARAMETERS in torture.txt and
>     adds a reference to the information in kernel-parameters.txt.
>
>     Signed-off-by: Junchang Wang <junchangwang@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>     [ paulmck: Add search string. ]
>
> diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
> index 55918b54808b..a41a0384d20c 100644
> --- a/Documentation/RCU/torture.txt
> +++ b/Documentation/RCU/torture.txt
> @@ -10,173 +10,8 @@ status messages via printk(), which can be examined via the dmesg
>  command (perhaps grepping for "torture").  The test is started
>  when the module is loaded, and stops when the module is unloaded.
>
> -
> -MODULE PARAMETERS
> -
> -This module has the following parameters:
> -
> -fqs_duration   Duration (in microseconds) of artificially induced bursts
> -               of force_quiescent_state() invocations.  In RCU
> -               implementations having force_quiescent_state(), these
> -               bursts help force races between forcing a given grace
> -               period and that grace period ending on its own.
> -
> -fqs_holdoff    Holdoff time (in microseconds) between consecutive calls
> -               to force_quiescent_state() within a burst.
> -
> -fqs_stutter    Wait time (in seconds) between consecutive bursts
> -               of calls to force_quiescent_state().
> -
> -gp_normal      Make the fake writers use normal synchronous grace-period
> -               primitives.
> -
> -gp_exp         Make the fake writers use expedited synchronous grace-period
> -               primitives.  If both gp_normal and gp_exp are set, or
> -               if neither gp_normal nor gp_exp are set, then randomly
> -               choose the primitive so that about 50% are normal and
> -               50% expedited.  By default, neither are set, which
> -               gives best overall test coverage.
> -
> -irqreader      Says to invoke RCU readers from irq level.  This is currently
> -               done via timers.  Defaults to "1" for variants of RCU that
> -               permit this.  (Or, more accurately, variants of RCU that do
> -               -not- permit this know to ignore this variable.)
> -
> -n_barrier_cbs  If this is nonzero, RCU barrier testing will be conducted,
> -               in which case n_barrier_cbs specifies the number of
> -               RCU callbacks (and corresponding kthreads) to use for
> -               this testing.  The value cannot be negative.  If you
> -               specify this to be non-zero when torture_type indicates a
> -               synchronous RCU implementation (one for which a member of
> -               the synchronize_rcu() rather than the call_rcu() family is
> -               used -- see the documentation for torture_type below), an
> -               error will be reported and no testing will be carried out.
> -
> -nfakewriters   This is the number of RCU fake writer threads to run.  Fake
> -               writer threads repeatedly use the synchronous "wait for
> -               current readers" function of the interface selected by
> -               torture_type, with a delay between calls to allow for various
> -               different numbers of writers running in parallel.
> -               nfakewriters defaults to 4, which provides enough parallelism
> -               to trigger special cases caused by multiple writers, such as
> -               the synchronize_srcu() early return optimization.
> -
> -nreaders       This is the number of RCU reading threads supported.
> -               The default is twice the number of CPUs.  Why twice?
> -               To properly exercise RCU implementations with preemptible
> -               read-side critical sections.
> -
> -onoff_interval
> -               The number of seconds between each attempt to execute a
> -               randomly selected CPU-hotplug operation.  Defaults to
> -               zero, which disables CPU hotplugging.  In HOTPLUG_CPU=n
> -               kernels, rcutorture will silently refuse to do any
> -               CPU-hotplug operations regardless of what value is
> -               specified for onoff_interval.
> -
> -onoff_holdoff  The number of seconds to wait until starting CPU-hotplug
> -               operations.  This would normally only be used when
> -               rcutorture was built into the kernel and started
> -               automatically at boot time, in which case it is useful
> -               in order to avoid confusing boot-time code with CPUs
> -               coming and going.
> -
> -shuffle_interval
> -               The number of seconds to keep the test threads affinitied
> -               to a particular subset of the CPUs, defaults to 3 seconds.
> -               Used in conjunction with test_no_idle_hz.
> -
> -shutdown_secs  The number of seconds to run the test before terminating
> -               the test and powering off the system.  The default is
> -               zero, which disables test termination and system shutdown.
> -               This capability is useful for automated testing.
> -
> -stall_cpu      The number of seconds that a CPU should be stalled while
> -               within both an rcu_read_lock() and a preempt_disable().
> -               This stall happens only once per rcutorture run.
> -               If you need multiple stalls, use modprobe and rmmod to
> -               repeatedly run rcutorture.  The default for stall_cpu
> -               is zero, which prevents rcutorture from stalling a CPU.
> -
> -               Note that attempts to rmmod rcutorture while the stall
> -               is ongoing will hang, so be careful what value you
> -               choose for this module parameter!  In addition, too-large
> -               values for stall_cpu might well induce failures and
> -               warnings in other parts of the kernel.  You have been
> -               warned!
> -
> -stall_cpu_holdoff
> -               The number of seconds to wait after rcutorture starts
> -               before stalling a CPU.  Defaults to 10 seconds.
> -
> -stat_interval  The number of seconds between output of torture
> -               statistics (via printk()).  Regardless of the interval,
> -               statistics are printed when the module is unloaded.
> -               Setting the interval to zero causes the statistics to
> -               be printed -only- when the module is unloaded, and this
> -               is the default.
> -
> -stutter                The length of time to run the test before pausing for this
> -               same period of time.  Defaults to "stutter=5", so as
> -               to run and pause for (roughly) five-second intervals.
> -               Specifying "stutter=0" causes the test to run continuously
> -               without pausing, which is the old default behavior.
> -
> -test_boost     Whether or not to test the ability of RCU to do priority
> -               boosting.  Defaults to "test_boost=1", which performs
> -               RCU priority-inversion testing only if the selected
> -               RCU implementation supports priority boosting.  Specifying
> -               "test_boost=0" never performs RCU priority-inversion
> -               testing.  Specifying "test_boost=2" performs RCU
> -               priority-inversion testing even if the selected RCU
> -               implementation does not support RCU priority boosting,
> -               which can be used to test rcutorture's ability to
> -               carry out RCU priority-inversion testing.
> -
> -test_boost_interval
> -               The number of seconds in an RCU priority-inversion test
> -               cycle.  Defaults to "test_boost_interval=7".  It is
> -               usually wise for this value to be relatively prime to
> -               the value selected for "stutter".
> -
> -test_boost_duration
> -               The number of seconds to do RCU priority-inversion testing
> -               within any given "test_boost_interval".  Defaults to
> -               "test_boost_duration=4".
> -
> -test_no_idle_hz        Whether or not to test the ability of RCU to operate in
> -               a kernel that disables the scheduling-clock interrupt to
> -               idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
> -               Defaults to omitting this test.
> -
> -torture_type   The type of RCU to test, with string values as follows:
> -
> -               "rcu":  rcu_read_lock(), rcu_read_unlock() and call_rcu(),
> -                       along with expedited, synchronous, and polling
> -                       variants.
> -
> -               "rcu_bh": rcu_read_lock_bh(), rcu_read_unlock_bh(), and
> -                       call_rcu_bh(), along with expedited and synchronous
> -                       variants.
> -
> -               "rcu_busted": This tests an intentionally incorrect version
> -                       of RCU in order to help test rcutorture itself.
> -
> -               "srcu": srcu_read_lock(), srcu_read_unlock() and
> -                       call_srcu(), along with expedited and
> -                       synchronous variants.
> -
> -               "sched": preempt_disable(), preempt_enable(), and
> -                       call_rcu_sched(), along with expedited,
> -                       synchronous, and polling variants.
> -
> -               "tasks": voluntary context switch and call_rcu_tasks(),
> -                       along with expedited and synchronous variants.
> -
> -               Defaults to "rcu".
> -
> -verbose                Enable debug printk()s.  Default is disabled.
> -
> +Module parameters are prefixed by "rcutorture." in
> +Documentation/admin-guide/kernel-parameters.txt.
>
>  OUTPUT
>
>
