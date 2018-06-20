Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A1BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0678A20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOR7k1ST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0678A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeFTNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:46:08 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35360 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbeFTNqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:46:05 -0400
Received: by mail-ua0-f193.google.com with SMTP id s13-v6so2169988uad.2;
        Wed, 20 Jun 2018 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rTnkHF6nLukZCMcmciqq/FwPEYLfyeGwT33kWnPRWZU=;
        b=hOR7k1STHe+j4K/Qoq+wXy5udDka8m8BMeh0xMeJmXsX1u/+R3kuQZEjt73ruofjI5
         cy74JQTBo56PyirJdY0dBUMPrnTeV7mfL4VNTZdPxn25uUJQEYx6ZYwS8YSkPlwqh/Fq
         qscJqbFaAXVWOa/XR4FWPGqwiuyYe8kqQoSApJx1bf/p3cUH1uS/ihksPr4syUHiu7p0
         64U/NdQW4e0QlmvtUv/9e94rZSGUzDSsVMs1L+39qiWxdRCPBNZvmrJK3Kdw5JZ/VfrM
         xm9voTiSI2K8Gk/SBC0pzqQccsAnno1G7Lt8sfDZFpej9r7rMxs3di13o+pskdMb3WBI
         ze/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rTnkHF6nLukZCMcmciqq/FwPEYLfyeGwT33kWnPRWZU=;
        b=UaCK6j/kGfH9JjY13yHgdvASy5oSl8qr7YRSDKYkr0TTRgTmEYhOkahVlPUbystMF1
         r8lX6AEhXimrai5kTIinQUO8x2ho+8ZA5n7r2SMTSZ1YipUD+fdttz7Lt1AjXLdXxmrw
         Wgz+NQDloWA95SWJWyZ6CsVBTbTHxxe/wbhgMVlyLX8D1QrqHiF327v6ryvdwti6N6jj
         BoA0HXCqDcv2AKIZBbRkR5OAFvDy1R5sr3oi0Ez0tqOpYMO2Ofa+ETcd3uE8A833DEe7
         jQV0XjsuH1l0NLoy7TnTWn6p632uZw9Thgdn2t5SOCXzYhWD8VxHfp4C3VVBP4dnX6MY
         LMiQ==
X-Gm-Message-State: APt69E2LwuGf5reN9NxCEezAcK4R11LSpDZ1Z0Ep/NhedZFqk1iZUlML
        qHjah5hEWfs1PiBVnfrMtdpoP6VBa+tnFyRwWi8=
X-Google-Smtp-Source: ADUXVKJVW+L2GvuvBne+wD4IuuUH/oolw5Z21H5qXWo3b3WrkRg+WA2nBZ3aOtOszHthvHbnpD9TWrFVzaQm3akphRM=
X-Received: by 2002:ab0:6008:: with SMTP id j8-v6mr13349191ual.28.1529502363923;
 Wed, 20 Jun 2018 06:46:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 06:46:02
 -0700 (PDT)
In-Reply-To: <1528164985-14099-1-git-send-email-okaya@codeaurora.org>
References: <1528164985-14099-1-git-send-email-okaya@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jun 2018 16:46:02 +0300
Message-ID: <CAHp75VekLHxB43b=7jCvuqhibz8ynfQGhwFXHkM+0orNCETjVA@mail.gmail.com>
Subject: Re: [PATCH V4] PCI: move early dump functionality from x86 arch into
 the common code
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 5:16 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.
>

It didn't break my setup on x86 at least. Thus,

Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/x86/include/asm/pci-direct.h               |  4 ---
>  arch/x86/kernel/setup.c                         |  5 ---
>  arch/x86/pci/common.c                           |  4 ---
>  arch/x86/pci/early.c                            | 44 -------------------------
>  drivers/pci/pci.c                               |  5 +++
>  drivers/pci/pci.h                               |  1 +
>  drivers/pci/probe.c                             | 19 +++++++++++
>  8 files changed, 26 insertions(+), 58 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e490902..e64f1d8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2995,7 +2995,7 @@
>                         See also Documentation/blockdev/paride.txt.
>
>         pci=option[,option...]  [PCI] various PCI subsystem options:
> -               earlydump       [X86] dump PCI config space before the kernel
> +               earlydump       dump PCI config space before the kernel
>                                 changes anything
>                 off             [X86] don't probe for the PCI bus
>                 bios            [X86-32] force use of PCI BIOS, don't access
> diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
> index e1084f7..94597a3 100644
> --- a/arch/x86/include/asm/pci-direct.h
> +++ b/arch/x86/include/asm/pci-direct.h
> @@ -15,8 +15,4 @@ extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
>  extern void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val);
>
>  extern int early_pci_allowed(void);
> -
> -extern unsigned int pci_early_dump_regs;
> -extern void early_dump_pci_device(u8 bus, u8 slot, u8 func);
> -extern void early_dump_pci_devices(void);
>  #endif /* _ASM_X86_PCI_DIRECT_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 2f86d88..480f250 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -991,11 +991,6 @@ void __init setup_arch(char **cmdline_p)
>                 setup_clear_cpu_cap(X86_FEATURE_APIC);
>         }
>
> -#ifdef CONFIG_PCI
> -       if (pci_early_dump_regs)
> -               early_dump_pci_devices();
> -#endif
> -
>         e820__reserve_setup_data();
>         e820__finish_early_params();
>
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 563049c..d4ec117 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -22,7 +22,6 @@
>  unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
>                                 PCI_PROBE_MMCONF;
>
> -unsigned int pci_early_dump_regs;
>  static int pci_bf_sort;
>  int pci_routeirq;
>  int noioapicquirk;
> @@ -599,9 +598,6 @@ char *__init pcibios_setup(char *str)
>                 pci_probe |= PCI_BIG_ROOT_WINDOW;
>                 return NULL;
>  #endif
> -       } else if (!strcmp(str, "earlydump")) {
> -               pci_early_dump_regs = 1;
> -               return NULL;
>         } else if (!strcmp(str, "routeirq")) {
>                 pci_routeirq = 1;
>                 return NULL;
> diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
> index e5f753c..f5fc953 100644
> --- a/arch/x86/pci/early.c
> +++ b/arch/x86/pci/early.c
> @@ -57,47 +57,3 @@ int early_pci_allowed(void)
>                         PCI_PROBE_CONF1;
>  }
>
> -void early_dump_pci_device(u8 bus, u8 slot, u8 func)
> -{
> -       u32 value[256 / 4];
> -       int i;
> -
> -       pr_info("pci 0000:%02x:%02x.%d config space:\n", bus, slot, func);
> -
> -       for (i = 0; i < 256; i += 4)
> -               value[i / 4] = read_pci_config(bus, slot, func, i);
> -
> -       print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value, 256, false);
> -}
> -
> -void early_dump_pci_devices(void)
> -{
> -       unsigned bus, slot, func;
> -
> -       if (!early_pci_allowed())
> -               return;
> -
> -       for (bus = 0; bus < 256; bus++) {
> -               for (slot = 0; slot < 32; slot++) {
> -                       for (func = 0; func < 8; func++) {
> -                               u32 class;
> -                               u8 type;
> -
> -                               class = read_pci_config(bus, slot, func,
> -                                                       PCI_CLASS_REVISION);
> -                               if (class == 0xffffffff)
> -                                       continue;
> -
> -                               early_dump_pci_device(bus, slot, func);
> -
> -                               if (func == 0) {
> -                                       type = read_pci_config_byte(bus, slot,
> -                                                                   func,
> -                                                              PCI_HEADER_TYPE);
> -                                       if (!(type & 0x80))
> -                                               break;
> -                               }
> -                       }
> -               }
> -       }
> -}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 97acba7..04052dc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -115,6 +115,9 @@ static bool pcie_ari_disabled;
>  /* If set, the PCIe ATS capability will not be used. */
>  static bool pcie_ats_disabled;
>
> +/* If set, the PCI config space of each device is printed during boot. */
> +bool pci_early_dump;
> +
>  bool pci_ats_disabled(void)
>  {
>         return pcie_ats_disabled;
> @@ -5805,6 +5808,8 @@ static int __init pci_setup(char *str)
>                                 pcie_ats_disabled = true;
>                         } else if (!strcmp(str, "noaer")) {
>                                 pci_no_aer();
> +                       } else if (!strcmp(str, "earlydump")) {
> +                               pci_early_dump = true;
>                         } else if (!strncmp(str, "realloc=", 8)) {
>                                 pci_realloc_get_opt(str + 8);
>                         } else if (!strncmp(str, "realloc", 7)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c358e7a0..c33265e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -7,6 +7,7 @@
>  #define PCI_VSEC_ID_INTEL_TBT  0x1234  /* Thunderbolt */
>
>  extern const unsigned char pcie_link_speed[];
> +extern bool pci_early_dump;
>
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 56771f3..3678f0a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1545,6 +1545,23 @@ static int pci_intx_mask_broken(struct pci_dev *dev)
>         return 0;
>  }
>
> +static void early_dump_pci_device(struct pci_dev *pdev)
> +{
> +       u32 value[256 / 4];
> +       int i;
> +
> +       if (!pci_early_dump)
> +               return;
> +
> +       pci_info(pdev, "config space:\n");
> +
> +       for (i = 0; i < 256; i += 4)
> +               pci_read_config_dword(pdev, i, &value[i / 4]);
> +
> +       print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
> +                      256, false);
> +}
> +
>  /**
>   * pci_setup_device - Fill in class and map information of a device
>   * @dev: the device structure to fill
> @@ -1594,6 +1611,8 @@ int pci_setup_device(struct pci_dev *dev)
>         pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
>                    dev->vendor, dev->device, dev->hdr_type, dev->class);
>
> +       early_dump_pci_device(dev);
> +
>         /* Need to have dev->class ready */
>         dev->cfg_size = pci_cfg_space_size(dev);
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
