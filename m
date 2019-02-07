Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA6C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3765218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ+9fh4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfBGQFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:05:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36072 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:05:22 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so971479itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dszkSZXmYPeVzmFoDUzY5zNw2u2LSiHhGCFL5mnV2Gk=;
        b=qZ+9fh4TU9/N52US4+K2hSMK7cOaQtsUF0wJ4WN8j8D7HQDxiEEv5adPOAKPHM0/9h
         Y4RVXV1fqrbsPA8znzgQWmBqfGngX4TSQU8baJIJlA1KkeSesJ5mtxqb7ZUsHQhrmxOY
         VWYiFWWeF1YuRBnBkwqBAMR5jSmeQkFXi4lnSbFQ1tUoCmocTMPLLZhkZFbqkmonOPGE
         +k6n0e/A7mBiL62+EgIZmydYAHLUdWtL/1wr330vkEWxXwdUmZFfoJt/XmQFX2Bdjxs4
         QMdetqsulAq2Wa6ZLHEwcqcYPUxrW1pDN4yK6kz3i0BNAG16JfsJN4F8KjTWIFlgQZvV
         shiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dszkSZXmYPeVzmFoDUzY5zNw2u2LSiHhGCFL5mnV2Gk=;
        b=ACyEArwhR7MgQNgjGtK2xtECTJAqIa+OVyeOqqEygUFyQu6T28U8v2Qwzzi4UoLtOO
         XZm7gaEt5N6eSWaBu3ZonA/poo/LfgC4tnPQTgrGEK8x6ht6m8Ps/yqa1+XNi/h7OlYN
         yG+lOj7D7KP98hp0Ifg3G8yxpyfy3WFUzSH2HHvzWO/pI3/QuSi9Pod2wfPJrkAH83+j
         UhyWOa2DJk5QEdzFl2LzxY3uWBx+zwLRNjIlD/bahcQJwvpwZksPrBVy/5IbesMHBGst
         zLX10gdeOLUR9WGOktd8JZHaXzX2GKpC9ZF2R1FUzDicf69t1MdEJJ+IAslEWRTpyqkC
         kZxw==
X-Gm-Message-State: AHQUAubIMLTF+u0OmPNvcteA8x7/BckYa42YAq8aQqcNjO8EDisQIfPn
        mQrGGqx1+ofUR2xalSXE+QtcIzb2iihyxD43vjUPrg==
X-Google-Smtp-Source: AHgI3IbQYJ2slgj2+d2utk/EuBEBuRyQPFFm6e9i6YHkSiq30CM0UYbWR1gg3iSEVufJTjk8BMCf3eWvh0l1nzVMnn4=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr1999137ioj.60.1549555520730;
 Thu, 07 Feb 2019 08:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20190207042234.25109-1-hedi.berriche@hpe.com> <20190207042234.25109-2-hedi.berriche@hpe.com>
In-Reply-To: <20190207042234.25109-2-hedi.berriche@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 7 Feb 2019 17:05:09 +0100
Message-ID: <CAKv+Gu_7yb2tf86G1f-kA3g5TVb4imQFTeL9S5qwGhJHVsmgQw@mail.gmail.com>
Subject: Re: [Patch v2 1/4] efi/x86: turn EFI runtime semaphore into a global lock
To:     Hedi Berriche <hedi.berriche@hpe.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 05:23, Hedi Berriche <hedi.berriche@hpe.com> wrote:
>
> Make efi_runtime_lock semaphore global so that it can be used by EFI
> runtime callers that may be defined outside efi/runtime-wrappers.c.
>
> Also now that efi_runtime_lock semaphore is no longer static, rename it
> to efi_runtime_sem so it doesn't clash with the efi_runtime_lock spinlock
> defined in arch/x86/platform/efi/efi_64.c when CONFIG_EFI_MIXED is
> enabled.
>
> The immediate motivation of this change is to serialise UV platform BIOS
> calls using the efi_runtime_sem semaphore.
>
> No functional changes.
>
> Cc: Russ Anderson <rja@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <sivanich@hpe.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>

Hello Hedi,

Same feedback as on v1: please don't rename the lock.


> ---
>  drivers/firmware/efi/runtime-wrappers.c | 60 ++++++++++++-------------
>  include/linux/efi.h                     |  3 ++
>  2 files changed, 33 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index 8903b9ccfc2b..ec60d6227925 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -53,7 +53,7 @@ struct efi_runtime_work efi_rts_work;
>   * @rts_arg<1-5>:      efi_runtime_service() function arguments
>   *
>   * Accesses to efi_runtime_services() are serialized by a binary
> - * semaphore (efi_runtime_lock) and caller waits until the work is
> + * semaphore (efi_runtime_sem) and caller waits until the work is
>   * finished, hence _only_ one work is queued at a time and the caller
>   * thread waits for completion.
>   */
> @@ -144,7 +144,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
>   * none of the remaining functions are actually ever called at runtime.
>   * So let's just use a single lock to serialize all Runtime Services calls.
>   */
> -static DEFINE_SEMAPHORE(efi_runtime_lock);
> +DEFINE_SEMAPHORE(efi_runtime_sem);
>
>  /*
>   * Calls the appropriate efi_runtime_service() with the appropriate
> @@ -233,10 +233,10 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -244,10 +244,10 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -257,11 +257,11 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
>                                 NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -269,11 +269,11 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
>                                 NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -285,11 +285,11 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
>                                 data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -299,11 +299,11 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
>                                 NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -315,11 +315,11 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(SET_VARIABLE, name, vendor, &attr, &data_size,
>                                 data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -330,12 +330,12 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
>  {
>         efi_status_t status;
>
> -       if (down_trylock(&efi_runtime_lock))
> +       if (down_trylock(&efi_runtime_sem))
>                 return EFI_NOT_READY;
>
>         status = efi_call_virt(set_variable, name, vendor, attr, data_size,
>                                data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -350,11 +350,11 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(QUERY_VARIABLE_INFO, &attr, storage_space,
>                                 remaining_space, max_variable_size, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -369,12 +369,12 @@ virt_efi_query_variable_info_nonblocking(u32 attr,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_trylock(&efi_runtime_lock))
> +       if (down_trylock(&efi_runtime_sem))
>                 return EFI_NOT_READY;
>
>         status = efi_call_virt(query_variable_info, attr, storage_space,
>                                remaining_space, max_variable_size);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -382,11 +382,11 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
>                                 NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -395,14 +395,14 @@ static void virt_efi_reset_system(int reset_type,
>                                   unsigned long data_size,
>                                   efi_char16_t *data)
>  {
> -       if (down_interruptible(&efi_runtime_lock)) {
> +       if (down_interruptible(&efi_runtime_sem)) {
>                 pr_warn("failed to invoke the reset_system() runtime service:\n"
>                         "could not get exclusive access to the firmware\n");
>                 return;
>         }
>         efi_rts_work.efi_rts_id = RESET_SYSTEM;
>         __efi_call_virt(reset_system, reset_type, status, data_size, data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>  }
>
>  static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
> @@ -414,11 +414,11 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
>                                 NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -432,11 +432,11 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
>                                 max_size, reset_type, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 45ff763fba76..930cd20842b8 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1745,6 +1745,9 @@ extern struct efi_runtime_work efi_rts_work;
>  /* Workqueue to queue EFI Runtime Services */
>  extern struct workqueue_struct *efi_rts_wq;
>
> +/* EFI runtime semaphore */
> +extern struct semaphore efi_runtime_sem;
> +
>  struct linux_efi_memreserve {
>         int             size;                   // allocated size of the array
>         atomic_t        count;                  // number of entries used
> --
> 2.20.1
>
