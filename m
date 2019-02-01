Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0112AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591B218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548981797;
	bh=RxM0QYUFORSLMs3x42CHniYHaPALPNd5VSOZh/yPHPQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2eqieSDxURC1ZflAxm+N0JUFuby1UJ0P/CkeHVHtUJHTub/YZ5JmI6+vacGbtj3sn
	 c/iqVlft7K/PdxhFFZj6WrQn8b2vJ76i047uLtjTMjAvCEwHbEseRDbwWXv3xSD+rS
	 QDidMESRLg+xQcStczDCnGoxGmGjDdiXtf8ZJqjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfBAAnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:43:15 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45161 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfBAAnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:43:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AB0BC2E00;
        Thu, 31 Jan 2019 19:43:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 31 Jan 2019 19:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Q4BkwvE66zdnu5FCX
        ZwIH13O5GixEIcvPvJXakdd38A=; b=x0xly+Trd1ygC3ICqRMBDE4UOu33Dr5zZ
        cidjBmZ80/5OHYBK9YnTkEWwKQTXznOZ6S0Em70fBp613Jh4HDslnV4o+3bdbTHX
        QPeBCGJOKSZ1ze9k6WNrTmjya158MLMSfc5WXy/TPaxqpL/4bxLTiqzvO14Goqbd
        LWYnNlG63aCh2rTOKhIPjRS20maACDUS8kxgrjZI2PpK/yw6ujqSTCMb9/cPAMP6
        X+ltboUnX5vUs+m2adFW+A3+03f7sCTEn4sXtwOAo80U48e2Cwuf4vncQs8mgyzi
        fUp/dKvU1o1p7Gt4BRJJbigSMzSAp3gnEPEaUuEeww4eJKMdAYqFw==
X-ME-Sender: <xms:H5ZTXMRW6UI7tpOTO79zDwTXQB-B-PjKJ8FpOg0388F5ZzR29cdbpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogg
    fgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcu
    oehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrvddvjedrud
    ehjeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:H5ZTXOD-IreE36fQLIUncAxKq-L6EPYUxLj6zqfGTtgdHoIx11_uAw>
    <xmx:H5ZTXE2yDmOzxnHnKH4NOl9r1XVjoaRpH6Eq_I9wXBhMMm43osTbZA>
    <xmx:H5ZTXEUibpXPw9-_PvrT89UlmE3D5RoNxBahzEdBRQsKjkWRJ5uKgA>
    <xmx:IZZTXM-bixUjVdSFOdeFXQ6KCtNTZqbDI-e2_whZ8MvG1XJTL28Kbg>
Received: from eros.localdomain (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE2EE10320;
        Thu, 31 Jan 2019 19:43:07 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Date:   Fri,  1 Feb 2019 11:42:42 +1100
Message-Id: <20190201004242.7659-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when displaying /proc/slabinfo if any cache names are too long
then the output columns are not aligned.  We could do something fancy to
get the maximum length of any cache name in the system or we could just
increase the hardcoded width.  Currently it is 17 characters.  Monitors
are wide these days so lets just increase it to 30 characters.

On one running kernel, with this choice of width, the increase is
sufficient to align the columns and total line width is increased from
112 to 119 characters (excluding the heading row).  Admittedly there may
be cache names in the wild which are longer than the cache names on this
machine, in which case the columns would still be unaligned.

Increase the width of the first column (cache name) in the output of
/proc/slabinfo from 17 to 30 characters.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

This patch does not touch the heading row, and discussion of column
width excludes this row.  Please note that the second column labeled by
the heading row is now *not* above the second column.

### Before patch is applied sample output of `cat /proc/slabinfo` (max column width == 112):

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
kcopyd_job             0      0   3312    9    8 : tunables    0    0    0 : slabdata      0      0      0
dm_uevent              0      0   2632   12    8 : tunables    0    0    0 : slabdata      0      0      0
fuse_request          60     60    392   20    2 : tunables    0    0    0 : slabdata      3      3      0
fuse_inode            21     21    768   21    4 : tunables    0    0    0 : slabdata      1      1      0
kvm_async_pf          90     90    136   30    1 : tunables    0    0    0 : slabdata      3      3      0
kvm_vcpu               4      4  24192    1    8 : tunables    0    0    0 : slabdata      4      4      0
kvm_mmu_page_header    100    150    160   25    1 : tunables    0    0    0 : slabdata      6      6      0
i915_request         100    100    640   25    4 : tunables    0    0    0 : slabdata      4      4      0
i915_vma             316    336    576   28    4 : tunables    0    0    0 : slabdata     12     12      0
fat_inode_cache       22     22    728   22    4 : tunables    0    0    0 : slabdata      1      1      0
fat_cache              0      0     40  102    1 : tunables    0    0    0 : slabdata      0      0      0
ext4_groupinfo_4k   3780   3780    144   28    1 : tunables    0    0    0 : slabdata    135    135      0
ext4_inode_cache  255633 258480   1080   30    8 : tunables    0    0    0 : slabdata   8616   8616      0
ext4_allocation_context    128    128    128   32    1 : tunables    0    0    0 : slabdata      4      4      0
ext4_io_end          256    256     64   64    1 : tunables    0    0    0 : slabdata      4      4      0
ext4_extent_status 197111 197778     40  102    1 : tunables    0    0    0 : slabdata   1939   1939      0
mbcache              294    584     56   73    1 : tunables    0    0    0 : slabdata      8      8      0
jbd2_journal_head    364    476    120   34    1 : tunables    0    0    0 : slabdata     14     14      0
jbd2_revoke_table_s    512    512     16  256    1 : tunables    0    0    0 : slabdata      2      2      0
fscrypt_info         512   1024     32  128    1 : tunables    0    0    0 : slabdata      8      8      0
...


### With patch applied output of `cat /proc/slabinfo` (max column width == 119):

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <share>
PINGv6                              0      0   1152   14    4 : tunables    0    0    0 : slabdata      0      0      0
RAWv6                              14     14   1152   14    4 : tunables    0    0    0 : slabdata      1      1      0
UDPv6                               0      0   1280   12    4 : tunables    0    0    0 : slabdata      0      0      0
tw_sock_TCPv6                       0      0    240   17    1 : tunables    0    0    0 : slabdata      0      0      0
request_sock_TCPv6                  0      0    304   13    1 : tunables    0    0    0 : slabdata      0      0      0
TCPv6                               0      0   2304   14    8 : tunables    0    0    0 : slabdata      0      0      0
sgpool-128                          8      8   4096    8    8 : tunables    0    0    0 : slabdata      1      1      0
bfq_io_cq                           0      0    160   25    1 : tunables    0    0    0 : slabdata      0      0      0
bfq_queue                           0      0    464   17    2 : tunables    0    0    0 : slabdata      0      0      0
mqueue_inode_cache                  9      9    896    9    2 : tunables    0    0    0 : slabdata      1      1      0
dnotify_struct                      0      0     32  128    1 : tunables    0    0    0 : slabdata      0      0      0
posix_timers_cache                  0      0    240   17    1 : tunables    0    0    0 : slabdata      0      0      0
UNIX                                0      0   1024    8    2 : tunables    0    0    0 : slabdata      0      0      0
ip4-frags                           0      0    208   19    1 : tunables    0    0    0 : slabdata      0      0      0
tcp_bind_bucket                     0      0    128   32    1 : tunables    0    0    0 : slabdata      0      0      0
PING                                0      0    960    8    2 : tunables    0    0    0 : slabdata      0      0      0
RAW                                 8      8    960    8    2 : tunables    0    0    0 : slabdata      1      1      0
tw_sock_TCP                         0      0    240   17    1 : tunables    0    0    0 : slabdata      0      0      0
request_sock_TCP                    0      0    304   13    1 : tunables    0    0    0 : slabdata      0      0      0
TCP                                 0      0   2176   15    8 : tunables    0    0    0 : slabdata      0      0      0
hugetlbfs_inode_cache              13     13    616   13    2 : tunables    0    0    0 : slabdata      1      1      0
dquot                               0      0    256   16    1 : tunables    0    0    0 : slabdata      0      0      0
eventpoll_pwq                       0      0     72   56    1 : tunables    0    0    0 : slabdata      0      0      0
dax_cache                          10     10    768   10    2 : tunables    0    0    0 : slabdata      1      1      0
request_queue                       0      0   2056   15    8 : tunables    0    0    0 : slabdata      0      0      0
biovec-max                          8      8   8192    4    8 : tunables    0    0    0 : slabdata      2      2      0
biovec-128                          8      8   2048    8    4 : tunables    0    0    0 : slabdata      1      1      0
biovec-64                           8      8   1024    8    2 : tunables    0    0    0 : slabdata      1      1      0
user_namespace                      8      8    512    8    1 : tunables    0    0    0 : slabdata      1      1      0
uid_cache                          21     21    192   21    1 : tunables    0    0    0 : slabdata      1      1      0
dmaengine-unmap-2                  64     64     64   64    1 : tunables    0    0    0 : slabdata      1      1      0
sock_inode_cache                   24     24    640   12    2 : tunables    0    0    0 : slabdata      2      2      0
skbuff_fclone_cache                 0      0    448    9    1 : tunables    0    0    0 : slabdata      0      0      0
skbuff_head_cache                  16     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
file_lock_cache                     0      0    216   18    1 : tunables    0    0    0 : slabdata      0      0      0
net_namespace                       0      0   3392    9    8 : tunables    0    0    0 : slabdata      0      0      0


 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 81732d05e74a..a339f1361164 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1365,7 +1365,7 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
 
 	memcg_accumulate_slabinfo(s, &sinfo);
 
-	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
+	seq_printf(m, "%-30s %6lu %6lu %6u %4u %4d",
 		   cache_name(s), sinfo.active_objs, sinfo.num_objs, s->size,
 		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
 
-- 
2.20.1

