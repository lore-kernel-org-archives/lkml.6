Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DE020882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DE020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934034AbeGISK1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:10:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933703AbeGISKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:10:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69I8Y5c129176
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 14:10:24 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4c3utetm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:10:24 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <abdhalee@linux.vnet.ibm.com>;
        Mon, 9 Jul 2018 12:10:23 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 12:10:20 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69IAJQQ14614926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 11:10:19 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86BDC6E059;
        Mon,  9 Jul 2018 12:10:19 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DCC06E04C;
        Mon,  9 Jul 2018 12:10:16 -0600 (MDT)
Received: from [9.84.221.249] (unknown [9.84.221.249])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 12:10:16 -0600 (MDT)
Subject: Re: [next-20180709][bisected 9cf57731][ppc] build fail with ld: BFD
 version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
From:   Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next <linux-next@vger.kernel.org>,
        stephen Rothwell <sfr@canb.auug.org.au>,
        mpe <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Jul 2018 23:40:14 +0530
In-Reply-To: <20180709114716.GN2476@hirez.programming.kicks-ass.net>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
         <20180709114716.GN2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070918-0036-0000-0000-00000A0CDBE2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009340; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01058929; UDB=6.00543425; IPR=6.00836849;
 MB=3.00022074; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 18:10:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070918-0037-0000-0000-0000480A7972
Message-Id: <1531159814.6480.11.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 13:47 +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 03:21:23PM +0530, Abdul Haleem wrote:
> > Greeting's
> > 
> > Today's next fails to build on powerpc with below error
> > 
> > kernel/cpu.o:(.data.rel+0x18e0): undefined reference to
> > `lockup_detector_online_cpu'
> > ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> > kernel/cpu.o:(.data.rel+0x18e8): undefined reference to
> > `lockup_detector_offline_cpu'
> > ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> > Makefile:1005: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> 
> Urgh, sorry about that. I think the below should cure that.
> 
> I got confused by all the varioud CONFIG options here abour and
> conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR it
> seems.
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 80664bbeca43..08f9247e9827 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -33,15 +33,10 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
>  #define sysctl_hardlockup_all_cpu_backtrace 0
>  #endif /* !CONFIG_SMP */
> 
> -extern int lockup_detector_online_cpu(unsigned int cpu);
> -extern int lockup_detector_offline_cpu(unsigned int cpu);
> -
>  #else /* CONFIG_LOCKUP_DETECTOR */
>  static inline void lockup_detector_init(void) { }
>  static inline void lockup_detector_soft_poweroff(void) { }
>  static inline void lockup_detector_cleanup(void) { }
> -#define lockup_detector_online_cpu	NULL
> -#define lockup_detector_offline_cpu	NULL
>  #endif /* !CONFIG_LOCKUP_DETECTOR */
> 
>  #ifdef CONFIG_SOFTLOCKUP_DETECTOR
> @@ -50,12 +45,18 @@ extern void touch_softlockup_watchdog(void);
>  extern void touch_softlockup_watchdog_sync(void);
>  extern void touch_all_softlockup_watchdogs(void);
>  extern unsigned int  softlockup_panic;
> -#else
> +
> +extern int lockup_detector_online_cpu(unsigned int cpu);
> +extern int lockup_detector_offline_cpu(unsigned int cpu);
> +#else /* CONFIG_SOFTLOCKUP_DETECTOR */
>  static inline void touch_softlockup_watchdog_sched(void) { }
>  static inline void touch_softlockup_watchdog(void) { }
>  static inline void touch_softlockup_watchdog_sync(void) { }
>  static inline void touch_all_softlockup_watchdogs(void) { }
> -#endif
> +
> +#define lockup_detector_online_cpu	NULL
> +#define lockup_detector_offline_cpu	NULL
> +#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
> 
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  void reset_hung_task_detector(void);
> 

Thanks Peter for the patch, build and boot is fine.

Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



