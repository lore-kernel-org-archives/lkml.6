Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDDUcz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:32:55 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:42168 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeDDUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:32:53 -0400
X-Google-Smtp-Source: AIpwx485Zlj9Phy9+DB5ejEopNheSWvgYoC7SJwdsh3FhbJF9WaTQUI/6B+38l6TxBZOpFN2FGTv1oIf7AGBGGiFDnA=
MIME-Version: 1.0
In-Reply-To: <10360653.ov98egbaqx@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Apr 2018 13:32:52 -0700
X-Google-Sender-Auth: ddaBpVq6dP0Rdt22gqC8RmhieEY
Message-ID: <CAGXu5jLTSd4wx6hxj6FCJ4O2PkqFyRw6nwu=0Y1NpoaRZKefWw@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 12:07 PM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> [  261.262135] Bad or missing usercopy whitelist? Kernel memory exposure
> attempt detected from SLUB object 'scsi_sense_cache' (offset 94, size 22)!
> I can easily reproduce it with a qemu VM and 2 virtual SCSI disks by calling
> smartctl in a loop and doing some usual background I/O. The warning is
> triggered within 3 minutes or so (not instantly).

Also:

Can you send me your .config? What SCSI drivers are you using in the
VM and on the real server?

Are you able to see what ioctl()s smartctl is issuing? I'll try to
reproduce this on my end...

-Kees

-- 
Kees Cook
Pixel Security
