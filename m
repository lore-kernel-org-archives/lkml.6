Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C63EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12081206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oupvfbcI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HPAFGFX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12081206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeLEKLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:11:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEKLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:11:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EDD51612F3; Wed,  5 Dec 2018 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544004689;
        bh=dh9ObBy7Oqfk20TVh1hAXsBltiW7p6iPVpmKKNSpEFo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=oupvfbcItvt1QQpQDQLUF9P4yUG9tk/TaRsh1Gaum7cDfSMnEduB78NG52SLm+xY+
         E2hoMggnOeZgEdFVZZR/Q18FUzB30ER8ouW4Nprgp7ZGkC6a7NO7S4ahCEo9oOqoB/
         MrZQo3G5L6MUSFa1169Kf7sdhiFdiJ7D1KxMns2w=
Received: from [10.79.128.218] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 064B961343;
        Wed,  5 Dec 2018 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544004688;
        bh=dh9ObBy7Oqfk20TVh1hAXsBltiW7p6iPVpmKKNSpEFo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=HPAFGFX/8YJqCpS4hp1T5QIe3sBT6suCnsx9rcDU9bYNDkL9BA0+K5hLBz5qRBWEs
         HzYBlqAR82DGcu6kkTDlFhBeosLw1XLNWtaGIXKIF7XNVK4GhovBM34JtKHOC+VEI8
         xXQBfUBqrcMh0/4rT7k3H9LEA5u4VJYlC9JW76Lk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 064B961343
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 4/8] soc: qcom: rpmpd: Add support for get/set
 performance state
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-5-rnayak@codeaurora.org>
 <154396526967.88331.13652897075952274639@swboyd.mtv.corp.google.com>
 <d9317471-fb81-482a-22c1-4a7b466a1df4@codeaurora.org>
Message-ID: <c1676ab0-5981-52be-18f3-44ee266e195d@codeaurora.org>
Date:   Wed, 5 Dec 2018 15:41:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <d9317471-fb81-482a-22c1-4a7b466a1df4@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/5/2018 12:33 PM, Rajendra Nayak wrote:
>>
>>> +               return 0;
>>> +       }
>>> +
>>> +       of_node_put(np);
>>
>> This same code exists twice. Perhaps a helper needs to exist for
>> qcom_rpm_get_performance() to pull the number out of the DT.
> 
> Sure I can make both drivers use a common helper instead of duplicating it.

which would mean I will need to create a new file just to define the
common helper. Does that seem like an overkill?
