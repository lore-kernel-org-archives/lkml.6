Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeDBIDZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 04:03:25 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:39486 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeDBIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 04:03:23 -0400
X-Google-Smtp-Source: AIpwx49hpNhEf1+S6ki2jN0fBdC9nmlbB7UV+taKToIqr9zQw9nN+gbRVq1ouLgdsnZveebkPVCIFPTsG38SNADI8Mw=
MIME-Version: 1.0
In-Reply-To: <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain> <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
From: chaitany kulkarni <ckulkarnilinux@gmail.com>
Date: Mon, 2 Apr 2018 01:03:21 -0700
Message-ID: <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
Subject: Re: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
To: =?UTF-8?Q?Rodrigo_Rosatti_Galv=C3=A3o?=
        <rosattig@linux.vnet.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3283Wa9025662

Please give me a couple of days, I'll look into this.

On Fri, Mar 30, 2018 at 2:48 PM, Rodrigo Rosatti Galvão
<rosattig@linux.vnet.ibm.com> wrote:
>
>> Doesn't that mean your host is using this command wrong? The NLB is a
>> 0's based value, we're supposed to +1 to get the correct block count.
>
>
> Keith, I tested passing different values to the c (number of blocks) and s
> (64-bit LBA of first block to access) parameters, and it was failing. When I
> removed the +1, the command worked fine.
>
> I used a simple script to validate this:
>
> for s in {0..20}
>     do
>             for c in {0..20}
>             do
>                     nvme write-zeroes /dev/nvme0 -n 10 -s $s -c $c
>             done
>     done
>
>
> Is there some other way to test it?
>
> --
> Rodrigo R. Galvão
> Intern - Linux Technology Center - IBM
>
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
