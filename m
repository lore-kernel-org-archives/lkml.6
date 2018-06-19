Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C98520836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h5p9mymx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h5p9mymx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C98520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938046AbeFSNMj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:12:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34902 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938031AbeFSNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:12:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91B9B604A6; Tue, 19 Jun 2018 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413954;
        bh=BZKLj2Ur+RGUP5IWqiRC/CVm84HDYFx5xU69X5Rvzt0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h5p9mymxotk8++S3g4Ev0NGb/UTxuwdrZsLSQt2kopQVoABEYj8RMXhLb0/Q5ygww
         8nq73U0a//ekEUn43eBbBqudWgNH4LjFHqSv0d4YlHeP/NKZhxeRSAS0xVySHc4g/r
         ToGyvDI6cQheCDpKoebZmZogPahvogMgZ+lYnMbU=
Received: from [10.206.16.80] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4927D60AD8;
        Tue, 19 Jun 2018 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413954;
        bh=BZKLj2Ur+RGUP5IWqiRC/CVm84HDYFx5xU69X5Rvzt0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h5p9mymxotk8++S3g4Ev0NGb/UTxuwdrZsLSQt2kopQVoABEYj8RMXhLb0/Q5ygww
         8nq73U0a//ekEUn43eBbBqudWgNH4LjFHqSv0d4YlHeP/NKZhxeRSAS0xVySHc4g/r
         ToGyvDI6cQheCDpKoebZmZogPahvogMgZ+lYnMbU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4927D60AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v11 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
 <1529329040-2606-4-git-send-email-rplsssn@codeaurora.org>
 <20180619052010.GA15126@tuxbook-pro>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <d06c84ea-4731-7d0e-b1b3-09efb09f7073@codeaurora.org>
Date:   Tue, 19 Jun 2018 18:42:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619052010.GA15126@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/19/2018 10:50 AM, Bjorn Andersson wrote:
> On Mon 18 Jun 06:37 PDT 2018, Raju P L S S S N wrote:
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 39d3a05..cb6300f 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +CFLAGS_rpmh-rsc.o := -I$(src)
> 
> Please rebase v12 onto v4.18-rc1, to make sure that the series apply
> cleanly.

Sure.

> 
> Regards,
> Bjorn
> 
