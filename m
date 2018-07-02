Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555EEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05EA2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yqh1zbdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05EA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeGBPaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:30:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34785 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeGBPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:30:10 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so1121115ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CD4KI0jPM07KgYF3rLl2mWnRZNB6RQOW9e3jPGthpjU=;
        b=Yqh1zbdTBk8D8NlBrmZkAQEtcDUabKzDwZQWkN/qAjxtgKHgPOX9UdTsX1ZRU5skvV
         iiZ9bgYBZvKH4gAM/BrfCywvhYZOqPQFcplwAAimHJJUno/EiX2jjcgTQnDmdIUxOkap
         NwylHT0qYQQOv7cFUVw4+KdjT0kjHiZTmwfkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CD4KI0jPM07KgYF3rLl2mWnRZNB6RQOW9e3jPGthpjU=;
        b=tvpiO2QOTf+WWD4XQKNkFDYOXmm4uL1GV0cb6tgH8LFt/jwqG2wdTavnkpBn3TF3IO
         zRFzewWAG6kgK8sfdK+IZlOC9waCVBtFJLF6DCogeZ2gPre/FVX37HhBaAcRL9B885fx
         KLdq+QUj/viUsuGqV/V0Zbw38udBz9gLgDXbDsDnhUwBvZwGOyCRVQX0OHLl370iH8G7
         Ykzd5+3+2J4C4t93PckXQWGy/+rB8DuW+0LIXITpO0WZYFh+cUgvA+QSfEone0aBxwbI
         Lt8FkCvGMlqJKzp/l6aacCGiNioDNgpkY1BTH+y9+QDHFWxMkkp2D6C7ew6o3FS8bOV1
         qG/g==
X-Gm-Message-State: APt69E35wpDe+nvRcWtzvm0FaAUtNF4rhNnQTu2aC+SiiElr2kMxhi9t
        cq1hxKfatpeJL74m6w+FXF6Zfk1rm55tbM7laRQI4g==
X-Google-Smtp-Source: AAOMgpc8btKIjRrpRogD5PfcYi93v3MYTd6ZyHZnvPgLsSyZB2VgHhXgMlHEOYgdVac/DI6CGq380Cn0tJt2Vxnpmvg=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr22364000iob.60.1530545410007;
 Mon, 02 Jul 2018 08:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 08:30:09 -0700 (PDT)
In-Reply-To: <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com> <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 2 Jul 2018 17:30:09 +0200
Message-ID: <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Some systems are memory constrained but they need to load very large
> firmwares.  The firmware subsystem allows drivers to request this
> firmware be loaded from the filesystem, but this requires that the
> entire firmware be loaded into kernel memory first before it's provided
> to the driver.  This can lead to a situation where we map the firmware
> twice, once to load the firmware into kernel memory and once to copy the
> firmware into the final resting place.
>
> To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> into a pre-allocated buffer") introduced request_firmware_into_buf() API
> that allows drivers to request firmware be loaded directly into a
> pre-allocated buffer. (Based on the mailing list discussions, calling
> dma_alloc_coherent() is unnecessary and confusing.)
>
> (Very broken/buggy) devices using pre-allocated memory run the risk of
> the firmware being accessible to the device prior to the completion of
> IMA's signature verification.  For the time being, this patch emits a
> warning, but does not prevent the loading of the firmware.
>

As I attempted to explain in the exchange with Luis, this has nothing
to do with broken or buggy devices, but is simply the reality we have
to deal with on platforms that lack IOMMUs.

Even if you load into one buffer, carry out the signature verification
and *only then* copy it to another buffer, a bus master could
potentially read it from the first buffer as well. Mapping for DMA
does *not* mean 'making the memory readable by the device' unless
IOMMUs are being used. Otherwise, a bus master can read it from the
first buffer, or even patch the code that performs the security check
in the first place. For such platforms, copying the data around to
prevent the device from reading it is simply pointless, as well as any
other mitigation in software to protect yourself from misbehaving bus
masters.

So issuing a warning in this particular case is rather arbitrary. On
these platforms, all bus masters can read (and modify) all of your
memory all of the time, and as long as the firmware loader code takes
care not to provide the DMA address to the device until after the
verification is complete, it really has done all it reasonably can in
the environment that it is expected to operate in.

(The use of dma_alloc_coherent() is a bit of a red herring here, as it
incorporates the DMA map operation. However, DMA map is a no-op on
systems with cache coherent 1:1 DMA [iow, all PCs and most arm64
platforms unless they have IOMMUs], and so there is not much
difference between memory allocated with kmalloc() or with
dma_alloc_coherent() in terms of whether the device can access it
freely)






> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> ---
> Changelog v5:
> - Instead of preventing loading firmware from a pre-allocate buffer,
> emit a warning.
>
>  security/integrity/ima/ima_main.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index e467664965e7..7da123d980ea 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -416,6 +416,15 @@ void ima_post_path_mknod(struct dentry *dentry)
>                 iint->flags |= IMA_NEW_FILE;
>  }
>
> +static int read_idmap[READING_MAX_ID] = {
> +       [READING_FIRMWARE] = FIRMWARE_CHECK,
> +       [READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
> +       [READING_MODULE] = MODULE_CHECK,
> +       [READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
> +       [READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
> +       [READING_POLICY] = POLICY_CHECK
> +};
> +
>  /**
>   * ima_read_file - pre-measure/appraise hook decision based on policy
>   * @file: pointer to the file to be measured/appraised/audit
> @@ -439,18 +448,16 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>                 }
>                 return 0;       /* We rely on module signature checking */
>         }
> +
> +       if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
> +               if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> +                   (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +                       pr_warn("device might be able to access firmware prior to signature verification completion.\n");
> +               }
> +       }
>         return 0;
>  }
>
> -static int read_idmap[READING_MAX_ID] = {
> -       [READING_FIRMWARE] = FIRMWARE_CHECK,
> -       [READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
> -       [READING_MODULE] = MODULE_CHECK,
> -       [READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
> -       [READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
> -       [READING_POLICY] = POLICY_CHECK
> -};
> -
>  /**
>   * ima_post_read_file - in memory collect/appraise/audit measurement
>   * @file: pointer to the file to be measured/appraised/audit
> --
> 2.7.5
>
