Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A05C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A8A2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KqrZ0c8q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KqrZ0c8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfBEWMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:12:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEWMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:12:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D9AB6085F; Tue,  5 Feb 2019 22:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404724;
        bh=tBmXkf+aQ9PMrF7Zd4JGnrc3wxJV1ziFiz6LYlrcUdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KqrZ0c8qrzAk8Ka1thRvuIS3a/lwv+LIjJS3Tylzfh8CwZOPtOeqH74FJZrO3RduZ
         a7PtKYCA/9v1rf+HUKbq6a4QgILeSKO9yrwSsefYUO+oTE4luZtI/Fl5g/0SG0ZtN5
         YJ/i7gdzJhm1eYI+gGzMidt5s9pMOES9sRqwpacU=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1644460134;
        Tue,  5 Feb 2019 22:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404724;
        bh=tBmXkf+aQ9PMrF7Zd4JGnrc3wxJV1ziFiz6LYlrcUdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KqrZ0c8qrzAk8Ka1thRvuIS3a/lwv+LIjJS3Tylzfh8CwZOPtOeqH74FJZrO3RduZ
         a7PtKYCA/9v1rf+HUKbq6a4QgILeSKO9yrwSsefYUO+oTE4luZtI/Fl5g/0SG0ZtN5
         YJ/i7gdzJhm1eYI+gGzMidt5s9pMOES9sRqwpacU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1644460134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 3/4] clk: qcom: Add MSM8998 Multimedia Clock Controller
 (MMCC) driver
To:     Stephen Boyd <sboyd@kernel.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
 <1548866171-30341-1-git-send-email-jhugo@codeaurora.org>
 <154940436246.169292.7591382350282828249@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <54750df0-245c-74ab-2a33-ce1588f3e38e@codeaurora.org>
Date:   Tue, 5 Feb 2019 15:12:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154940436246.169292.7591382350282828249@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 3:06 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-01-30 08:36:11)
> [..]
>> +};
>> +MODULE_DEVICE_TABLE(of, mmcc_msm8998_match_table);
>> +
>> +static int mmcc_msm8998_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       int i, ret;
>> +       struct regmap *regmap;
>> +       struct clk *c;
>> +
>> +       c = devm_clk_get(dev, "xo");
>> +       if (!IS_ERR(c))
>> +               dummy_xo_init.parent_names =
>> +                                       (const char *[]){__clk_get_name(c)};
>> +       else
>> +               return PTR_ERR(c);
>> +
>> +       c = devm_clk_get(dev, "gpll0");
>> +       if (!IS_ERR(c))
>> +               dummy_gpll0_init.parent_names =
>> +                                       (const char *[]){__clk_get_name(c)};
>> +       else
>> +               return PTR_ERR(c);
> 
> Urgh, my parent mapping series can't come be merged fast enough it
> seems!

Sorry, I'm not familiar with the context.  Something I should incorporate?

> 
>> +
>> +       regmap = qcom_cc_map(pdev, &mmcc_msm8998_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       for (i = 0; i < ARRAY_SIZE(mmcc_msm8998_hws); i++) {
>> +               ret = devm_clk_hw_register(dev, mmcc_msm8998_hws[i]);
> 
> I think we should make this common to the qcom_cc_desc now. Can you
> throw in an optional list of clk_hw pointers that also get registered as
> its own patch and update the existing drivers that are all doing this?

Yeah, can do.

> 
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return qcom_cc_really_probe(pdev, &mmcc_msm8998_desc, regmap);
>> +}


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
