Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeC1L5t convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:57:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeC1L5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:57:48 -0400
From: <yael.chemla@foss.arm.com>
To: "'Wei Yongjun'" <weiyongjun1@huawei.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>
Cc: <dm-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <1522235518-20209-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1522235518-20209-1-git-send-email-weiyongjun1@huawei.com>
Subject: RE: [PATCH -next] dm verity: make some functions static
Date: Wed, 28 Mar 2018 14:57:43 +0300
Message-ID: <000a01d3c68b$fd4ca9d0$f7e5fd70$@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHQ+iKZfAKGT+9VT+nwflHeBS68JqPrIJvQ
Content-Language: en-il
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,
i'll add this fix, got this also from the kbuild test robot.
Thank you,
Yael

> -----Original Message-----
> From: Wei Yongjun <weiyongjun1@huawei.com>
> Sent: Wednesday, 28 March 2018 14:12
> To: Alasdair Kergon <agk@redhat.com>; Mike Snitzer <snitzer@redhat.com>;
> yaeceh01 <yael.chemla@foss.arm.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; dm-devel@redhat.com; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH -next] dm verity: make some functions static
> 
> Fixes the following sparse warnings:
> 
> drivers/md/dm-verity-target.c:375:6: warning:
>  symbol 'verity_for_io_block' was not declared. Should it be static?
> drivers/md/dm-verity-target.c:403:14: warning:
>  symbol 'verity_calc_buffs_for_bv' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/md/dm-verity-target.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index da35f0e..e70d4d2 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -372,9 +372,9 @@ int verity_hash_for_block(struct dm_verity *v, struct
> dm_verity_io *io,
>  /*
>   * Calculates the digest for the given bio
>   */
> -void verity_for_io_block(struct dm_verity *v, struct dm_verity_io *io,
> -			 struct bvec_iter *iter, struct scatterlist *sg,
> -			 unsigned int *nents, unsigned int *total_len)
> +static void verity_for_io_block(struct dm_verity *v, struct dm_verity_io *io,
> +				struct bvec_iter *iter, struct scatterlist *sg,
> +				unsigned int *nents, unsigned int *total_len)
>  {
>  	unsigned int todo = 1 << v->data_dev_block_bits;
>  	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti-
> >per_io_data_size); @@ -400,8 +400,9 @@ void verity_for_io_block(struct
> dm_verity *v, struct dm_verity_io *io,
>   * Calculate how many buffers are required to accommodate
>   * bio_vec starting from iter.
>   */
> -unsigned int verity_calc_buffs_for_bv(struct dm_verity *v, struct
> dm_verity_io *io,
> -				      struct bvec_iter *iter)
> +static unsigned int verity_calc_buffs_for_bv(struct dm_verity *v,
> +					     struct dm_verity_io *io,
> +					     struct bvec_iter *iter)
>  {
>  	unsigned int todo = 1 << v->data_dev_block_bits;
>  	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti-
> >per_io_data_size);
