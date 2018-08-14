Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781EBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161472173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o1NJOtOJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PFyD8AAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161472173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeHNH5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:57:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeHNH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:57:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C44760B62; Tue, 14 Aug 2018 05:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534223502;
        bh=ID9csXLz3y8iQfVHusaDcadgD6D2SKfirqKWZZ09eeI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o1NJOtOJp/dPG7J/wU7B1YeRvNZnBYZtFKTN12XZmDDerMSA+LyMBo/eh7uBcj8w8
         ifwtIDAYdVvC/zbg82JrY0U1ybcAMflPXekUpZVXpKETkMvhvgzYjHkShsvjpbMHm8
         SdIELlQsqUbDhTsJvSlM4pXixaNMxRnA4aavV7ug=
Received: from [10.79.128.19] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58FD76076A;
        Tue, 14 Aug 2018 05:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534223501;
        bh=ID9csXLz3y8iQfVHusaDcadgD6D2SKfirqKWZZ09eeI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PFyD8AAbRtrTj7vugGnVCgtGKZ5n0zdg3LOnHyFvz9vFf3dujLxwDh0+c8+kkc0ay
         CMW95leVy0yVdV6cSosxcaJmRZxJ6nwYhpJ0/WOzYFAEmcb3sksEPoLk0YBjzZgfH7
         Ta8uvO2X3xCTVe+oMsK49dHv46jcI9FQfr3sBfGQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58FD76076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v1 10/10] MAINTAINERS: Add entry for Qualcomm TSENS
 thermal drivers
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <106a459af3882745e78cb9b774dcfda08a96a6dd.1533815718.git.amit.kucheria@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <15e7ae62-18ea-e9e3-eedf-9d6dda69c182@codeaurora.org>
Date:   Tue, 14 Aug 2018 10:41:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <106a459af3882745e78cb9b774dcfda08a96a6dd.1533815718.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/2018 6:02 PM, Amit Kucheria wrote:
> Create an entry for the TSENS drivers and mark them as maintained
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Thanks Amit for signing up to maintain this driver.

Acked-by: Rajendra Nayak <rnayak@codeaurora.org>

> ---
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68b4ff8ed205..ca6183d6d545 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11862,6 +11862,13 @@ L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
>   F:	drivers/iommu/qcom_iommu.c
>   
> +QUALCOMM TSENS THERMAL DRIVER
> +M:	Amit Kucheria <amit.kucheria@linaro.org>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/qcom/
> +
>   QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
>   M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
>   L:	linux-media@vger.kernel.org
> 
