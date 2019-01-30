Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B512AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DBE20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H53j9uW8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BJqUpMIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfA3XH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:07:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfA3XH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:07:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9532360314; Wed, 30 Jan 2019 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548887278;
        bh=yNu+zu1N5wWx/sy/nB3pe16FWHuLygnnFbvq3azrWfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H53j9uW8IPOROrMJB7c9UXvW+NFWfGFXFB9hhFIFbQwY36VmDNK5fjgn6RSpaeUiB
         3tNE+moWlK1npfVZrazspbkIov7pKg8llmfW7/qws3cLwTkyTW3ziHs+YtzUQ1B0zH
         SnNmzzAIJ+lmAQsbxUDYCu4LGt4Jwt/hvgbwl+/k=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DEFBF60314;
        Wed, 30 Jan 2019 22:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548887277;
        bh=yNu+zu1N5wWx/sy/nB3pe16FWHuLygnnFbvq3azrWfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BJqUpMInX5/zu0Ly1pXi+SD+Dv9sIxYzFFtxjz7EWZbyfCN/OADlzwlwRBoDdBVcD
         n1hqZBvEDVRnfCThWCCV1lwa2+6uTZsltxPFdgfmi2T74ux9UHvHT8tIpTC5PpxBXx
         bYnnOfNy408qEw+EKirUvM+pULQou1C2wwyJ9OVs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jan 2019 14:27:57 -0800
From:   alokc@codeaurora.org
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
In-Reply-To: <CAE=gft5+OJCHTVszSW2Tt9HX3UA-LuTzK95Q4-R3v=DUqff9OA@mail.gmail.com>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
 <CAE=gft5+OJCHTVszSW2Tt9HX3UA-LuTzK95Q4-R3v=DUqff9OA@mail.gmail.com>
Message-ID: <c439ef5a77c79a049b8efd8b86df7d55@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 17:10, Evan Green wrote:
> On Mon, Jan 21, 2019 at 10:34 PM Alok Chauhan <alokc@codeaurora.org> 
> wrote:
>> 
>> Add documentation for the interconnect and interconnect-names bindings
>> for the GENI QUP as detailed by 
>> bindings/interconnect/interconnect.txt.
>> 
>> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 
>> ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt 
>> b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> index dab7ca9..44d7e02 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> @@ -17,6 +17,12 @@ Required properties if child node exists:
>>  - #address-cells:      Must be <1> for Serial Engine Address
>>  - #size-cells:                 Must be <1> for Serial Engine Address 
>> Size
>>  - ranges:              Must be present
>> +- interconnects:       phandle to a interconnect provider. Please 
>> refer
>> +                       ../interconnect/interconnect.txt for details.
> 
> This path to the interconnect documentation is not correct.
sorry, i will correct this in next patch.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
