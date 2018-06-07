Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vQ/fMcUZGVstXwAAmS7hNA
	; Thu, 07 Jun 2018 11:42:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B3756089E; Thu,  7 Jun 2018 11:42:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A02286063F;
	Thu,  7 Jun 2018 11:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A02286063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeFGLmf convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 07:42:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932183AbeFGLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:42:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57Bcopk118792
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 07:42:32 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jf334atp0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 07:42:32 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 12:42:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 12:42:21 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57BgKqG21692602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 11:42:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C41642041;
        Thu,  7 Jun 2018 12:32:40 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EAB142047;
        Thu,  7 Jun 2018 12:32:40 +0100 (BST)
Received: from localhost (unknown [9.124.222.26])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 12:32:40 +0100 (BST)
Date: Thu, 07 Jun 2018 17:12:18 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -tip v5 24/27] bpf: error-inject: kprobes: Clear
 current_kprobe and enable preempt in kprobe
To: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Josef Bacik <jbacik@fb.com>,
        James Hogan <jhogan@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        sparclinux@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812800822.10068.3306094708706993432.stgit@devbox>
In-Reply-To: <152812800822.10068.3306094708706993432.stgit@devbox>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18060711-0016-0000-0000-000001D92299
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060711-0017-0000-0000-0000322C3723
Message-Id: <1528371714.iz71qgzxv3.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=676 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> Clear current_kprobe and enable preemption in kprobe
> even if pre_handler returns !0.
> 
> This simplifies function override using kprobes.
> 
> Jprobe used to require to keep the preemption disabled and
> keep current_kprobe until it returned to original function
> entry. For this reason kprobe_int3_handler() and similar
> arch dependent kprobe handers checks pre_handler result
> and exit without enabling preemption if the result is !0.
> 
> After removing the jprobe, Kprobes does not need to
> keep preempt disabled even if user handler returns !0
> anymore.
> 
> But since the function override handler in error-inject
> and bpf is also returns !0 if it overrides a function,
> to balancing the preempt count, it enables preemption
> and reset current kprobe by itself.
> 
> That is a bad design that is very buggy. This fixes
> such unbalanced preempt-count and current_kprobes setting
> in kprobes, bpf and error-inject.
> 
> Note: for powerpc and x86, this removes all preempt_disable
> from kprobe_ftrace_handler because ftrace callbacks are
> called under preempt disabled.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: x86@kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  Changes in v5:
>   - Fix kprobe_ftrace_handler in arch/powerpc too.
> ---
>  arch/arc/kernel/kprobes.c            |    5 +++--
>  arch/arm/probes/kprobes/core.c       |   10 +++++-----
>  arch/arm64/kernel/probes/kprobes.c   |   10 +++++-----
>  arch/ia64/kernel/kprobes.c           |   13 ++++---------
>  arch/mips/kernel/kprobes.c           |    4 ++--
>  arch/powerpc/kernel/kprobes-ftrace.c |   15 ++++++---------
>  arch/powerpc/kernel/kprobes.c        |    7 +++++--

For the powerpc bits:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks,
Naveen
