Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10623C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982B021473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/sjOq04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982B021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJRPgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:36:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41425 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJRPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:36:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id 23-v6so18155210qkh.8;
        Thu, 18 Oct 2018 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50C6jMl669IOdyegGGlU2mP1btKwnUnzNIzrgUk9pik=;
        b=G/sjOq04/T3H5Bn3wPFw5JE5uES1S+pI6UjP9UtJo+j48OwDybq4xKF98hvpT1prbc
         USlgS47deWQof90YbWlnl+mvv/IzGX16fKJrHHqSNxny/HrRuAbaElU3EImyRnQpBPQx
         84I9USFr0V1iPtVdXY8GLWgFNMH9gYBzv0cgVs8RfhYG+g9WPifAy2dYd0Et6rJqLkGH
         UikSHc1tut9DRINzarZfsSTN+08m5b4DqeE+lMOZ6y1xNL/RzzquGfuypnXZ2CWjOLNV
         obOVyruC21lKjV2Q1nsG3HVTMEfj1Mt1I9KxQEEtzg/Yh/vcHFBvHBlTxYMWZO+6mQVF
         vqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50C6jMl669IOdyegGGlU2mP1btKwnUnzNIzrgUk9pik=;
        b=bVJdd53+D3LfW3imdFjYga3wqqGDhjnCcQdJTbJsAXI4emGO5cnTKvbM/777HSKjCy
         yLilxElrnQJj/2qUAlazPpgIRknXJf/yoKzHUwHKKtJUNYTW91/bgMt7X3Y3Wllsyh63
         1Df+Eq9moZTbr089HWt7rVoiv2BrOnZma6RYBkyc6B4uKvuPaole1xFFuBIs/rD5U0rn
         92F7DEyxQdXzS1xqXVGq7e5yHb5e0YGjgR8Njmjkv9vbi5Ifmpe/OsFpDvgvhRX1wNzj
         MhoQFVoAvFdO9qOw627YvmgEjkM+U4kCbcl1JXs+jGlCIyeMH0qBKPV6XrvB1VIGRDhq
         7LCA==
X-Gm-Message-State: ABuFfoiWhABb5qw45N0TTDtMg71ftua6RIL1QcHRmyj/W03XVFAMGwDT
        zs+RaTFqkmsa5slnv9FUABzLSChJH5R2AB//jic=
X-Google-Smtp-Source: ACcGV63UXROUzCIe5ssNROtwpOw/T+JtF7Bexxps1PWM6Ah+ICRxpEyL+MdimmkvG29yKC5CY5ruR7ucx3UH2K9UYAY=
X-Received: by 2002:ae9:f40b:: with SMTP id y11-v6mr28344591qkl.137.1539848183782;
 Thu, 18 Oct 2018 00:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180923144510.4564-1-hdegoede@redhat.com> <20180923144510.4564-2-hdegoede@redhat.com>
 <CAJZ5v0iu5eikTw3wOK7wHOVe+xHTv5xPTnQELEyA2oF8sL3S=g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iu5eikTw3wOK7wHOVe+xHTv5xPTnQELEyA2oF8sL3S=g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Oct 2018 10:36:11 +0300
Message-ID: <CAHp75VccCQ3ey3kRpE35BDkjjFZtdYiHZ+caSVcviCd-fY71bA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Sep 23, 2018 at 4:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > On some BYT/CHT systems the SoC's P-Unit shares the I2C bus with the
> > kernel. The P-Unit has a semaphore for the PMIC bus which we can take to
> > block it from accessing the shared bus while the kernel wants to access it.
> >
> > Currently we have the I2C-controller driver acquiring and releasing the
> > semaphore around each I2C transfer. There are 2 problems with this:
> >
> > 1) PMIC accesses often come in the form of a read-modify-write on one of
> > the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
> > between the read and the write. If the P-Unit modifies the register during
> > this window?, then we end up overwriting the P-Unit's changes.
> > I believe that this is mostly an academic problem, but I'm not sure.
> >
> > 2) To safely access the shared I2C bus, we need to do 3 things:
> > a) Notify the GPU driver that we are starting a window in which it may not
> > access the P-Unit, since the P-Unit seems to ignore the semaphore for
> > explicit power-level requests made by the GPU driver
> > b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
> > C6/C7 while we hold the semaphore hangs the SoC
> > c) Finally take the P-Unit's PMIC bus semaphore
> > All 3 these steps together are somewhat expensive, so ideally if we have
> > a bunch of i2c transfers grouped together we only do this once for the
> > entire group.
> >
> > Taking the read-modify-write on a PMIC register as example then ideally we
> > would only do all 3 steps once at the beginning and undo all 3 steps once
> > at the end.
> >
> > For this we need to be able to take the semaphore from within e.g. the PMIC
> > opregion driver, yet we do not want to remove the taking of the semaphore
> > from the I2C-controller driver, as that is still necessary to protect many
> > other code-paths leading to accessing the shared I2C bus.
> >
> > This means that we first have the PMIC driver acquire the semaphore and
> > then have the I2C controller driver trying to acquire it again.
> >
> > To make this possible this commit does the following:
> >
> > 1) Move the semaphore code from being private to the I2C controller driver
> > into the generic iosf_mbi code, which already has other code to deal with
> > the shared bus so that it can be accessed outside of the I2C bus driver.
> >
> > 2) Rework the code so that it can be called multiple times nested, while
> > still blocking I2C accesses while e.g. the GPU driver has indicated the
> > P-Unit needs the bus through a iosf_mbi_punit_acquire() call.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> If there are no objections or concerns regarding this patch, I'm
> inclined to take the entire series including it.

Please, go ahead, it looks good to me.
Thanks!

>
> > ---
> > Note this commit deliberately limits the i2c-designware changes to
> > only touch i2c-designware-baytrail.c, deliberately not doing some cleanups
> > which become possible after removing the semaphore code from the
> > i2c-designmware code. This is done so that this commit can be merged
> > through the x86 tree without causing conflicts in the i2c tree.
> >
> > The cleanups to the i2c-designware tree will be done in a follow up
> > patch which can be merged once this commit is in place.
> > ---
> >  arch/x86/include/asm/iosf_mbi.h              |  39 +++--
> >  arch/x86/platform/intel/iosf_mbi.c           | 161 +++++++++++++++++--
> >  drivers/i2c/busses/i2c-designware-baytrail.c | 125 +-------------
> >  3 files changed, 180 insertions(+), 145 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
> > index 3de0489deade..5270ff39b9af 100644
> > --- a/arch/x86/include/asm/iosf_mbi.h
> > +++ b/arch/x86/include/asm/iosf_mbi.h
> > @@ -105,8 +105,10 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask);
> >   * the PMIC bus while another driver is also accessing the PMIC bus various bad
> >   * things happen.
> >   *
> > - * To avoid these problems this function must be called before accessing the
> > - * P-Unit or the PMIC, be it through iosf_mbi* functions or through other means.
> > + * Call this function before sending requests to the P-Unit which may make it
> > + * access the PMIC, be it through iosf_mbi* functions or through other means.
> > + * This function will block all kernel access to the PMIC I2C bus, so that the
> > + * P-Unit can safely access the PMIC over the shared I2C bus.
> >   *
> >   * Note on these systems the i2c-bus driver will request a sempahore from the
> >   * P-Unit for exclusive access to the PMIC bus when i2c drivers are accessing
> > @@ -122,6 +124,31 @@ void iosf_mbi_punit_acquire(void);
> >   */
> >  void iosf_mbi_punit_release(void);
> >
> > +/**
> > + * iosf_mbi_block_punit_i2c_access() - Block P-Unit accesses to the PMIC bus
> > + *
> > + * Call this function to block P-Unit access to the PMIC I2C bus, so that the
> > + * kernel can safely access the PMIC over the shared I2C bus.
> > + *
> > + * This function acquires the P-Unit bus semaphore and notifies
> > + * pmic_bus_access_notifier listeners that they may no longer access the
> > + * P-Unit in a way which may cause it to access the shared I2C bus.
> > + *
> > + * Note this function may be called multiple times and the bus will not
> > + * be released until iosf_mbi_unblock_punit_i2c_access() has been called the
> > + * same amount of times.
> > + *
> > + * Return: Nonzero on error
> > + */
> > +int iosf_mbi_block_punit_i2c_access(void);
> > +
> > +/*
> > + * iosf_mbi_unblock_punit_i2c_access() - Release PMIC I2C bus block
> > + *
> > + * Release i2c access block gotten through iosf_mbi_block_punit_i2c_access().
> > + */
> > +void iosf_mbi_unblock_punit_i2c_access(void);
> > +
> >  /**
> >   * iosf_mbi_register_pmic_bus_access_notifier - Register PMIC bus notifier
> >   *
> > @@ -158,14 +185,6 @@ int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb);
> >  int iosf_mbi_unregister_pmic_bus_access_notifier_unlocked(
> >         struct notifier_block *nb);
> >
> > -/**
> > - * iosf_mbi_call_pmic_bus_access_notifier_chain - Call PMIC bus notifier chain
> > - *
> > - * @val: action to pass into listener's notifier_call function
> > - * @v: data pointer to pass into listener's notifier_call function
> > - */
> > -int iosf_mbi_call_pmic_bus_access_notifier_chain(unsigned long val, void *v);
> > -
> >  /**
> >   * iosf_mbi_assert_punit_acquired - Assert that the P-Unit has been acquired.
> >   */
> > diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
> > index 6f37a2137a79..5623a315f004 100644
> > --- a/arch/x86/platform/intel/iosf_mbi.c
> > +++ b/arch/x86/platform/intel/iosf_mbi.c
> > @@ -18,12 +18,14 @@
> >   * enumerate the device using PCI.
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/pci.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/capability.h>
> > +#include <linux/pm_qos.h>
> >
> >  #include <asm/iosf_mbi.h>
> >
> > @@ -34,8 +36,8 @@
> >
> >  static struct pci_dev *mbi_pdev;
> >  static DEFINE_SPINLOCK(iosf_mbi_lock);
> > -static DEFINE_MUTEX(iosf_mbi_punit_mutex);
> > -static BLOCKING_NOTIFIER_HEAD(iosf_mbi_pmic_bus_access_notifier);
> > +
> > +/**************** Generic iosf_mbi access helpers ****************/
> >
> >  static inline u32 iosf_mbi_form_mcr(u8 op, u8 port, u8 offset)
> >  {
> > @@ -192,6 +194,30 @@ bool iosf_mbi_available(void)
> >  }
> >  EXPORT_SYMBOL(iosf_mbi_available);
> >
> > +/*
> > + **************** PUNIT/kernel shared i2c bus arbritration ****************
> > + *
> > + * Some Bay Trail and Cherry Trail devices have the PUNIT and us (the kernel)
> > + * share a single I2C bus to the PMIC. Below are helpers to arbitrate the
> > + * accesses between the kernel and the PUNIT.
> > + *
> > + * See arch/x86/include/asm/iosf_mbi.h for kernel-doc text for each function.
> > + */
> > +
> > +#define SEMAPHORE_TIMEOUT              500
> > +#define PUNIT_SEMAPHORE_BYT            0x7
> > +#define PUNIT_SEMAPHORE_CHT            0x10e
> > +#define PUNIT_SEMAPHORE_BIT            BIT(0)
> > +#define PUNIT_SEMAPHORE_ACQUIRE                BIT(1)
> > +
> > +static DEFINE_MUTEX(iosf_mbi_punit_mutex);
> > +static DEFINE_MUTEX(iosf_mbi_block_punit_i2c_access_count_mutex);
> > +static BLOCKING_NOTIFIER_HEAD(iosf_mbi_pmic_bus_access_notifier);
> > +static u32 iosf_mbi_block_punit_i2c_access_count;
> > +static u32 iosf_mbi_sem_address;
> > +static unsigned long iosf_mbi_sem_acquired;
> > +static struct pm_qos_request iosf_mbi_pm_qos;
> > +
> >  void iosf_mbi_punit_acquire(void)
> >  {
> >         mutex_lock(&iosf_mbi_punit_mutex);
> > @@ -204,6 +230,113 @@ void iosf_mbi_punit_release(void)
> >  }
> >  EXPORT_SYMBOL(iosf_mbi_punit_release);
> >
> > +static int iosf_mbi_get_sem(u32 *sem)
> > +{
> > +       int ret;
> > +
> > +       ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > +                           iosf_mbi_sem_address, sem);
> > +       if (ret) {
> > +               dev_err(&mbi_pdev->dev, "Error punit semaphore read failed\n");
> > +               return ret;
> > +       }
> > +
> > +       *sem &= PUNIT_SEMAPHORE_BIT;
> > +       return 0;
> > +}
> > +
> > +static void iosf_mbi_reset_semaphore(void)
> > +{
> > +       if (iosf_mbi_modify(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > +                           iosf_mbi_sem_address, 0, PUNIT_SEMAPHORE_BIT))
> > +               dev_err(&mbi_pdev->dev, "Error punit semaphore reset failed\n");
> > +
> > +       pm_qos_update_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
> > +
> > +       blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
> > +                                    MBI_PMIC_BUS_ACCESS_END, NULL);
> > +       mutex_unlock(&iosf_mbi_punit_mutex);
> > +}
> > +
> > +int iosf_mbi_block_punit_i2c_access(void)
> > +{
> > +       unsigned long start, end;
> > +       int ret = 0;
> > +       u32 sem;
> > +
> > +       if (WARN_ON(!mbi_pdev || !iosf_mbi_sem_address))
> > +               return -ENXIO;
> > +
> > +       mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> > +
> > +       if (iosf_mbi_block_punit_i2c_access_count > 0)
> > +               goto out;
> > +
> > +       mutex_lock(&iosf_mbi_punit_mutex);
> > +       blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
> > +                                    MBI_PMIC_BUS_ACCESS_BEGIN, NULL);
> > +
> > +       /*
> > +        * Disallow the CPU to enter C6 or C7 state, entering these states
> > +        * requires the punit to talk to the pmic and if this happens while
> > +        * we're holding the semaphore, the SoC hangs.
> > +        */
> > +       pm_qos_update_request(&iosf_mbi_pm_qos, 0);
> > +
> > +       /* host driver writes to side band semaphore register */
> > +       ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> > +                            iosf_mbi_sem_address, PUNIT_SEMAPHORE_ACQUIRE);
> > +       if (ret) {
> > +               dev_err(&mbi_pdev->dev, "Error punit semaphore request failed\n");
> > +               goto out;
> > +       }
> > +
> > +       /* host driver waits for bit 0 to be set in semaphore register */
> > +       start = jiffies;
> > +       end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
> > +       do {
> > +               ret = iosf_mbi_get_sem(&sem);
> > +               if (!ret && sem) {
> > +                       iosf_mbi_sem_acquired = jiffies;
> > +                       dev_dbg(&mbi_pdev->dev, "punit semaphore acquired after %ums\n",
> > +                               jiffies_to_msecs(jiffies - start));
> > +                       goto out; /* Success, done. */
> > +               }
> > +
> > +               usleep_range(1000, 2000);
> > +       } while (time_before(jiffies, end));
> > +
> > +       ret = -ETIMEDOUT;
> > +       dev_err(&mbi_pdev->dev, "Error punit semaphore timed out, resetting\n");
> > +       iosf_mbi_reset_semaphore();
> > +
> > +       if (!iosf_mbi_get_sem(&sem))
> > +               dev_err(&mbi_pdev->dev, "PUNIT SEM: %d\n", sem);
> > +out:
> > +       if (!WARN_ON(ret))
> > +               iosf_mbi_block_punit_i2c_access_count++;
> > +
> > +       mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(iosf_mbi_block_punit_i2c_access);
> > +
> > +void iosf_mbi_unblock_punit_i2c_access(void)
> > +{
> > +       mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> > +
> > +       iosf_mbi_block_punit_i2c_access_count--;
> > +       if (iosf_mbi_block_punit_i2c_access_count == 0) {
> > +               iosf_mbi_reset_semaphore();
> > +               dev_dbg(&mbi_pdev->dev, "punit semaphore held for %ums\n",
> > +                       jiffies_to_msecs(jiffies - iosf_mbi_sem_acquired));
> > +       }
> > +
> > +       mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> > +}
> > +EXPORT_SYMBOL(iosf_mbi_unblock_punit_i2c_access);
> > +
> >  int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb)
> >  {
> >         int ret;
> > @@ -241,19 +374,14 @@ int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL(iosf_mbi_unregister_pmic_bus_access_notifier);
> >
> > -int iosf_mbi_call_pmic_bus_access_notifier_chain(unsigned long val, void *v)
> > -{
> > -       return blocking_notifier_call_chain(
> > -                               &iosf_mbi_pmic_bus_access_notifier, val, v);
> > -}
> > -EXPORT_SYMBOL(iosf_mbi_call_pmic_bus_access_notifier_chain);
> > -
> >  void iosf_mbi_assert_punit_acquired(void)
> >  {
> >         WARN_ON(!mutex_is_locked(&iosf_mbi_punit_mutex));
> >  }
> >  EXPORT_SYMBOL(iosf_mbi_assert_punit_acquired);
> >
> > +/**************** iosf_mbi debug code ****************/
> > +
> >  #ifdef CONFIG_IOSF_MBI_DEBUG
> >  static u32     dbg_mdr;
> >  static u32     dbg_mcr;
> > @@ -338,7 +466,7 @@ static inline void iosf_debugfs_remove(void) { }
> >  #endif /* CONFIG_IOSF_MBI_DEBUG */
> >
> >  static int iosf_mbi_probe(struct pci_dev *pdev,
> > -                         const struct pci_device_id *unused)
> > +                         const struct pci_device_id *dev_id)
> >  {
> >         int ret;
> >
> > @@ -349,12 +477,16 @@ static int iosf_mbi_probe(struct pci_dev *pdev,
> >         }
> >
> >         mbi_pdev = pci_dev_get(pdev);
> > +       iosf_mbi_sem_address = dev_id->driver_data;
> > +
> >         return 0;
> >  }
> >
> >  static const struct pci_device_id iosf_mbi_pci_ids[] = {
> > -       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_BAYTRAIL) },
> > -       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_BRASWELL) },
> > +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_BAYTRAIL),
> > +         .driver_data = PUNIT_SEMAPHORE_BYT },
> > +       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_BRASWELL),
> > +         .driver_data = PUNIT_SEMAPHORE_CHT },
> >         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_QUARK_X1000) },
> >         { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_TANGIER) },
> >         { 0, },
> > @@ -371,6 +503,9 @@ static int __init iosf_mbi_init(void)
> >  {
> >         iosf_debugfs_init();
> >
> > +       pm_qos_add_request(&iosf_mbi_pm_qos, PM_QOS_CPU_DMA_LATENCY,
> > +                          PM_QOS_DEFAULT_VALUE);
> > +
> >         return pci_register_driver(&iosf_mbi_pci_driver);
> >  }
> >
> > @@ -381,6 +516,8 @@ static void __exit iosf_mbi_exit(void)
> >         pci_unregister_driver(&iosf_mbi_pci_driver);
> >         pci_dev_put(mbi_pdev);
> >         mbi_pdev = NULL;
> > +
> > +       pm_qos_remove_request(&iosf_mbi_pm_qos);
> >  }
> >
> >  module_init(iosf_mbi_init);
> > diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
> > index 9ca1feaba98f..8c84fa0b0384 100644
> > --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> > +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> > @@ -3,139 +3,23 @@
> >   * Intel BayTrail PMIC I2C bus semaphore implementaion
> >   * Copyright (c) 2014, Intel Corporation.
> >   */
> > -#include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/acpi.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/pm_qos.h>
> >
> >  #include <asm/iosf_mbi.h>
> >
> >  #include "i2c-designware-core.h"
> >
> > -#define SEMAPHORE_TIMEOUT      500
> > -#define PUNIT_SEMAPHORE                0x7
> > -#define PUNIT_SEMAPHORE_CHT    0x10e
> > -#define PUNIT_SEMAPHORE_BIT    BIT(0)
> > -#define PUNIT_SEMAPHORE_ACQUIRE        BIT(1)
> > -
> > -static unsigned long acquired;
> > -
> > -static u32 get_sem_addr(struct dw_i2c_dev *dev)
> > -{
> > -       if (dev->flags & MODEL_CHERRYTRAIL)
> > -               return PUNIT_SEMAPHORE_CHT;
> > -       else
> > -               return PUNIT_SEMAPHORE;
> > -}
> > -
> > -static int get_sem(struct dw_i2c_dev *dev, u32 *sem)
> > -{
> > -       u32 addr = get_sem_addr(dev);
> > -       u32 data;
> > -       int ret;
> > -
> > -       ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr, &data);
> > -       if (ret) {
> > -               dev_err(dev->dev, "iosf failed to read punit semaphore\n");
> > -               return ret;
> > -       }
> > -
> > -       *sem = data & PUNIT_SEMAPHORE_BIT;
> > -
> > -       return 0;
> > -}
> > -
> > -static void reset_semaphore(struct dw_i2c_dev *dev)
> > -{
> > -       if (iosf_mbi_modify(BT_MBI_UNIT_PMC, MBI_REG_READ, get_sem_addr(dev),
> > -                           0, PUNIT_SEMAPHORE_BIT))
> > -               dev_err(dev->dev, "iosf failed to reset punit semaphore during write\n");
> > -
> > -       pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
> > -
> > -       iosf_mbi_call_pmic_bus_access_notifier_chain(MBI_PMIC_BUS_ACCESS_END,
> > -                                                    NULL);
> > -       iosf_mbi_punit_release();
> > -}
> > -
> >  static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
> >  {
> > -       u32 addr;
> > -       u32 sem = PUNIT_SEMAPHORE_ACQUIRE;
> > -       int ret;
> > -       unsigned long start, end;
> > -
> > -       might_sleep();
> > -
> > -       if (!dev || !dev->dev)
> > -               return -ENODEV;
> > -
> > -       if (!dev->release_lock)
> > -               return 0;
> > -
> > -       iosf_mbi_punit_acquire();
> > -       iosf_mbi_call_pmic_bus_access_notifier_chain(MBI_PMIC_BUS_ACCESS_BEGIN,
> > -                                                    NULL);
> > -
> > -       /*
> > -        * Disallow the CPU to enter C6 or C7 state, entering these states
> > -        * requires the punit to talk to the pmic and if this happens while
> > -        * we're holding the semaphore, the SoC hangs.
> > -        */
> > -       pm_qos_update_request(&dev->pm_qos, 0);
> > -
> > -       addr = get_sem_addr(dev);
> > -
> > -       /* host driver writes to side band semaphore register */
> > -       ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, addr, sem);
> > -       if (ret) {
> > -               dev_err(dev->dev, "iosf punit semaphore request failed\n");
> > -               goto out;
> > -       }
> > -
> > -       /* host driver waits for bit 0 to be set in semaphore register */
> > -       start = jiffies;
> > -       end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
> > -       do {
> > -               ret = get_sem(dev, &sem);
> > -               if (!ret && sem) {
> > -                       acquired = jiffies;
> > -                       dev_dbg(dev->dev, "punit semaphore acquired after %ums\n",
> > -                               jiffies_to_msecs(jiffies - start));
> > -                       return 0;
> > -               }
> > -
> > -               usleep_range(1000, 2000);
> > -       } while (time_before(jiffies, end));
> > -
> > -       dev_err(dev->dev, "punit semaphore timed out, resetting\n");
> > -out:
> > -       reset_semaphore(dev);
> > -
> > -       ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, addr, &sem);
> > -       if (ret)
> > -               dev_err(dev->dev, "iosf failed to read punit semaphore\n");
> > -       else
> > -               dev_err(dev->dev, "PUNIT SEM: %d\n", sem);
> > -
> > -       WARN_ON(1);
> > -
> > -       return -ETIMEDOUT;
> > +       return iosf_mbi_block_punit_i2c_access();
> >  }
> >
> >  static void baytrail_i2c_release(struct dw_i2c_dev *dev)
> >  {
> > -       if (!dev || !dev->dev)
> > -               return;
> > -
> > -       if (!dev->acquire_lock)
> > -               return;
> > -
> > -       reset_semaphore(dev);
> > -       dev_dbg(dev->dev, "punit semaphore held for %ums\n",
> > -               jiffies_to_msecs(jiffies - acquired));
> > +       iosf_mbi_unblock_punit_i2c_access();
> >  }
> >
> >  int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
> > @@ -166,14 +50,9 @@ int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
> >         dev->release_lock = baytrail_i2c_release;
> >         dev->shared_with_punit = true;
> >
> > -       pm_qos_add_request(&dev->pm_qos, PM_QOS_CPU_DMA_LATENCY,
> > -                          PM_QOS_DEFAULT_VALUE);
> > -
> >         return 0;
> >  }
> >
> >  void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
> >  {
> > -       if (dev->acquire_lock)
> > -               pm_qos_remove_request(&dev->pm_qos);
> >  }
> > --
> > 2.19.0.rc1
> >



-- 
With Best Regards,
Andy Shevchenko
