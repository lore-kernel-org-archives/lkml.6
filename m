Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43265C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022CD20700
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x5hu8lsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022CD20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLGEnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:43:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34912 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLGEnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:43:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB74hO9o095742;
        Thu, 6 Dec 2018 22:43:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544157804;
        bh=jcsEja8Bdx8MLvNTEpj1AiD6otx0hSpcdjHwJ4HF49s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x5hu8lsfZ3fQxlN2XJYSaMaDsXsC1wkyI99+5YZUxEUmGIMEgVOpIZP4aKuRJcWH2
         SHX7RXWC6LR9XmD01scwWm0uZuZKkux/xO+595SykIC/4wEnIPURDK/qY8U977G1sW
         qzmjPOAIdjyBLeoSCkriN0txLtG2wPTXiXdO7Sms=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB74hOKp001725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 22:43:24 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 6
 Dec 2018 22:43:24 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 6 Dec 2018 22:43:24 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB74hJSn002728;
        Thu, 6 Dec 2018 22:43:20 -0600
Subject: Re: [PATCH v1 0/4] phy: qcom-qmp: Fix clock-cells binding and
 provider
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
CC:     <evgreen@chromium.org>, robh+dt <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Doug Anderson <dianders@chromium.org>, <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
References: <20181129221357.67417-1-evgreen@chromium.org>
 <62461d1d-2269-37f7-8d08-a116e470ad89@ti.com>
 <CAFp+6iHmPDWyU1GVe0ZvYLh4vzEkgy1UqDp3rEM3D4gHNitGkg@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <df0a0a62-0f5f-31d3-4d8a-fd0d3b21e5b2@ti.com>
Date:   Fri, 7 Dec 2018 10:13:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iHmPDWyU1GVe0ZvYLh4vzEkgy1UqDp3rEM3D4gHNitGkg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek,

On 04/12/18 6:07 PM, Vivek Gautam wrote:
> Hi Kishon,
> 
> On Tue, Dec 4, 2018 at 1:44 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Andy Gross, David Brown, Vivek,
>>
>> On 30/11/18 3:43 AM, Evan Green wrote:
>>> This series fixes the QMP PHY bindings, which had specified #clock-cells
>>> in the parent node, and had set it to 1. Putting it in the parent node is
>>> wrong because the clock providers are the child nodes, so this change
>>> moves it there. Having it set to 1 is also wrong, since nothing is ever
>>> specified as to what should go in that cell. So this changes it to zero.
>>> Finally, this change completes a little bit of code to actually allow these
>>> exposed clocks to be pointed at in DT.
>>>
>>> I had no idea how to fix up ipq8074.dtsi. It seems to be completely wrong in
>>> that it doesn't specify #clock-cells at all, has no child nodes, and
>>> specifies clock-output-names in the parent node. As far as I can tell this
>>> doesn't work at all. But I can't add the child nodes myself because I don't know
>>> 1) how many there are, and 2) the registers in them. I also have no way to test it.
>>>
>>> Speaking of testing, I was able to test this on sdm845, but haven't tested msm8996.
>>
>> Can someone help test this series in msm8996?
> 
> Sure, will give it a try tomorrow.

I'm planning to close the merge by today. Can you test this series please?

Thanks
Kishon

> 
> Thanks
> Vivek
> 
>>
>> Thanks
>> Kishon
>>
>>>
>>> This patch sits atop the UFS device nodes series [1].
>>>
>>> [1] https://lore.kernel.org/lkml/20181026173544.136037-1-evgreen@chromium.org/
>>>
>>>
>>>
>>> Evan Green (4):
>>>   dt-bindings: phy-qcom-qmp: Move #clock-cells to child
>>>   arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
>>>   arm64: dts: qcom: sdm845: Fix QMP PHY #clock-cells
>>>   phy: qcom-qmp: Expose provided clocks to DT
>>>
>>>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 11 ++++-----
>>>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  6 +++--
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  4 ++--
>>>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 23 ++++++++++++++++++-
>>>  4 files changed, 33 insertions(+), 11 deletions(-)
>>>
> 
> 
> 
