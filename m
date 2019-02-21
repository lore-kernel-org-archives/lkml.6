Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01094C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F912083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nK2f9r7U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="goLAsUJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfBUPYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:24:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfBUPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:24:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7CAB460A0B; Thu, 21 Feb 2019 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550762644;
        bh=3fAzblEObj//tJoORp3OSn6zUJxccH9Vo0EQqE0yltY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nK2f9r7UeiJXJmoNFnpWoIVIUK7xX3lS+Ig5HdfJ5DQoAvamxLYMW7uvKYEeAQxLB
         dc5s0R1S09w5Re9sbdfNHuqRtj6fQZKzQsyaElxZO/49ZC8X9YKI+biTl6yx3SVtFb
         T7a4KWjsYUPE1fqvAWGY4rgIc+T5SIxpB0pA/8Xk=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70B83609F2;
        Thu, 21 Feb 2019 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550762643;
        bh=3fAzblEObj//tJoORp3OSn6zUJxccH9Vo0EQqE0yltY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goLAsUJP2HHUM8OzPokNcvWnYOnzRhfDGpbMbjLG9XZdLmvPnDfFk1QXSKDOMWYxk
         xdYX+EEc3yObb/CHj6PFGgBBR6g0Mod0I4Uv73foXIl/18l05fend4dWS1lR+rOTPu
         nJu1vmwpH1G5nHN8XNuNRLizu0do1pZIP6g1/j/M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70B83609F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 21 Feb 2019 08:24:02 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v1 2/2] drivers: soc: qcom: rpmh-rsc: Correct check for
 slot number
Message-ID: <20190221152402.GB17102@codeaurora.org>
References: <20190221124036.30535-1-rplsssn@codeaurora.org>
 <20190221124036.30535-3-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190221124036.30535-3-rplsssn@codeaurora.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21 2019 at 05:42 -0700, Raju P.L.S.S.S.N wrote:
>From: Maulik Shah <mkshah@codeaurora.org>
>
>The return index value from bitmap_find_next_zero_area can be higher
>than available slot. So correct the check to return error in such case.
>
>Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
>---
> drivers/soc/qcom/rpmh-rsc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>index 10b3102298c7..3ff3bebd4d71 100644
>--- a/drivers/soc/qcom/rpmh-rsc.c
>+++ b/drivers/soc/qcom/rpmh-rsc.c
>@@ -491,7 +491,7 @@ static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
> 	do {
> 		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
> 						  i, msg->num_cmds, 0);
>-		if (slot == tcs->num_tcs * tcs->ncpt)
>+		if (slot >= tcs->num_tcs * tcs->ncpt)
> 			return -ENOMEM;
> 		i += tcs->ncpt;
> 	} while (slot + msg->num_cmds - 1 >= i);
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>of the Code Aurora Forum, hosted by The Linux Foundation.
>
