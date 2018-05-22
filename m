Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeEVRzK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:55:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32805 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeEVRzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:55:07 -0400
X-Google-Smtp-Source: AB8JxZrgKT1OT1xOb+3JJiP26f6mejWf+Xks9gQ6WpEuzEls5SZbYr+DDkXCP5XYwdQINRmqYY1Ing==
Subject: Re: [PATCH v7 0/5] AIO add per-command iopriority
To: adam.manzanares@wdc.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, bcrl@kvack.org
Cc: mingo@kernel.org, tglx@linutronix.de, kstewart@linuxfoundation.org,
        peterz@infradead.org, pombredanne@nexb.com, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com
References: <20180522175221.2391-1-adam.manzanares@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <da84d129-4dcd-c861-bfc4-62cd425e60e3@kernel.dk>
Date: Tue, 22 May 2018 11:55:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180522175221.2391-1-adam.manzanares@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/18 11:52 AM, adam.manzanares@wdc.com wrote:
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
> Third patch passes ioprio hint from aio iocb to kiocb and initializes kiocb
> ioprio value appropriately when it is not explicitly set.
> 
> Fourth patch enables the feature for blkdev.
> 
> Fifth patch enables the feature for iomap direct IO

LGTM, you can add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

Al, are you picking this series up, or should I?

-- 
Jens Axboe
