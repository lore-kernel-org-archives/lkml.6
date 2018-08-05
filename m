Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B782C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D74217C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0Q+K3CA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D74217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeHEKVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 06:21:21 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37027 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHEKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 06:21:21 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so8498327ioh.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yT6owx9DHj0U08psBNj/nXo0h3fpKNs+e7+vxhr2q2Q=;
        b=a0Q+K3CAb2USl39VuC84XQeq7G0dkce1rUOsy5S6O7ZVu0TVEdXDrHsz108UI+mqgN
         cUdQ16OuP3YTCp/tiTdC+cHNcRB2tZaDHuduHzlngYK6w6EDOnPfxizuXu5aOhqoDmRL
         ghcaYWIz8AoCLidlvlVmlmhK74fC5Qi65eXxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yT6owx9DHj0U08psBNj/nXo0h3fpKNs+e7+vxhr2q2Q=;
        b=tz4BsT/Zrjo69hc9X+ZKevZsqsIYnkCxJhb5wQHxBDiGvRG9gpGcqWJeQo7uXs6m7v
         9X8kCcSz5jqUPJOhK2WyVXl7I2YBOt2Fw0sLyHp8QehAcexDBplQZSPktS3vk5N9X66c
         HM30L53LiYAU4vDLNrUWQfNH9Hvt5PVOWdgqR9420xYSt6BxJIojvElriMpB35Z32fJG
         8B7b2fhYMpnJmxg0DxXRQRrObKP65Wk08FTkR5e6h0q3lVw9Pa+d5SwwufNeqXpcBHBE
         v6/hyDirARwncZLRaLWnWM3DfUOZxTUYTQuNBsL3osdlbpUJcpr1Z+eNBz37nwYf2yk2
         f0OA==
X-Gm-Message-State: AOUpUlHMKYd1rePAtHf+DWDnvMxpJfx444Sb7uan8zKJlMbfWXwXGkFK
        LOV/kdPbYEj9RI3E/uemuKX3W0Uj77wtUJ7h/0hygQ==
X-Google-Smtp-Source: AA+uWPwB5LjusVgtoev6baCCFEJOTf+GyUNndRNSLPldctBWzKvfuCigAmpnVTcprNKWdiXfA6FvUFca5PqVA8IdZec=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr11416460iof.173.1533457057156;
 Sun, 05 Aug 2018 01:17:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 01:17:36 -0700 (PDT)
In-Reply-To: <20180805032119.20485-3-jlee@suse.com>
References: <20180805032119.20485-1-jlee@suse.com> <20180805032119.20485-3-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 5 Aug 2018 10:17:36 +0200
Message-ID: <CAKv+Gu9tE2KZNXTqtOi9qg3a861NQc-rQYxUQbioj04DzAkXbQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] efi: the function transfers status to string
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 August 2018 at 05:21, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> This function can be used to transfer EFI status code to string
> for printing out debug message.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Ryan Chen <yu.chen.surf@gmail.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Very useful.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  include/linux/efi.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 56add823f190..744cf92fe18e 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1651,4 +1651,30 @@ struct linux_efi_tpm_eventlog {
>
>  extern int efi_tpm_eventlog_init(void);
>
> +#define EFI_STATUS_STR(_status) \
> +case EFI_##_status: \
> +       return "EFI_" __stringify(_status);
> +
> +static inline char *
> +efi_status_to_str(efi_status_t status)
> +{
> +       switch (status) {
> +       EFI_STATUS_STR(SUCCESS)
> +       EFI_STATUS_STR(LOAD_ERROR)
> +       EFI_STATUS_STR(INVALID_PARAMETER)
> +       EFI_STATUS_STR(UNSUPPORTED)
> +       EFI_STATUS_STR(BAD_BUFFER_SIZE)
> +       EFI_STATUS_STR(BUFFER_TOO_SMALL)
> +       EFI_STATUS_STR(NOT_READY)
> +       EFI_STATUS_STR(DEVICE_ERROR)
> +       EFI_STATUS_STR(WRITE_PROTECTED)
> +       EFI_STATUS_STR(OUT_OF_RESOURCES)
> +       EFI_STATUS_STR(NOT_FOUND)
> +       EFI_STATUS_STR(ABORTED)
> +       EFI_STATUS_STR(SECURITY_VIOLATION)
> +       }
> +
> +       return "";
> +}
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.13.6
>
