Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165021AbeCBE42 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:56:28 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:35246 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164400AbeCBE41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:56:27 -0500
X-Google-Smtp-Source: AG47ELtkFmIaUvb0TxTvKh5HOSoNSlFvAxPBVov0IJcgYyx9kQoh/uin1SqzNQeRw2bdvaq6tR1p7kfukG2Wjms8Sg8=
MIME-Version: 1.0
In-Reply-To: <1519945861.2675.9.camel@sandisk.com>
References: <1496655478-4039-1-git-send-email-opensource.ganesh@gmail.com> <1519945861.2675.9.camel@sandisk.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Fri, 2 Mar 2018 12:56:26 +0800
Message-ID: <CADAEsF8OySXKpqBmN-Vi+8md=RpHAyUghO99UnrwJRdD72yWCQ@mail.gmail.com>
Subject: Re: [PATCH] scsi_lib: increase {host|target|device}_busy count after
 dispatch cmd
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bart:

2018-03-02 7:11 GMT+08:00 Bart Van Assche <Bart.VanAssche@wdc.com>:
> On Mon, 2017-06-05 at 17:37 +0800, Ganesh Mahendran wrote:
>> In android system, when there are lots of threads running. Thread A
>> holding *host_busy* count is easily to be preempted, and if at the
>> same time, thread B set *host_blocked*, then all other threads will
>> be io blocked.
>
> Hello Ganesh,
>
> Have you considered to insert preempt_disable() and preempt_enable() calls
> where necessary to achieve the same effect? I think that would result in a
> much less intrusive patch.

Yes, preempt_disable()preempt_enable will also achieve the same effect.
But I just think preempt_disable()preempt_enable may be a little heavy for
this problem which can be fixed by increaseing {host|target|device}_busy count
after dispatch cmd.

Thanks.

>
> Thanks,
>
> Bart.
>
>
