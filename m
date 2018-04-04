Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeDDUrS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:47:18 -0400
Received: from smtp.infotech.no ([82.134.31.41]:35726 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbeDDUrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:47:17 -0400
Reply-To: dgilbert@interlog.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Kees Cook <keescook@chromium.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jLTSd4wx6hxj6FCJ4O2PkqFyRw6nwu=0Y1NpoaRZKefWw@mail.gmail.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <b7fe22f9-4820-11fe-fe92-cf246642d9f6@interlog.com>
Date: Wed, 4 Apr 2018 16:47:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLTSd4wx6hxj6FCJ4O2PkqFyRw6nwu=0Y1NpoaRZKefWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 04:32 PM, Kees Cook wrote:
> On Wed, Apr 4, 2018 at 12:07 PM, Oleksandr Natalenko
> <oleksandr@natalenko.name> wrote:
>> [  261.262135] Bad or missing usercopy whitelist? Kernel memory exposure
>> attempt detected from SLUB object 'scsi_sense_cache' (offset 94, size 22)!
>> I can easily reproduce it with a qemu VM and 2 virtual SCSI disks by calling
>> smartctl in a loop and doing some usual background I/O. The warning is
>> triggered within 3 minutes or so (not instantly).
> 
> Also:
> 
> Can you send me your .config? What SCSI drivers are you using in the
> VM and on the real server?
> 
> Are you able to see what ioctl()s smartctl is issuing? I'll try to
> reproduce this on my end...

smartctl -r scsiioctl,3 ....
