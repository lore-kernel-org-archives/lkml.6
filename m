Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEUU7H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:59:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751087AbeEUU7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:59:05 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, tglx@linutronix.de, mingo@kernel.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de, jack@suse.cz,
        darrick.wong@oracle.com, rgoldwyn@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-api@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v5 4/5] fs: blkdev set bio prio from kiocb prio
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
        <20180521160147.2372-5-adam.manzanares@wdc.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Mon, 21 May 2018 16:59:03 -0400
In-Reply-To: <20180521160147.2372-5-adam.manzanares@wdc.com> (adam
        manzanares's message of "Mon, 21 May 2018 09:01:46 -0700")
Message-ID: <x491se4vi7c.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adam.manzanares@wdc.com writes:

> From: Adam Manzanares <adam.manzanares@wdc.com>
>
> Now that kiocb has an ioprio field copy this over to the bio when it is
> created from the kiocb.
>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>


> ---
>  fs/block_dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 7ec920e27065..da1e94d2bb75 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -355,6 +355,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		bio->bi_write_hint = iocb->ki_hint;
>  		bio->bi_private = dio;
>  		bio->bi_end_io = blkdev_bio_end_io;
> +		bio->bi_ioprio = iocb->ki_ioprio;
>  
>  		ret = bio_iov_iter_get_pages(bio, iter);
>  		if (unlikely(ret)) {
