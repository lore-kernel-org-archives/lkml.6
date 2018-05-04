Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeEDPD6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:03:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751196AbeEDPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:03:57 -0400
Date: Fri, 04 May 2018 20:33:48 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/6] powerpc/syscalls: Switch trivial cases to
 SYSCALL_DEFINE
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20180502132051.28861-1-mpe@ellerman.id.au>
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18050415-0008-0000-0000-000004F308D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050415-0009-0000-0000-00001E87368A
Message-Id: <1525446080.ih4a1c8i42.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/powerpc/kernel/pci_32.c               | 6 +++---
>  arch/powerpc/kernel/pci_64.c               | 4 ++--
>  arch/powerpc/mm/subpage-prot.c             | 4 +++-
>  arch/powerpc/platforms/cell/spu_syscalls.c | 3 ++-
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 

I suppose we can also do this for switch_endian?

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 466216506eb2..290265f2700c 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -123,7 +123,7 @@ long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
 				 (u64)len_high << 32 | len_low, advice);
 }
 
-long sys_switch_endian(void)
+SYSCALL_DEFINE0(switch_endian)
 {
 	struct thread_info *ti;


- Naveen
