Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C5AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9993021568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9993021568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391461AbeIVCOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:14:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390726AbeIVCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:14:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LKOEnN012990
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:24:23 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn5eydbha-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:24:23 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 21 Sep 2018 14:24:22 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 14:24:20 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LKOJdd6160536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 13:24:19 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24570BE054;
        Fri, 21 Sep 2018 14:24:19 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CF1CBE059;
        Fri, 21 Sep 2018 14:24:18 -0600 (MDT)
Received: from localhost (unknown [9.80.102.110])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Sep 2018 14:24:18 -0600 (MDT)
Date:   Fri, 21 Sep 2018 17:24:15 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] powerpc/process: fix casting and missing header
References: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18092120-0012-0000-0000-000016B93741
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009747; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091682; UDB=6.00564082; IPR=6.00871705;
 MB=3.00023441; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 20:24:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092120-0013-0000-0000-0000547CB6E1
Message-Id: <20180921202415.GA19940@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:47:29PM +0000, Christophe Leroy wrote:
> This patch fixes the following warnings. The first ones are leftovers
> from when __get_user() was replaced by probe_kernel_address().
> 
> The last one is from when show_user_instructions() was added.
> 
> arch/powerpc/kernel/process.c:1287:22: warning: incorrect type in argument 2 (different address spaces)
> arch/powerpc/kernel/process.c:1287:22:    expected void const *src
> arch/powerpc/kernel/process.c:1287:22:    got unsigned int [noderef] <asn:1>*<noident>
> arch/powerpc/kernel/process.c:1319:21: warning: incorrect type in argument 2 (different address spaces)
> arch/powerpc/kernel/process.c:1319:21:    expected void const *src
> arch/powerpc/kernel/process.c:1319:21:    got unsigned int [noderef] <asn:1>*<noident>
> arch/powerpc/kernel/process.c:1302:6: warning: symbol 'show_user_instructions' was not declared. Should it be static?
> 
> Fixes: 7b051f665c32d ("powerpc: Use probe_kernel_address in show_instructions")
> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Smoke test passed.  Thank you.

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  v3: new in v3 to fix sparse warnings reported by snowpatch on the serie
> 
>  arch/powerpc/kernel/process.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 913c5725cdb2..e108e1ef2b85 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -65,6 +65,7 @@
>  #include <asm/livepatch.h>
>  #include <asm/cpu_has_feature.h>
>  #include <asm/asm-prototypes.h>
> +#include <asm/stacktrace.h>
>  
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
> @@ -1284,7 +1285,7 @@ static void show_instructions(struct pt_regs *regs)
>  #endif
>  
>  		if (!__kernel_text_address(pc) ||
> -		     probe_kernel_address((unsigned int __user *)pc, instr)) {
> +		    probe_kernel_address((const void *)pc, instr)) {
>  			pr_cont("XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> @@ -1316,7 +1317,7 @@ void show_user_instructions(struct pt_regs *regs)
>  			pr_info("%s[%d]: code: ", current->comm, current->pid);
>  		}
>  
> -		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
> +		if (probe_kernel_address((const void *)pc, instr)) {
>  			pr_cont("XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> -- 
> 2.13.3
> 

-- 
Murilo

