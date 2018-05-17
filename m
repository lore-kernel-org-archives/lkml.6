Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeEQMFg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:05:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751976AbeEQMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:05:15 -0400
Subject: Re: [PATCH] ima: Fix pr_fmt() redefinition
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 17 May 2018 08:04:55 -0400
In-Reply-To: <20180517104702.24689-1-pvorel@suse.cz>
References: <20180517104702.24689-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051712-0008-0000-0000-000004F77F1F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051712-0009-0000-0000-00001E8BF3DF
Message-Id: <1526558695.3306.11.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Thu, 2018-05-17 at 12:47 +0200, Petr Vorel wrote:
> Previous definition was too late and caused problems in powerpc allyesconfig:
> security/integrity/ima/ima_kexec.c:18:0: warning: "pr_fmt" redefined
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> In file included from include/linux/kernel.h:14:0,
>                  from include/asm-generic/bug.h:18,
>                  from arch/powerpc/include/asm/bug.h:128,
>                  from include/linux/bug.h:5,
>                  from include/linux/seq_file.h:7,
>                  from security/integrity/ima/ima_kexec.c:13:
> include/linux/printk.h:288:0: note: this is the location of the previous definition
>  #define pr_fmt(fmt) fmt
> 
> Fixes: 3dea0d93d257 ("ima: Unify logging")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

As the original patch hasn't been upstreamed yet, I'll squash this fix
with the original patch.

thanks!

Mimi

> ---
>  security/integrity/ima/ima_kexec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index db0de585f6c0..16bd18747cfa 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,13 +10,13 @@
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
>  #include "ima.h"
> 
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #ifdef CONFIG_IMA_KEXEC
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
