Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A350D21A16
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u+Xk8uQu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XJWMUmd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A350D21A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbeHGCKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:10:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42922 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbeHGCKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:10:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id y203-v6so4283627ywd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZG5TAyA4nNXksOXqLe9olEvdlfmRUFYyWKppal+gWTo=;
        b=u+Xk8uQuT58obUaFnZN5nrm/+BcG47zJkKf0vSxDn9In23mpx3dGoR/4fiDnL1k+d8
         mJfyjZiOazGmr847yjdEfvQAgDI6R06WHZXr0qW5sK1sDHxcjFSqotJlfzd/YJaXdvA0
         Gx5OpUcT5MFXH5lPhNEDlZs1/ENkQ4NA9WJPkVT2Acll9ZJ4UoiPUU3XXW/bXZ9qqcdK
         m/uJUMIqBMC93Ibu3XHBu8456w1TyXMWUlXtst7JvoOiFwdwHQ9NJHwZpCSv7cmbUplu
         hqe/IIx6cCfK722yOXu1U9Q6dupzCtHY3lphehqzKxWJ+3x4999oAs7xvi1eOouhtBxj
         vIeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZG5TAyA4nNXksOXqLe9olEvdlfmRUFYyWKppal+gWTo=;
        b=XJWMUmd452Pb109LT7Ei/TSkE4zHo+b7ld+Kb5VVEatti6MZDgP8c/e2ki+vNlApzu
         61oFUfeLnn5N42d7XC9iva/NVMIQ6FnPu02bEY2unBuOOq3I3EnQdIKTZQe9bTmDFGhf
         Bbqr8cX3/xT9M5KHlkiWAbc1r/eg7onKC/y7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZG5TAyA4nNXksOXqLe9olEvdlfmRUFYyWKppal+gWTo=;
        b=ZpxNhwOHyEHDabDh8WSwf1jPvFnO6j5caE3Tbk5FDlszEQzI2oHV7lT0HBCl+Mo4os
         3phFF+X6IbLq7aw+5KbZyDUGDflsiddfN/59NWAksh7Hg51JD3SpZDO9G/MEftDOXF4U
         K3UfOR7/TdCyAZn8NQd5o6cNR5GZBhddf9yaIpj6uphCo+TdWQrNMFevJSev82HpWooi
         H5SPdMGdqWGw1QGMPYjH99qSG879v3GSlfxYNDwYFVkZHKWbh+jSc8r9SrzEWB//oBrO
         M3b8CXwIJwKuZXDtLz4A8lxSCCWKsNQWBsit7qO7Voyq7YUBgcmw824FEm5ZYUDCXb+x
         Ec2w==
X-Gm-Message-State: AOUpUlGILEJFsFkA9X9smpHu8OxGQJSlCfcdAcKJSunn2N7AFHBAq075
        oBZUd7ipA5FO6eyypIPzRORzTjyYgk7volAi9JH3Wg==
X-Google-Smtp-Source: AAOMgpeDtjUhAvRun49Yy9APlgV+SBWxPC31PamnZaZoY79VNsX8l4uqhkT7woeqezccfafsSsHQda9j7kI4iqyBhtg=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr8683129ywn.88.1533599944887;
 Mon, 06 Aug 2018 16:59:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 16:59:04 -0700 (PDT)
In-Reply-To: <111cb1b0-24ba-bcb2-53d5-9665d2b4c421@infradead.org>
References: <20180731195155.46664-1-keescook@chromium.org> <20180731195155.46664-5-keescook@chromium.org>
 <111cb1b0-24ba-bcb2-53d5-9665d2b4c421@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 Aug 2018 16:59:04 -0700
X-Google-Sender-Auth: mVg08e6sgmVipiBIyTeS_GF7sxA
Message-ID: <CAGXu5jKNeep01VOwC-dWsT4iDXrkBOhHJX0+4BEBotYOx1D0Tg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] target: don't depend on SCSI
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel <target-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 4:38 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 07/31/2018 12:51 PM, Kees Cook wrote:
>> From: Christoph Hellwig <hch@lst.de>
>>
>> The core target code only needs code from scsi_common.c, which is now
>> separately selectable.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/target/Kconfig | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/target/Kconfig b/drivers/target/Kconfig
>> index 4c44d7bed01a..cb6f32ce7de8 100644
>> --- a/drivers/target/Kconfig
>> +++ b/drivers/target/Kconfig
>> @@ -1,10 +1,10 @@
>>
>>  menuconfig TARGET_CORE
>>       tristate "Generic Target Core Mod (TCM) and ConfigFS Infrastructure"
>> -     depends on SCSI && BLOCK
>> +     depends on BLOCK
>>       select CONFIGFS_FS
>>       select CRC_T10DIF
>> -     select BLK_SCSI_REQUEST # only for scsi_command_size_tbl..
>> +     select BLK_SCSI_REQUEST
>>       select SGL_ALLOC
>>       default n
>>       help
>> @@ -29,6 +29,7 @@ config TCM_FILEIO
>>
>>  config TCM_PSCSI
>>       tristate "TCM/pSCSI Subsystem Plugin for Linux/SCSI"
>> +     depends on SCSI
>>       help
>>       Say Y here to enable the TCM/pSCSI subsystem plugin for non-buffered
>>       passthrough access to Linux/SCSI device
>>
>
> Hi,
>
> This patch causes build errors in linux-next-20180806 when SCSI=m and
> LOOPBACK_TARGET=y.
>
> drivers/target/loopback/tcm_loop.o: In function `tcm_loop_port_link':
> tcm_loop.c:(.text+0x445): undefined reference to `scsi_add_device'
> drivers/target/loopback/tcm_loop.o: In function `tcm_loop_driver_remove':
> tcm_loop.c:(.text+0x55c): undefined reference to `scsi_remove_host'
> tcm_loop.c:(.text+0x564): undefined reference to `scsi_host_put'
> drivers/target/loopback/tcm_loop.o: In function `tcm_loop_submission_work':
> tcm_loop.c:(.text+0x7c4): undefined reference to `scmd_printk'
> drivers/target/loopback/tcm_loop.o: In function `tcm_loop_driver_probe':
> tcm_loop.c:(.text+0x7fb): undefined reference to `scsi_host_alloc'
> tcm_loop.c:(.text+0x85b): undefined reference to `scsi_add_host_with_dma'
> tcm_loop.c:(.text+0x896): undefined reference to `scsi_host_put'
> drivers/target/loopback/tcm_loop.o: In function `tcm_loop_port_unlink':
> tcm_loop.c:(.text+0x962): undefined reference to `scsi_device_lookup'
> tcm_loop.c:(.text+0x972): undefined reference to `scsi_remove_device'
> tcm_loop.c:(.text+0x97a): undefined reference to `scsi_device_put'
> drivers/target/loopback/tcm_loop.o:(.data+0x210): undefined reference to `scsi_change_queue_depth'

Can you send your .config? I'm struggling to get a build with SCSI=m. :P

I wonder if LOOPBACK_TARGET is just missing a "depends on SCSI" as was
added for TCM_PSCSI?

-Kees

-- 
Kees Cook
Pixel Security
