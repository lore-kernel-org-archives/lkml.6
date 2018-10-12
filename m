Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8BAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934102086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dTmJwe43";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EsjwfLDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934102086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJLNld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:41:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeJLNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:41:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B91AF60BF7; Fri, 12 Oct 2018 06:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539324640;
        bh=1fkfAPhsJ22AbfA/7Fdc/oFJVLMjbUCfa21aA0GID3Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dTmJwe43HsgdUVbB8aQXwTXIKoTt0/bYWxAOPnW2aXUd8e83SmuwcGVMwLz9dX5/h
         DolO01ZFLcqov+/3F2d4+pUn35Byk6L4C5adwuwA26IfT6jFt+vNqIXYjQWWRQMWQa
         rc/xerixdRadEzmK27oDyM0y+GKfpyCzFTSGbElc=
Received: from [10.79.40.129] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83991600E6;
        Fri, 12 Oct 2018 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539324639;
        bh=1fkfAPhsJ22AbfA/7Fdc/oFJVLMjbUCfa21aA0GID3Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EsjwfLDDEOqGhp1aFUgJREI/IRB3LMAHtYKUD57Gv/I98rLqkyEwUApU5koJLHHpa
         PaJSE/vizbuX/kMqq594Zp7cTD+SJix4vbz73JhCiBGxkWZge8gS0ob3rKzbUHDl9P
         5hrmfg4crAbFVFSiNCq4z8nCucgGNNrpwo76N5B0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83991600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v3 1/1] scsi: ufs: make UFS Tx lane1 clock optional for
 QCOM platforms
To:     Can Guo <cang@codeaurora.org>, dianders@chromium.org,
        subhashj@codeaurora.org, asutoshd@codeaurora.org,
        evgreen@chromium.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1539306736-9519-1-git-send-email-cang@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <462df3c4-582b-ccf1-8ced-e0c084bca0f2@codeaurora.org>
Date:   Fri, 12 Oct 2018 11:40:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539306736-9519-1-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 6:42 AM, Can Guo wrote:
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>
> Per Qcom's UFS host controller HW design, the UFS Tx lane1 clock could be
> muxed with Tx lane0 clock, hence keep Tx lane1 clock optional by ignoring
> it if it is not provided in device tree. This change also performs some
> cleanup to lanes per direction checks when enable/disable lane clocks just
> for symmetry.
>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
> Changes since v2:
> - Incorporated review comments from Doug.
>
> Changes since v1:
> - Incorporated review comments from Doug.
> - Update the commit title and commit message.
>
>   drivers/scsi/ufs/ufs-qcom.c | 55 ++++++++++++++++++++++++---------------------
>   1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 2b38db2..dbc84cb 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -79,20 +79,28 @@ static int ufs_qcom_get_connected_tx_lanes(struct ufs_hba *hba, u32 *tx_lanes)
>   }
>   
>   static int ufs_qcom_host_clk_get(struct device *dev,
> -		const char *name, struct clk **clk_out)
> +		const char *name, struct clk **clk_out, bool optional)
>   {
>   	struct clk *clk;
>   	int err = 0;
>   
>   	clk = devm_clk_get(dev, name);
> -	if (IS_ERR(clk)) {
> -		err = PTR_ERR(clk);
> -		dev_err(dev, "%s: failed to get %s err %d",
> -				__func__, name, err);
> -	} else {
> +	if (!IS_ERR(clk)) {
>   		*clk_out = clk;
> +		return 0;
>   	}
>   
> +	err = PTR_ERR(clk);
> +
> +	if (optional && err == -ENOENT) {
> +		*clk_out = NULL;
> +		return 0;
> +	}
> +
> +	if (err != -EPROBE_DEFER)
> +		dev_err(dev, "failed to get %s err %d",
> +				name, err);
> +
>   	return err;
>   }
>   
> @@ -113,11 +121,9 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
>   	if (!host->is_lane_clks_enabled)
>   		return;
>   
> -	if (host->hba->lanes_per_direction > 1)
> -		clk_disable_unprepare(host->tx_l1_sync_clk);
> +	clk_disable_unprepare(host->tx_l1_sync_clk);
>   	clk_disable_unprepare(host->tx_l0_sync_clk);
> -	if (host->hba->lanes_per_direction > 1)
> -		clk_disable_unprepare(host->rx_l1_sync_clk);
> +	clk_disable_unprepare(host->rx_l1_sync_clk);
>   	clk_disable_unprepare(host->rx_l0_sync_clk);
>   
>   	host->is_lane_clks_enabled = false;
> @@ -141,24 +147,21 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
>   	if (err)
>   		goto disable_rx_l0;
>   
> -	if (host->hba->lanes_per_direction > 1) {
> -		err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
> +	err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
>   			host->rx_l1_sync_clk);
> -		if (err)
> -			goto disable_tx_l0;
> +	if (err)
> +		goto disable_tx_l0;
>   
> -		err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
> +	err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
>   			host->tx_l1_sync_clk);
> -		if (err)
> -			goto disable_rx_l1;
> -	}
> +	if (err)
> +		goto disable_rx_l1;
>   
>   	host->is_lane_clks_enabled = true;
>   	goto out;
>   
>   disable_rx_l1:
> -	if (host->hba->lanes_per_direction > 1)
> -		clk_disable_unprepare(host->rx_l1_sync_clk);
> +	clk_disable_unprepare(host->rx_l1_sync_clk);
>   disable_tx_l0:
>   	clk_disable_unprepare(host->tx_l0_sync_clk);
>   disable_rx_l0:
> @@ -172,25 +175,25 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>   	int err = 0;
>   	struct device *dev = host->hba->dev;
>   
> -	err = ufs_qcom_host_clk_get(dev,
> -			"rx_lane0_sync_clk", &host->rx_l0_sync_clk);
> +	err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
> +					&host->rx_l0_sync_clk, false);
>   	if (err)
>   		goto out;
>   
> -	err = ufs_qcom_host_clk_get(dev,
> -			"tx_lane0_sync_clk", &host->tx_l0_sync_clk);
> +	err = ufs_qcom_host_clk_get(dev, "tx_lane0_sync_clk",
> +					&host->tx_l0_sync_clk, false);
>   	if (err)
>   		goto out;
>   
>   	/* In case of single lane per direction, don't read lane1 clocks */
>   	if (host->hba->lanes_per_direction > 1) {
>   		err = ufs_qcom_host_clk_get(dev, "rx_lane1_sync_clk",
> -			&host->rx_l1_sync_clk);
> +			&host->rx_l1_sync_clk, false);
>   		if (err)
>   			goto out;
>   
>   		err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
> -			&host->tx_l1_sync_clk);
> +			&host->tx_l1_sync_clk, true);
>   	}
>   out:
>   	return err;

Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek
