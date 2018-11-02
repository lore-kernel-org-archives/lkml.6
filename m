Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95237C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415A320831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415A320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeKCAWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:22:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbeKCAWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:22:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2FEh93026399
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 11:14:54 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ngrxc8axg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:14:54 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 2 Nov 2018 15:14:53 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 15:14:49 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2FEj4Y19005516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 15:14:45 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 098416A051;
        Fri,  2 Nov 2018 15:14:45 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 510506A047;
        Fri,  2 Nov 2018 15:14:43 +0000 (GMT)
Received: from [9.80.230.50] (unknown [9.80.230.50])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 15:14:43 +0000 (GMT)
Subject: Re: [PATCH v1 3/7] vfio: ap: AP Queue Interrupt structures
 definitions
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-4-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 2 Nov 2018 11:14:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541009577-29656-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18110215-8235-0000-0000-00000E208BF1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009972; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111622; UDB=6.00576090; IPR=6.00891713;
 MB=3.00024005; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 15:14:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110215-8236-0000-0000-0000433848E7
Message-Id: <c440a74d-bea6-1416-4b54-0894e21c4a6c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 2:12 PM, Pierre Morel wrote:
> We define all the structures we need to let GISA handle
> the AP Queues Interrupt.
> 
> This patch defines the inline assembler for AP Queue Interrupt
> Control instruction with GISA, some utilities to manipulate
> the data in the registers used by this instruction.
> 
> We also define new ap_matrix components to handle interruptions
> and adapter mapping.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_private.h | 77 +++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 5675492233c7..45103865bd7f 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -74,15 +74,92 @@ struct ap_matrix {
>    * @group_notifier: notifier block used for specifying callback function for
>    *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
>    * @kvm:	the struct holding guest's state
> + * @map:	the adapter information for QEMU mapping
> + * @gisc:	the Guest ISC
>    */
>   struct ap_matrix_mdev {
>   	struct list_head node;
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;
>   	struct kvm *kvm;
> +	struct s390_map_info *map;
> +	unsigned char gisc;
>   };
>   
>   extern int vfio_ap_mdev_register(void);
>   extern void vfio_ap_mdev_unregister(void);
>   
> +/* AP Queue Interrupt Control associated structures and functions */
> +struct aqic_gisa {
> +	uint8_t  rzone;
> +	uint8_t  izone;
> +	unsigned	ir:1;
> +	unsigned	reserved1:4;
> +	unsigned	gisc:3;
> +	unsigned	reserved2:6;
> +	unsigned	f:2;
> +	unsigned	reserved3:1;
> +	unsigned	gisao:27;
> +	unsigned	t:1;
> +	unsigned	isc:3;
> +}  __packed __aligned(8);

This struct is redundant with the 'struct ap_qirq_ctrl'
defined in arch/s390/include/asm/ap.h. That file also includes
the asm for the ap_aqic function.

> +
> +struct ap_status {
> +	unsigned	e:1;
> +	unsigned	r:1;
> +	unsigned	f:1;
> +	unsigned	reserved:4;
> +	unsigned	i:1;
> +	unsigned	rc:8;
> +	unsigned	pad:16;
> +}  __packed __aligned(4);
> +
> +static inline uint32_t status2reg(struct ap_status a)
> +{
> +	return *(uint32_t *)(&a);
> +}
> +
> +static inline struct ap_status reg2status(uint32_t r)
> +{
> +	return *(struct ap_status *)(&r);
> +}
> +
> +static inline struct aqic_gisa reg2aqic(uint64_t r)
> +{
> +	return *((struct aqic_gisa *)&r);
> +}
> +
> +static inline uint64_t aqic2reg(struct aqic_gisa a)
> +{
> +	return *((uint64_t *)&a);
> +}
> +
> +/**
> + * ap_host_aqic - Issue the host AQIC instruction.
> + * @apqn is the AP queue number
> + * @gr1  the caller must have setup the register
> + *       with GISA address and format, with interrupt
> + *       request, ISC and guest ISC
> + * @gr2  the caller must have setup the register
> + *       to the guest NIB physical address
> + *
> + * issue the AQIC PQAP instruction and return the AP status
> + * word
> + */
> +static inline uint32_t ap_host_aqic(uint64_t apqn, uint64_t gr1,
> +				    uint64_t gr2)
> +

> +	register unsigned long reg0 asm ("0") = apqn | (3UL << 24);
> +	register unsigned long reg1_in asm ("1") = gr1;
> +	register uint32_t reg1_out asm ("1");
> +	register unsigned long reg2 asm ("2") = gr2;
> +
> +	asm volatile(
> +		".long 0xb2af0000"	  /* PQAP(AQIC) */
> +		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
> +		:
> +		: "cc");
> +	return reg1_out;
> +}

This function is redundant to the ap_aqic function in
arch/s390/include/asm/ap.h

> +
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

