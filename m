Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE73C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30F7217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfAIQ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:29:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbfAIQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:29:51 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09GTmKm125748
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 11:29:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwjn9x60s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 11:29:42 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 9 Jan 2019 16:29:26 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 16:29:21 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09GTKvW24379564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 16:29:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E0FA4055;
        Wed,  9 Jan 2019 16:29:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24561A4051;
        Wed,  9 Jan 2019 16:29:20 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.32.142])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 16:29:20 +0000 (GMT)
Subject: Re: [PATCH v1 1/2] virtio_pci: use queue idx instead of array idx to
 set up the vq
To:     Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     pbonzini@redhat.com, dgilbert@redhat.com
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
 <1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Wed, 9 Jan 2019 17:29:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19010916-0008-0000-0000-000002AE6FCC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010916-0009-0000-0000-0000221A7273
Message-Id: <ed55e8b4-1274-a57e-bc84-c857f9d661fe@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: stable@vger.kernel.org
Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")


On 28.12.2018 03:26, Wei Wang wrote:
> When find_vqs, there will be no vq[i] allocation if its corresponding
> names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> with names[2] being NULL because the related feature bit is turned off,
> so technically there are 3 queues on the device, and name[4] should
> correspond to the 3rd queue on the device.
> 
> So we use queue_idx as the queue index, which is increased only when the
> queue exists.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 465a6f5..d0584c0 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -285,7 +285,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	u16 msix_vec;
> -	int i, err, nvectors, allocated_vectors;
> +	int i, err, nvectors, allocated_vectors, queue_idx = 0;
>  
>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
> @@ -321,7 +321,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  			msix_vec = allocated_vectors++;
>  		else
>  			msix_vec = VP_MSIX_VQ_VECTOR;
> -		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
> +		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
>  				     ctx ? ctx[i] : false,
>  				     msix_vec);
>  		if (IS_ERR(vqs[i])) {
> @@ -356,7 +356,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
>  		const char * const names[], const bool *ctx)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	int i, err;
> +	int i, err, queue_idx = 0;
>  
>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
> @@ -374,7 +374,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
>  			vqs[i] = NULL;
>  			continue;
>  		}
> -		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
> +		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
>  				     ctx ? ctx[i] : false,
>  				     VIRTIO_MSI_NO_VECTOR);
>  		if (IS_ERR(vqs[i])) {
> 

