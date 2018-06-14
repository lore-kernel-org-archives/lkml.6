Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6582FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C7F208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgIF8y03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C7F208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbeFNR0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:26:50 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39891 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeFNR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:26:47 -0400
Received: by mail-ua0-f196.google.com with SMTP id n4-v6so4641918uad.6;
        Thu, 14 Jun 2018 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fN9h2PEhQHzf8JinoYr5NgVE/8yH668AsljLMT/YIPo=;
        b=BgIF8y03ZlQ4ba0z0GkB9zaT/5PuuDuC8adHjCDvSdCKi0I++06am04AGxwM+MNgHu
         rOyO+sJlf6KN+6zeL+TdfqvnYMrCahUl3FE8vOVawAcHWjkgidFJ8jjc4TIWVm++tMZP
         GH22KHLbwVQ8ys8hkVtOGQ5ZLdLyoSoEa497SSZ7yGby5aWaLZcIK2vK+738SZuMQ58k
         akdQq4jEhDNhsZotrWGej0w/BzZLPTl3yX6lNeUpcFbUWq9e+OgYAUA8i5uw3dB2M7Kh
         bnH5e8AG8hfHzeNQaiIJaNdVhe7pRf5T5nKKNLjCLJa+AYXIaC0V81i8BnpjQwjFybUW
         WEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fN9h2PEhQHzf8JinoYr5NgVE/8yH668AsljLMT/YIPo=;
        b=rZyOrYTESlFQOtuaqzmAPIx2nmOFywMyEgihTkE7Poq4MW9VBzcDDdLV6FpK5aYc+c
         1F8BuHw0Tj1e6GZKaHxyuoXEwdg+x0IZo/uqNm4pPK+zDshxYlvAIzA25+DgGVzuGh97
         NGNpkdfmtRIBaHVLf4F9x+DkY8WyHNswEixImFKxACPH2I7NCXAwh0i/NB0qGkbHolIF
         gcaciZn6d4QRbfWDK8hiCJF9TtBVG61mOeIW8efRc6MuAqvz+zsnkzLKWos3+Hk/iJCz
         ImQ+rsBIrBUMwDD0jJ0L/BFrSggRfH7icbL/RchT8dCwzdc1E4bsokQQo6BgHF12N1XM
         pdag==
X-Gm-Message-State: APt69E2p+wCvYgyyN4qlvVvgUaA5W8lmgoFIH8bNXku1dXB9/ana0cfJ
        b37/GxU06Oz2xLOP/N5L1Zpyk3eUlU8NrswmQ7k=
X-Google-Smtp-Source: ADUXVKL3CIuVdW3RBOmgwv34KkuYgt5Dcu6+p5bl8r//3dBArR70nQEXbHGJ3zqboxNG6hsairoa9cZoZIw1hL2hfJw=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr2451514uad.49.1528997206212;
 Thu, 14 Jun 2018 10:26:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 10:26:45
 -0700 (PDT)
In-Reply-To: <3b881313-d96c-0395-05f3-dd612b7e440f@gmail.com>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com> <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain> <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com> <3b881313-d96c-0395-05f3-dd612b7e440f@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 20:26:45 +0300
Message-ID: <CAHp75VctDOupi9Vk+njzj3U5G8BthwnaNqE=Y8mOhJLviFkYbA@mail.gmail.com>
Subject: Re: [PATCH v4] dcdbas: Add support for WSMT ACPI table
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mario Limonciello <mario_limonciello@dell.com>
Cc:     Darren Hart <dvhart@infradead.org>, Douglas_Warzecha@dell.com,
        Jared.Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 6:45 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> If the WSMT ACPI table is present and indicates that a fixed communication
> buffer should be used, use the firmware-specified buffer instead of
> allocating a buffer in memory for communications between the dcdbas driver
> and firmare.

Thanks for an update.

I answered to previous thread. The questions / comments are still
applicable here.

> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> v2 Bumped driver version to 5.6.0-3.3
> v3 Removed dependency on ACPI in Kconfig
>    Moved the added #include to be in alphabetical order
>    Added comments in smi_request_store()
>    Simplified checksum code
>    Changed loop searching 0xf0000 to be more readable
>    Reworked calculation of remap_size & smi_data_buf_size
> v4 Fixed comment that starts with "Calling Interface SMI"
>    Fixed formatting of first "if" statement in dcdbas_check_wsmt()
>
>
>  drivers/firmware/dcdbas.c | 118 +++++++++++++++++++++++++++++++++++++++++++---
>  drivers/firmware/dcdbas.h |  10 ++++
>  2 files changed, 122 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
> index 0bdea60c65dd..4cac70d05bfc 100644
> --- a/drivers/firmware/dcdbas.c
> +++ b/drivers/firmware/dcdbas.c
> @@ -21,6 +21,7 @@
>   */
>
>  #include <linux/platform_device.h>
> +#include <linux/acpi.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/errno.h>
>  #include <linux/cpu.h>
> @@ -41,7 +42,7 @@
>  #include "dcdbas.h"
>
>  #define DRIVER_NAME            "dcdbas"
> -#define DRIVER_VERSION         "5.6.0-3.2"
> +#define DRIVER_VERSION         "5.6.0-3.3"
>  #define DRIVER_DESCRIPTION     "Dell Systems Management Base Driver"
>
>  static struct platform_device *dcdbas_pdev;
> @@ -49,19 +50,23 @@ static struct platform_device *dcdbas_pdev;
>  static u8 *smi_data_buf;
>  static dma_addr_t smi_data_buf_handle;
>  static unsigned long smi_data_buf_size;
> +static unsigned long max_smi_data_buf_size = MAX_SMI_DATA_BUF_SIZE;
>  static u32 smi_data_buf_phys_addr;
>  static DEFINE_MUTEX(smi_data_lock);
> +static u8 *eps_buffer;
>
>  static unsigned int host_control_action;
>  static unsigned int host_control_smi_type;
>  static unsigned int host_control_on_shutdown;
>
> +static bool wsmt_enabled;
> +
>  /**
>   * smi_data_buf_free: free SMI data buffer
>   */
>  static void smi_data_buf_free(void)
>  {
> -       if (!smi_data_buf)
> +       if (!smi_data_buf || wsmt_enabled)
>                 return;
>
>         dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
> @@ -86,7 +91,7 @@ static int smi_data_buf_realloc(unsigned long size)
>         if (smi_data_buf_size >= size)
>                 return 0;
>
> -       if (size > MAX_SMI_DATA_BUF_SIZE)
> +       if (size > max_smi_data_buf_size)
>                 return -EINVAL;
>
>         /* new buffer is needed */
> @@ -169,7 +174,7 @@ static ssize_t smi_data_write(struct file *filp, struct kobject *kobj,
>  {
>         ssize_t ret;
>
> -       if ((pos + count) > MAX_SMI_DATA_BUF_SIZE)
> +       if ((pos + count) > max_smi_data_buf_size)
>                 return -EINVAL;
>
>         mutex_lock(&smi_data_lock);
> @@ -322,8 +327,15 @@ static ssize_t smi_request_store(struct device *dev,
>                         ret = count;
>                 break;
>         case 1:
> -               /* Calling Interface SMI */
> -               smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
> +               /*
> +                * Calling Interface SMI
> +                *
> +                * Provide physical address of command buffer field within
> +                * the struct smi_cmd... can't use virt_to_phys() on smi_cmd
> +                * because address may be from memremap().
> +                */
> +               smi_cmd->ebx = smi_data_buf_phys_addr +
> +                               offsetof(struct smi_cmd, command_buffer);
>                 ret = dcdbas_smi_request(smi_cmd);
>                 if (!ret)
>                         ret = count;
> @@ -482,6 +494,93 @@ static void dcdbas_host_control(void)
>         }
>  }
>
> +/* WSMT */
> +
> +static u8 checksum(u8 *buffer, u8 length)
> +{
> +       u8 sum = 0;
> +       u8 *end = buffer + length;
> +
> +       while (buffer < end)
> +               sum += *buffer++;
> +       return sum;
> +}
> +
> +static inline struct smm_eps_table *check_eps_table(u8 *addr)
> +{
> +       struct smm_eps_table *eps = (struct smm_eps_table *)addr;
> +
> +       if (strncmp(eps->smm_comm_buff_anchor, SMM_EPS_SIG, 4) != 0)
> +               return NULL;
> +
> +       if (checksum(addr, eps->length) != 0)
> +               return NULL;
> +
> +       return eps;
> +}
> +
> +static int dcdbas_check_wsmt(void)
> +{
> +       struct acpi_table_wsmt *wsmt = NULL;
> +       struct smm_eps_table *eps = NULL;
> +       u64 remap_size;
> +       u8 *addr;
> +
> +       acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
> +       if (!wsmt)
> +               return 0;
> +
> +       /* Check if WSMT ACPI table shows that protection is enabled */
> +       if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS) ||
> +           !(wsmt->protection_flags & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
> +               return 0;
> +
> +       /* Scan for EPS (entry point structure) */
> +       for (addr = (u8 *)__va(0xf0000);
> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
> +            addr += 1) {
> +               eps = check_eps_table(addr);
> +               if (eps)
> +                       break;
> +       }
> +
> +       if (!eps) {
> +               dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS found\n");
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * Get physical address of buffer and map to virtual address.
> +        * Table gives size in 4K pages, regardless of actual system page size.
> +        */
> +       if (upper_32_bits(eps->smm_comm_buff_addr + 8)) {
> +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer address is above 4GB\n");
> +               return -EINVAL;
> +       }
> +       /*
> +        * Limit remap size to MAX_SMI_DATA_BUF_SIZE + 8 (since the first 8
> +        * bytes are used for a semaphore, not the data buffer itself).
> +        */
> +       remap_size = eps->num_of_4k_pages * PAGE_SIZE;
> +       if (remap_size > MAX_SMI_DATA_BUF_SIZE + 8)
> +               remap_size = MAX_SMI_DATA_BUF_SIZE + 8;
> +       eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
> +       if (!eps_buffer) {
> +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map EPS buffer\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* First 8 bytes is for a semaphore, not part of the smi_data_buf */
> +       smi_data_buf_phys_addr = eps->smm_comm_buff_addr + 8;
> +       smi_data_buf = eps_buffer + 8;
> +       smi_data_buf_size = remap_size - 8;
> +       max_smi_data_buf_size = smi_data_buf_size;
> +       wsmt_enabled = true;
> +       dev_info(&dcdbas_pdev->dev,
> +                "WSMT found, using firmware-provided SMI buffer.\n");
> +       return 1;
> +}
> +
>  /**
>   * dcdbas_reboot_notify: handle reboot notification for host control
>   */
> @@ -548,6 +647,11 @@ static int dcdbas_probe(struct platform_device *dev)
>
>         dcdbas_pdev = dev;
>
> +       /* Check if ACPI WSMT table specifies protected SMI buffer address */
> +       error = dcdbas_check_wsmt();
> +       if (error < 0)
> +               return error;
> +
>         /*
>          * BIOS SMI calls require buffer addresses be in 32-bit address space.
>          * This is done by setting the DMA mask below.
> @@ -635,6 +739,8 @@ static void __exit dcdbas_exit(void)
>          */
>         if (dcdbas_pdev)
>                 smi_data_buf_free();
> +       if (eps_buffer)
> +               memunmap(eps_buffer);
>         platform_device_unregister(dcdbas_pdev_reg);
>         platform_driver_unregister(&dcdbas_driver);
>  }
> diff --git a/drivers/firmware/dcdbas.h b/drivers/firmware/dcdbas.h
> index ca3cb0a54ab6..52729a494b00 100644
> --- a/drivers/firmware/dcdbas.h
> +++ b/drivers/firmware/dcdbas.h
> @@ -53,6 +53,7 @@
>  #define EXPIRED_TIMER                          (0)
>
>  #define SMI_CMD_MAGIC                          (0x534D4931)
> +#define SMM_EPS_SIG                            "$SCB"
>
>  #define DCDBAS_DEV_ATTR_RW(_name) \
>         DEVICE_ATTR(_name,0600,_name##_show,_name##_store);
> @@ -103,5 +104,14 @@ struct apm_cmd {
>
>  int dcdbas_smi_request(struct smi_cmd *smi_cmd);
>
> +struct smm_eps_table {
> +       char smm_comm_buff_anchor[4];
> +       u8 length;
> +       u8 checksum;
> +       u8 version;
> +       u64 smm_comm_buff_addr;
> +       u64 num_of_4k_pages;
> +} __packed;
> +
>  #endif /* _DCDBAS_H_ */
>
> --
> 2.14.2
>



-- 
With Best Regards,
Andy Shevchenko
