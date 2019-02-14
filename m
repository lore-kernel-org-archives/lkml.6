Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD0BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7227321916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439986AbfBNUev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:34:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439968AbfBNUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:34:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EKYnxD016196
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:34:49 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qndrfqxhx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:34:47 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 14 Feb 2019 20:34:06 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 20:34:03 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EKXwlY28967108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 20:33:58 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED4AE6E04E;
        Thu, 14 Feb 2019 20:33:57 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FA886E04C;
        Thu, 14 Feb 2019 20:33:56 +0000 (GMT)
Received: from [9.80.213.209] (unknown [9.80.213.209])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 20:33:55 +0000 (GMT)
Subject: Re: [PATCH v3 0/9] [RFC] vfio: ap: ioctl definitions for AP Queue
 Interrupt Control
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 14 Feb 2019 15:33:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021420-0012-0000-0000-0000170B17EF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010596; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161083; UDB=6.00606048; IPR=6.00941639;
 MB=3.00025585; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-14 20:34:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021420-0013-0000-0000-00005634C367
Message-Id: <e3d4788e-eb01-6337-4267-432af53762e0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:51 AM, Pierre Morel wrote:

The subject leads one to believe this patch series introduces
ioctl definitions for AQIC, but there is not a single ioctl
definition in the series. Something like this might be more
appropriate:

vfio: ap: support for AP Queue Interrupt Control

Regards
T. Krow

> This patch implement PQAP/AQIC interception in KVM.
> 
> To implement this we need to add a new structure, vfio_ap_queue,to be
> able to retrieve the mediated device associated with a queue and specific
> values needed to register/unregister the interrupt structures:
>   - APQN: to be able to issue the commands and search for queue structures
>   - NIB : to unpin the NIB on clear IRQ
>   - ISC : to unregister with the GIB interface
>   - MATRIX: a pointer to the matrix mediated device
>   - DEV: a pointer to the AP queue device from AP bus.
> 
> 
> 1) Phase 1, probe and remove from vfio_ap_queue
> 
> The vfio_ap_queue structures are dynamically allocated when a queue
> is probed by the ap_vfio_driver.
> It is linked to the ap_queue device as the driver data.
> We store the APQN of the ap_queue device inside the vfio_ap_queue.
> The vfio_ap_queue are free during remove.
> 
> 
> 2) Phase 2, assignment of vfio_ap_queue to a mediated device
> 
> When the VFIO device is opened the queues are associated to
> the mediated device, at the same time the CRYCB is setup.
> 
> When the device is closed or if a queue is removed the queue is
> dissociated from the mediated device, as the same time the
> CRYCB is cleared.
> 
> Two new functions are used for this: associate/disassociate.
> 
> 
> 3) Phase 3 intercepting the PQAP/AQIC instruction
> 
> On interception of the PQAP/AQIC instruction, the interception code
> makes sure the pqap_hook is initialized and allowed to be called
> and call it.
> Otherwise it reports the usual -EOPNOTSUPP return code to let
> QEMU handle the fault.
>    
> the pqap callback search for the queue asociated with the APQN
> stored in the register 0, setting the code to "illegal APQN"
> if the vfio_ap_queue can not be found.
> 
> Depending on the "i" bit of the register 1, the pqap callback
> setup or clear the interruption by calling the host format PQAP/AQIC
> instruction.
> When seting up the interruption it uses the NIB and the guest ISC
> provided by the guest and the host ISC provided by the registration
> to the GIB code, pin the NIB and also stores ISC and NIB inside
> the vfio_ap_queue structure.
> When clearing the interrupt it retrieves the host ISC to unregister
> with the GIB code and unpin the NIB.
> 
> There is a QEMU patch which is needed to enable the PQAP/AQIC
> facility in the guest.
> 
> Posted in qemu-devel@nongnu.org as:
> Message-Id: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>
> 
> 
> 4) Phase 4 clean dissociation from the mediated device on remove
> 
> On removing of the AP device the remove callback is called.
> To be sure that the guest will not access the queue anymore
> we clear the APID CRYCB bit.
> Cleaning the APID, over the APQI, is chosen because the architecture
> specifies that only the APID can be dynamically changed outside IPL.
> After this the queue is zeroes, care is taken to correctly wait until
> the queue is empty.
> 
> 
> 
> Pierre Morel (9):
>    s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem
>    s390: ap: kvm: setting a hook for PQAP instructions
>    s390: ap: new vfio_ap_queue structure
>    s390: ap: tools to find a queue with a specific APQN
>    s390: ap: tools to associate a queue to a matrix
>    vfio: ap: register IOMMU VFIO notifier
>    s390: ap: implement PAPQ AQIC interception in kernel
>    s390: ap: Cleanup on removing the AP device
>    s390: ap: kvm: add AP Queue Interruption Control facility
> 
>   arch/s390/include/asm/kvm_host.h      |   1 +
>   arch/s390/kvm/priv.c                  |  50 +++++
>   arch/s390/tools/gen_facilities.c      |   1 +
>   drivers/s390/crypto/ap_bus.h          |   1 +
>   drivers/s390/crypto/vfio_ap_drv.c     | 178 ++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_ops.c     | 363 +++++++++++++++++++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_private.h |  12 ++
>   7 files changed, 593 insertions(+), 13 deletions(-)
> 

