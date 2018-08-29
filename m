Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57570C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EEB205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ASXnfWPI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NMQf4Jjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EEB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeH2Ugi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:36:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2Ugi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:36:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65844606DB; Wed, 29 Aug 2018 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535560733;
        bh=U41rgn7RrpT8qe0KRoaBy+ubCno5KyRkbsvYmLgjMXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ASXnfWPIfzCCCN5tz5QjjpLdC6fD4+W76UGvjL8980hfY/V/rAbqJPpMXr89SkTY9
         Xf5yy4AqKuSsQK4Ty+fUK/RCPvL5ALOiJzG6bQSqgdAFTbkX+BA/UUDMrL0p41MR3b
         rNMxnsGzzX6Jox3m9MgzqVBX3zqFsYEqcA0BV2vs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1581D60242;
        Wed, 29 Aug 2018 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535560732;
        bh=U41rgn7RrpT8qe0KRoaBy+ubCno5KyRkbsvYmLgjMXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NMQf4Jjz11F7KPvlrl9Ws/S/kt39HVocDXHgnB8mR/yP6yYOAI61H1HGxBcEFLJAF
         8Q1yQR2YDBSK7Lcygsz1ubJ5TJjKhVe1fAeH66Nh0DPqrIs9FBBDmf/sJDo+adF/je
         912ANyoo6g3lVFOlLb/OW7Jb51gydzIHX7qlb/pU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Aug 2018 22:08:52 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 3/6] dt-bindings: remoteproc: Remove additional
 definition tag
In-Reply-To: <20180828004422.GZ160295@google.com>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-4-sibis@codeaurora.org>
 <20180828004422.GZ160295@google.com>
Message-ID: <c3e417189c150114b67af9e5ded668b6@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,
Thanks for the review!

On 2018-08-28 06:14, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> Subject: dt-bindings: remoteproc: Remove additional definition tag
> 
> nit: the subject is a bit generic, you probably should at least add
> 'qcom: ' to the 'path'.
> 

Will add

> On Fri, Aug 24, 2018 at 06:48:57PM +0530, Sibi Sankar wrote:
>> Remove the additional definition tag declared for WCSS sub-system
>> under reset-names.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 601dd9f389aa..c45e4c131fa2 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -58,7 +58,7 @@ on the Qualcomm Hexagon core.
>>  	Usage: required
>>  	Value type: <stringlist>
>>  	Definition: must be "mss_restart" for the modem sub-system
>> -	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
>> +		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
>>  		    for the wcss syb-system
> 
> Since you are already at it you might also want to fix the typo in
> 'wcss syb-system'.
> 

nice catch, will correct it.

I missed your query in the other thread, APPS refers to the pdc_sync 
reset line for the Application processor.

> Other than the nits:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
