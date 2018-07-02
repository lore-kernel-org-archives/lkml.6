Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5315AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0874E2517D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0874E2517D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeGBP4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:56:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752415AbeGBP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:56:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62FrmJL115605
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 11:56:10 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jykxbghnn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:56:10 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 2 Jul 2018 11:56:08 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 11:56:06 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62Fu4O92294038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 15:56:04 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 417D3AE05F;
        Mon,  2 Jul 2018 11:55:48 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4954AE062;
        Mon,  2 Jul 2018 11:55:47 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.218])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 11:55:47 -0400 (EDT)
Subject: Re: [PATCH v6 05/21] KVM: s390: CPU model support for AP
 virtualization
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-6-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 2 Jul 2018 11:56:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070215-0040-0000-0000-0000044854E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009295; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055524; UDB=6.00541382; IPR=6.00833446;
 MB=3.00021964; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 15:56:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070215-0041-0000-0000-0000084E70BA
Message-Id: <e83a1433-649f-5540-016b-aa2c96f66d02@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 05:11 PM, Tony Krowiak wrote:
> Introduces a new CPU model feature and two CPU model
> facilities to support AP virtualization for KVM guests.
>
> CPU model feature:
>
> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
> AP instructions are available on the guest. This
> feature will be enabled by the kernel only if the AP
> instructions are installed on the linux host. This feature
> must be specifically turned on for the KVM guest from
> userspace to use the VFIO AP device driver for guest
> access to AP devices.
>
> CPU model facilities:
>
> 1. AP Query Configuration Information (QCI) facility is installed.
>
>     This is indicated by setting facilities bit 12 for
>     the guest. The kernel will not enable this facility
>     for the guest if it is not set on the host. This facility
>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>     feature is not installed.
>
>     If this facility is not set for the KVM guest, then only
>     APQNs with an APQI less than 16 will be available to the
>     guest regardless of the guest's matrix configuration. This
>     is a limitation of the AP bus running on the guest.
>
> 2. AP Facilities Test facility (APFT) is installed.
>
>     This is indicated by setting facilities bit 15 for
>     the guest. The kernel will not enable this facility for
>     the guest if it is not set on the host. This facility
>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>     feature is not installed.
>
>     If this facility is not set for the KVM guest, then no
>     AP devices will be available to the guest regardless of
>     the guest's matrix configuration. This is a limitation
>     of the AP bus running under the guest.
>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   arch/s390/include/uapi/asm/kvm.h |    1 +
>   arch/s390/kvm/kvm-s390.c         |    8 ++++++++
>   arch/s390/tools/gen_facilities.c |    3 +++
>   3 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 4cdaa55..a580dec 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>   #define KVM_S390_VM_CPU_FEAT_KSS	13
> +#define KVM_S390_VM_CPU_FEAT_AP		14
>   struct kvm_s390_vm_cpu_feat {
>   	__u64 feat[16];
>   };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3b7a515..d2208d4 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -40,6 +40,7 @@
>   #include <asm/sclp.h>
>   #include <asm/cpacf.h>
>   #include <asm/timex.h>
> +#include <asm/ap.h>
>   #include "kvm-s390.h"
>   #include "gaccess.h"
>   
> @@ -366,6 +367,13 @@ static void kvm_s390_cpu_feat_init(void)
>   
>   	if (MACHINE_HAS_ESOP)
>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
> +
> +	/*
> +	 * Check if AP instructions installed on host
> +	 */
> +	if (ap_instructions_available() == 0)
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
> +
>   	/*
>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 90a8c9e..e0e2c19 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -106,6 +106,9 @@ struct facility_def {
>   
>   		.name = "FACILITIES_KVM_CPUMODEL",
>   		.bits = (int[]){
> +			12, /* AP Query Configuration Information */
> +			15, /* AP Facilities Test */
> +			156, /* Execution Token facility */

Oops. This last one is an error, the result of a faulty merge with the 
latest
code base.

>   			-1  /* END */
>   		}
>   	},


