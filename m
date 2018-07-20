Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B881ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C074820673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C074820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeGTAxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:53:52 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:40957 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbeGTAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:53:51 -0400
Received: by mail-qt0-f170.google.com with SMTP id h4-v6so8858518qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3S3xdlsaXqGme8+9aaUUo0lEKC2IR7HpmNnxNRT3Js4=;
        b=Ec5a6l099ooDEoxz7PrzB502dkDuSFB+hOVezXrb3NuGNDTzj5PPqpfreeruzJgUUe
         CUBjPewiwt/LHe0lhbRJA0ItEWnLP8k1m+ss7aUna/XLAY0Ij6DXWdtK/vBIU2L8iM09
         Qqv0iAM8IeoKSX+N/8csT/d7BkN3Ap5ou7MzzyYEYIOf56l6ZY1jQ2l7WKQT0tdABTBC
         Xo0mg7Wy7xL2ghNTSijXDBKn72s3/vanhXveIzu1s94hFPNlSW5yrUX71MbBA3FKfUdd
         voemN//pZYqhAx28q45h6U+xdsGMqADcY69V1T45lf5w6/J+gAapSMTkLO2hhjFkI2Dt
         AerA==
X-Gm-Message-State: AOUpUlGgEbaGO7VMRvjKvn+2mjlfBRGrMZY2HKn56QoThh9fF/47my3m
        G7V6g9cWbcplgt0DISWgNq69KQ==
X-Google-Smtp-Source: AAOMgpcwvxfsXxPb7JOsxaJAtfIZCcMJrhXSKgL1PqZnBjEftFSBWvHMzII6TjrVH8wu0+kZpGLLBQ==
X-Received: by 2002:a0c:9e2a:: with SMTP id p42-v6mr12920426qve.54.1532045297752;
        Thu, 19 Jul 2018 17:08:17 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f184-v6sm339818qkc.23.2018.07.19.17.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 17:08:16 -0700 (PDT)
Message-ID: <be93e682cd5a583e9b4cb6c4fcd7a476d597bb6b.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/fb_helper: Add
 drm_fb_helper_output_poll_changed_with_rpm()
From:   Lyude Paul <lyude@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     nouveau@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Jul 2018 20:08:15 -0400
In-Reply-To: <20180719074926.GA14303@wunner.de>
References: <20180718205645.25924-1-lyude@redhat.com>
         <20180718205645.25924-2-lyude@redhat.com>
         <20180719074926.GA14303@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 09:49 +0200, Lukas Wunner wrote:
> On Wed, Jul 18, 2018 at 04:56:39PM -0400, Lyude Paul wrote:
> > When DP MST hubs get confused, they can occasionally stop responding for
> > a good bit of time up until the point where the DRM driver manages to
> > do the right DPCD accesses to get it to start responding again. In a
> > worst case scenario however, this process can take upwards of 10+
> > seconds.
> > 
> > Currently we use the default output_poll_changed handler
> > drm_fb_helper_output_poll_changed() to handle output polling, which
> > doesn't happen to grab any power references on the device when polling.
> > If we're unlucky enough to have a hub (such as Lenovo's infamous laptop
> > docks for the P5x/P7x series) that's easily startled and confused, this
> > can lead to a pretty nasty deadlock situation that looks like this:
> > 
> > - Hotplug event from hub happens, we enter
> >   drm_fb_helper_output_poll_changed() and start communicating with the
> >   hub
> > - While we're in drm_fb_helper_output_poll_changed() and attempting to
> >   communicate with the hub, we end up confusing it and cause it to stop
> >   responding for at least 10 seconds
> > - After 5 seconds of being in drm_fb_helper_output_poll_changed(), the
> >   pm core attempts to put the GPU into autosuspend, which ends up
> >   calling drm_kms_helper_poll_disable()
> > - While the runtime PM core is waiting in drm_kms_helper_poll_disable()
> >   for the output poll to finish, we end up finally detecting an MST
> >   display
> > - We notice the new display and tries to enable it, which triggers
> >   an atomic commit which triggers a call to pm_runtime_get_sync()
> > - the output poll thread deadlocks the pm core waiting for the pm core
> >   to finish the autosuspend request while the pm core waits for the
> >   output poll thread to finish
> 
> This will still deadlock if ->runtime_suspend commences before the
> hotplug event and the hotplug event occurs before polling has been
> disabled by ->runtime_suspend.
> 
> The correct fix is to call pm_runtime_get_sync() *conditionally* in
> the atomic commit which enables the display, using the same conditional
> as d61a5c106351, i.e. if (!drm_kms_helper_is_poll_worker()).
> 
> Now I realize I sent you down the wrong path when I suggested to
> introduce a DRM helper here.  My apologies, I didn't fully appreciate
> what is going awry here!
> 
> Anything that happens in nouveau's poll worker never needs to acquire
> a runtime PM ref because polling is only enabled while runtime active,
> and ->runtime_suspend waits for an ongoing poll to finish.

Hopefully I'm not missing anything here, but this doesn't really make any
sense. I'm not sure I explained myself as well as I thought I did. To be
honest, I had to double check this about literally 20 times to make sure I was
actually understanding this issue correctly. Turns out I was missing a couple
of parts, so I'm going to try again at explaining this using a diagram that
shows the various threads running concurrently

START: Driver load
       |
       |
       |           Thread 1
        ----- output_poll_execute()
                       |
           drm_helper_hpd_irq_event()
                       |
                       |  Schedules →            Thread 2
                       ----------------- nouveau_display_hpd_work()
                    Finish                          |
                                           pm_runtime_get_sync() <--- keeps GPU alive
                                                    |
                                                   ...
                                                    |
                       ------------------------------
                <still Thread 2>
             drm_helper_hpd_irq_event()
                       |
                       |         Schedules →
                       ------------------------------
                       |                         Thread 3
Drop last RPM ref -v   |                   output_poll_execute()
             pm_runtime_put_sync()                  |
                       |             drm_dp_mst_topology_mgr_set_mst()
                    Finish                          |
                                                    |
                               ← Schedules          |
                       -----------------------------|
                       |                            |
                    Thread 4                        |
                       |                            |
          drm_dp_mst_link_probe_work()  drm_dp_mst_wait_tx_reply() <-- these wait on eachother
                       |                            |                     this is normal
                       |    Sideband transactions   |
                       |    happen here, this is    |
                       |    where timeouts happen   |
                       |                            |
                       |      5 seconds later...    | autosuspend delay kicks in
                       |            ...             |                        |
                       |                            |                     Thread 5
                       |  Communication + timeouts  |                 pm_runtime_work
                       |  are still happening here  |                        |
                       |                            |           nouveau_pmops_runtime_suspend()
                       |                            |                        |
                       |  Success! We can enable    |                        |
                       |        displays now!       |            drm_kms_helper_poll_disable()
                       |                            |                        |
                       |                 *Atomic commit begins*              |
                       |                            |     <-------------     |
                       | More sideband transactions |       Waiting on       |
                       |          ......            |  output_poll_execute() |
                       |                            |     <-------------     |
                       |                  pm_runtime_get_sync()              |
                       |                            |                        |
                       |   -------------------->    |     ------------->     |
                       |        Waiting on          |       Waiting on       |
                       |     output_poll_exec()     |    suspend requests    |
                       |   -------------------->    |     ------------->     |
                       |                            |                        |
                       ----------------------------------------------------->|
                                                                         DEADLOCK

phew. that took a LONG time to come up with.

Anyway-that's why your explanation doesn't make sense: the deadlock is
happening because we're calling pm_runtime_get_sync(). If we were to make that
call conditional (e.g. drm_kms_helper_is_poll_worker()), all that would mean
is that we wouldn't grab any runtime power reference and the GPU would
immediately suspend once the atomic commit finished, as the suspend request in
Thread 5 would finally get unblocked and thus----suspend.

Hopefully I explained that better this time, I'll definitely make sure to
actually include that diagram in the patch. As for whether or not this patch
is even the right solution, I will need to confirm that tommorrow (if you
don't think it is still, please feel free to say so!) because it's getting
late here.

Cheers!
	Lyude

> 
> Thinking a bit more about this, our mistake is to acquire runtime PM
> refs too far down in the call stack.  As a fix that can be backported
> to stable, adding if (!drm_kms_helper_is_poll_worker()) conditionals
> seems fine to me, but the long term fix is to push acquisition of refs
> further up in the call stack.
> 
> E.g., if the user forces connector probing via sysfs, a runtime PM ref
> should be acquired in status_store() in drm_sysfs.c before invoking
> connector->funcs->fill_modes().  That way, if the user forces connector
> probing while the GPU is powering down, rpm_resume() will correctly wait
> for rpm_suspend() to finish before resuming the card.  So if we architect
> it like this, we're actually using the functionality provided by the
> PM core in the way that it's supposed to be used.
> 
> The problem is that adding pm_runtime_get_sync() to status_store()
> conflicts with the desire to have a library of generic DRM functions:
> Some GPUs may be able to probe connectors without resuming to runtime
> active state, others don't use runtime PM at all.  One solution that
> comes to mind is a driver_features flag which tells the DRM core whether
> to acquire a runtime PM ref in various places.
> 
> In your original patches 4 and 5, what exactly was the call stack which
> led to i2c being accessed while runtime suspended?  Was it sysfs access
> via /sys/class/i2c-adapter/* ?  If so, acquisition of the runtime PM ref
> needs to likewise happen in that sysfs entry point, rather than deep down
> in the call stack upon accessing the i2c bus.
> 
> Thanks,
> 
> Lukas
> 
> > 
> > Sample:
> > [  246.669625] INFO: task kworker/4:0:37 blocked for more than 120
> > seconds.
> > [  246.673398]       Not tainted 4.18.0-rc5Lyude-Test+ #2
> > [  246.675271] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  246.676527] kworker/4:0     D    0    37      2 0x80000000
> > [  246.677580] Workqueue: events output_poll_execute [drm_kms_helper]
> > [  246.678704] Call Trace:
> > [  246.679753]  __schedule+0x322/0xaf0
> > [  246.680916]  schedule+0x33/0x90
> > [  246.681924]  schedule_preempt_disabled+0x15/0x20
> > [  246.683023]  __mutex_lock+0x569/0x9a0
> > [  246.684035]  ? kobject_uevent_env+0x117/0x7b0
> > [  246.685132]  ? drm_fb_helper_hotplug_event.part.28+0x20/0xb0
> > [drm_kms_helper]
> > [  246.686179]  mutex_lock_nested+0x1b/0x20
> > [  246.687278]  ? mutex_lock_nested+0x1b/0x20
> > [  246.688307]  drm_fb_helper_hotplug_event.part.28+0x20/0xb0
> > [drm_kms_helper]
> > [  246.689420]  drm_fb_helper_output_poll_changed+0x23/0x30
> > [drm_kms_helper]
> > [  246.690462]  drm_kms_helper_hotplug_event+0x2a/0x30 [drm_kms_helper]
> > [  246.691570]  output_poll_execute+0x198/0x1c0 [drm_kms_helper]
> > [  246.692611]  process_one_work+0x231/0x620
> > [  246.693725]  worker_thread+0x214/0x3a0
> > [  246.694756]  kthread+0x12b/0x150
> > [  246.695856]  ? wq_pool_ids_show+0x140/0x140
> > [  246.696888]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [  246.697998]  ret_from_fork+0x3a/0x50
> > [  246.699034] INFO: task kworker/0:1:60 blocked for more than 120
> > seconds.
> > [  246.700153]       Not tainted 4.18.0-rc5Lyude-Test+ #2
> > [  246.701182] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  246.702278] kworker/0:1     D    0    60      2 0x80000000
> > [  246.703293] Workqueue: pm pm_runtime_work
> > [  246.704393] Call Trace:
> > [  246.705403]  __schedule+0x322/0xaf0
> > [  246.706439]  ? wait_for_completion+0x104/0x190
> > [  246.707393]  schedule+0x33/0x90
> > [  246.708375]  schedule_timeout+0x3a5/0x590
> > [  246.709289]  ? mark_held_locks+0x58/0x80
> > [  246.710208]  ? _raw_spin_unlock_irq+0x2c/0x40
> > [  246.711222]  ? wait_for_completion+0x104/0x190
> > [  246.712134]  ? trace_hardirqs_on_caller+0xf4/0x190
> > [  246.713094]  ? wait_for_completion+0x104/0x190
> > [  246.713964]  wait_for_completion+0x12c/0x190
> > [  246.714895]  ? wake_up_q+0x80/0x80
> > [  246.715727]  ? get_work_pool+0x90/0x90
> > [  246.716649]  flush_work+0x1c9/0x280
> > [  246.717483]  ? flush_workqueue_prep_pwqs+0x1b0/0x1b0
> > [  246.718442]  __cancel_work_timer+0x146/0x1d0
> > [  246.719247]  cancel_delayed_work_sync+0x13/0x20
> > [  246.720043]  drm_kms_helper_poll_disable+0x1f/0x30 [drm_kms_helper]
> > [  246.721123]  nouveau_pmops_runtime_suspend+0x3d/0xb0 [nouveau]
> > [  246.721897]  pci_pm_runtime_suspend+0x6b/0x190
> > [  246.722825]  ? pci_has_legacy_pm_support+0x70/0x70
> > [  246.723737]  __rpm_callback+0x7a/0x1d0
> > [  246.724721]  ? pci_has_legacy_pm_support+0x70/0x70
> > [  246.725607]  rpm_callback+0x24/0x80
> > [  246.726553]  ? pci_has_legacy_pm_support+0x70/0x70
> > [  246.727376]  rpm_suspend+0x142/0x6b0
> > [  246.728185]  pm_runtime_work+0x97/0xc0
> > [  246.728938]  process_one_work+0x231/0x620
> > [  246.729796]  worker_thread+0x44/0x3a0
> > [  246.730614]  kthread+0x12b/0x150
> > [  246.731395]  ? wq_pool_ids_show+0x140/0x140
> > [  246.732202]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [  246.732878]  ret_from_fork+0x3a/0x50
> > [  246.733768] INFO: task kworker/4:2:422 blocked for more than 120
> > seconds.
> > [  246.734587]       Not tainted 4.18.0-rc5Lyude-Test+ #2
> > [  246.735393] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  246.736113] kworker/4:2     D    0   422      2 0x80000080
> > [  246.736789] Workqueue: events_long drm_dp_mst_link_probe_work
> > [drm_kms_helper]
> > [  246.737665] Call Trace:
> > [  246.738490]  __schedule+0x322/0xaf0
> > [  246.739250]  schedule+0x33/0x90
> > [  246.739908]  rpm_resume+0x19c/0x850
> > [  246.740750]  ? finish_wait+0x90/0x90
> > [  246.741541]  __pm_runtime_resume+0x4e/0x90
> > [  246.742370]  nv50_disp_atomic_commit+0x31/0x210 [nouveau]
> > [  246.743124]  drm_atomic_commit+0x4a/0x50 [drm]
> > [  246.743775]  restore_fbdev_mode_atomic+0x1c8/0x240 [drm_kms_helper]
> > [  246.744603]  restore_fbdev_mode+0x31/0x140 [drm_kms_helper]
> > [  246.745373]  drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xb0
> > [drm_kms_helper]
> > [  246.746220]  drm_fb_helper_set_par+0x2d/0x50 [drm_kms_helper]
> > [  246.746884]  drm_fb_helper_hotplug_event.part.28+0x96/0xb0
> > [drm_kms_helper]
> > [  246.747675]  drm_fb_helper_output_poll_changed+0x23/0x30
> > [drm_kms_helper]
> > [  246.748544]  drm_kms_helper_hotplug_event+0x2a/0x30 [drm_kms_helper]
> > [  246.749439]  nv50_mstm_hotplug+0x15/0x20 [nouveau]
> > [  246.750111]  drm_dp_send_link_address+0x177/0x1c0 [drm_kms_helper]
> > [  246.750764]  drm_dp_check_and_send_link_address+0xa8/0xd0
> > [drm_kms_helper]
> > [  246.751602]  drm_dp_mst_link_probe_work+0x51/0x90 [drm_kms_helper]
> > [  246.752314]  process_one_work+0x231/0x620
> > [  246.752979]  worker_thread+0x44/0x3a0
> > [  246.753838]  kthread+0x12b/0x150
> > [  246.754619]  ? wq_pool_ids_show+0x140/0x140
> > [  246.755386]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [  246.756162]  ret_from_fork+0x3a/0x50
> > [  246.756847]
> >                Showing all locks held in the system:
> > [  246.758261] 3 locks held by kworker/4:0/37:
> > [  246.759016]  #0: 00000000f8df4d2d ((wq_completion)"events"){+.+.}, at:
> > process_one_work+0x1b3/0x620
> > [  246.759856]  #1: 00000000e6065461 ((work_completion)(&(&dev-
> > >mode_config.output_poll_work)->work)){+.+.}, at:
> > process_one_work+0x1b3/0x620
> > [  246.760670]  #2: 00000000cb66735f (&helper->lock){+.+.}, at:
> > drm_fb_helper_hotplug_event.part.28+0x20/0xb0 [drm_kms_helper]
> > [  246.761516] 2 locks held by kworker/0:1/60:
> > [  246.762274]  #0: 00000000fff6be0f ((wq_completion)"pm"){+.+.}, at:
> > process_one_work+0x1b3/0x620
> > [  246.762982]  #1: 000000005ab44fb4 ((work_completion)(&dev-
> > >power.work)){+.+.}, at: process_one_work+0x1b3/0x620
> > [  246.763890] 1 lock held by khungtaskd/64:
> > [  246.764664]  #0: 000000008cb8b5c3 (rcu_read_lock){....}, at:
> > debug_show_all_locks+0x23/0x185
> > [  246.765588] 5 locks held by kworker/4:2/422:
> > [  246.766440]  #0: 00000000232f0959 ((wq_completion)"events_long"){+.+.},
> > at: process_one_work+0x1b3/0x620
> > [  246.767390]  #1: 00000000bb59b134 ((work_completion)(&mgr-
> > >work)){+.+.}, at: process_one_work+0x1b3/0x620
> > [  246.768154]  #2: 00000000cb66735f (&helper->lock){+.+.}, at:
> > drm_fb_helper_restore_fbdev_mode_unlocked+0x4c/0xb0 [drm_kms_helper]
> > [  246.768966]  #3: 000000004c8f0b6b (crtc_ww_class_acquire){+.+.}, at:
> > restore_fbdev_mode_atomic+0x4b/0x240 [drm_kms_helper]
> > [  246.769921]  #4: 000000004c34a296 (crtc_ww_class_mutex){+.+.}, at:
> > drm_modeset_backoff+0x8a/0x1b0 [drm]
> > [  246.770839] 1 lock held by dmesg/1038:
> > [  246.771739] 2 locks held by zsh/1172:
> > [  246.772650]  #0: 00000000836d0438 (&tty->ldisc_sem){++++}, at:
> > ldsem_down_read+0x37/0x40
> > [  246.773680]  #1: 000000001f4f4d48 (&ldata->atomic_read_lock){+.+.}, at:
> > n_tty_read+0xc1/0x870
> > 
> > [  246.775522] =============================================
> > 
> > So, to fix this (and any other possible deadlock issues like this that
> > could occur in the output_poll_changed patch) we make sure that
> > nouveau's output_poll_changed functions grab a runtime power ref before
> > sending any hotplug events, and hold it until we're finished. We
> > introduce this through adding a generic DRM helper which other drivers
> > may reuse.
> > 
> > This fixes deadlock issues when in fbcon with nouveau on my P50, and
> > should fix it for everyone else's as well!
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Reviewed-by: Karol Herbst <karolherbst@gmail.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v1:
> >  - Add a generic helper for DRM to handle this
> > 
> >  drivers/gpu/drm/drm_fb_helper.c         | 23 +++++++++++++++++++++++
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c |  2 +-
> >  include/drm/drm_fb_helper.h             |  5 +++++
> >  3 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c
> > b/drivers/gpu/drm/drm_fb_helper.c
> > index 2ee1eaa66188..1ab2f3646526 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/sysrq.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_fb_helper.h>
> > @@ -2928,6 +2929,28 @@ void drm_fb_helper_output_poll_changed(struct
> > drm_device *dev)
> >  }
> >  EXPORT_SYMBOL(drm_fb_helper_output_poll_changed);
> >  
> > +/**
> > + * drm_fb_helper_output_poll_changed_with_rpm - DRM mode
> > + *                                              config
> > \.output_poll_changed
> > + *                                              helper for fbdev
> > emulation
> > + * @dev: DRM device
> > + *
> > + * Same as drm_fb_helper_output_poll_changed, except that it makes sure
> > that
> > + * the device is active by synchronously grabbing a runtime power
> > reference
> > + * while probing.
> > + */
> > +void drm_fb_helper_output_poll_changed_with_rpm(struct drm_device *dev)
> > +{
> > +	int ret;
> > +
> > +	ret = pm_runtime_get_sync(dev->dev);
> > +	if (WARN_ON(ret < 0 && ret != -EACCES))
> > +		return;
> > +	drm_fb_helper_hotplug_event(dev->fb_helper);
> > +	pm_runtime_put(dev->dev);
> > +}
> > +EXPORT_SYMBOL(drm_fb_helper_output_poll_changed_with_rpm);
> > +
> >  /* The Kconfig DRM_KMS_HELPER selects FRAMEBUFFER_CONSOLE (if !EXPERT)
> >   * but the module doesn't depend on any fb console symbols.  At least
> >   * attempt to load fbcon to avoid leaving the system without a usable
> > console.
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > index eb3e41a78806..fa3ab618a0f9 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -2015,7 +2015,7 @@ nv50_disp_atomic_state_alloc(struct drm_device *dev)
> >  static const struct drm_mode_config_funcs
> >  nv50_disp_func = {
> >  	.fb_create = nouveau_user_framebuffer_create,
> > -	.output_poll_changed = drm_fb_helper_output_poll_changed,
> > +	.output_poll_changed =
> > drm_fb_helper_output_poll_changed_with_rpm,
> >  	.atomic_check = nv50_disp_atomic_check,
> >  	.atomic_commit = nv50_disp_atomic_commit,
> >  	.atomic_state_alloc = nv50_disp_atomic_state_alloc,
> > diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> > index b069433e7fc1..ca809bfbaebb 100644
> > --- a/include/drm/drm_fb_helper.h
> > +++ b/include/drm/drm_fb_helper.h
> > @@ -330,6 +330,7 @@ void drm_fb_helper_fbdev_teardown(struct drm_device
> > *dev);
> >  
> >  void drm_fb_helper_lastclose(struct drm_device *dev);
> >  void drm_fb_helper_output_poll_changed(struct drm_device *dev);
> > +void drm_fb_helper_output_poll_changed_with_rpm(struct drm_device *dev);
> >  #else
> >  static inline void drm_fb_helper_prepare(struct drm_device *dev,
> >  					struct drm_fb_helper *helper,
> > @@ -564,6 +565,10 @@ static inline void
> > drm_fb_helper_output_poll_changed(struct drm_device *dev)
> >  {
> >  }
> >  
> > +static inline void drm_fb_helper_output_poll_changed_with_rpm(struct
> > drm_device *dev)
> > +{
> > +}
> > +
> >  #endif
> >  
> >  static inline int
> > -- 
> > 2.17.1
> > 
-- 
Cheers,
	Lyude Paul
