Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7958C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0452184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfAWNYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:24:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbfAWNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:24:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NDHSO8144437
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:24:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q6q07wx9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:24:09 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 23 Jan 2019 13:24:07 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 13:24:04 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NDO2Q941943274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 13:24:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A46FCA405C;
        Wed, 23 Jan 2019 13:24:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70274A4054;
        Wed, 23 Jan 2019 13:24:02 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Jan 2019 13:24:02 +0000 (GMT)
Date:   Wed, 23 Jan 2019 14:24:01 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Laura Abbott <labbott@redhat.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
References: <20190123125513.20210-1-labbott@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190123125513.20210-1-labbott@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19012313-0028-0000-0000-0000033D069A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012313-0029-0000-0000-000023FA444F
Message-Id: <20190123132401.GG3424@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
> There's a build failure with gcc9:
> 
>  ./arch/s390/include/asm/jump_label.h: Assembler messages:
>  ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
>  ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
>  make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
> 
> According to the toolchain people, the actual issue is the use of
> "X" constraint which is too permissive. Switch to using "i" instead.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1668703
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/s390/include/asm/jump_label.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
> index e2d3e6c43395..41dabfd8518d 100644
> --- a/arch/s390/include/asm/jump_label.h
> +++ b/arch/s390/include/asm/jump_label.h
> @@ -22,7 +22,7 @@ static inline bool arch_static_branch(struct static_key *key, bool branch)
>  			  ".long	0b-.,%l[label]-.\n"
>  			  ".quad	%0-.\n"
>  			  ".popsection\n"
> -			  : : "X" (&((char *)key)[branch]) : : label);
> +			  : : "i" (&((char *)key)[branch]) : : label);
>  	return false;
>  label:
>  	return true;

Hmmm, this works only for the kernel image, but not for modules, which
we compile with "-fPIC", which again doesn't work as described in the
referenced bugzilla:

In file included from ././include/linux/compiler_types.h:68,
                 from <command-line>:
./arch/s390/include/asm/jump_label.h: In function 'kvm_vcpu_ioctl':
./include/linux/compiler-gcc.h:124:38: warning: asm operand 0 probably doesn't match constraints
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
  ^~~~~~~~~~~~~~~~~
./include/linux/compiler-gcc.h:124:38: error: impossible constraint in 'asm'
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"

Andreas, Ilya, any idea how to fix this?

