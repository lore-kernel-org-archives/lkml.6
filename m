Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8807C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BE220881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BE220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeGIMUw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:20:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933180AbeGIMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:20:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69CKDe3005827
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 08:20:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k45n9y93s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:20:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Jul 2018 13:20:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 13:20:39 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69CKbA137552242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 12:20:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A9624204B;
        Mon,  9 Jul 2018 15:21:00 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55AAF42047;
        Mon,  9 Jul 2018 15:20:59 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 15:20:59 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 13/21] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
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
 <1530306683-7270-14-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 9 Jul 2018 14:20:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-14-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070912-0016-0000-0000-000001E4D7A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070912-0017-0000-0000-0000323956D2
Message-Id: <ef3d480b-29b3-d184-4fb2-14f88961d97d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2018 23:11, Tony Krowiak wrote:
> Provides a sysfs interface to view the AP matrix configured for the
> mediated matrix device.
>
> The relevant sysfs structures are:
>
> /sys/devices/vfio_ap
> ... [matrix]
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. matrix
>
> To view the matrix configured for the mediated matrix device,
> print the matrix file:
>
> 	cat matrix
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c |   31 +++++++++++++++++++++++++++++++
>   1 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index c8f31f3..bc7398d 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -697,6 +697,36 @@ static ssize_t control_domains_show(struct device *dev,
>   }
>   DEVICE_ATTR_RO(control_domains);
>
> +static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	char *bufpos = buf;
> +	unsigned long apid;
> +	unsigned long apqi;
> +	unsigned long napm = matrix_mdev->matrix.apm_max + 1;
> +	unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
> +	int nchars = 0;
> +	int n;
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm) {
> +		n = sprintf(bufpos, "%02lx\n", apid);
> +		bufpos += n;
> +		nchars += n;
> +
> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm) {
> +			n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
> +			bufpos += n;
> +			nchars += n;
> +		}
> +	}
> +
> +	return nchars;
> +}
> +DEVICE_ATTR_RO(matrix);
> +
> +
>   static struct attribute *vfio_ap_mdev_attrs[] = {
>   	&dev_attr_assign_adapter.attr,
>   	&dev_attr_unassign_adapter.attr,
> @@ -705,6 +735,7 @@ static ssize_t control_domains_show(struct device *dev,
>   	&dev_attr_assign_control_domain.attr,
>   	&dev_attr_unassign_control_domain.attr,
>   	&dev_attr_control_domains.attr,
> +	&dev_attr_matrix.attr,
>   	NULL,
>   };
>

I have still the same remark: what you show here is not what is currently
used by the SIE.
It is not irrelevant but what the guest really use may be more interesting
for the admin.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

