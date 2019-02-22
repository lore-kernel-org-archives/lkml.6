Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306F2C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08E820818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfBVKo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:44:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35615 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726135AbfBVKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:44:55 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MAaT5M011839;
        Fri, 22 Feb 2019 11:44:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qpc75j5n5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Feb 2019 11:44:50 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4B1031;
        Fri, 22 Feb 2019 10:44:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 768D32C54;
        Fri, 22 Feb 2019 10:44:49 +0000 (GMT)
Received: from [10.201.23.162] (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Feb
 2019 11:44:48 +0100
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: acknowledge the received
 creation message
To:     Xiang Xiao <xiaoxiang781216@gmail.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <wendy.liang@xilinx.com>,
        <kumar.gala@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     QianWenfa <qianwenfa@xiaomi.com>, Xiang Xiao <xiaoxiang@xiaomi.com>
References: <1549955596-19784-1-git-send-email-xiaoxiang@xiaomi.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <5cf04a05-938a-2dd0-d36b-e939f0c935ff@st.com>
Date:   Fri, 22 Feb 2019 11:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549955596-19784-1-git-send-email-xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiang,



On 2/12/19 8:13 AM, Xiang Xiao wrote:
> From: QianWenfa <qianwenfa@xiaomi.com>
> 
> the two phase handsake make the client could initiate the transfer
> immediately without the server side send any dummy message first.
As discussed on OpenAMP mailing list, the first point (from my pov) is
to figure out if this should be part of the rpmsg protocol or service
dependent (so managed by the rpmsg client itself)...


> 
> Signed-off-by: Wenfa Qian <qianwenfa@xiaomi.com>
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 664f957..e323c98 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -71,6 +71,7 @@ struct virtproc_info {
>  
>  /* The feature bitmap for virtio rpmsg */
>  #define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> +#define VIRTIO_RPMSG_F_ACK	1 /* RP supports name service acknowledge */
>  
>  /**
>   * struct rpmsg_hdr - common header for all rpmsg messages
> @@ -115,10 +116,12 @@ struct rpmsg_ns_msg {
>   *
>   * @RPMSG_NS_CREATE: a new remote service was just created
>   * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> + * @RPMSG_NS_ACK: acknowledge the previous creation message
>   */
>  enum rpmsg_ns_flags {
>  	RPMSG_NS_CREATE		= 0,
>  	RPMSG_NS_DESTROY	= 1,
> +	RPMSG_NS_ACK		= 2,
>  };
>  
>  /**
> @@ -330,13 +333,14 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
>  	int err = 0;
>  
>  	/* need to tell remote processor's name service about this channel ? */
> -	if (rpdev->announce && rpdev->ept &&
> +	if (rpdev->ept && (rpdev->announce ||
> +	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_ACK)) &&
>  	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {Regarding this condition i have a concern. If rpdev->announce is false
but  VIRTIO_RPMSG_F_ACK feature is set, this should generate an ack message.
Seems that this condition can occurs depending on the rpmsg_device
struct provided on registration, when rpmsg_dev_probe is called.

>  		struct rpmsg_ns_msg nsm;
>  
>  		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
>  		nsm.addr = rpdev->ept->addr;
> -		nsm.flags = RPMSG_NS_CREATE;
> +		nsm.flags = rpdev->announce ? RPMSG_NS_CREATE : RPMSG_NS_ACK;
>  
>  		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
>  		if (err)
> @@ -820,6 +824,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>  	struct rpmsg_channel_info chinfo;
>  	struct virtproc_info *vrp = priv;
>  	struct device *dev = &vrp->vdev->dev;
> +	struct device *tmp;
>  	int ret;
>  
>  #if defined(CONFIG_DYNAMIC_DEBUG)
> @@ -847,21 +852,30 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>  	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
>  
>  	dev_info(dev, "%sing channel %s addr 0x%x\n",
> -		 msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
> +		 msg->flags == RPMSG_NS_ACK ? "ack" :
> +		 msg->flags == RPMSG_NS_DESTROY ? "destroy" : "creat",
>  		 msg->name, msg->addr);
>  
>  	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
>  	chinfo.src = RPMSG_ADDR_ANY;
>  	chinfo.dst = msg->addr;
>  
> -	if (msg->flags & RPMSG_NS_DESTROY) {
> +	if (msg->flags == RPMSG_NS_DESTROY) {
>  		ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
>  		if (ret)
>  			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
> -	} else {
> +	} else if (msg->flags == RPMSG_NS_CREATE) {
>  		newch = rpmsg_create_channel(vrp, &chinfo);
>  		if (!newch)
>  			dev_err(dev, "rpmsg_create_channel failed\n");
> +	} else if (msg->flags == RPMSG_NS_ACK) {
> +		chinfo.dst = RPMSG_ADDR_ANY;
> +		tmp = rpmsg_find_device(&vrp->vdev->dev, &chinfo);
nit-picking... replace &vrp->vdev->dev by dev and change tmp by a more
explicit name.
> +		if (tmp) {
> +			newch = to_rpmsg_device(tmp);
> +			newch->dst = msg->addr;
> +		} else
typo: braces

Regards,
Arnaud
> +			dev_err(dev, "rpmsg_find_device failed\n");
>  	}
>  
>  	return 0;
> @@ -1028,6 +1042,7 @@ static struct virtio_device_id id_table[] = {
>  
>  static unsigned int features[] = {
>  	VIRTIO_RPMSG_F_NS,
> +	VIRTIO_RPMSG_F_ACK,
>  };
>  
>  static struct virtio_driver virtio_ipc_driver = {
> 
