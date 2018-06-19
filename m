Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88FBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9752920874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz1Imwz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9752920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755582AbeFSEg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeFSEgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:36:24 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1FB20874;
        Tue, 19 Jun 2018 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529382983;
        bh=Wy6WEF0djXltsuWdxDUCl6/NFElInXoS5X4pEbx5Ixw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sz1Imwz2HbNGOIcUX3CB/I9zTO5qYT4uCYU4m0Bn2vnykNAJ8R8Azv7Ijpq2tKwHV
         TYMkTOJLMuGfOTVVk60tN/eapR8wm1ilN1o5GtgVFLOwNXL5Z6Qz7ctTMmvM5RrPk2
         1XsuVAPFwAWYBK4dntk0AUBMifaliZLtiHNe4bjY=
Date:   Tue, 19 Jun 2018 10:06:15 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rpmsg: smd: fix kerneldoc warnings
Message-ID: <20180619043614.GP25852@vkoul-mobl>
References: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
 <20180618123339.24115-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618123339.24115-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-18, 13:33, Srinivas Kandagatla wrote:
> This patch fixes below kerneldoc warnings
> 
> qcom_smd.c:141: warning: Function parameter or member 'dev' not described in 'qcom_smd_edge'
> qcom_smd.c:141: warning: Function parameter or member 'name' not described in 'qcom_smd_edge'
> qcom_smd.c:141: warning: Function parameter or member 'new_channel_event' not described in 'qcom_smd_edge'
> qcom_smd.c:222: warning: Function parameter or member 'qsept' not described in 'qcom_smd_channel'
> qcom_smd.c:222: warning: Function parameter or member 'registered' not described in 'qcom_smd_channel'
> qcom_smd.c:222: warning: Function parameter or member 'state_change_event' not described in 'qcom_smd_channel'
> qcom_smd.c:222: warning: Function parameter or member 'drvdata' not described in 'qcom_smd_channel'
> qcom_smd.c:737: warning: Function parameter or member 'wait' not described in '__qcom_smd_send'
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> qcom_smd.c

this one looks out of place to me :)

> ---
>  drivers/rpmsg/qcom_smd.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 6437bbeebc91..8c6a142050f8 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -93,6 +93,8 @@ static const struct {
>  
>  /**
>   * struct qcom_smd_edge - representing a remote processor
> + * @dev:		device associated with this edge
> + * @name:		name of this edge
>   * @of_node:		of_node handle for information related to this edge
>   * @edge_id:		identifier of this edge
>   * @remote_pid:		identifier of remote processor
> @@ -106,6 +108,7 @@ static const struct {
>   * @channels_lock:	guard for modifications of @channels
>   * @allocated:		array of bitmaps representing already allocated channels
>   * @smem_available:	last available amount of smem triggering a channel scan
> + * @new_channel_event:	wait queue for new channel events
>   * @scan_work:		work item for discovering new channels
>   * @state_work:		work item for edge state changes
>   */
> @@ -172,10 +175,12 @@ struct qcom_smd_endpoint {
>  /**
>   * struct qcom_smd_channel - smd channel struct
>   * @edge:		qcom_smd_edge this channel is living on
> - * @qsdev:		reference to a associated smd client device
> + * @qsept:		reference to a associated smd endpoint
> + * @registered:		flag to indicate if the channel is registered
>   * @name:		name of the channel
>   * @state:		local state of the channel
>   * @remote_state:	remote state of the channel
> + * @state_change_event:	state change event
>   * @info:		byte aligned outgoing/incoming channel info
>   * @info_word:		word aligned outgoing/incoming channel info
>   * @tx_lock:		lock to make writes to the channel mutually exclusive
> @@ -187,6 +192,7 @@ struct qcom_smd_endpoint {
>   * @cb:			callback function registered for this channel
>   * @recv_lock:		guard for rx info modifications and cb pointer
>   * @pkt_size:		size of the currently handled packet
> + * @drvdata:		driver private data
>   * @list:		lite entry for @channels in qcom_smd_edge
>   */
>  struct qcom_smd_channel {
> @@ -726,6 +732,7 @@ static int qcom_smd_write_fifo(struct qcom_smd_channel *channel,
>   * @channel:	channel handle
>   * @data:	buffer of data to write
>   * @len:	number of bytes to write
> + * @wait:	flag to indicate if write has ca wait
>   *
>   * This is a blocking write of len bytes into the channel's tx ring buffer and
>   * signal the remote end. It will sleep until there is enough space available
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
