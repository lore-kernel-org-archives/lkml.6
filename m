Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F6DC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84662175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmEQNXbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBGTi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:38:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53083 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfBGTi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:38:56 -0500
Received: by mail-it1-f195.google.com with SMTP id d11so2815398itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1D1C4Hb4rsA2WfLhrsPOD8CGtk8a213Z+w+LdUam84E=;
        b=TmEQNXbXyOS9s9+F63s9ktGaxRM8ZIyLf6Ht5Z/LY1b/9ML0rHgJPFQAdH1ou0kwAO
         Ih3GbiTHRXPEa3FrdvGeVsmuhUwPRHP+slR8rRqcPsnEQYNgG4sc0gMoqO7Lk9RFYJ2H
         QgmSMUYZhYI74a8reD3oQsK1Jwpm25fM9wpSIE6odMovRxES1CmHDqOvcfS0kOR+59C7
         bd7PLA+rZaVd84iP1rSUKk7TWfm2BKtZVKIHcqMv/9UTMNFpRP6gJ6BOl4xzJPX+pMa4
         C5cN51A4WhT5R0XF8MuRdhC6LSZBq1gDOtT/mfXmat1m5GreyM4jkn6UPK6GoUuhOBje
         J6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1D1C4Hb4rsA2WfLhrsPOD8CGtk8a213Z+w+LdUam84E=;
        b=ZVwrY/xie7YkLaw0O5V10tFhuvWqso/c+jiYEhudG1CbTXhosAGDYEJ0RvxIdLHNiv
         QLeMrzrleiGwCl0AYNtFaCQdGA2SQAY0cy/jLqTprSqXI1zy67nnUmmgxDZKanWzFFpU
         smd6dKnsTfmdQvnw1wx3RD2yuh4CgkabvQn2u242ytYgZccqZQL/DMoh6O9dcrAP4R8W
         iArTp9SF6C36UwnedAsYrEPnkOG4pcBkhiF/e9G568Zw8WK9jTX1+jTLGgFskv8beieY
         J0WT/s7Bkr/cFyqx7j89D2DxWBkgQV7LkTBji6vNgbfnwF9pSKvRlY1VgZhdlWAaIz1I
         rTWg==
X-Gm-Message-State: AHQUAuZGjuQ99a4GOUMOt0/Mp+FQ9uNNoM+L1cEqOytqWLPZKmnQjeZE
        0QcC4cazbhl6DMDok+m759oai02gAphgEooNB5irBg==
X-Google-Smtp-Source: AHgI3IY2KGPuxLf10UzXbwb1QshzpAB5wv0BeuBjp6p/NWPjnjRC7SwkbPinNjOnGzpTlSYgzjKYBpwOvSIan3Dn0Kw=
X-Received: by 2002:a02:bb81:: with SMTP id g1mr4016911jan.130.1549568335528;
 Thu, 07 Feb 2019 11:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20190207042234.25109-1-hedi.berriche@hpe.com> <20190207042234.25109-2-hedi.berriche@hpe.com>
 <CAKv+Gu_7yb2tf86G1f-kA3g5TVb4imQFTeL9S5qwGhJHVsmgQw@mail.gmail.com> <20190207173808.GE6398@sarge.linuxathome.me>
In-Reply-To: <20190207173808.GE6398@sarge.linuxathome.me>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 7 Feb 2019 20:38:42 +0100
Message-ID: <CAKv+Gu90BQ8ZAtu5K7FHTto7uGM3974Dtcch07B+8QvWJwwQFg@mail.gmail.com>
Subject: Re: [Patch v2 1/4] efi/x86: turn EFI runtime semaphore into a global lock
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Thu, 7 Feb 2019 at 18:38, Hedi Berriche <hedi.berriche@hpe.com> wrote:
>
> On Thu, Feb 07, 2019 at 16:05 Ard Biesheuvel wrote:
> >On Thu, 7 Feb 2019 at 05:23, Hedi Berriche <hedi.berriche@hpe.com> wrote:
> >>
> >> Make efi_runtime_lock semaphore global so that it can be used by EFI
> >> runtime callers that may be defined outside efi/runtime-wrappers.c.
> >>
> >> Also now that efi_runtime_lock semaphore is no longer static, rename it
> >> to efi_runtime_sem so it doesn't clash with the efi_runtime_lock spinlock
> >> defined in arch/x86/platform/efi/efi_64.c when CONFIG_EFI_MIXED is
> >> enabled.
> >>
> >> The immediate motivation of this change is to serialise UV platform BIOS
> >> calls using the efi_runtime_sem semaphore.
> >>
> >> No functional changes.
> >>
> >> Cc: Russ Anderson <rja@hpe.com>
> >> Cc: Mike Travis <mike.travis@hpe.com>
> >> Cc: Dimitri Sivanich <sivanich@hpe.com>
> >> Cc: Steve Wahl <steve.wahl@hpe.com>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> >
> >Hello Hedi,
>
> Hi Ard,
>
> >Same feedback as on v1: please don't rename the lock.
>
> With the efi_runtime_lock semaphore being no longer static, not renaming it
> will cause a compile failure as it will clash with the declaration of the
> efi_runtime_lock *spinlock* in arch/x86/platform/efi/efi_64.c in the
> CONFIG_EFI_MIXED case.
>

Ah right, it's in the commit log, as requested. Apologies for not spotting that.

Given how UV is a bit of an outlier, I'd prefer it if we could make
this functionality a bit more light weight, by only exposing the lock
if needed, and not create a global symbol for an internal lock if we
can avoid it.

Could you please try something along the lines of

--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -146,6 +146,10 @@
  */
 static DEFINE_SEMAPHORE(efi_runtime_lock);

+#ifdef CONFIG_X86_UV
+extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
+#endif
+
 /*
  * Calls the appropriate efi_runtime_service() with the appropriate
  * arguments.

and add a declaration

extern struct semaphore __efi_uv_runtime_lock;

to bios_uv.c itself rather than to a header file? You can combine this
with your changes in patch #4 (and drop the first patch entirely)

Also, I noticed that there is some CONFIG_EFI guarded code in
bios_uv.c while the whole file already depends on CONFIG_EFI via the
Kconfig symbol. Perhaps you could include a patch to clean that up as
well? Thanks.





> >> ---
> >>  drivers/firmware/efi/runtime-wrappers.c | 60 ++++++++++++-------------
> >>  include/linux/efi.h                     |  3 ++
> >>  2 files changed, 33 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> >> index 8903b9ccfc2b..ec60d6227925 100644
> >> --- a/drivers/firmware/efi/runtime-wrappers.c
> >> +++ b/drivers/firmware/efi/runtime-wrappers.c
> >> @@ -53,7 +53,7 @@ struct efi_runtime_work efi_rts_work;
> >>   * @rts_arg<1-5>:      efi_runtime_service() function arguments
> >>   *
> >>   * Accesses to efi_runtime_services() are serialized by a binary
> >> - * semaphore (efi_runtime_lock) and caller waits until the work is
> >> + * semaphore (efi_runtime_sem) and caller waits until the work is
> >>   * finished, hence _only_ one work is queued at a time and the caller
> >>   * thread waits for completion.
> >>   */
> >> @@ -144,7 +144,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
> >>   * none of the remaining functions are actually ever called at runtime.
> >>   * So let's just use a single lock to serialize all Runtime Services calls.
> >>   */
> >> -static DEFINE_SEMAPHORE(efi_runtime_lock);
> >> +DEFINE_SEMAPHORE(efi_runtime_sem);
> >>
> >>  /*
> >>   * Calls the appropriate efi_runtime_service() with the appropriate
> >> @@ -233,10 +233,10 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -244,10 +244,10 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -257,11 +257,11 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
> >>                                 NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -269,11 +269,11 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
> >>                                 NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -285,11 +285,11 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
> >>                                 data);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -299,11 +299,11 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
> >>                                 NULL, NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -315,11 +315,11 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(SET_VARIABLE, name, vendor, &attr, &data_size,
> >>                                 data);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -330,12 +330,12 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_trylock(&efi_runtime_lock))
> >> +       if (down_trylock(&efi_runtime_sem))
> >>                 return EFI_NOT_READY;
> >>
> >>         status = efi_call_virt(set_variable, name, vendor, attr, data_size,
> >>                                data);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -350,11 +350,11 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
> >>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
> >>                 return EFI_UNSUPPORTED;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(QUERY_VARIABLE_INFO, &attr, storage_space,
> >>                                 remaining_space, max_variable_size, NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -369,12 +369,12 @@ virt_efi_query_variable_info_nonblocking(u32 attr,
> >>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
> >>                 return EFI_UNSUPPORTED;
> >>
> >> -       if (down_trylock(&efi_runtime_lock))
> >> +       if (down_trylock(&efi_runtime_sem))
> >>                 return EFI_NOT_READY;
> >>
> >>         status = efi_call_virt(query_variable_info, attr, storage_space,
> >>                                remaining_space, max_variable_size);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -382,11 +382,11 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
> >>  {
> >>         efi_status_t status;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
> >>                                 NULL, NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -395,14 +395,14 @@ static void virt_efi_reset_system(int reset_type,
> >>                                   unsigned long data_size,
> >>                                   efi_char16_t *data)
> >>  {
> >> -       if (down_interruptible(&efi_runtime_lock)) {
> >> +       if (down_interruptible(&efi_runtime_sem)) {
> >>                 pr_warn("failed to invoke the reset_system() runtime service:\n"
> >>                         "could not get exclusive access to the firmware\n");
> >>                 return;
> >>         }
> >>         efi_rts_work.efi_rts_id = RESET_SYSTEM;
> >>         __efi_call_virt(reset_system, reset_type, status, data_size, data);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>  }
> >>
> >>  static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
> >> @@ -414,11 +414,11 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
> >>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
> >>                 return EFI_UNSUPPORTED;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
> >>                                 NULL, NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> @@ -432,11 +432,11 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
> >>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
> >>                 return EFI_UNSUPPORTED;
> >>
> >> -       if (down_interruptible(&efi_runtime_lock))
> >> +       if (down_interruptible(&efi_runtime_sem))
> >>                 return EFI_ABORTED;
> >>         status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
> >>                                 max_size, reset_type, NULL);
> >> -       up(&efi_runtime_lock);
> >> +       up(&efi_runtime_sem);
> >>         return status;
> >>  }
> >>
> >> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >> index 45ff763fba76..930cd20842b8 100644
> >> --- a/include/linux/efi.h
> >> +++ b/include/linux/efi.h
> >> @@ -1745,6 +1745,9 @@ extern struct efi_runtime_work efi_rts_work;
> >>  /* Workqueue to queue EFI Runtime Services */
> >>  extern struct workqueue_struct *efi_rts_wq;
> >>
> >> +/* EFI runtime semaphore */
> >> +extern struct semaphore efi_runtime_sem;
> >> +
> >>  struct linux_efi_memreserve {
> >>         int             size;                   // allocated size of the array
> >>         atomic_t        count;                  // number of entries used
> >> --
> >> 2.20.1
> >>
>
> --
> Be careful of reading health books, you might die of a misprint.
>         -- Mark Twain
