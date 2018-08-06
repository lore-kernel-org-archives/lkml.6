Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D4F21A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D4F21A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbeHFV0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:26:07 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36675 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbeHFV0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:26:07 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so5730364ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RJTcjvdhRI6N6H9gAbv9CmhfPxvMfjX4cdGlzKT7mwA=;
        b=kf3DHJPdYJPePnu1x89lyh28O/1UT4k+lV4oFfOyKd9ISRIXGrQ381xHjJByUqVTdm
         b3o25sTG0kbtmhyTXN8NWmKW3XNy/+9c55qr0gqoWCveK6Lmi2N/JOf8hVJzL0iLyn/G
         o3HdetGVpM4kDoqd1Dc/y1WycaIm2zcnw8QDf6SO8yBQncJ7KdKjjlRA8jSSpjIf9mfM
         k3SA3r0zER/13iXYBt8WY0sadTqQA+CCJo51ZKzkrxKVmQ6IO4s+TqnByIikSYYjc+wt
         6cY9WYdZqb1EdzeOFO4IOxBaZo2RudfGGXFf9qys+6ByRLMG9o1I2e47FIIsVaJTfcHR
         YdFQ==
X-Gm-Message-State: AOUpUlGpmpUx2GYO64/XhzS8zOyXKy7nD1xYgRlCDMlp5rA56xl83X3C
        toMrl9aafLOm5VqY5QrM5LBNtw==
X-Google-Smtp-Source: AAOMgpeBR7j+SK7CxyvThOGaNOIGCa2uKvU/fUZeI7aDTq/0A6f47N1zZiCWjvRJS+ce8LKbK10HGg==
X-Received: by 2002:a25:afc6:: with SMTP id d6-v6mr8318373ybj.84.1533582935155;
        Mon, 06 Aug 2018 12:15:35 -0700 (PDT)
Received: from malachite ([172.56.23.147])
        by smtp.gmail.com with ESMTPSA id z125-v6sm16457139ywg.57.2018.08.06.12.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 12:15:34 -0700 (PDT)
Message-ID: <4e72a10062166d646ebd3eb28b6c186d4c00a63f.camel@redhat.com>
Subject: Re: [PATCH v3 3/8] drm/fb_helper: Introduce hotplug_suspend/resume()
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Mon, 06 Aug 2018 15:15:31 -0400
In-Reply-To: <20180806084322.GK3008@phenom.ffwll.local>
References: <20180731003954.19962-1-lyude@redhat.com>
         <20180731003954.19962-4-lyude@redhat.com>
         <20180806084322.GK3008@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 10:43 +0200, Daniel Vetter wrote:
> On Mon, Jul 30, 2018 at 08:39:48PM -0400, Lyude Paul wrote:
> > I'm sure I don't need to tell you that fb_helper's locking is a mess.
> > That being said; fb_helper's locking mess can seriously complicate the
> > runtime suspend/resume operations of drivers because it can invoke
> > atomic commits and connector probing from anywhere that calls
> > drm_fb_helper_hotplug_event(). Since most drivers use
> > drm_fb_helper_output_poll_changed() as their output_poll_changed
> > handler, this can happen in every single context that can fire off a
> > hotplug event. An example:
> 
> Uh, I think this ever more looks like a serious rabbit hole between
> nouveau and rpm. It looks like nouveau tries to use rpm as the outermost
> lock, surrounding every other drm lock there is. That doesn't really work,
> and means you'll keep fighting drm core locking forever.
> 
> All other rpm supporting drivers (i915, and the pile of armsoc ones) push
> their rpm_get/put dance way down into the low-level callbacks. That then
> allows you to fix all the trouble with probing, i2x, dp_aux and stuff
> abitrarily nesting (since rpm itself is refcounted).
> 
> But I'm not really sure why nouveau is different here.
A quick note: this isn't a problem unique to nouveau; I already have
(apparently incorrect according to pm runtime maintainers) hacks that fix
these in amdgpu that I'm planning on reapproaching with a proper fix.

That being said: i915 is also more of a special case compared to other
drivers, mainly because i915 does still have to deal with all these problems
but has it's own handlers that simplify dealing with it. For runtime resume,
you guys call down to disable_rpm_wakeref_asserts() during a portion of the
runtime suspend process to avoid the potential of something trying to grab a
runtime power reference and deadlocking the process, and additionally do the
same thing in your irq handler in i915_irq.c:

	/* IRQs are synced during runtime_suspend, we don't require a wakeref
*/
	disable_rpm_wakeref_asserts(dev_priv);

This essentially translates to the same thing that we're doing here with
nouveau: preventing any calls that would potentially call down to
pm_runtime_resume() so that the runtime suspend handler won't deadlock while
trying to disable HPD irqs. Likewise-this also ensures that you can call
intel_pm_runtime_get()/intel_pm_runtime_put() much lower on the stack without
having to worry about the potential for deadlocks.

While I haven't addressed it in this patchset yet, I pretty much want to do
the same thing for handling nouveau's current issues with i2c and dp aux: grab
runtime power references deeper, and avoid resuming the device in runtime
suspend/resume callbacks.

You did mention in the review of one of my other patches that we should avoid
disabling polling during runtime suspend, and you're definitely right. I feel
a bit silly for not remembering that since I was the one who made it so that
i915 does polling in runtime suspend for chips without RPM HPD detection in
the first place because it was causing people's displays not to come up on
vlv...
Anyway: I think if we just leave output polling enabled during runtime suspend
that might actually fix all of the fb_helper locking issues since we won't
need to wait on any of the output poll workers to finish, at least I think it
should: I'll confirm this when I get into the office

> -Daniel
> 
> > 
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
> > 	   Showing all locks held in the system:
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
> > Because of this, there's an unreasonable number of places that drm
> > drivers would need to insert special handling to prevent trying to
> > resume the device from all of these contexts that can deadlock. It's
> > difficult even to try synchronizing with fb_helper in these contexts as
> > well, since any of them could introduce a deadlock by waiting to acquire
> > the top-level fb_helper mutex, while it's being held by another thread
> > that might potentially call down to pm_runtime_get_sync().
> > 
> > Luckily-there's no actual reason we need to allow fb_helper to handle
> > hotplugging at all when runtime suspending a device. If a hotplug
> > happens during a runtime suspend operation, there's no reason the driver
> > can't just re-enable fbcon's hotplug handling and bring it up to speed
> > with hotplugging events it may have missed by calling
> > drm_fb_helper_hotplug_event().
> > 
> > So, let's make this easy and just add helpers to handle disabling and
> > enabling fb_helper connector probing() without having to potentially
> > wait on fb_helper to finish it's work. This will let us fix the runtime
> > suspend/resume deadlocks that we've been experiencing with nouveau,
> > along with being able to fix some of the incorrect runtime PM core
> > interaction that other DRM drivers currently perform to work around
> > these issues.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Karol Herbst <karolherbst@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 65 +++++++++++++++++++++++++++++++++
> >  include/drm/drm_fb_helper.h     | 20 ++++++++++
> >  2 files changed, 85 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c
> > b/drivers/gpu/drm/drm_fb_helper.c
> > index 2ee1eaa66188..28d59befbc92 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -2733,6 +2733,66 @@ int drm_fb_helper_initial_config(struct
> > drm_fb_helper *fb_helper, int bpp_sel)
> >  }
> >  EXPORT_SYMBOL(drm_fb_helper_initial_config);
> >  
> > +/**
> > + * drm_fb_helper_resume_hotplug - Allow fb_helper to handle probing new
> > + *                                connectors again, and bring it up to
> > date
> > + *                                with the current device's connector
> > status
> > + * fb_helper: driver-allocated fbdev helper, can be NULL
> > + *
> > + * Allow fb_helper to react to connector status changes again after
> > having
> > + * been disabled through drm_fb_helper_suspend_hotplug(). This also
> > schedules
> > + * a fb_helper hotplug event to bring fb_helper up to date with the
> > current
> > + * status of the DRM device's connectors.
> > + */
> > +void
> > +drm_fb_helper_resume_hotplug(struct drm_fb_helper *fb_helper)
> > +{
> > +	fb_helper->hotplug_suspended = false;
> > +	drm_fb_helper_hotplug_event(fb_helper);
> > +}
> > +EXPORT_SYMBOL(drm_fb_helper_resume_hotplug);
> > +
> > +/**
> > + * drm_fb_helper_suspend_hotplug - Attempt to temporarily inhibit
> > fb_helper's
> > + *                                 ability to respond to connector
> > changes
> > + *                                 without waiting
> > + * @fb_helper: driver-allocated fbdev helper, can be NULL
> > + *
> > + * Temporarily prevent fb_helper from being able to handle connector
> > changes,
> > + * but only if it isn't busy doing something else. The connector probing
> > + * routines in fb_helper can potentially grab any modesetting lock
> > imaginable,
> > + * which dramatically complicates the runtime suspend process. This
> > helper can
> > + * be used to simplify the process of runtime suspend by allowing the
> > driver
> > + * to disable unpredictable fb_helper operations as early as possible,
> > without
> > + * requiring that we try waiting on fb_helper (as this could lead to very
> > + * difficult to solve deadlocks with runtime suspend code if fb_helper
> > ends up
> > + * needing to acquire a runtime PM reference).
> > + *
> > + * This call should be put at the very start of a driver's runtime
> > suspend
> > + * operation if desired. The driver must be responsible for re-enabling
> > + * fb_helper hotplug handling when normal hotplug detection becomes
> > available
> > + * on the device again. This will usually happen if runtime suspend is
> > + * aborted, or when the device is runtime resumed.
> > + *
> > + * Returns: true if hotplug handling was disabled, false if disabling
> > hotplug
> > + * handling would mean waiting on fb_helper.
> > + */
> > +bool
> > +drm_fb_helper_suspend_hotplug(struct drm_fb_helper *fb_helper)
> > +{
> > +	int ret;
> > +
> > +	ret = mutex_trylock(&fb_helper->lock);
> > +	if (!ret)
> > +		return false;
> > +
> > +	fb_helper->hotplug_suspended = true;
> > +	mutex_unlock(&fb_helper->lock);
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL(drm_fb_helper_suspend_hotplug);
> > +
> >  /**
> >   * drm_fb_helper_hotplug_event - respond to a hotplug notification by
> >   *                               probing all the outputs attached to the
> > fb
> > @@ -2774,6 +2834,11 @@ int drm_fb_helper_hotplug_event(struct
> > drm_fb_helper *fb_helper)
> >  		return err;
> >  	}
> >  
> > +	if (fb_helper->hotplug_suspended) {
> > +		mutex_unlock(&fb_helper->lock);
> > +		return err;
> > +	}
> > +
> >  	DRM_DEBUG_KMS("\n");
> >  
> >  	drm_setup_crtcs(fb_helper, fb_helper->fb->width, fb_helper->fb-
> > >height);
> > diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> > index b069433e7fc1..30881131075c 100644
> > --- a/include/drm/drm_fb_helper.h
> > +++ b/include/drm/drm_fb_helper.h
> > @@ -232,6 +232,14 @@ struct drm_fb_helper {
> >  	 * See also: @deferred_setup
> >  	 */
> >  	int preferred_bpp;
> > +
> > +	/**
> > +	 * @hotplug_suspended:
> > +	 *
> > +	 * Whether or not we can currently handle hotplug events, or if we
> > +	 * need to wait for the DRM device to uninhibit us.
> > +	 */
> > +	bool hotplug_suspended;
> >  };
> >  
> >  /**
> > @@ -330,6 +338,10 @@ void drm_fb_helper_fbdev_teardown(struct drm_device
> > *dev);
> >  
> >  void drm_fb_helper_lastclose(struct drm_device *dev);
> >  void drm_fb_helper_output_poll_changed(struct drm_device *dev);
> > +
> > +void drm_fb_helper_resume_hotplug(struct drm_fb_helper *fb_helper);
> > +bool drm_fb_helper_suspend_hotplug(struct drm_fb_helper *fb_helper);
> > +
> >  #else
> >  static inline void drm_fb_helper_prepare(struct drm_device *dev,
> >  					struct drm_fb_helper *helper,
> > @@ -564,6 +576,14 @@ static inline void
> > drm_fb_helper_output_poll_changed(struct drm_device *dev)
> >  {
> >  }
> >  
> > +static inline void
> > +drm_fb_helper_resume_hotplug(struct drm_fb_helper *fb_helper)
> > +{
> > +}
> > +static inline bool
> > +drm_fb_helper_suspend_hotplug(struct drm_fb_helper *fb_helper)
> > +{
> > +}
> >  #endif
> >  
> >  static inline int
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
-- 
Cheers,
	Lyude Paul

