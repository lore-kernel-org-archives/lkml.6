Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C509AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1AA208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1AA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeK0HzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:55:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43876 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeK0HzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:55:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so19326968qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=YhC1r1TFC6jtiugyNNAV7rbWUNm74Rniq6kMjpdTcMA=;
        b=TMUh2rKSwq4uxlg/O2MvvYxmmHGm3BG1e2YqQrt+S6UdTU0MxrYBlKWfz89jzl+vFm
         nrKmt3P5Nr/iMxE5I/KiZUVj/aSO8KOg14CLUzXuwmaszdSFeX8u71Q7bUTpf0AqXDzZ
         qC5MR7TtLyte6KdlXvr2NxUcUYsbbJChMIEaMiJru6rljIzJrQ4SMSI+FSxHtbEi+mPE
         Yb1CGn7ES5DFa1Dt1sW/ad8GAymT0+c4QoP6cGfc4ZlqjA37aTv9+GPTc3mrcbqk3GKy
         xP/gqP38y0Biw/lzm128jT8USF+AP4K4iqYhg+1iu3T1fewiMvLZDRzXLCTkiti2V8/n
         B3Zg==
X-Gm-Message-State: AA+aEWa/398X2uspXqJhJ2/HcENyw6c9twnZ5RPthEgQEVvuNQmAMFo1
        fzPFCH6N/LqNpYFPGZYjIi1krA==
X-Google-Smtp-Source: AFSGD/UK9WyRHKjxeAvaxWbCai9ThOP4PqMRJIU+bTrdZ7KQuVXIjKTi6vPqoCcpgrU5meZV+VbF1g==
X-Received: by 2002:a0c:f0c2:: with SMTP id d2mr27950853qvl.123.1543265986762;
        Mon, 26 Nov 2018 12:59:46 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id p42sm908883qte.8.2018.11.26.12.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:59:45 -0800 (PST)
Message-ID: <8c6a11e9aaaba8869d394c141463ee2fdc1c80e5.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH 2/2] drm/nouveau: Grab an rpm reference
 before/after DP AUX transactions
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Nov 2018 15:59:45 -0500
In-Reply-To: <CACO55ts3DZuvj3d-gSHXcrv4wGkbzxvCsZ4qYgjqjCkQxKq_dA@mail.gmail.com>
References: <20181117015024.5771-1-lyude@redhat.com>
         <20181117015024.5771-3-lyude@redhat.com>
         <CACO55ts3DZuvj3d-gSHXcrv4wGkbzxvCsZ4qYgjqjCkQxKq_dA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-24 at 16:47 +0100, Karol Herbst wrote:
> why the nouveau_is_rpm_worker stuff?

To prevent us from trying to grab a runtime PM reference in the runtime
suspend/resume codepath without preventing us from using the aux channel in
those code paths, since drm_dp_mst_topology_mgr_suspend() and
drm_dp_mst_topology_mgr_resume() both need to be able to use the aux channel.
Without that those functions will try to grab a runtime pm ref while runtime
resume then deadlock.

> On Sat, Nov 17, 2018 at 2:50 AM Lyude Paul <lyude@redhat.com> wrote:
> > Now that we have ->pre_transfer() and ->post_transfer() for DP AUX
> > channel devices, we can implement these hooks in order to ensure that
> > the GPU is actually woken up before AUX transactions happen. This fixes
> > /dev/drm_dp_aux* not working while the GPU is suspended, along with some
> > more rare issues where the GPU might runtime-suspend if the time between
> > two DP AUX channel transactions ends up being longer then the runtime
> > suspend delay (sometimes observed on KASAN kernels where everything is
> > slow).
> > 
> > Additionally, we add tracking for the current task that's running our
> > runtime suspend/resume callbacks. We need this in order to avoid trying
> > to grab a runtime power reference when nouveau uses the DP AUX channel
> > for MST suspend/resume in it's runtime susped/resume callbacks.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_connector.c | 36 +++++++++++++++++++++
> >  drivers/gpu/drm/nouveau/nouveau_drm.c       | 12 ++++++-
> >  drivers/gpu/drm/nouveau/nouveau_drv.h       |  8 +++++
> >  3 files changed, 55 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > index fd80661dff92..d2e9752f2f91 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > @@ -1171,6 +1171,38 @@ nouveau_connector_hotplug(struct nvif_notify
> > *notify)
> >         return NVIF_NOTIFY_KEEP;
> >  }
> > 
> > +static int
> > +nouveau_connector_aux_pre_xfer(struct drm_dp_aux *obj)
> > +{
> > +       struct nouveau_connector *nv_connector =
> > +               container_of(obj, typeof(*nv_connector), aux);
> > +       struct nouveau_drm *drm = nouveau_drm(nv_connector->base.dev);
> > +       int ret;
> > +
> > +       if (nouveau_is_rpm_worker(drm))
> > +               return 0;
> > +
> > +       ret = pm_runtime_get_sync(drm->dev->dev);
> > +       if (ret < 0 && ret != -EAGAIN)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +static void
> > +nouveau_connector_aux_post_xfer(struct drm_dp_aux *obj)
> > +{
> > +       struct nouveau_connector *nv_connector =
> > +               container_of(obj, typeof(*nv_connector), aux);
> > +       struct nouveau_drm *drm = nouveau_drm(nv_connector->base.dev);
> > +
> > +       if (nouveau_is_rpm_worker(drm))
> > +               return;
> > +
> > +       pm_runtime_mark_last_busy(drm->dev->dev);
> > +       pm_runtime_put_autosuspend(drm->dev->dev);
> > +}
> > +
> >  static ssize_t
> >  nouveau_connector_aux_xfer(struct drm_dp_aux *obj, struct drm_dp_aux_msg
> > *msg)
> >  {
> > @@ -1341,6 +1373,10 @@ nouveau_connector_create(struct drm_device *dev,
> > int index)
> >         case DRM_MODE_CONNECTOR_DisplayPort:
> >         case DRM_MODE_CONNECTOR_eDP:
> >                 nv_connector->aux.dev = dev->dev;
> > +               nv_connector->aux.pre_transfer =
> > +                       nouveau_connector_aux_pre_xfer;
> > +               nv_connector->aux.post_transfer =
> > +                       nouveau_connector_aux_post_xfer;
> >                 nv_connector->aux.transfer = nouveau_connector_aux_xfer;
> >                 ret = drm_dp_aux_register(&nv_connector->aux);
> >                 if (ret) {
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > index 2b2baf6e0e0d..4323e9e61c2e 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > @@ -859,6 +859,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
> >  {
> >         struct pci_dev *pdev = to_pci_dev(dev);
> >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > +       struct nouveau_drm *drm = nouveau_drm(drm_dev);
> >         int ret;
> > 
> >         if (!nouveau_pmops_runtime()) {
> > @@ -866,6 +867,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
> >                 return -EBUSY;
> >         }
> > 
> > +       drm->rpm_task = current;
> > +
> >         nouveau_switcheroo_optimus_dsm();
> >         ret = nouveau_do_suspend(drm_dev, true);
> >         pci_save_state(pdev);
> > @@ -873,6 +876,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
> >         pci_ignore_hotplug(pdev);
> >         pci_set_power_state(pdev, PCI_D3cold);
> >         drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
> > +
> > +       drm->rpm_task = NULL;
> >         return ret;
> >  }
> > 
> > @@ -881,6 +886,7 @@ nouveau_pmops_runtime_resume(struct device *dev)
> >  {
> >         struct pci_dev *pdev = to_pci_dev(dev);
> >         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > +       struct nouveau_drm *drm = nouveau_drm(drm_dev);
> >         struct nvif_device *device = &nouveau_drm(drm_dev)->client.device;
> >         int ret;
> > 
> > @@ -889,11 +895,13 @@ nouveau_pmops_runtime_resume(struct device *dev)
> >                 return -EBUSY;
> >         }
> > 
> > +       drm->rpm_task = current;
> > +
> >         pci_set_power_state(pdev, PCI_D0);
> >         pci_restore_state(pdev);
> >         ret = pci_enable_device(pdev);
> >         if (ret)
> > -               return ret;
> > +               goto out;
> >         pci_set_master(pdev);
> > 
> >         ret = nouveau_do_resume(drm_dev, true);
> > @@ -905,6 +913,8 @@ nouveau_pmops_runtime_resume(struct device *dev)
> >         /* Monitors may have been connected / disconnected during suspend
> > */
> >         schedule_work(&nouveau_drm(drm_dev)->hpd_work);
> > 
> > +out:
> > +       drm->rpm_task = NULL;
> >         return ret;
> >  }
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h
> > b/drivers/gpu/drm/nouveau/nouveau_drv.h
> > index 0b2191fa96f7..e8d4203ddfb4 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> > @@ -212,6 +212,8 @@ struct nouveau_drm {
> >         bool have_disp_power_ref;
> > 
> >         struct dev_pm_domain vga_pm_domain;
> > +
> > +       struct task_struct *rpm_task;
> >  };
> > 
> >  static inline struct nouveau_drm *
> > @@ -231,6 +233,12 @@ int nouveau_pmops_suspend(struct device *);
> >  int nouveau_pmops_resume(struct device *);
> >  bool nouveau_pmops_runtime(void);
> > 
> > +static inline bool
> > +nouveau_is_rpm_worker(struct nouveau_drm *drm)
> > +{
> > +       return drm->rpm_task == current;
> > +}
> > +
> >  #include <nvkm/core/tegra.h>
> > 
> >  struct drm_device *
> > --
> > 2.19.1
> > 
> > _______________________________________________
> > Nouveau mailing list
> > Nouveau@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/nouveau
-- 
Cheers,
	Lyude Paul

