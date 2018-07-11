Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C66C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F5020652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F5020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390813AbeGKX3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:29:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388171AbeGKX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:29:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BNE0E6049761
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 19:23:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5s8w4fad-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 19:23:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 12 Jul 2018 00:23:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 00:23:00 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BNMxZp13893730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 23:22:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A3F11C04A;
        Thu, 12 Jul 2018 02:23:20 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D82811C04C;
        Thu, 12 Jul 2018 02:23:19 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.145.191.79])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 02:23:19 +0100 (BST)
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
Date:   Thu, 12 Jul 2018 01:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071123-0020-0000-0000-000002A587FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071123-0021-0000-0000-000020F1D0D7
Message-Id: <74beb5b9-1a49-ca42-4ffe-3bf042718ed0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110243
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Configures the AP adapters, usage domains and control domains for the
> KVM guest from the matrix configured via the mediated matrix device's
> sysfs attribute files.
> 
[..]
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

Are you sure this or works as expected? E.g. if adm_max == 15 the bitmaps
include the least significant 2 bytes but you want the other two.

> +}

