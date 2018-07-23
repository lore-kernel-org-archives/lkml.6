Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CEFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C713220671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C713220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbeGWSwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:52:51 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36008 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387994AbeGWSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:52:50 -0400
Received: by mail-qk0-f196.google.com with SMTP id a132-v6so961181qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=d8VmFIV1Jwj62ki97eU0UQF8nbAwUmaszhd1dD1zaAY=;
        b=UCKuGDKFNz3s6agjmL9Ve7hd/2it+tAUWGMmfiny9WlIRI+ZMR9HO+x9+7pS4UaLna
         TTw3Cl2CZBj2gBm9Wn/VhMv4mil2mc8azt2Q66gzVZHHAz73/JqeQ4Ky9MZe9dS8eR3j
         Vc8jW+VZNRjCmeUE/FVKF35poODTUUaRpsSpl6b13UWHKaJ+NtGMhHrcbpC3F/wf15Rr
         5I+1SmSqdTMt4pwdnHAO717v527pkDX8rUAt9UOICSF+mISjOZelCNseiqL0zGVwwtqW
         oVDQrWh0nxhXkgRKF61GIIgFRrd5HNx7cA+Jm6IS+EKMuD1snvUZqH/ueHKhUCyAhReV
         agwA==
X-Gm-Message-State: AOUpUlEh8owd2dQXtO87L8g1XAevgCmAF92nsWeqG23PoNWqtsGTCxrP
        NxViBH0yLgdj1lT1lJwMoF3ynw==
X-Google-Smtp-Source: AAOMgpeLSejK+pE6XQKHMVVMdK+O+vgS0P1KLmFDEy4En6FOXR9FKV2AmqxKsC66nyOHJLeqkvB9WA==
X-Received: by 2002:a37:6446:: with SMTP id y67-v6mr12214713qkb.309.1532368230011;
        Mon, 23 Jul 2018 10:50:30 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id u10-v6sm7866424qki.6.2018.07.23.10.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:50:29 -0700 (PDT)
Message-ID: <1a6531e25f5252553523a3127265876d056a3f4d.camel@redhat.com>
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
Date:   Mon, 23 Jul 2018 13:50:28 -0400
In-Reply-To: <20180721093955.GA32572@wunner.de>
References: <20180718205645.25924-1-lyude@redhat.com>
         <20180718205645.25924-2-lyude@redhat.com>
         <20180719074926.GA14303@wunner.de>
         <be93e682cd5a583e9b4cb6c4fcd7a476d597bb6b.camel@redhat.com>
         <20180721093955.GA32572@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-21 at 11:39 +0200, Lukas Wunner wrote:
> On Thu, Jul 19, 2018 at 08:08:15PM -0400, Lyude Paul wrote:
> > On Thu, 2018-07-19 at 09:49 +0200, Lukas Wunner wrote:
> > > On Wed, Jul 18, 2018 at 04:56:39PM -0400, Lyude Paul wrote:
> > > > When DP MST hubs get confused, they can occasionally stop responding
> > > > for
> > > > a good bit of time up until the point where the DRM driver manages to
> > > > do the right DPCD accesses to get it to start responding again. In a
> > > > worst case scenario however, this process can take upwards of 10+
> > > > seconds.
> > > > 
> > > > Currently we use the default output_poll_changed handler
> > > > drm_fb_helper_output_poll_changed() to handle output polling, which
> > > > doesn't happen to grab any power references on the device when
> > > > polling.
> > > > If we're unlucky enough to have a hub (such as Lenovo's infamous
> > > > laptop
> > > > docks for the P5x/P7x series) that's easily startled and confused,
> > > > this
> > > > can lead to a pretty nasty deadlock situation that looks like this:
> > > > 
> > > > - Hotplug event from hub happens, we enter
> > > >   drm_fb_helper_output_poll_changed() and start communicating with the
> > > >   hub
> > > > - While we're in drm_fb_helper_output_poll_changed() and attempting to
> > > >   communicate with the hub, we end up confusing it and cause it to
> > > > stop
> > > >   responding for at least 10 seconds
> > > > - After 5 seconds of being in drm_fb_helper_output_poll_changed(), the
> > > >   pm core attempts to put the GPU into autosuspend, which ends up
> > > >   calling drm_kms_helper_poll_disable()
> > > > - While the runtime PM core is waiting in
> > > > drm_kms_helper_poll_disable()
> > > >   for the output poll to finish, we end up finally detecting an MST
> > > >   display
> > > > - We notice the new display and tries to enable it, which triggers
> > > >   an atomic commit which triggers a call to pm_runtime_get_sync()
> > > > - the output poll thread deadlocks the pm core waiting for the pm core
> > > >   to finish the autosuspend request while the pm core waits for the
> > > >   output poll thread to finish
> > > 
> > > The correct fix is to call pm_runtime_get_sync() *conditionally* in
> > > the atomic commit which enables the display, using the same conditional
> > > as d61a5c106351, i.e. if (!drm_kms_helper_is_poll_worker()).
> 
> First of all, I was mistaken when I wrote above that a check for
> !drm_kms_helper_is_poll_worker() would solve the problem.  Sorry!
> It doesn't because the call to pm_runtime_get_sync() is not happening
> in output_poll_execute() but in drm_dp_mst_link_probe_work().
> 
> Looking once more at the three stack traces you've provided, we've got:
> - output_poll_execute() stuck waiting for fb_helper->lock
>   which is held by drm_dp_mst_link_probe_work()
> - rpm_suspend() stuck waiting for output_poll_execute() to finish
> - drm_dp_mst_link_probe_work() stuck waiting in rpm_resume()
> 
> For the moment we can ignore the first task, i.e. output_poll_execute(),
> and focus on the latter two.
> 
> As said I'm unfamiliar with MST but browsing through drm_dp_mst_topology.c
> I notice that drm_dp_mst_link_probe_work() is the ->work element in
> drm_dp_mst_topology_mgr() and is queued on HPD.  I further notice that
> the work item is flushed on ->runtime_suspend:
> 
> nouveau_pmops_runtime_suspend()
>   nouveau_do_suspend()
>     nouveau_display_suspend()
>       nouveau_display_fini()
>         disp->fini() == nv50_display_fini()
> 	  nv50_mstm_fini()
> 	    drm_dp_mst_topology_mgr_suspend()
> 	      flush_work(&mgr->work);
> 
> And before the work item is flushed, the HPD source is quiesced.
> 
> So it looks like drm_dp_mst_link_probe_work() can only ever run
> while the GPU is runtime resumed, it never runs while the GPU is
> runtime suspended.  This means that you don't have to acquire any
> runtime PM references in or below drm_dp_mst_link_probe_work().
> Au contraire, you must not acquire any because it will deadlock while
> the GPU is runtime suspending.  If there are functions which are
> called from drm_dp_mst_link_probe_work() as well as from other contexts,
> and those other contexts need a runtime PM ref to be acquired,
> you need to acquire the runtime PM ref conditionally on not being
> drm_dp_mst_link_probe_work() (using the current_work() technique).
> 
> Alternatively, move acquisition of the runtime PM ref further up in
> the call chain to those other contexts.
> 
> 
> > Anyway-that's why your explanation doesn't make sense: the deadlock is
> > happening because we're calling pm_runtime_get_sync(). If we were to
> > make that call conditional (e.g. drm_kms_helper_is_poll_worker()),
> > all that would mean is that we wouldn't grab any runtime power reference
> > and the GPU would immediately suspend once the atomic commit finished,
> > as the suspend request in Thread 5 would finally get unblocked and thus
> > ----suspend.
> 
> Right, that seems to be a bug nouveau_pmops_runtime_suspend():
> 
> If a display is plugged in while the GPU is about to runtime suspend,
> the display may be lit up by output_poll_execute() but the GPU will
> then nevertheless be powered off.
> 
> I guess after calling drm_kms_helper_poll_disable() we should re-check
> if a crtc has been activated.  This should have bumped the runtime PM
> refcount and have_disp_power_ref should be true.  In that case, the
> nouveau_pmops_runtime_suspend() should return -EBUSY to abort the
> runtime_suspend.
> 
> The same check seems necessary after flushing drm_dp_mst_link_probe_work():
> If the work item lit up a new display, all previous suspend steps need
> to be unwound and -EBUSY needs to be returned to the PM core.
> 
> Communication with an MST hub exceeding the autosuspend timeout is
> just one scenario where this bug manifests itself.
> 
> BTW, drm_kms_helper_poll_disable() seems to be called twice in the
> runtime_suspend code path, once in nouveau_pmops_runtime_suspend()
> and a second time in nouveau_display_fini().
> 
> A stupid question, I notice that nv50_display_fini() calls nv50_mstm_fini()
> only if encoder_type != DRM_MODE_ENCODER_DPMST.  Why isn't that == ?
Because there's a difference between DPMST connectors and encoders vs. the
rest of the device's encoders. Every DP MST topology will take up a single
"physical" DP connector on the device that will be marked as disconnected.
This connector also owns the "mstm" (MST manager, referred to as the
drm_dp_mst_topology_mgr in DRM), which through the callbacks nouveau provides
is responsible for creating the fake DP MST ports and encoders. All of these
fake ports will have DPMST encoders as opposed to the physical DP ports, which
will have TMDS encoders. Hence-mstms are only on physical connectors with
TMDS, not fake connectors with DPMST.


> 
> Thanks,
> 
> Lukas
-- 
Cheers,
	Lyude Paul

