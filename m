Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31335C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B042054F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B042054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLHAIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:08:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45411 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHAIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:08:46 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so3447664qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 16:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=13mzs8ocSTdtB+u3hnqnZ280c8w0GvfDnW89U2cV/Tg=;
        b=iMZTAm7GeWreHhofXVV7olT73uyZUkeTdhpiqjMVWz4OVbIrMbTn7EXwQDYaQORpvA
         ofal2P3bjbWDC3z+IUYLWisBWw2YkE2ihPcddFqZTyTBspq7dNaUbZNIzGAFdBlA14/2
         PJR25Rs5KeFQ5JGZaRIFVyGtKcrMVcGxY+7toEx98PYdtKSxUUlYPKD4ZZG8AOoPzhzV
         2poH2xrmiWm45CqMeBaPJ4aUA5rX7tk7PMbfTxUKWXKODZjq06xswHfveD4fKrL/ez69
         JzHBOqhV7oJPwqWNSItqd32QJtVZ/27K/40cwPK4nJaWTo1pBHUnvFR2WWFHYsgEWx3j
         mx7w==
X-Gm-Message-State: AA+aEWayjhy/+wF5NAzC6hBKE0fQqKXN1s8Eoq6WPwOf7PHDOUY1zB4Z
        xhIHhV5OyutS2i6eaM53VgTHYTTAJ5s=
X-Google-Smtp-Source: AFSGD/V3r+IGbvcbe9TJjXz1HzZ37Wy1BCqxF//LaJbFIaep3IAE4qlF6Z22MLGCZ38ayOxsCtFabg==
X-Received: by 2002:a37:4a87:: with SMTP id x129mr3621343qka.142.1544227724519;
        Fri, 07 Dec 2018 16:08:44 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id a90sm3538356qka.30.2018.12.07.16.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 16:08:43 -0800 (PST)
Message-ID: <95255117123da3702da585491d2fdd74890937c0.camel@redhat.com>
Subject: Re: next/master boot bisection: Oops in nouveau driver on jetson-tk1
From:   Lyude Paul <lyude@redhat.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Kevin Hilman <khilman@baylibre.com>
Date:   Fri, 07 Dec 2018 19:08:40 -0500
In-Reply-To: <89fa50d0-945f-d1ed-ae55-ee947187f209@collabora.com>
References: <89fa50d0-945f-d1ed-ae55-ee947187f209@collabora.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uhhhhhhhhhhhhh
didn't we fix this weeks ago? with "drm/nouveau: tegra: Call
nouveau_drm_device_init()"


On Fri, 2018-12-07 at 23:31 +0000, Guillaume Tucker wrote:
> Please find below an automated bisection report for a kernel Oops
> seen during the initialisation of the nouveau GPU driver on
> jetson-tk1.
> 
> 
> All the LAVA test jobs for this bisection can be found here:
> 
>   
> http://lava.baylibre.com:10080/scheduler/alljobs?length=25&search=lava-bisect-staging-7366#table
> 
> 
> Here's the beginning of the Oops stack trace:
> 
> [    7.485361] [00000064] *pgd=f9e7b835
> [    7.485372] Internal error: Oops: 17 [#1] SMP ARM
> [    7.485376] Modules linked in: snd_soc_tegra_rt5640(+)
> snd_soc_tegra_utils snd_soc_rt5640(+) snd_soc_rl6231 snd_soc_tegra30_ahub
> snd_hda_tegra snd_soc_core snd_hda_codec snd_hda_core ac97_bus
> snd_pcm_dmaengine snd_pcm xhci_tegra(+) snd_timer snd soundcore nouveau(+)
> ttm tegra_devfreq tegra_wdt
> [    7.542227] CPU: 1 PID: 128 Comm: udevd Not tainted 4.20.0-rc5-next-
> 20181206 #44
> [    7.549603] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [    7.555859] PC is at drm_plane_register_all+0x18/0x50
> [    7.560899] LR is at drm_modeset_register_all+0xc/0x6c
> 
> 
> Full log:
> 
>   http://lava.baylibre.com:10080/scheduler/job/68628#L816
> 
> 
> The bisection was run from next-20181206 as this is where the
> issue was discovered on kernelci.org but the patch it found has
> already been merged in mainline.
> 
> Hope this helps!
> 
> Guillaume
> 
> 
> -----------8<------------------------8<-----------
> 
> 
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> Bisection result for next/master (next-20181206) on jetson-tk1
> 
>   Good:       84df9525b0c2 Linux 4.19
>   Bad:        4c92b7b3080d Add linux-next specific files for 20181206
>   Found:      cfea88a4d866 drm/nouveau: Start using new drm_dev
> initialization helpers
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        None
>   Branch:     master
>   Target:     jetson-tk1
>   Lab:        lab-baylibre
>   Config:     multi_v7_defconfig
>   Plan:       dmesg-nouveau
> 
> Breaking commit found:
> 
> ----------------------------------------------------------------------------
> ---
> commit cfea88a4d86632f28cf80be97079f131645b7869
> Author: Lyude Paul <lyude@redhat.com>
> Date:   Wed Aug 22 21:40:07 2018 -0400
> 
>     drm/nouveau: Start using new drm_dev initialization helpers
>     
>     Per the documentation in drm_get_pci_dev(), this function is deprecated
>     and shouldn't be used anymore. As it turns out, we're going to need to
>     stop using drm_get_pci_dev() anyway in order to allow us to turn off the
>     card before full system shutdowns, otherwise we'll hit race conditions
>     with userspace while trying to tear down the card on shutdown.
>     
>     So, start using drm_dev_get() and drm_dev_put(), and just turn our
>     load/unload callbacks into open coded init/fini() functions.
>     
>     Signed-off-by: Lyude Paul <lyude@redhat.com>
>     Cc: Karol Herbst <kherbst@redhat.com>
>     Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 905956809d21..2b2baf6e0e0d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -458,75 +458,8 @@ nouveau_accel_init(struct nouveau_drm *drm)
>  	nouveau_bo_move_init(drm);
>  }
>  
> -static int nouveau_drm_probe(struct pci_dev *pdev,
> -			     const struct pci_device_id *pent)
> -{
> -	struct nvkm_device *device;
> -	struct apertures_struct *aper;
> -	bool boot = false;
> -	int ret;
> -
> -	if (vga_switcheroo_client_probe_defer(pdev))
> -		return -EPROBE_DEFER;
> -
> -	/* We need to check that the chipset is supported before booting
> -	 * fbdev off the hardware, as there's no way to put it back.
> -	 */
> -	ret = nvkm_device_pci_new(pdev, NULL, "error", true, false, 0,
> &device);
> -	if (ret)
> -		return ret;
> -
> -	nvkm_device_del(&device);
> -
> -	/* Remove conflicting drivers (vesafb, efifb etc). */
> -	aper = alloc_apertures(3);
> -	if (!aper)
> -		return -ENOMEM;
> -
> -	aper->ranges[0].base = pci_resource_start(pdev, 1);
> -	aper->ranges[0].size = pci_resource_len(pdev, 1);
> -	aper->count = 1;
> -
> -	if (pci_resource_len(pdev, 2)) {
> -		aper->ranges[aper->count].base = pci_resource_start(pdev, 2);
> -		aper->ranges[aper->count].size = pci_resource_len(pdev, 2);
> -		aper->count++;
> -	}
> -
> -	if (pci_resource_len(pdev, 3)) {
> -		aper->ranges[aper->count].base = pci_resource_start(pdev, 3);
> -		aper->ranges[aper->count].size = pci_resource_len(pdev, 3);
> -		aper->count++;
> -	}
> -
> -#ifdef CONFIG_X86
> -	boot = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
> -#endif
> -	if (nouveau_modeset != 2)
> -		drm_fb_helper_remove_conflicting_framebuffers(aper,
> "nouveaufb", boot);
> -	kfree(aper);
> -
> -	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug,
> -				  true, true, ~0ULL, &device);
> -	if (ret)
> -		return ret;
> -
> -	pci_set_master(pdev);
> -
> -	if (nouveau_atomic)
> -		driver_pci.driver_features |= DRIVER_ATOMIC;
> -
> -	ret = drm_get_pci_dev(pdev, pent, &driver_pci);
> -	if (ret) {
> -		nvkm_device_del(&device);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int
> -nouveau_drm_load(struct drm_device *dev, unsigned long flags)
> +nouveau_drm_device_init(struct drm_device *dev)
>  {
>  	struct nouveau_drm *drm;
>  	int ret;
> @@ -613,7 +546,7 @@ nouveau_drm_load(struct drm_device *dev, unsigned long
> flags)
>  }
>  
>  static void
> -nouveau_drm_unload(struct drm_device *dev)
> +nouveau_drm_device_fini(struct drm_device *dev)
>  {
>  	struct nouveau_drm *drm = nouveau_drm(dev);
>  
> @@ -642,18 +575,116 @@ nouveau_drm_unload(struct drm_device *dev)
>  	kfree(drm);
>  }
>  
> +static int nouveau_drm_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *pent)
> +{
> +	struct nvkm_device *device;
> +	struct drm_device *drm_dev;
> +	struct apertures_struct *aper;
> +	bool boot = false;
> +	int ret;
> +
> +	if (vga_switcheroo_client_probe_defer(pdev))
> +		return -EPROBE_DEFER;
> +
> +	/* We need to check that the chipset is supported before booting
> +	 * fbdev off the hardware, as there's no way to put it back.
> +	 */
> +	ret = nvkm_device_pci_new(pdev, NULL, "error", true, false, 0,
> &device);
> +	if (ret)
> +		return ret;
> +
> +	nvkm_device_del(&device);
> +
> +	/* Remove conflicting drivers (vesafb, efifb etc). */
> +	aper = alloc_apertures(3);
> +	if (!aper)
> +		return -ENOMEM;
> +
> +	aper->ranges[0].base = pci_resource_start(pdev, 1);
> +	aper->ranges[0].size = pci_resource_len(pdev, 1);
> +	aper->count = 1;
> +
> +	if (pci_resource_len(pdev, 2)) {
> +		aper->ranges[aper->count].base = pci_resource_start(pdev, 2);
> +		aper->ranges[aper->count].size = pci_resource_len(pdev, 2);
> +		aper->count++;
> +	}
> +
> +	if (pci_resource_len(pdev, 3)) {
> +		aper->ranges[aper->count].base = pci_resource_start(pdev, 3);
> +		aper->ranges[aper->count].size = pci_resource_len(pdev, 3);
> +		aper->count++;
> +	}
> +
> +#ifdef CONFIG_X86
> +	boot = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
> +#endif
> +	if (nouveau_modeset != 2)
> +		drm_fb_helper_remove_conflicting_framebuffers(aper,
> "nouveaufb", boot);
> +	kfree(aper);
> +
> +	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug,
> +				  true, true, ~0ULL, &device);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);
> +
> +	if (nouveau_atomic)
> +		driver_pci.driver_features |= DRIVER_ATOMIC;
> +
> +	drm_dev = drm_dev_alloc(&driver_pci, &pdev->dev);
> +	if (IS_ERR(drm_dev)) {
> +		ret = PTR_ERR(drm_dev);
> +		goto fail_nvkm;
> +	}
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		goto fail_drm;
> +
> +	drm_dev->pdev = pdev;
> +	pci_set_drvdata(pdev, drm_dev);
> +
> +	ret = nouveau_drm_device_init(drm_dev);
> +	if (ret)
> +		goto fail_pci;
> +
> +	ret = drm_dev_register(drm_dev, pent->driver_data);
> +	if (ret)
> +		goto fail_drm_dev_init;
> +
> +	return 0;
> +
> +fail_drm_dev_init:
> +	nouveau_drm_device_fini(drm_dev);
> +fail_pci:
> +	pci_disable_device(pdev);
> +fail_drm:
> +	drm_dev_put(drm_dev);
> +fail_nvkm:
> +	nvkm_device_del(&device);
> +	return ret;
> +}
> +
>  void
>  nouveau_drm_device_remove(struct drm_device *dev)
>  {
> +	struct pci_dev *pdev = dev->pdev;
>  	struct nouveau_drm *drm = nouveau_drm(dev);
>  	struct nvkm_client *client;
>  	struct nvkm_device *device;
>  
> +	drm_dev_unregister(dev);
> +
>  	dev->irq_enabled = false;
>  	client = nvxx_client(&drm->client.base);
>  	device = nvkm_device_find(client->device);
> -	drm_put_dev(dev);
>  
> +	nouveau_drm_device_fini(dev);
> +	pci_disable_device(pdev);
> +	drm_dev_put(dev);
>  	nvkm_device_del(&device);
>  }
>  
> @@ -1020,8 +1051,6 @@ driver_stub = {
>  		DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_RENDER |
>  		DRIVER_KMS_LEGACY_CONTEXT,
>  
> -	.load = nouveau_drm_load,
> -	.unload = nouveau_drm_unload,
>  	.open = nouveau_drm_open,
>  	.postclose = nouveau_drm_postclose,
>  	.lastclose = nouveau_vga_lastclose,
> ----------------------------------------------------------------------------
> ---
> 
> 
> Git bisection log:
> 
> ----------------------------------------------------------------------------
> ---
> git bisect start
> # good: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
> git bisect good 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
> # bad: [4c92b7b3080d8281941ae81c51cd62bb49bdc3d4] Add linux-next specific
> files for 20181206
> git bisect bad 4c92b7b3080d8281941ae81c51cd62bb49bdc3d4
> # bad: [c38239b4be1ac7e4bcf5bbd971353bae51525b8f] Merge branch 'parisc-4.20-
> 2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git bisect bad c38239b4be1ac7e4bcf5bbd971353bae51525b8f
> # good: [d49f8a52b15bf35db778035340d8a673149f9f93] Merge tag 'scsi-misc' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good d49f8a52b15bf35db778035340d8a673149f9f93
> # good: [ac747c0715f29c2be3848b719a1b7e65b07f7b21] Merge tag 'kbuild-v4.20'
> of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect good ac747c0715f29c2be3848b719a1b7e65b07f7b21
> # bad: [46972c03ab667dc298cad0c9db517fb9b1521b5f] Merge tag 'drm-misc-next-
> fixes-2018-10-10' of git://anongit.freedesktop.org/drm/drm-misc into drm-
> next
> git bisect bad 46972c03ab667dc298cad0c9db517fb9b1521b5f
> # good: [6ac99a328ee16d3f8cc253f1df62623cee3e9ea5] drm/exynos: mixer: Make
> plane alpha configurable
> git bisect good 6ac99a328ee16d3f8cc253f1df62623cee3e9ea5
> # good: [0957dc7097a3f462f6cedb45cf9b9785cc29e5bb] drm/amdgpu: revert "stop
> using gart_start as offset for the GTT domain"
> git bisect good 0957dc7097a3f462f6cedb45cf9b9785cc29e5bb
> # good: [2de0b0a158bf423208c3898522c8fa1c1078df48] Merge tag 'drm/tegra/for-
> 4.20-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
> git bisect good 2de0b0a158bf423208c3898522c8fa1c1078df48
> # good: [04b96b63c5640a305e30611def7a9c5fcd7a72cf] drm/msm/dpu: Remove
> unneeded checks in dpu_crtc.c
> git bisect good 04b96b63c5640a305e30611def7a9c5fcd7a72cf
> # good: [6952e3a1dffcb931cf8625aa01642b9afac2af61] Merge branch 'for-
> upstream/mali-dp' of git://linux-arm.org/linux-ld into drm-next
> git bisect good 6952e3a1dffcb931cf8625aa01642b9afac2af61
> # good: [62e681f7dcab746412dce22d4b75b32c5ea38cdb] Merge tag 'drm-msm-fixes-
> 2018-10-09' of git://people.freedesktop.org/~robclark/linux into drm-next
> git bisect good 62e681f7dcab746412dce22d4b75b32c5ea38cdb
> # bad: [7e6191d4360a2df6cf2a2613dcb79680cb943df8] Merge branch 'linux-4.20'
> of git://github.com/skeggsb/linux into drm-next
> git bisect bad 7e6191d4360a2df6cf2a2613dcb79680cb943df8
> # good: [c4cee69a4497d9c6ad8868d63568b30e50cac9e9] drm/nouveau: Fix
> potential memory leak in nouveau_drm_load()
> git bisect good c4cee69a4497d9c6ad8868d63568b30e50cac9e9
> # bad: [a971558c298755d2c07bc5508c65d689471763c8] drm/nouveau/disp: keep
> track of high-speed state, program into clock
> git bisect bad a971558c298755d2c07bc5508c65d689471763c8
> # bad: [4126b99e744b7a29746e201e2be6644d2edf3c56] drm/nouveau/disp: add a
> way to configure scrambling/tmds for hdmi 2.0
> git bisect bad 4126b99e744b7a29746e201e2be6644d2edf3c56
> # bad: [cfea88a4d86632f28cf80be97079f131645b7869] drm/nouveau: Start using
> new drm_dev initialization helpers
> git bisect bad cfea88a4d86632f28cf80be97079f131645b7869
> # first bad commit: [cfea88a4d86632f28cf80be97079f131645b7869] drm/nouveau:
> Start using new drm_dev initialization helpers
> ----------------------------------------------------------------------------
> ---
-- 
Cheers,
	Lyude Paul

