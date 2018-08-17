Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5CFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E242520895
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E242520895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHQPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:43:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbeHQPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:43:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7HCcc8s102143
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:39:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kwvb5w6y7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:39:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 17 Aug 2018 08:39:41 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Aug 2018 08:39:38 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7HCdbUx15597680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 12:39:37 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 784B2AC05F;
        Fri, 17 Aug 2018 08:39:55 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A999AAC05E;
        Fri, 17 Aug 2018 08:39:54 -0400 (EDT)
Received: from localhost (unknown [9.80.100.14])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Aug 2018 08:39:54 -0400 (EDT)
Date:   Fri, 17 Aug 2018 09:39:34 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/process: Constify the number of insns
 printed by show instructions functions.
References: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
 <ae227d64c78e893b63ed71d911e016cb88212459.1534192631.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae227d64c78e893b63ed71d911e016cb88212459.1534192631.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18081712-0060-0000-0000-0000029F94E7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009560; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074817; UDB=6.00553923; IPR=6.00854776;
 MB=3.00022773; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-17 12:39:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081712-0061-0000-0000-00004632B238
Message-Id: <20180817123934.GB7458@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Tue, Aug 14, 2018 at 08:59:20AM +0000, Christophe Leroy wrote:
> instructions_to_print var is assigned value 16 and there is no
> way to change it.
> 
> This patch replaces it by a constant.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  arch/powerpc/kernel/process.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index c722ce4ca1c0..6317f2ed04ab 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1259,17 +1259,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
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
> @@ -1306,9 +1305,9 @@ void show_user_instructions(struct pt_regs *regs)
>  	char buf[96]; /* enough for 8 times 9 + 2 chars */
>  	int l = 0;
>  
> -	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
> +	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
>  
> -	for (i = 0; i < instructions_to_print; i++) {
> +	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
>  		int instr;
>  
>  		if (!(i % 8) && (i > 0)) {
> -- 
> 2.13.3
> 

-- 
Murilo

