Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2582FC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AA421A5C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzdRF7on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AA421A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeFUS4c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:56:32 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36677 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeFUS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:56:30 -0400
Received: by mail-ot0-f194.google.com with SMTP id c15-v6so4777804otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g634w4K9e9cC7Qo531J78rWwGGbpuOvmiEn+vr+jgq0=;
        b=EzdRF7onPN3Z7tL+Ew5V7LIRgVX/inmkNs/z3MlDNWS2TgdElZZQvhnYt/Fvb2HPn9
         2gGBfTjDc/UQ0FrS8kQDNukUJ1pETY1aluduGfTqT8AiQ+5nirzpzd58bFa3Kgb7CUfN
         gk4MF/2iorTNWdvERUtj3PrSJPjFaLTJtQaTD/XijqGtURB7xAfC1tCD1VHhLKUZW5o8
         4U52NotujjzYEoDpEMOjDzKN6Uz+rjyNtl84fG7mUoNcgmON9ZWdj8dVcZUewC91+FMm
         NfIvrmXgl66KWM0AdmXuM6awI5SidEISQCyUHu/Qqws8wtJVBTM6/60Vjsq2t4wUR9X3
         VIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g634w4K9e9cC7Qo531J78rWwGGbpuOvmiEn+vr+jgq0=;
        b=buZoYrz68k2kObNoOsiplOml5DkSV6EO8AY+dep9PJzox9tNBIyb1Gu3G0z17viYj5
         7/LEKMT/lYUoX69BoDfQWNyGvOby/8+RwsS825NxNvgtpLz2ip1aM3oHThvp0eqbmn94
         4LR6ouWK4osW9G1QL7FL4B8dAc9GUKEMOavfwgNW8dWiK0VPBY6belIWtkScLa7A7zyJ
         u9fMOZBgr/INYs34Ie6DDsgvG0L4VpjVvE7SNawhef/kLsU7JMzQDyHgdG/PCEUpuHmE
         8hxWPQwgV5uBvGTwssZzP8+O2qCytHfOzeA3wL8R/Y2fnqGloFcdw95/me1zdBD9qSs/
         tJIA==
X-Gm-Message-State: APt69E03/4P7zsLE5nt9ykdxYylMykAtexIwLHqLJv5ujmYli1JUOmx7
        +5LpV9NPmjYNENQmjKL8h2Mbi5gFyTNQYpfSTjB1ng==
X-Google-Smtp-Source: ADUXVKLI04+F2tjyfhCJFHzIEYcFlFzy7BHwLLtstFq8fmjOSCJ5beOskygbUT17IcAsSB0cumCH7NSEnIAYi75PlAY=
X-Received: by 2002:a9d:350a:: with SMTP id o10-v6mr15563369otc.247.1529607389471;
 Thu, 21 Jun 2018 11:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180621151809.10921-1-jannh@google.com> <eafae3a5-346b-5361-4551-7dc5a146e1da@interlog.com>
In-Reply-To: <eafae3a5-346b-5361-4551-7dc5a146e1da@interlog.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 Jun 2018 20:56:18 +0200
Message-ID: <CAG48ez1EgmS9Gp2G__doddRQQU2iuSQ=7WXymrKUFDwWHjx91A@mail.gmail.com>
Subject: Re: [PATCH v2] sg: mitigate read/write abuse
To:     dgilbert@interlog.com
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>, axboe@kernel.dk,
        fujita.tomonori@lab.ntt.co.jp,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org, bblock@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 6:53 PM Douglas Gilbert <dgilbert@interlog.com> wrote:
>
> On 2018-06-21 05:18 PM, Jann Horn wrote:
> > As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
> > to be called under KERNEL_DS"), sg improperly accesses userspace memory
> > outside the provided buffer, permitting kernel memory corruption via
> > splice().
> > But it doesn't just do it on ->write(), also on ->read().
> >
> > As a band-aid, make sure that the ->read() and ->write() handlers can not
> > be called in weird contexts (kernel context or credentials different from
> > file opener), like for ib_safe_file_access().
> >
> > If someone needs to use these interfaces from different security contexts,
> > a new interface should be written that goes through the ->ioctl() handler.
> >
> > I've mostly copypasted ib_safe_file_access() over as sg_safe_file_access()
> > because I couldn't find a good common header - please tell me if you know a
> > better way.
> > The duplicate pr_err_once() calls are so that each of them fires once;
> > otherwise, this would probably have to be a macro.
> >
> > changed in v2:
> >   - remove the bsg parts per Christoph Hellwig's request
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >   drivers/scsi/sg.c | 29 ++++++++++++++++++++++++++++-
> >   1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> > index 53ae52dbff84..51b685192646 100644
> > --- a/drivers/scsi/sg.c
> > +++ b/drivers/scsi/sg.c
> > @@ -51,6 +51,7 @@ static int sg_version_num = 30536;  /* 2 digits for each component */
> >   #include <linux/atomic.h>
> >   #include <linux/ratelimit.h>
> >   #include <linux/uio.h>
> > +#include <linux/cred.h> /* for sg_safe_file_access() */
> >
> >   #include "scsi.h"
> >   #include <scsi/scsi_dbg.h>
> > @@ -209,6 +210,23 @@ static void sg_device_destroy(struct kref *kref);
> >       sdev_prefix_printk(prefix, (sdp)->device,               \
> >                          (sdp)->disk->disk_name, fmt, ##a)
> >
> > +/*
> > + * The SCSI interfaces that use read() and write() as an asynchronous variant of
> > + * ioctl(..., SG_IO, ...) are fundamentally unsafe, since there are lots of ways
> > + * to trigger read() and write() calls from various contexts with elevated
> > + * privileges. This can lead to kernel memory corruption (e.g. if these
> > + * interfaces are called through splice()) and privilege escalation inside
> > + * userspace (e.g. if a process with access to such a device passes a file
> > + * descriptor to a SUID binary as stdin/stdout/stderr).
> > + *
> > + * This function provides protection for the legacy API by restricting the
> > + * calling context.
> > + */
> > +static inline bool sg_safe_file_access(struct file *filp)
> > +{
> > +     return filp->f_cred == current_cred() && !uaccess_kernel();
> > +}
> > +
> >   static int sg_allow_access(struct file *filp, unsigned char *cmd)
> >   {
> >       struct sg_fd *sfp = filp->private_data;
> > @@ -393,6 +411,12 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
> >       struct sg_header *old_hdr = NULL;
> >       int retval = 0;
> >
> > +     if (!sg_safe_file_access(filp)) {
> > +             pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
> > +                     __func__, task_tgid_vnr(current), current->comm);
> > +             return -EINVAL;
>
> The error message and returned code apply to the
> (filp->f_cred == current_cred()) case, not so much to !uaccess_kernel().
> While on the error path could you not break out the !uaccess_kernel()
> with an appropriate error message and a return code of -EACCES ? Perhaps
> a message is unneeded since EACCES is clear.
>
> Not that wild about EINVAL either since it suggests (to me) a "front end"
> error (e.g. associated with a badly formed request). How about EPERM for
> the changing credentials case.

I used EINVAL since infiniband uses that error case, but I see how it
would be a relatively confusing error code in the context of an sg
device - I agree that EACCES and EPERM might be a better fit here.
I'll adjust the patch.
However, shouldn't it be EPERM in the uaccess_kernel() case and EACCES
in the filp->f_cred!=current_cred() case (instead of the other way
around)?

> And could I suggest a comment in the code along these lines:
>
> /*
>   * This could cause a response to be stranded. Close the associated
>   * file descriptor to free up any resources being held.
>   */

You mean, as advice to users of this interface, telling them to
close() the FD if they get an error code from read()?

> > +     }
> > +
> >       if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
> >               return -ENXIO;
> >       SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
> > @@ -581,8 +605,11 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
> >       sg_io_hdr_t *hp;
> >       unsigned char cmnd[SG_MAX_CDB_SIZE];
> >
> > -     if (unlikely(uaccess_kernel()))
> > +     if (!sg_safe_file_access(filp)) {
> > +             pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
> > +                     __func__, task_tgid_vnr(current), current->comm);
> >               return -EINVAL;
>
> Same comments as above.
>
>
> Doug Gilbert
>
> > +     }
> >
> >       if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
> >               return -ENXIO;
> >
>
