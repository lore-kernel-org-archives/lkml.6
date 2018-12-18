Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7820CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452A2214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PeF2E6jn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HbWlzZ2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLRFQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:16:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeLRFQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:16:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27E6360736; Tue, 18 Dec 2018 05:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545110208;
        bh=54GgltfqSXioxajEhez7kdYLUjTaFaA+6eAk1ynfnuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PeF2E6jnBT98aPXwqXWo6XIFh/197B+s05V8ZL9GK1vNV7co58KMjtfMh37o9rK2i
         BrR6SQvALo2q0narmHwJ2HWd6a8+TX69mHHWJHFnvLPtLA5ggXtXLULYz3ObVVAmY7
         gjF9GLFNiVdhhoQxl6SdlEbnajaQ56uCeuctauiU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 492A0600E2;
        Tue, 18 Dec 2018 05:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545110207;
        bh=54GgltfqSXioxajEhez7kdYLUjTaFaA+6eAk1ynfnuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HbWlzZ2C8Di5KmiWQFYGh9XGjXxIY7tnA6Gc1UNav1k1b68moW+fr1cG30MPmZZph
         0QfirKj139KWKKSRX8faayqTbRtdOPnNvnbLBHWWEeT4amH3toNt07/bKoVphJQR5e
         KZRaYsZ0WOfxji0qv4H6WxYpMpy4AHjX/JduG+6I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 10:46:47 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: soc: qcom: Add remote-pid binding for
 GLINK SMEM
In-Reply-To: <CAD=FV=WJPEzXahN3HRdNPTfcPs+OPCiQ_3f1zQh1-poekPgGRg@mail.gmail.com>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <CAD=FV=WJPEzXahN3HRdNPTfcPs+OPCiQ_3f1zQh1-poekPgGRg@mail.gmail.com>
Message-ID: <ae7c275abb7fb2604f2643c04d1dc0ab@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the review :)

On 2018-12-18 05:29, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 17, 2018 at 2:07 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Add missing qcom,remote-pid dt binding required for GLINK SMEM
>> which specifies the remote endpoint of the GLINK edge.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
> 
> Fixes: 2b41d6c8e696 ("dt-bindings: soc: qcom: Extend GLINK to cover 
> SMEM")
> 
> 
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt 
>> b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>> index 0b8cc533ca83..59ae603ba520 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>> @@ -21,6 +21,11 @@ edge.
>>         Definition: should specify the IRQ used by the remote 
>> processor to
>>                     signal this processor about communication related 
>> events
>> 
>> +- qcom,remote-pid:
>> +       Usage: required for glink-smem
>> +       Value type: <u32>
>> +       Definition: specifies the identfier of the remote endpoint of 
>> this edge
> 
> s/identfier/identifier/
> 

missed this, will correct it in v3.

> 
> Other than the typo this seems right to me.  Feel free to add my
> Reviewed-by tag when that's fixed.
> 
> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
