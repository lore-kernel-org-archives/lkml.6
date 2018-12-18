Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6766C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823D1214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NafQNl+5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O9PgKi6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLRA5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:57:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLRA5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:57:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26C49607CA; Tue, 18 Dec 2018 00:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545094656;
        bh=rEJ0NxQTGAJDJiyMi733DjjMdP+C+VS98Eiy/hAE4Vs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NafQNl+5uMkXMP8yy4tMhU+//Ngxlh8Br2guCt5IQcmsnaiQpML0O/GRWApaLmOHH
         B32jZew9xT4q1jAXJHcM4O7YNZoOmWgrTuKXDgMLDvwppK5w1lacjjwXh5GMgRz9Fi
         9vJiNYMHw9Fap6lUXDefeQqveJR3Wbzl0SU12vs4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABEA7601D7;
        Tue, 18 Dec 2018 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545094655;
        bh=rEJ0NxQTGAJDJiyMi733DjjMdP+C+VS98Eiy/hAE4Vs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O9PgKi6KG+FgXGiDRu9mjVNA34vOk6bNbZSvZ0tSAr3PQp5Uy6ksQ/liKe58uOxww
         tuyHW2U3Xb/cJm6L5gFHWMRg592j8bCjKIMTaOGkFOFhcCLToFsOUCHl0WSt8ZuBcR
         dG/YcX2R0smS1sx/6+CYXgtSMZj+ZQDAklWrqKRU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABEA7601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3] clk: qcom: smd: Add support for MSM8998 rpm clocks
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1545092467-31485-1-git-send-email-jhugo@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <83f726d7-97c9-8fe3-229a-d68f59fb347a@codeaurora.org>
Date:   Mon, 17 Dec 2018 17:57:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1545092467-31485-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2018 5:21 PM, Jeffrey Hugo wrote:
> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
> for clients to vote on.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
> v3
> -Ensure Marc's hang was addressed by GCC fixes
> -Renamed the bb clks to ln_bb to match the schematics
> 
> v2
> -fix compatible ordering nits per Stephen
> 

Sorry, I missed a build error.  Ignore this.  Will spin a v4.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
