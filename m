Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C6C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717BC21471
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y7WwYOC/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y7WwYOC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717BC21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeIMDke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:40:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeIMDke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:40:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9726360594; Wed, 12 Sep 2018 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536791638;
        bh=1bD15yvhWTSoLZGmyUtQDXWG/LmgU6E79ev9mlP9LC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7WwYOC/jTTCZeIZ3T1MgeoJLYrQ3dioTwhgbuL3yBTv8MmnVDUPiIurbqZPwQCe8
         hTRTV+HH+HLHY4WhFBUC9VqCi7IMwGfcpq9Rs7pOf2A7Nrzaho+6s4DUvhwDPR8u02
         u+ZhDq2p3wZPJrLCpkbwnPF1crw/zws5HzNmGD+g=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E53756053B;
        Wed, 12 Sep 2018 22:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536791638;
        bh=1bD15yvhWTSoLZGmyUtQDXWG/LmgU6E79ev9mlP9LC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7WwYOC/jTTCZeIZ3T1MgeoJLYrQ3dioTwhgbuL3yBTv8MmnVDUPiIurbqZPwQCe8
         hTRTV+HH+HLHY4WhFBUC9VqCi7IMwGfcpq9Rs7pOf2A7Nrzaho+6s4DUvhwDPR8u02
         u+ZhDq2p3wZPJrLCpkbwnPF1crw/zws5HzNmGD+g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E53756053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 12 Sep 2018 16:33:56 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v2 5/6] drivers: qcom: rpmh-rsc: write PDC data
Message-ID: <20180912223356.GA11079@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-6-git-send-email-rplsssn@codeaurora.org>
 <20180912222809.GK22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180912222809.GK22824@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12 2018 at 16:28 -0600, Matthias Kaehlcke wrote:
>On Fri, Jul 27, 2018 at 03:34:48PM +0530, Raju P L S S S N wrote:
>> From: Lina Iyer <ilina@codeaurora.org>
>>
>> The Power Domain Controller can be programmed to wakeup the RSC and
>> setup the resources back in the active state, before the processor is
>> woken up by a timer interrupt. The wakeup value from the timer hardware
>> can be copied to the PDC which has its own timer and is in an always-on
>> power domain. Programming the wakeup value is done through a separate
>> register on the RSC.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>> Changes in v2:
>>    - Remove unnecessary EXPORT_SYMBOL
>> ---
>
>> +int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg)
>> +{
>> +	int i;
>> +	void __iomem *addr = drv->base + RSC_PDC_DRV_DATA;
>> +
>> +	if (!msg || !msg->cmds || msg->num_cmds != RSC_PDC_DATA_SIZE)
>> +		return -EINVAL;
>
>Is it really always exactly 2 (RSC_PDC_DATA_SIZE) commands?
>
Yes, always.

