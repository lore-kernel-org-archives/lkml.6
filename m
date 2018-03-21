Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521648858-2-6277538825748531740
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521648857; b=SY2yh/2m5oWry5/57Nwmo1DvQMfogud492HrEFZ6PfuzoH1
    ZuL6SwZ7uATulfEtTtiAkGAwX24Ojmd1MQhO9IMoBNdJGr0i6Iesvoi3ahgho/8B
    Dcbw7Z2fO8kk0t/GcZQw6UbZC/xYstVgNRBsktUCpGgQ9IMr0eGuDpss0L18DMmR
    NMxTfx5ajjcxy0TCeyrL5ZJXAZVy7CHSd0z68L4vgOpNBVyfw7GfA2zssS5R2cED
    n5xwnmlb9q3TkUnS+wDSDoxWkryex8g2MYvB0+dmzuldKVDVw3GppBokBuTwLQ9+
    TATXvFZDA7s1P9dycDwkTiLL4Yf/iar7Vtw7Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521648857;
    bh=YyHFmH8NLLpx4oecmnng8mvI/WVX9oW1qbpdu1iBLUc=; b=sWCH9h8Pcab/
    LNksTmH5p/1Aku/T31JuhzIscWXSTXQOGeeEeQGCV7MLLPgLor+byhKceHUb1CrD
    dRfYCzGkGMm6mb6rwr9tMdtQpWioWLx7x1Pwpvx6MDK2tVZnlbAHZRxl9Orq7A6/
    VSAqzwFwet674rVtRQsirp/8W0hGSEw3Pl9v9dhnCiDsQNyJyQQ4je6SMzyEtvHP
    0vhKaSiNfTVH5d+iS1xKyJVDw54lbX4qmSGt0LhEWFMoIIu4NoZEOygra1Qa+pXN
    cAHov0scm3ZuZbDd96UB5yp3UbSi/XnTgIT0/w5+NyDKIOun3jPkDcklBb7xmxWp
    upx/U4+3Lg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=aBvGNVM1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=aBvGNVM1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCUQOO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:14:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56390 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeCUQON (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 12:14:13 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2] shm: add split function to shm_vm_ops
Date: Wed, 21 Mar 2018 09:13:14 -0700
Message-Id: <20180321161314.7711-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com>
References: <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If System V shmget/shmat operations are used to create a hugetlbfs
backed mapping, it is possible to munmap part of the mapping and
split the underlying vma such that it is not huge page aligned.
This will untimately result in the following BUG:

kernel BUG at /build/linux-jWa1Fv/linux-4.15.0/mm/hugetlb.c:3310!
Oops: Exception in kernel mode, sig: 5 [#1]
LE SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in: kcm nfc af_alg caif_socket caif phonet fcrypt
		8<--8<--8<--8< snip 8<--8<--8<--8<
CPU: 18 PID: 43243 Comm: trinity-subchil Tainted: G         C  E
4.15.0-10-generic #11-Ubuntu
NIP:  c00000000036e764 LR: c00000000036ee48 CTR: 0000000000000009
REGS: c000003fbcdcf810 TRAP: 0700   Tainted: G         C  E
(4.15.0-10-generic)
MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER:
20040000
CFAR: c00000000036ee44 SOFTE: 1
GPR00: c00000000036ee48 c000003fbcdcfa90 c0000000016ea600 c000003fbcdcfc40
GPR04: c000003fd9858950 00007115e4e00000 00007115e4e10000 0000000000000000
GPR08: 0000000000000010 0000000000010000 0000000000000000 0000000000000000
GPR12: 0000000000002000 c000000007a2c600 00000fe3985954d0 00007115e4e00000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 00000fe398595a94 000000000000a6fc c000003fd9858950 0000000000018554
GPR24: c000003fdcd84500 c0000000019acd00 00007115e4e10000 c000003fbcdcfc40
GPR28: 0000000000200000 00007115e4e00000 c000003fbc9ac600 c000003fd9858950
NIP [c00000000036e764] __unmap_hugepage_range+0xa4/0x760
LR [c00000000036ee48] __unmap_hugepage_range_final+0x28/0x50
Call Trace:
[c000003fbcdcfa90] [00007115e4e00000] 0x7115e4e00000 (unreliable)
[c000003fbcdcfb50] [c00000000036ee48]
__unmap_hugepage_range_final+0x28/0x50
[c000003fbcdcfb80] [c00000000033497c] unmap_single_vma+0x11c/0x190
[c000003fbcdcfbd0] [c000000000334e14] unmap_vmas+0x94/0x140
[c000003fbcdcfc20] [c00000000034265c] exit_mmap+0x9c/0x1d0
[c000003fbcdcfce0] [c000000000105448] mmput+0xa8/0x1d0
[c000003fbcdcfd10] [c00000000010fad0] do_exit+0x360/0xc80
[c000003fbcdcfdd0] [c0000000001104c0] do_group_exit+0x60/0x100
[c000003fbcdcfe10] [c000000000110584] SyS_exit_group+0x24/0x30
[c000003fbcdcfe30] [c00000000000b184] system_call+0x58/0x6c
Instruction dump:
552907fe e94a0028 e94a0408 eb2a0018 81590008 7f9c5036 0b090000 e9390010
7d2948f8 7d2a2838 0b0a0000 7d293038 <0b090000> e9230086 2fa90000 419e0468
---[ end trace ee88f958a1c62605 ]---

This bug was introduced by commit 31383c6865a5 ("mm, hugetlbfs:
introduce ->split() to vm_operations_struct").  A split function
was added to vm_operations_struct to determine if a mapping can
be split.  This was mostly for device-dax and hugetlbfs mappings
which have specific alignment constraints.

Mappings initiated via shmget/shmat have their original vm_ops
overwritten with shm_vm_ops.  shm_vm_ops functions will call back
to the original vm_ops if needed.  Add such a split function to
shm_vm_ops.

Fixes: 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_operations_struct")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: stable@vger.kernel.org
---
Changes in v2
  * Updated commit message
  * Cc stable

 ipc/shm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ipc/shm.c b/ipc/shm.c
index 4643865e9171..93e0e3a4d009 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -386,6 +386,17 @@ static int shm_fault(struct vm_fault *vmf)
 	return sfd->vm_ops->fault(vmf);
 }
 
+static int shm_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+
+	if (sfd->vm_ops && sfd->vm_ops->split)
+		return sfd->vm_ops->split(vma, addr);
+
+	return 0;
+}
+
 #ifdef CONFIG_NUMA
 static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
 {
@@ -510,6 +521,7 @@ static const struct vm_operations_struct shm_vm_ops = {
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.fault	= shm_fault,
+	.split	= shm_split,
 #if defined(CONFIG_NUMA)
 	.set_policy = shm_set_policy,
 	.get_policy = shm_get_policy,
-- 
2.13.6
