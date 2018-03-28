Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeC1LGe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:06:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33397 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752611AbeC1LGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:06:33 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        yaeceh01 <yael.chemla@foss.arm.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] dm verity: make some functions static
Date: Wed, 28 Mar 2018 11:11:58 +0000
Message-ID: <1522235518-20209-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

drivers/md/dm-verity-target.c:375:6: warning:
 symbol 'verity_for_io_block' was not declared. Should it be static?
drivers/md/dm-verity-target.c:403:14: warning:
 symbol 'verity_calc_buffs_for_bv' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/md/dm-verity-target.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index da35f0e..e70d4d2 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -372,9 +372,9 @@ int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
 /*
  * Calculates the digest for the given bio
  */
-void verity_for_io_block(struct dm_verity *v, struct dm_verity_io *io,
-			 struct bvec_iter *iter, struct scatterlist *sg,
-			 unsigned int *nents, unsigned int *total_len)
+static void verity_for_io_block(struct dm_verity *v, struct dm_verity_io *io,
+				struct bvec_iter *iter, struct scatterlist *sg,
+				unsigned int *nents, unsigned int *total_len)
 {
 	unsigned int todo = 1 << v->data_dev_block_bits;
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
@@ -400,8 +400,9 @@ void verity_for_io_block(struct dm_verity *v, struct dm_verity_io *io,
  * Calculate how many buffers are required to accommodate
  * bio_vec starting from iter.
  */
-unsigned int verity_calc_buffs_for_bv(struct dm_verity *v, struct dm_verity_io *io,
-				      struct bvec_iter *iter)
+static unsigned int verity_calc_buffs_for_bv(struct dm_verity *v,
+					     struct dm_verity_io *io,
+					     struct bvec_iter *iter)
 {
 	unsigned int todo = 1 << v->data_dev_block_bits;
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
