Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA81C2152E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oUwqnAqk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CKoueKAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA81C2152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeHZFrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 01:47:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeHZFrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 01:47:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 282ED604BE; Sun, 26 Aug 2018 02:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535249180;
        bh=53zILNaWd+DGlzukKlknhzimPIPgRCasmlcROaGcgMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUwqnAqk99QDt2B2r3VuMqM8FInK2QLOUQNghl9ohaQnKVoIeiTn6bz4PFnpyfoiT
         42nmS3FHjS67y8twf3RbtKOfcL5MdTO8vMr7AU61+dTKhaKTdISyCsbb0dGTndqZ0T
         lVJVlfcoIQPyLszLUk7sJylG2m2t9QuTGPnJn4kg=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 424DB604BE;
        Sun, 26 Aug 2018 02:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535249179;
        bh=53zILNaWd+DGlzukKlknhzimPIPgRCasmlcROaGcgMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKoueKAst4LON1wBSEDn/L+ck+I/VgKRKIjFdNtWgqdV9zZG7SBcqRGAWiQSoRg8I
         aIP6xqntl3P9vaJ7Nwe8tSMtYznne3pCUy23dqU1e8ndIj8UeO2fpz4r1wL5NGGLtj
         ZTeh1MOBwBAzJgAFMGIp1dnNvtfc5DSxaGuvryc4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 424DB604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Sat, 25 Aug 2018 20:06:18 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH] drivers: qcom: rpmh: avoid sending sleep/wake sets
 immediately
Message-ID: <20180826020618.GP5081@codeaurora.org>
References: <1535139252-20066-1-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1535139252-20066-1-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25 2018 at 13:34 -0600, Raju P.L.S.S.S.N wrote:
>Fix the redundant call being made to send the sleep and wake requests
>immediately to the controller.
>
>As per the patch[1], the sleep and wake request votes are cached in rpmh
>controller and sent during rpmh_flush(). These requests needs to be sent
>only during entry of deeper system low power modes or suspend.
>
>[1]https://patchwork.kernel.org/patch/10477533/
>
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
>---
> drivers/soc/qcom/rpmh.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>index f81488b..390e779 100644
>--- a/drivers/soc/qcom/rpmh.c
>+++ b/drivers/soc/qcom/rpmh.c
>@@ -237,9 +237,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
> 		WARN_ON(irqs_disabled());
> 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
> 	} else {
>-		ret = rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr),
>-				&rpm_msg->msg);
> 		/* Clean up our call by spoofing tx_done */
>+		ret = 0;
> 		rpmh_tx_done(&rpm_msg->msg, ret);
> 	}
>
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
>
