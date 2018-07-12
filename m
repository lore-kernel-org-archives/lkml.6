Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734AAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2556020871
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2556020871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeGLNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:38:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbeGLNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:38:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CDOSWc096688
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:28:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k66fjmf5m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:28:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 12 Jul 2018 14:28:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 14:28:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CDSksr21495968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 13:28:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFB5BA4057;
        Thu, 12 Jul 2018 16:29:07 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2F50A404D;
        Thu, 12 Jul 2018 16:29:06 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.152.224.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 16:29:06 +0100 (BST)
Subject: Re: [PATCH v6 15/21] s390: vfio-ap: configure the guest's AP matrix
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-16-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Thu, 12 Jul 2018 15:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071213-0012-0000-0000-0000028978BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071213-0013-0000-0000-000020BB20D4
Message-Id: <fb3480f2-2cdb-d8fb-c92e-4af49e74327d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Configures the AP adapters, usage domains and control domains for the

[..]

> +static inline void kvm_ap_clear_crycb_masks(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb0, 0,
> +	       sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb0));
> +	memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb1, 0,
> +	       sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb1));
> +}
> +
> +static void kvm_ap_set_crycb_masks(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	int nbytes;
> +	unsigned long *apm, *aqm, *adm;
> +
> +	kvm_ap_clear_crycb_masks(matrix_mdev);
> +
> +	apm = kvm_ap_get_crycb_apm(matrix_mdev);
> +	aqm = kvm_ap_get_crycb_aqm(matrix_mdev);
> +	adm = kvm_ap_get_crycb_adm(matrix_mdev);
> +
> +	nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.apm_max + 1);
> +	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
> +
> +	nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.aqm_max + 1);
> +	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
> +
> +	/*
> +	 * Merge the AQM and ADM since the ADM is a superset of the
> +	 * AQM by agreed-upon convention.
> +	 */
> +	bitmap_or(adm, matrix_mdev->matrix.adm, matrix_mdev->matrix.aqm,
> +		  matrix_mdev->matrix.adm_max + 1);
> +}
> +

[..]

> +
> +static int kvm_ap_configure_matrix(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&matrix_mdev->kvm->lock);
> +
> +	ret = kvm_ap_validate_queue_sharing(matrix_mdev);
> +	if (ret)
> +		goto done;
> +
> +	kvm_ap_set_crycb_masks(matrix_mdev);
> +
> +done:
> +	mutex_unlock(&matrix_mdev->kvm->lock);
> +
> +	return ret;
> +}
> +
> +void kvm_ap_deconfigure_matrix(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	mutex_lock(&matrix_mdev->kvm->lock);
> +	kvm_ap_clear_crycb_masks(matrix_mdev);

The guest may be running at this point of time, or?

I think you need our safe update operation that we used to use for the
initial set too, but then somebody was like it ain't necessary because
we don't support hotplug (yet).


Regards,
Halil

> +	mutex_unlock(&matrix_mdev->kvm->lock);
> +}
> +

