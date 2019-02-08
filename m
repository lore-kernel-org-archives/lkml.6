Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D4FC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBB720869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVpNJl/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBHXcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:32:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37101 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:32:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id r10-v6so4411120ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 15:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GShAPLWpz4DTo92m1M6kcJDwBDurJlO5C5FzWtcE51E=;
        b=RVpNJl/BG2UM85j5kQZjwy5tVjF5y0pWFshVXLTbsucVEvqHEv7+LJ7P7dkql1g45L
         LbmNBf1lLzNY5YQJ7/SAD7CVvIbhjKAp1bn9wEUqimaoCBBCEMR1CVUSuxuWc77FG0um
         afbQNMHpiHpre3Kfhg8aGpTKsTGWoXqVN1H8VuCNXIu5edot0wBLVfCUWGwB/w5xUr1+
         R8VvjgBUJePR8xFforRL26gahzkGRG7BXRJC0gS7q3gtsB4WyLvSE0d16qbeufybIUgn
         X6aprJOnloRRB14e23Ng/glA6kEzX3qoO+wOt2qCqsQAwDbD30mjeZ86rks5Z9BjSHaf
         ZR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GShAPLWpz4DTo92m1M6kcJDwBDurJlO5C5FzWtcE51E=;
        b=CeKBOSjA4QU+VpZBUwnxOl3fox7AvfMlLFphYuI+2qpQ0X6rJjCAzBm6yv1XWl3UDA
         S+RpAT9TLbwy6Rk2fN5vJMgeV45RvjsxuK7MCaBfEHh23HHV15l6xd7IAjPh+R7QaH7H
         KVIrNRmf3V+YFcrVVy3DO+823I3QFWp5drYJA9qqmKiBiXQFuE6dwRv5YmwHKgzGTF1W
         axj7hLkvYKY5pIFsh2kzNIkqIJQj2dYeGWhLG4ZJZeWfvC7WmPUneftqLZEMWFp8RDpR
         AJnJIMPmLUc00SvO8VZKX4YuRrrHrrnEiWGYJsuWH7qzYl4s386pQyxQdNxwAJ7RzIi1
         AT3Q==
X-Gm-Message-State: AHQUAuYNuDIhV8KIPUuoTzPC4pCJqkfKhIc0Okm5N5lktXGEDLxXyVkl
        tzwz6Jl+GhR/SXh7EPanBR6tUDWz7F/kQFolWn6ASO4KbIM=
X-Google-Smtp-Source: AHgI3IbsNn+jnGobgBqbAA8GEcCkxi/ve+lCNvdyX6bR9jfPVOcQJJd/OG0dF9pd5DZVf8i28i9Id3d8YqGaRwcOYfU=
X-Received: by 2002:a2e:980e:: with SMTP id a14-v6mr629578ljj.119.1549668758083;
 Fri, 08 Feb 2019 15:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20190206175627.GA20399@gmail.com> <CANiq72=gS7=G6WbZ4jqybMBh44FeF7UeVEfeb1hN8uMAMt_2bw@mail.gmail.com>
 <20190207105431.GA26041@linux-8ccs>
In-Reply-To: <20190207105431.GA26041@linux-8ccs>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 9 Feb 2019 00:32:27 +0100
Message-ID: <CANiq72kAfcdj+dVaBHsCzTvxp2jdeSiPuv+CJDxoRhy2zpK5xg@mail.gmail.com>
Subject: Re: [PATCH v2] include/linux/module.h: mark init/cleanup_module
 aliases as __init/exit
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 11:54 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> My order of preference would be 2, 1, striving for 3 eventually.

For reference, for 3), we would need to tweak the following ~130
modules [1]. Quite a lot of them are the simple kind. Also, if we end
up with 3), we could potentially remove a few modpost checks (e.g.
ANY_INIT_TO_ANY_EXIT).

I am submitting the patch for 2). It requires introducing the new
attribute, so let's see if people like it.

Cheers,
Miguel

[1]

arch/x86/kvm/vmx/vmx.c
crypto/async_tx/raid6test.c
crypto/ecdh.c
drivers/block/drbd/drbd_main.c
drivers/bluetooth/btrsi.c
drivers/char/ipmi/ipmi_si_intf.c
drivers/char/ipmi/ipmi_ssif.c
drivers/char/lp.c
drivers/char/mwave/mwavedd.c
drivers/connector/connector.c
drivers/cpufreq/powernow-k8.c
drivers/crypto/ccp/ccp-crypto-main.c
drivers/dma/ti/edma.c
drivers/dma/ti/omap-dma.c
drivers/firmware/efi/efivars.c
drivers/firmware/google/memconsole-coreboot.c
drivers/fmc/fmc-chardev.c
drivers/fmc/fmc-core.c
drivers/fmc/fmc-fakedev.c
drivers/fmc/fmc-trivial.c
drivers/fmc/fmc-write-eeprom.c
drivers/fsi/fsi-core.c
drivers/fsi/fsi-occ.c
drivers/fsi/fsi-sbefifo.c
drivers/fsi/fsi-scom.c
drivers/gpu/drm/drm_drv.c
drivers/hv/hv_util.c
drivers/hwtracing/stm/console.c
drivers/hwtracing/stm/dummy_stm.c
drivers/hwtracing/stm/heartbeat.c
drivers/hwtracing/stm/p_basic.c
drivers/hwtracing/stm/p_sys-t.c
drivers/infiniband/sw/rdmavt/vt.c
drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
drivers/isdn/mISDN/core.c
drivers/isdn/mISDN/l1oip_core.c
drivers/lightnvm/pblk-init.c
drivers/mcb/mcb-core.c
drivers/md/bcache/super.c
drivers/md/dm-integrity.c
drivers/md/dm-thin.c
drivers/md/md-cluster.c
drivers/md/md-faulty.c
drivers/md/md-linear.c
drivers/md/raid0.c
drivers/md/raid1.c
drivers/md/raid10.c
drivers/md/raid5.c
drivers/media/common/b2c2/flexcop.c
drivers/media/pci/cx25821/cx25821-alsa.c
drivers/media/pci/ivtv/ivtvfb.c
drivers/media/pci/saa7134/saa7134-alsa.c
drivers/media/platform/davinci/vpif.c
drivers/media/platform/davinci/vpss.c
drivers/media/platform/exynos4-is/fimc-is.c
drivers/media/platform/omap/omap_vout.c
drivers/message/fusion/mptctl.c
drivers/mtd/devices/block2mtd.c
drivers/mtd/maps/sbc_gxx.c
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
drivers/net/ethernet/microchip/encx24j600.c
drivers/net/fddi/defxx.c
drivers/net/ipvlan/ipvtap.c
drivers/net/macvtap.c
drivers/net/phy/sfp.c
drivers/net/tun.c
drivers/net/vmxnet3/vmxnet3_drv.c
drivers/net/wireless/marvell/mwifiex/main.c
drivers/net/wireless/rsi/rsi_91x_main.c
drivers/net/wireless/rsi/rsi_91x_sdio.c
drivers/nfc/nfcmrvl/uart.c
drivers/pcmcia/i82092.c
drivers/platform/x86/classmate-laptop.c
drivers/platform/x86/thinkpad_acpi.c
drivers/rpmsg/rpmsg_char.c
drivers/scsi/aic7xxx/aic7xxx_osm.c
drivers/scsi/arcmsr/arcmsr_hba.c
drivers/soc/fsl/dpio/dpio-driver.c
drivers/staging/gasket/apex_driver.c
drivers/staging/greybus/fw-core.c
drivers/staging/greybus/loopback.c
drivers/staging/greybus/raw.c
drivers/staging/greybus/uart.c
drivers/staging/unisys/visorhba/visorhba_main.c
drivers/staging/unisys/visornic/visornic_main.c
drivers/tty/rocket.c
drivers/tty/serial/kgdboc.c
drivers/tty/serial/owl-uart.c
drivers/usb/gadget/function/f_tcm.c
drivers/usb/gadget/function/u_serial.c
drivers/vhost/net.c
drivers/vhost/scsi.c
drivers/video/fbdev/aty/aty128fb.c
drivers/video/fbdev/geode/gx1fb_core.c
drivers/video/fbdev/gxt4500.c
drivers/video/fbdev/matrox/matroxfb_crtc2.c
drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
drivers/video/fbdev/nvidia/nvidia.c
drivers/video/fbdev/riva/fbdev.c
drivers/video/fbdev/sstfb.c
drivers/video/fbdev/uvesafb.c
drivers/virtio/virtio.c
drivers/watchdog/cpu5wdt.c
kernel/backtracetest.c
kernel/locking/locktorture.c
kernel/rcu/rcuperf.c
kernel/rcu/rcutorture.c
lib/interval_tree_test.c
lib/memory-notifier-error-inject.c
lib/netdev-notifier-error-inject.c
lib/of-reconfig-notifier-error-inject.c
lib/pm-notifier-error-inject.c
lib/raid6/algos.c
lib/test_ida.c
lib/test_xarray.c
mm/hwpoison-inject.c
net/9p/trans_xen.c
net/core/drop_monitor.c
net/l2tp/l2tp_netlink.c
net/netfilter/xt_NETMAP.c
net/openvswitch/datapath.c
net/rds/af_rds.c
net/rds/rdma_transport.c
net/rds/tcp.c
samples/connector/cn_test.c
samples/livepatch/livepatch-callbacks-busymod.c
samples/livepatch/livepatch-callbacks-demo.c
samples/livepatch/livepatch-callbacks-mod.c
samples/livepatch/livepatch-sample.c
samples/livepatch/livepatch-shadow-fix1.c
samples/livepatch/livepatch-shadow-fix2.c
samples/livepatch/livepatch-shadow-mod.c
