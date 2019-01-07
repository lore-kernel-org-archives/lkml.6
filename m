Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07D6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697262147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfAGNyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:54:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfAGNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:54:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07Ds4aW008107
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 08:54:09 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pv7d19uy8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:54:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 7 Jan 2019 13:49:08 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 13:49:04 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07Dn3IL63504638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 13:49:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D16F6AE045;
        Mon,  7 Jan 2019 13:49:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70336AE04D;
        Mon,  7 Jan 2019 13:49:03 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.141])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 13:49:03 +0000 (GMT)
Subject: Re: [PATCH v3 1/3] virtio-balloon: tweak config_changed
 implementation
To:     Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
 <1546844466-38079-2-git-send-email-wei.w.wang@intel.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Mon, 7 Jan 2019 14:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1546844466-38079-2-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19010713-0012-0000-0000-000002E350A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010713-0013-0000-0000-0000211A59CA
Message-Id: <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.01.2019 08:01, Wei Wang wrote:
> virtio-ccw has deadlock issues with reading the config space inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> The config_read_bitmap is used as a flag to the workqueue callbacks
> about the related config fields that need to be read.
> 
> The cmd_id_received is also renamed to cmd_id_received_cache, and
> the value should be obtained via virtio_balloon_cmd_id_received.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Together with 
  virtio_pci: use queue idx instead of array idx to set up the vq
  virtio: don't allocate vqs when names[i] = NULL

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

as already said, would be good to add cc stable (and a Fixes: tag)


> ---
>  drivers/virtio/virtio_balloon.c | 98 +++++++++++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 728ecd1..fb12fe2 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -61,6 +61,10 @@ enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_MAX
>  };
>  
> +enum virtio_balloon_config_read {
> +	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
> +};
> +
>  struct virtio_balloon {
>  	struct virtio_device *vdev;
>  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> @@ -77,14 +81,20 @@ struct virtio_balloon {
>  	/* Prevent updating balloon when it is being canceled. */
>  	spinlock_t stop_update_lock;
>  	bool stop_update;
> +	/* Bitmap to indicate if reading the related config fields are needed */
> +	unsigned long config_read_bitmap;
>  
>  	/* The list of allocated free pages, waiting to be given back to mm */
>  	struct list_head free_page_list;
>  	spinlock_t free_page_list_lock;
>  	/* The number of free page blocks on the above list */
>  	unsigned long num_free_page_blocks;
> -	/* The cmd id received from host */
> -	u32 cmd_id_received;
> +	/*
> +	 * The cmd id received from host.
> +	 * Read it via virtio_balloon_cmd_id_received to get the latest value
> +	 * sent from host.
> +	 */
> +	u32 cmd_id_received_cache;
>  	/* The cmd id that is actively in use */
>  	__virtio32 cmd_id_active;
>  	/* Buffer to store the stop sign */
> @@ -390,37 +400,31 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  	return num_returned;
>  }
>  
> +static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
> +{
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		return;
> +
> +	/* No need to queue the work if the bit was already set. */
> +	if (test_and_set_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
> +			     &vb->config_read_bitmap))
> +		return;
> +
> +	queue_work(vb->balloon_wq, &vb->report_free_page_work);
> +}
> +
>  static void virtballoon_changed(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  	unsigned long flags;
> -	s64 diff = towards_target(vb);
> -
> -	if (diff) {
> -		spin_lock_irqsave(&vb->stop_update_lock, flags);
> -		if (!vb->stop_update)
> -			queue_work(system_freezable_wq,
> -				   &vb->update_balloon_size_work);
> -		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> -	}
>  
> -	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> -		virtio_cread(vdev, struct virtio_balloon_config,
> -			     free_page_report_cmd_id, &vb->cmd_id_received);
> -		if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
> -			/* Pass ULONG_MAX to give back all the free pages */
> -			return_free_pages_to_mm(vb, ULONG_MAX);
> -		} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
> -			   vb->cmd_id_received !=
> -			   virtio32_to_cpu(vdev, vb->cmd_id_active)) {
> -			spin_lock_irqsave(&vb->stop_update_lock, flags);
> -			if (!vb->stop_update) {
> -				queue_work(vb->balloon_wq,
> -					   &vb->report_free_page_work);
> -			}
> -			spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> -		}
> +	spin_lock_irqsave(&vb->stop_update_lock, flags);
> +	if (!vb->stop_update) {
> +		queue_work(system_freezable_wq,
> +			   &vb->update_balloon_size_work);
> +		virtio_balloon_queue_free_page_work(vb);
>  	}
> +	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>  }
>  
>  static void update_balloon_size(struct virtio_balloon *vb)
> @@ -527,6 +531,17 @@ static int init_vqs(struct virtio_balloon *vb)
>  	return 0;
>  }
>  
> +static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
> +{
> +	if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
> +			       &vb->config_read_bitmap))
> +		virtio_cread(vb->vdev, struct virtio_balloon_config,
> +			     free_page_report_cmd_id,
> +			     &vb->cmd_id_received_cache);
> +
> +	return vb->cmd_id_received_cache;
> +}
> +
>  static int send_cmd_id_start(struct virtio_balloon *vb)
>  {
>  	struct scatterlist sg;
> @@ -537,7 +552,8 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
>  	while (virtqueue_get_buf(vq, &unused))
>  		;
>  
> -	vb->cmd_id_active = cpu_to_virtio32(vb->vdev, vb->cmd_id_received);
> +	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
> +					virtio_balloon_cmd_id_received(vb));
>  	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
>  	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
>  	if (!err)
> @@ -620,7 +636,8 @@ static int send_free_pages(struct virtio_balloon *vb)
>  		 * stop the reporting.
>  		 */
>  		cmd_id_active = virtio32_to_cpu(vb->vdev, vb->cmd_id_active);
> -		if (cmd_id_active != vb->cmd_id_received)
> +		if (unlikely(cmd_id_active !=
> +			     virtio_balloon_cmd_id_received(vb)))
>  			break;
>  
>  		/*
> @@ -637,11 +654,9 @@ static int send_free_pages(struct virtio_balloon *vb)
>  	return 0;
>  }
>  
> -static void report_free_page_func(struct work_struct *work)
> +static void virtio_balloon_report_free_page(struct virtio_balloon *vb)
>  {
>  	int err;
> -	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> -						 report_free_page_work);
>  	struct device *dev = &vb->vdev->dev;
>  
>  	/* Start by sending the received cmd id to host with an outbuf. */
> @@ -659,6 +674,23 @@ static void report_free_page_func(struct work_struct *work)
>  		dev_err(dev, "Failed to send a stop id, err = %d\n", err);
>  }
>  
> +static void report_free_page_func(struct work_struct *work)
> +{
> +	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> +						 report_free_page_work);
> +	u32 cmd_id_received;
> +
> +	cmd_id_received = virtio_balloon_cmd_id_received(vb);
> +	if (cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
> +		/* Pass ULONG_MAX to give back all the free pages */
> +		return_free_pages_to_mm(vb, ULONG_MAX);
> +	} else if (cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
> +		   cmd_id_received !=
> +		   virtio32_to_cpu(vb->vdev, vb->cmd_id_active)) {
> +		virtio_balloon_report_free_page(vb);
> +	}
> +}
> +
>  #ifdef CONFIG_BALLOON_COMPACTION
>  /*
>   * virtballoon_migratepage - perform the balloon page migration on behalf of
> @@ -885,7 +917,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  			goto out_del_vqs;
>  		}
>  		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
> -		vb->cmd_id_received = VIRTIO_BALLOON_CMD_ID_STOP;
> +		vb->cmd_id_received_cache = VIRTIO_BALLOON_CMD_ID_STOP;
>  		vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
>  		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
> 

