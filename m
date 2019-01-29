Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E72AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDC721473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cBRWWhLc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RLiTvBB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfA2Os0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:48:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2OsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:48:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CCEB9607F4; Tue, 29 Jan 2019 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548773304;
        bh=RYy2yFr8t2PJ/0/wHbPQpf69MFau9NKwCcDNZPKeVg4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cBRWWhLcshZEjVBqwLYCt0KTP6Jkm/Hz56NF48VEx/D9LDTJ78nq+RPx35PwMe1iZ
         uPg3mpsu/TQfREcB5Bw8WwJ83wC0Sg4CF+5UnLcFVMrkTce92dSP9ZRGW3iv+DQCN6
         t4cDTPATTu3Jd4dEPqsbVTTN1AKwpWRJ+8xcpC84=
Received: from [192.168.1.100] (unknown [157.49.239.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B39D6072E;
        Tue, 29 Jan 2019 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548773303;
        bh=RYy2yFr8t2PJ/0/wHbPQpf69MFau9NKwCcDNZPKeVg4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RLiTvBB/scwl2+TQF+DsB6oP16m3ZF5vw5OErQilmUDibNzpQYlj5Uht+y8Eud4wC
         G0UidDhV2QTbArQl+bMIj4+AZFaSUIBO21yMNeBltwP+3rAQxF9TDBgBJu/hHOGcYe
         zs7waZe9aL3czqwOURl7v/cctdnXCvzC1j0xOkiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B39D6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190129132528.GA16669@leoy-ThinkPad-X240s>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <5d50103e-bcfd-6704-a431-c17360198348@codeaurora.org>
Date:   Tue, 29 Jan 2019 20:18:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129132528.GA16669@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/2019 6:55 PM, Leo Yan wrote:
> 
> Looks good to me and tested on my Hikey board (though I cannot test
> for a device with UCI ID):
> 
> Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>
> 

Thanks Leo.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
