Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C254EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2D820823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bqFPVUcg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FVnrdeLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfBEWPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:15:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfBEWPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:15:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1423860134; Tue,  5 Feb 2019 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404921;
        bh=+qlIWUsT8IlXyb8i/dhm//aIdmVxSni1ea4+90IQwP0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bqFPVUcg9UMXU+/w7ZHP/pv6ZIk2qrnWmDz4AYWvtVYjXuAKDA6cCOz+VBilIFDz7
         HK40Uui/k9fX/PXWmdoaAubi8Tes/QRsyPtC98WIiIwDApMdpCr1M12Vj9RNaaTPlm
         ZaFYuC9sSuoRNps35EXusdth0KgYwWDOLy2jsLcw=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42D9360134;
        Tue,  5 Feb 2019 22:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549404920;
        bh=+qlIWUsT8IlXyb8i/dhm//aIdmVxSni1ea4+90IQwP0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FVnrdeLGlW+UwvAYvc/dPVWb4wSNbG6yvOaONwvfomVuikl8+bj7xLzxAK6DvTK+k
         +Aij5F7sp0VBDvNsW75+jslDPhSWjZYQHOXMu+1sg4z0pYgAUuhKKEZxbK3QEJ+vX1
         9LTIadKqsaf4X0rg6Mb0TtbFkkpkL23xfl4ocCuY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42D9360134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 1/4] clk: qcom: smd: Add XO clock for MSM8998
To:     Stephen Boyd <sboyd@kernel.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
 <1548866144-30265-1-git-send-email-jhugo@codeaurora.org>
 <154940408967.169292.15276398799323074789@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <6e62a49a-fdb1-a087-fe83-e86aed969ae7@codeaurora.org>
Date:   Tue, 5 Feb 2019 15:15:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154940408967.169292.15276398799323074789@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 3:01 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-01-30 08:35:44)
>> The XO clock generally feeds into other clock controllers as the parent
>> for a lot of clock generators.
>>
>> Fixes: 6131dc81211c (clk: qcom: smd: Add support for MSM8998 rpm clocks)
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> 
> We've historically left out the XO clk because it causes problems where
> the XO vote goes away during late init because nobody references it from
> the rest of the clk tree and also because RPM defers probe of the system
> and then the console blows up when it gets a clk that can't change rate.
> See commit 54823af9cd52 ("clk: qcom: Always add factor clock for xo
> clocks") for some more info on why we removed all the workarounds and
> stuff around here too.
> 
> So are you sure this is OK to do?
>   
> 

So, I've got pretty much everything as modules, and I haven't seen any 
issues.  However let me take a look at the commit you point out and see.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
