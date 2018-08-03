Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D7C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5F621700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5F621700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbeHCCfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:35:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729118AbeHCCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:35:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w730cRxd127762
        for <linux-kernel@vger.kernel.org>; Thu, 2 Aug 2018 20:42:10 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmagu44nx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 20:42:10 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Thu, 2 Aug 2018 20:42:10 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Aug 2018 20:42:05 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w730g4XH10945148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 00:42:04 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE16DAC059;
        Thu,  2 Aug 2018 20:42:41 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A39FAC05E;
        Thu,  2 Aug 2018 20:42:41 -0400 (EDT)
Received: from localhost (unknown [9.85.153.136])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Aug 2018 20:42:40 -0400 (EDT)
Date:   Thu, 2 Aug 2018 21:42:01 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
 <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18080300-2213-0000-0000-000002D46A78
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009473; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01069338; UDB=6.00549867; IPR=6.00847837;
 MB=3.00022469; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-03 00:42:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080300-2214-0000-0000-00005B0FE16A
Message-Id: <20180803004201.GA5891@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Thu, Aug 02, 2018 at 07:26:20AM +0200, Christophe LEROY wrote:
>
>
> Le 01/08/2018 à 23:33, Murilo Opsfelder Araujo a écrit :
> > show_user_instructions() is a slightly modified version of
> > show_instructions() that allows userspace instruction dump.
> >
> > This will be useful within show_signal_msg() to dump userspace
> > instructions of the faulty location.
> >
> > Here is a sample of what show_user_instructions() outputs:
> >
> >    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
> >    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> >
> > The current->comm and current->pid printed can serve as a glue that
> > links the instructions dump to its originator, allowing messages to be
> > interleaved in the logs.
> >
> > Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> > ---
> >   arch/powerpc/include/asm/stacktrace.h | 13 +++++++++
> >   arch/powerpc/kernel/process.c         | 40 +++++++++++++++++++++++++++
> >   2 files changed, 53 insertions(+)
> >   create mode 100644 arch/powerpc/include/asm/stacktrace.h
> >
> > diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
> > new file mode 100644
> > index 000000000000..6149b53b3bc8
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/stacktrace.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Stack trace functions.
> > + *
> > + * Copyright 2018, Murilo Opsfelder Araujo, IBM Corporation.
> > + */
> > +
> > +#ifndef _ASM_POWERPC_STACKTRACE_H
> > +#define _ASM_POWERPC_STACKTRACE_H
> > +
> > +void show_user_instructions(struct pt_regs *regs);
> > +
> > +#endif /* _ASM_POWERPC_STACKTRACE_H */
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index e9533b4d2f08..364645ac732c 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1299,6 +1299,46 @@ static void show_instructions(struct pt_regs *regs)
> >   	pr_cont("\n");
> >   }
> > +void show_user_instructions(struct pt_regs *regs)
> > +{
> > +	int i;
> > +	const char *prefix = KERN_INFO "%s[%d]: code: ";
> > +	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
> > +					sizeof(int));
> > +
> > +	printk(prefix, current->comm, current->pid);
>
> Why not use pr_info() and remove KERN_INFO from *prefix ?

Because it doesn't compile:

  arch/powerpc/kernel/process.c:1317:10: error: expected ‘)’ before ‘prefix’
    pr_info(prefix, current->comm, current->pid);
            ^
  ./include/linux/printk.h:288:21: note: in definition of macro ‘pr_fmt’
   #define pr_fmt(fmt) fmt
                     ^

`pr_info(prefix, ...)` expands to `printk("\001" "6" prefix, ...)`,
which is an invalid string concatenation.

`pr_info("%s", ...)` expands to `printk("\001" "6" "%s", ...)`, which is
valid.

> > +
> > +	for (i = 0; i < instructions_to_print; i++) {
> > +		int instr;
> > +
> > +		if (!(i % 8) && (i > 0)) {
> > +			pr_cont("\n");
> > +			printk(prefix, current->comm, current->pid);
> > +		}
> > +
> > +#if !defined(CONFIG_BOOKE)
> > +		/* If executing with the IMMU off, adjust pc rather
> > +		 * than print XXXXXXXX.
> > +		 */
> > +		if (!(regs->msr & MSR_IR))
> > +			pc = (unsigned long)phys_to_virt(pc);
>
> Shouldn't this be done outside of the loop, only once ?

I don't think so.

pc gets incremented at the bottom of the loop:

  pc += sizeof(int);

Adjusting pc is necessary at each iteration.  Leaving this block inside
the loop seems correct.

Cheers
Murilo

