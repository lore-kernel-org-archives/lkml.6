Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031216AbeCAOO7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:14:59 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33271 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031174AbeCAOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:14:57 -0500
X-Google-Smtp-Source: AG47ELsbpCbZBkpb+FxewHKnLiqKnZD8iTnwLLOnRHrQZYJO5TgwpvSwCMdJEfBsfd95Z4mUzEYge0vSzd0AopcvPWc=
MIME-Version: 1.0
In-Reply-To: <01000161e1e448a5-d54e05d2-58f2-4480-b05b-67185d4ffae7-000000@email.amazonses.com>
References: <01000161e1e448a5-d54e05d2-58f2-4480-b05b-67185d4ffae7-000000@email.amazonses.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 16:14:55 +0200
Message-ID: <CAHp75Vc6g1+sO_xD=FPdBd8dZJqqA_Se6N3EnZav8uGKex6_fg@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: Keep disk read-only when re-reading partition
To: Jeremy Cline <jeremy@jcline.org>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 4:08 PM, Jeremy Cline <jeremy@jcline.org> wrote:
> If the read-only flag is true on a SCSI disk, re-reading the partition
> table sets the flag back to false.
>
> To observe this bug, you can run:
>
> 1. blockdev --setro /dev/sda
> 2. blockdev --rereadpt /dev/sda
> 3. blockdev --getro /dev/sda
>
> This commit reads the disk's old state and combines it with the device
> disk-reported state rather than unconditionally marking it as RW.

> -               sdkp->write_prot = ((data.device_specific & 0x80) != 0);
> +               sdkp->write_prot = ((data.device_specific & 0x80) != 0) ||
> +                       disk_ro;

Perhaps
               sdkp->write_prot = (data.device_specific & 0x80) || disk_ro;

will save a line.

-- 
With Best Regards,
Andy Shevchenko
