Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33778ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A5C2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A5C2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391475AbeIVCQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:16:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391318AbeIVCQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:16:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LKODvI130989
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:25:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mn60r3mqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:25:49 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 21 Sep 2018 14:25:48 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 14:25:46 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LKPjPM45744204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 13:25:45 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF56C605D;
        Fri, 21 Sep 2018 14:25:45 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C11E9C6055;
        Fri, 21 Sep 2018 14:25:44 -0600 (MDT)
Received: from localhost (unknown [9.80.102.110])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Sep 2018 14:25:44 -0600 (MDT)
Date:   Fri, 21 Sep 2018 17:25:40 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] powerpc/process: Constify the number of insns
 printed by show instructions functions.
References: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
 <3fdf75eed98b1fa22da77e675692a86a7a9986a7.1536327756.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdf75eed98b1fa22da77e675692a86a7a9986a7.1536327756.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18092120-8235-0000-0000-00000E04333D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009747; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091682; UDB=6.00564082; IPR=6.00871706;
 MB=3.00023441; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 20:25:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092120-8236-0000-0000-000042B9A78B
Message-Id: <20180921202540.GC19940@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:47:33PM +0000, Christophe Leroy wrote:
> instructions_to_print var is assigned value 16 and there is no
> way to change it.
> 
> This patch replaces it by a constant.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  v3: no change
>  v2: no change
> 
>  arch/powerpc/kernel/process.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 2a39f7aca846..7d86b4f7949e 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1261,17 +1261,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	return last;
>  }
>  
> -static int instructions_to_print = 16;
> +#define NR_INSN_TO_PRINT	16
>  
>  static void show_instructions(struct pt_regs *regs)
>  {
>  	int i;
> -	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
> -			sizeof(int));
> +	unsigned long pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
>  
>  	printk("Instruction dump:");
>  
> -	for (i = 0; i < instructions_to_print; i++) {
> +	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
>  		int instr;
>  
>  		if (!(i % 8))
> @@ -1304,11 +1303,11 @@ static void show_instructions(struct pt_regs *regs)
>  void show_user_instructions(struct pt_regs *regs)
>  {
>  	unsigned long pc;
> -	int n = instructions_to_print;
> +	int n = NR_INSN_TO_PRINT;
>  	struct seq_buf s;
>  	char buf[96]; /* enough for 8 times 9 + 2 chars */
>  
> -	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
> +	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
>  
>  	seq_buf_init(&s, buf, sizeof(buf));
>  
> -- 
> 2.13.3
> 

-- 
Murilo

