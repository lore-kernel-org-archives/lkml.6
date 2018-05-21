Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeEUU5m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:57:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbeEUU5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:57:40 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, tglx@linutronix.de, mingo@kernel.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de, jack@suse.cz,
        darrick.wong@oracle.com, rgoldwyn@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-api@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v5 0/5] AIO add per-command iopriority
In-Reply-To: <20180521160147.2372-1-adam.manzanares@wdc.com> (adam
        manzanares's message of "Mon, 21 May 2018 09:01:42 -0700")
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Mon, 21 May 2018 16:57:37 -0400
Message-ID: <x49fu2kvi9q.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adam,

adam.manzanares@wdc.com writes:

> From: Adam Manzanares <adam.manzanares@wdc.com>
>
> This is the per-I/O equivalent of the ioprio_set system call.
> See the following link for performance implications on a SATA HDD:
> https://lkml.org/lkml/2016/12/6/495
>
> First patch factors ioprio_check_cap function out of ioprio_set system call to
> also be used by the aio ioprio interface.
>
> Second patch converts kiocb ki_hint field to a u16 to avoid kiocb bloat.
>
> Third patch passes ioprio hint from aio iocb to kiocb and inititalizes kiocb
> ioprio value appropriately when it is not explicitly set.
>
> Fourth patch enables the feature for blkdev.
>
> Fifth patch enables the feature for iomap direct IO
>
> Note: this work is based on top of linux-vfs/for-next

I'll cook up a libaio test case.  Can you put together a man-pages
update for this?

Thanks!
Jeff
