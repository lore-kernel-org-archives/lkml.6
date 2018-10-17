Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30404ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D784221527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/6hUpdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D784221527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJQPPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:15:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41509 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbeJQPPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:15:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so23304469lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwzYng0iReT0nzgQGi2cZ+4md91xoAnHk++w/JLcWMI=;
        b=g/6hUpdR13Xd3HAv1t4UFWs6jGjqowJYtWKmk1zLkvCyAbH4RiDhUslkyu4Sd7DQdy
         5L8WCcCFX7NiT6fLXq72ePPY5eJd0HXik4TBXULthk3B1MP3fM0WlKG0nRuWXrbppGh2
         GUsn1tXzXQgsyJ5LwEtw5dVYBxUuZMlZXCTy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwzYng0iReT0nzgQGi2cZ+4md91xoAnHk++w/JLcWMI=;
        b=Lfrv5BtX23pkpDQpPKwZwDcsNRnxoQZDDGrZUwjNGWYfVHpspq6BKdOnBLh703HGSz
         RyMLha0kdZJr/DGOuWdjxsa3R0p50TyIMjsHRLCcDochE8iZPkLvRiREwtCO8hMS7n07
         EdiPncfDJNZ5ZBeii6HfSkCk80Sb6uXG67vxDuQlwhcRJYN7l2lm+U7UaeNnOemG8/+K
         m0HhTG/qKPKfTUyqChT+y+Wvb8ay1Fz+BA/Ca9wUumSI8sXedFuvL/L/F4WjEYvz0V9w
         eVccFPgTdCJsQhBs2p1ChPQvFlTbsXdAnnBX9/kSPBs2zW0bTHPuQDLp2x3lhozxP++K
         PTXg==
X-Gm-Message-State: ABuFfoioXhHGa7fQOjZaTR4t7JQobtXKTHWqE5IrvEq5ZHHZcn8/PQNE
        JgjTZ4U6tHfh/nqTd/pHnN8t+RR0kNYMaSF7z7Us74m0
X-Google-Smtp-Source: ACcGV60lQ5053TlNuh08uoQNhwACvlfABydgWHYdMpDoNOHYuFQ0Tz0q+GUprVbtzMYWHR5bfxh8g4UmJM8SEsDSeH0=
X-Received: by 2002:a2e:1642:: with SMTP id 2-v6mr16005590ljw.56.1539760878787;
 Wed, 17 Oct 2018 00:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181016170539.315587743@linuxfoundation.org>
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 17 Oct 2018 12:50:42 +0530
Message-ID: <CAMi1Hd1SzkvCWsap+zYFrZ=mPtRN2V+NoaNFr89Z84+NqwTgvw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/71] 4.9.134-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Oct 2018 at 22:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.134 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
<snip> ..

> Paul Burton <paul.burton@mips.com>
>     MIPS: VDSO: Always map near top of user memory

This patch broke stable-rc/linux-4.9.y build on kernelci
https://kernelci.org/build/stable-rc/branch/linux-4.9.y/kernel/v4.9.133-72-gda849e5647be/,
mostly because of missing mips_gic_present() definition. It is added
in 582e2b4aecda ("MIPS: GIC: Introduce asm/mips-gic.h with accessor
functions"), which need to be backported too because it doesn't apply
cleanly on linux-4.9.y.

Regards,
Amit Pundir

>
> Jann Horn <jannh@google.com>
>     mm/vmstat.c: fix outdated vmstat_text
>
> Daniel Rosenberg <drosen@google.com>
>     ext4: Fix error code in ext4_xattr_set_entry()
>
> Amber Lin <Amber.Lin@amd.com>
>     drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7
>
> Vitaly Kuznetsov <vkuznets@redhat.com>
>     x86/kvm/lapic: always disable MMIO interface in x2APIC mode
>
> Nicolas Ferre <nicolas.ferre@microchip.com>
>     ARM: dts: at91: add new compatibility string for macb on sama5d3
>
> Nicolas Ferre <nicolas.ferre@microchip.com>
>     net: macb: disable scatter-gather for macb on sama5d3
>
> Jongsung Kim <neidhard.kim@lge.com>
>     stmmac: fix valid numbers of unicast filter entries
>
> Yu Zhao <yuzhao@google.com>
>     sound: enable interrupt after dma buffer initialization
>
> Dan Carpenter <dan.carpenter@oracle.com>
>     scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()
>
> Laura Abbott <labbott@redhat.com>
>     scsi: iscsi: target: Don't use stack buffer for scatterlist
>
> Tony Lindgren <tony@atomide.com>
>     mfd: omap-usb-host: Fix dts probe of children
>
> Lei Yang <Lei.Yang@windriver.com>
>     selftests: memory-hotplug: add required configs
>
> Lei Yang <Lei.Yang@windriver.com>
>     selftests/efivarfs: add required kernel configs
>
> Danny Smith <danny.smith@axis.com>
>     ASoC: sigmadsp: safeload should not have lower byte limit
>
> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>     ASoC: wm8804: Add ACPI support
>
>
> -------------
>
> Diffstat:
>
>  Documentation/devicetree/bindings/net/macb.txt     |   1 +
>  Documentation/networking/ip-sysctl.txt             |  13 +-
>  Makefile                                           |   4 +-
>  arch/arm/boot/dts/sama5d3_emac.dtsi                |   2 +-
>  arch/mips/include/asm/processor.h                  |  10 +-
>  arch/mips/kernel/process.c                         |  25 +
>  arch/mips/kernel/vdso.c                            |  18 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h       |   4 +-
>  arch/x86/include/asm/pgtable_types.h               |   2 +-
>  arch/x86/include/uapi/asm/kvm.h                    |   1 +
>  arch/x86/kvm/lapic.c                               |  22 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   2 +-
>  drivers/i2c/busses/i2c-scmi.c                      |   1 +
>  drivers/mfd/omap-usb-host.c                        |  11 +-
>  drivers/net/bonding/bond_main.c                    |  43 +-
>  drivers/net/dsa/bcm_sf2.c                          |  12 +-
>  drivers/net/ethernet/broadcom/bcmsysport.c         |  22 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  13 +-
>  drivers/net/ethernet/cadence/macb.c                |   8 +
>  drivers/net/ethernet/hisilicon/hns/hnae.c          |   2 +-
>  drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  30 +-
>  drivers/net/ethernet/marvell/mvpp2.c               |  10 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   8 +-
>  .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   3 +-
>  .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   3 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |   3 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  12 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   5 +-
>  drivers/net/team/team.c                            |   5 +
>  drivers/net/usb/qmi_wwan.c                         |   1 +
>  drivers/net/usb/smsc75xx.c                         |   1 +
>  drivers/scsi/qla2xxx/qla_target.h                  |   4 +-
>  drivers/target/iscsi/iscsi_target.c                |  22 +-
>  drivers/usb/host/xhci-hub.c                        |  18 +-
>  drivers/video/fbdev/aty/atyfb.h                    |   3 +-
>  drivers/video/fbdev/aty/atyfb_base.c               |   7 +-
>  drivers/video/fbdev/aty/mach64_ct.c                |  10 +-
>  fs/ext4/xattr.c                                    |   2 +-
>  include/linux/netdevice.h                          |   7 +
>  include/linux/rhashtable.h                         |   4 +-
>  include/linux/skbuff.h                             |  34 +-
>  include/net/bonding.h                              |   7 +-
>  include/net/inet_frag.h                            | 133 +++--
>  include/net/inet_sock.h                            |   6 -
>  include/net/ip.h                                   |   1 -
>  include/net/ip_fib.h                               |   1 +
>  include/net/ipv6.h                                 |  26 +-
>  include/uapi/linux/snmp.h                          |   1 +
>  lib/rhashtable.c                                   |   5 +-
>  mm/vmstat.c                                        |   1 -
>  net/core/dev.c                                     |  28 +-
>  net/core/rtnetlink.c                               |   6 +
>  net/core/skbuff.c                                  |  31 +-
>  net/dccp/input.c                                   |   4 +-
>  net/dccp/ipv4.c                                    |   4 +-
>  net/ieee802154/6lowpan/6lowpan_i.h                 |  26 +-
>  net/ieee802154/6lowpan/reassembly.c                | 148 +++---
>  net/ipv4/fib_frontend.c                            |  12 +-
>  net/ipv4/fib_semantics.c                           |  50 ++
>  net/ipv4/inet_connection_sock.c                    |   5 +-
>  net/ipv4/inet_fragment.c                           | 379 +++-----------
>  net/ipv4/ip_fragment.c                             | 573 ++++++++++++---------
>  net/ipv4/ip_sockglue.c                             |   3 +-
>  net/ipv4/ip_tunnel.c                               |   9 +
>  net/ipv4/proc.c                                    |   7 +-
>  net/ipv4/tcp_input.c                               |  37 +-
>  net/ipv4/tcp_ipv4.c                                |   4 +-
>  net/ipv6/addrconf.c                                |   4 +-
>  net/ipv6/ip6_tunnel.c                              |  13 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c            | 100 ++--
>  net/ipv6/proc.c                                    |   5 +-
>  net/ipv6/raw.c                                     |  29 +-
>  net/ipv6/reassembly.c                              | 212 ++++----
>  net/netlabel/netlabel_unlabeled.c                  |   3 +-
>  sound/hda/hdac_controller.c                        |   8 +-
>  sound/soc/codecs/sigmadsp.c                        |   3 +-
>  sound/soc/codecs/wm8804-i2c.c                      |  15 +-
>  tools/perf/scripts/python/export-to-postgresql.py  |   9 +
>  tools/testing/selftests/efivarfs/config            |   1 +
>  tools/testing/selftests/memory-hotplug/config      |   1 +
>  80 files changed, 1185 insertions(+), 1133 deletions(-)
>
>
