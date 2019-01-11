Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8AEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1722206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m/SCxCur";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q0jhrkQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfAKTsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:48:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfAKTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:48:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 11238607F4; Fri, 11 Jan 2019 19:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547236133;
        bh=7GkrtKZPOvXOzlIjB7wYFqGqSz+/Wp7aIytFKWbA4Wo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m/SCxCuruorEnoH6T5XJZ2GI0d96l6rYJgAUlMQcB2/Q7sw6zR232pfIrNLGEBAw7
         h/jEz9Cln12NCDBUt5iyTY0MIeJhC+IrBgKY9v5Qj0jHwwWw6u9kqaMzsbwB9+Esjw
         h9eHeZDiwFgnKa11Oqo9P18trUXVMyPMgacUBQfw=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51F93601B4;
        Fri, 11 Jan 2019 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547236132;
        bh=7GkrtKZPOvXOzlIjB7wYFqGqSz+/Wp7aIytFKWbA4Wo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q0jhrkQ2d05V1lAWQwCw6R+W5HNjB5jsBM0Vu1JZtCIWGlpUVMLlWBwWUTOPea7Ul
         Fnzx+10BCC6SptoeLd2p7wCJNaOASNgO8B3dbLqyyQgerdl69KKHvvrXiJZ5I3J7xB
         ZusAaB9jEM2rerCe4qgCqdVK0p3jgiILvZSvcvV0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51F93601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 4/6] phy: qcom-qmp: Add QMP V3 USB3 PHY support for
 msm8998
To:     Rob Herring <robh@kernel.org>
Cc:     kishon@ti.com, bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
References: <1546620647-2467-1-git-send-email-jhugo@codeaurora.org>
 <20190111194513.GA13699@bogus>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <a5f38a7b-a761-c924-08ef-fc685f027561@codeaurora.org>
Date:   Fri, 11 Jan 2019 12:48:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111194513.GA13699@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2019 12:45 PM, Rob Herring wrote:
> On Fri, Jan 04, 2019 at 09:50:47AM -0700, Jeffrey Hugo wrote:
>> MSM8998 contains a single QMP v3 USB3 phy similar to the existing sdm845
>> support, however MSM8998 does not have display port (DP) support.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   5 +
>>   drivers/phy/qualcomm/phy-qcom-qmp.c                | 142 +++++++++++++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.h                |   4 +
>>   3 files changed, 151 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> index 41a1074..6061b6f 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> @@ -9,6 +9,7 @@ Required properties:
>>   	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>>   	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>>   	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>> +	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
> 
> Please make bindings a separate patch. Combining patch 1 and 2
> binding changes is fine.
> 
> Rob
> 

Sure.  Planning on re-spinning early next week to address a few comments.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
