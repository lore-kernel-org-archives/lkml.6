Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5B92175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfBFRKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:10:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727218AbfBFRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:10:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16H9THp120604
        for <linux-kernel@vger.kernel.org>; Wed, 6 Feb 2019 12:09:59 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qg2pcmhmr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:09:58 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 6 Feb 2019 17:09:56 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 17:09:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16H9qeT57671802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 17:09:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75BC04203F;
        Wed,  6 Feb 2019 17:09:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A270642042;
        Wed,  6 Feb 2019 17:09:51 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.78.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Feb 2019 17:09:51 +0000 (GMT)
Subject: Re: [PATCH v7 00/15] KVM: s390: make use of the GIB
To:     Michael Mueller <mimu@linux.ibm.com>,
        KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Wed, 6 Feb 2019 18:09:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19020617-0020-0000-0000-00000313984F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020617-0021-0000-0000-000021649CCE
Message-Id: <bfedd077-c91d-a54d-cb00-5a290ab9b453@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series Applied and queued.
see https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=next


On 31.01.2019 09:52, Michael Mueller wrote:
> The Guest Information Area (GIB) and its mechanics is part of
> the AIV facility. It provides hardware support to process
> Adapter Interruptions (AI) for pagable storage mode guests. 
> 
> Whenever a guest cannot process an AI because none of its
> vcpus is running in SIE context, a GIB alert interruption is
> sent to and handled by the host program to dispatch a vcpu of
> the respective guest.
> 
> Eventually, the AI is handled by the guest.
> 
> v6->v7:
>   patches 1/15 to 7/15
>      prepare the existing Interruption and GISA code for
>      the introduction of the GIB code. (kept from v6)
>   patches 8/15 to 10/15
>      kept from v6.
>   patch 11/15
>      kvm_s390_gisc_register() now uses a single conditional
>      branch to extend IAM restore value and to set the IAM
>      in GISA. 
>   patch 12/15
>      kvm_s390_clear_gisa() now refactored in its own patch.
>   patch 13/15
>      I'm keeping the 50 usec timer expiration as the statistic
>      data shows a single timer restart only.
>        gisa_get_ipm_or_restore_iam() now called when entering
>      kvm_s390_handle_wait(). That saves some of the timer
>      restarts.
>        Some modifications in kvm_s390_gisa_destroy()
>   patch 14/15
>      kept from v6.
>   patch 15/15
>      additional test on non NULL gisa origin in pending_irqs()
> 
> v5->v6:
>   Futher significant change was introduced with this version
>   now:
> 
>   a) During the alert list processing now a hrtimer is
>      started to kick an idle vcpu with open I/O interrupt
>      mask. It then is restarted to monitor the interruption
>      consumption and when the IPM is clean (no relevant
>      ISCs pending anymore) atomically restores the IAM
>      and don't restarts or if new ISCs arrive kick other
>      idle vcpus.
> 
>   patches 1/13 to 7/13:
>      prepare the existing Interruption and GISA code for
>      the introduction of the GIB code.
>   patches 8/13 to 10/13:
>      kept from v5.
>   patch 11/13:
>      Some comments added.
>   patch 12/13:
>      Significatly changed due to the hrtimer control.
>   patch 13/13:
>      Basically kept from v5 except for a slight reordering
>      that shortens the patch.
> 
> v4->v5:
>   Between these two versions some significant change was
>   introduced:
> 
>   a) During IPM look-up, the IAM gets atomically restored
>      if the IPM is clean. (The main strategy is: As soon no
>      airqs are pending anymore, get prepared for new ones
>      arriving).
> 
>   b) Kick a set of vcpus in WAIT state, that will be able
>      to handle all ISCs in IPM if possible. The main loop
>      that processes the GIB alert list is unchanged.
> 
>   patches 1/15 to 6/15:
>      prepare the existing Interruption and GISA code for
>      the introduction of the GIB code.
>   patches 7/15 to 9/15:
>      kept from v4. 
>   patch 10/15:
>      restores the IAM in get_ipm() when clean on request
>      with additional parameter irq_flags
>   patch 12/15:
>      modifies kvm_s390_deliver_pending_interrupts() such
>      that the IAM is not restored during the deliverable_irqs()
>      test as we are about to enter the SIE. Restoring the
>      IAM would trigger the alert mechanism unnecessarily
>      on SIE entry.
>   patch 13/15:
>      process_gib_alert_list() now triggers a minimal set
>      of idle vcpus capable the handle all pending ISCs.
>   patch 14/15:
>      the wiring is logical similar to v4 but uses different
>      routines
>   patch 15/15: 
>      kept from v4. 
> 
> v3->v4:
>   The central change of v4 is that the metric "vcpus_in_sie"
>   has been dropped. A least agressive IAM restore strategy
>   is being followed now. The consequence is that potentially
>   more GAL interruptions are to be handled by the host program.
>   The assuption as made that as soon the first vcpu is trying
>   to go into wait state, this could be the last vcpu being
>   open for I/O interruptions. Thus, to not loose the initiative
>   to deliver I/O interruptions as soon as possible, the IAM
>   is restored. Adding better heuristics can be done in future.
> 
>   I expect this to be the last version of the series.
>  
>   patch 01/12: Kernel msg now printed when FLIC fails
>                to register during arch inititialization.
>   patch 03/12: Commit message slightly changed with the
>   	       hint that gib initialization is called
> 	       by last patch of this serias.
>   patch 09/12: IAM now restored during kvm_s390_handle_wait()
>   patch 10/12: gib destroy case now handled upon unsuccessful
>   	       arch inititialization.
> 
> All other patches are unchanged.
> 
> v2->v3:
>   patch 01/12: Fixes a resource dealocation issue upon
>   	       unsuccessful exit from kvm_arch_init().
> 	       It is relevant for patch 11/12 as well. 
>   patch 08/12: The function process_gib_alert_list() has
>                been rewritten to reduce the number of GAL
> 	       interruptions on the host for many guest
> 	       scenarios.
>   patch 10/12: The IAM is now never cleared before SIE entry.
>                It will be cleared by millicode as soon the
> 	       first guest interruption is made pending and
> 	       not directly processed in SIE. The IAM gets
> 	       restored as soon a vm is idle, i.e. no vcpu
> 	       of that guest is in SIE context anymore.
>   patch 11/12: now integrates with new patch 01/12
>   patch 12/12: This patch is just experimental and shall not
>                be part of the final series.
> 
> The first patch of series v2: "leave AIs in IPM of GISA
> during vcpu_pre_run()" has been dropped.
> 
> All other patches are unchanged.
> 
> v1->v2:
>   patch 01/12: New patch. Tt can go also standalone without the
>   	       rest of the GIB series presented here but is a
> 	       requirement 
>   patch 03/12: kvm_s390_gib_init() now has a return code
>   patch 06/12: unlink_gib_alert_list() now uses cmpxchg() instead
>     	       of atomic_xchg()
>   patch 08/12: New patch. Foctors out __find_vcpu_for_floating_irq()
>   patch 09/12: process_gib_alert_list() has been simplified
>                the GISA clear/destroy cases have been removed
>   patch 11/12: kvm_s390_gisa_clear/destroy() now clear the IAM
>                and process the alert list directly
> 	       The IAM now gets restored in vcpu_post_run() only if
> 	       the GISA is not in alert list
>   patch 12/12: during kvm_arch_init() now the return code of
>     	       kvm_s390_gib_init() is honored.
> 
> All other patches are unchanged.
> 
> Michael Mueller (15):
>   KVM: s390: drop obsolete else path
>   KVM: s390: make bitmap declaration consistent
>   KVM: s390: move bitmap idle_mask into arch struct top level
>   KVM: s390: coding style kvm_s390_gisa_init/clear()
>   KVM: s390: use pending_irqs_no_gisa() where appropriate
>   KVM: s390: remove kvm_s390_ from gisa static inline functions
>   KVM: s390: introduce struct kvm_s390_gisa_interrupt
>   s390/cio: add function chsc_sgib()
>   KVM: s390: add the GIB and its related life-cyle functions
>   KVM: s390: add kvm reference to struct sie_page2
>   KVM: s390: add functions to (un)register GISC with GISA
>   KVM: s390: kvm_s390_gisa_clear() now clears the IPM only
>   KVM: s390: add gib_alert_irq_handler()
>   KVM: s390: start using the GIB
>   KVM: s390: fix possible null pointer dereference in pending_irqs()
> 
>  arch/s390/include/asm/cio.h      |   1 +
>  arch/s390/include/asm/irq.h      |   1 +
>  arch/s390/include/asm/isc.h      |   1 +
>  arch/s390/include/asm/kvm_host.h |  36 +++-
>  arch/s390/kernel/irq.c           |   1 +
>  arch/s390/kvm/interrupt.c        | 431 +++++++++++++++++++++++++++++++++++----
>  arch/s390/kvm/kvm-s390.c         |  13 +-
>  arch/s390/kvm/kvm-s390.h         |   4 +-
>  drivers/s390/cio/chsc.c          |  37 ++++
>  drivers/s390/cio/chsc.h          |   1 +
>  10 files changed, 480 insertions(+), 46 deletions(-)
> 

