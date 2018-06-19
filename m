Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AD7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444BE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444BE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937057AbeFSCnc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:43:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755509AbeFSCnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:43:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5J2db1w044152
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:43:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jps89g329-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:43:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 03:43:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 03:43:26 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5J2hPAZ22544550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 02:43:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 756704C040;
        Tue, 19 Jun 2018 03:34:26 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA9824C04E;
        Tue, 19 Jun 2018 03:34:25 +0100 (BST)
Received: from localhost (unknown [9.77.83.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 03:34:25 +0100 (BST)
Date:   Tue, 19 Jun 2018 08:13:21 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4.14 120/189] powerpc/trace/syscalls: Update syscall name
 matching logic
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
References: <20180618081209.254234434@linuxfoundation.org>
        <20180618081214.069543596@linuxfoundation.org>
In-Reply-To: <20180618081214.069543596@linuxfoundation.org>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18061902-4275-0000-0000-0000028F3E5D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061902-4276-0000-0000-000037967ECC
Message-Id: <1529376134.mmb9hh2cc8.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.

Please drop this and the next patch since these depend on commit 
e145242ea0df6, which is not in v4.14.

- Naveen

> 
> ------------------
> 
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> 
> [ Upstream commit 0b7758aaf6543b9a10c8671db559e9d374a3fd95 ]
> 
> On powerpc64 ABIv1, we are enabling syscall tracing for only ~20
> syscalls. This is due to commit e145242ea0df6 ("syscalls/core,
> syscalls/x86: Clean up syscall stub naming convention") which has
> changed the syscall entry wrapper prefix from "SyS" to "__se_sys".
> 
> Update the logic for ABIv1 to not just skip the initial dot, but also
> the "__se_sys" prefix.
> 
> Fixes: commit e145242ea0df6 ("syscalls/core, syscalls/x86: Clean up 
> syscall stub naming convention")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/include/asm/ftrace.h |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -73,13 +73,9 @@ struct dyn_arch_ftrace {
>  #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
>  static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
>  {
> -	/*
> -	 * Compare the symbol name with the system call name. Skip the .sys or .SyS
> -	 * prefix from the symbol name and the sys prefix from the system call name and
> -	 * just match the rest. This is only needed on ppc64 since symbol names on
> -	 * 32bit do not start with a period so the generic function will work.
> -	 */
> -	return !strcmp(sym + 4, name + 3);
> +	/* We need to skip past the initial dot, and the __se_sys alias */
> +	return !strcmp(sym + 1, name) ||
> +		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name));
>  }
>  #endif
>  #endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */
> 
> 
> 

