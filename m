Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D6E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U92x/0OJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e+oc0vNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D6E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHXVeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:34:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHXVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:34:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2A72A604BE; Fri, 24 Aug 2018 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535133500;
        bh=bws7dT220kuv0IzwwWu2TsuKTEHECg9cTocXj0sTP8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U92x/0OJ3nAp2DHR6ZgXbCeXaZs2OzajcJobbQzHTkN+qv67JcDP5NanJ2VpMU5an
         jpWlvf0QoT24iS7+UFEgA5qW890DsZqU9nTlAfCWHMPSrsWgRyLyMgHzE7d4lgXRMN
         uWk6U3osV3g0zg1CaCUNBsxKsRQ4H61GSKCXPV3Y=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C84EA6022B;
        Fri, 24 Aug 2018 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535133499;
        bh=bws7dT220kuv0IzwwWu2TsuKTEHECg9cTocXj0sTP8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+oc0vNYoI3aAqMQMkCBR+w9Dh7jX76ZaGT85hl1SUlCln5plEOwNS13eAddz7LAk
         YALuo1y6FYKdusMz3HcTJw07CGd3DP+bWrmJZ8h+TcdLtloKl0ZNrDxeeFeebwjoiP
         1Oo1gEIYXLXCjkTYB0IFN8LSM+bzlE6u2n+54Wfc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Aug 2018 10:58:19 -0700
From:   vnkgutta@codeaurora.org
To:     Evan Green <evgreen@chromium.org>
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Subject: Re: [PATCH v2 1/4] drivers: soc: Add broadcast base for Last Level
 Cache Controller (LLCC)
In-Reply-To: <CAE=gft64sF7APE490guRHo7PS9XsFkPn9-ZKcMB4_wPE5FXONQ@mail.gmail.com>
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-2-git-send-email-vnkgutta@codeaurora.org>
 <CAE=gft64sF7APE490guRHo7PS9XsFkPn9-ZKcMB4_wPE5FXONQ@mail.gmail.com>
Message-ID: <022159d88ada0092f5c24a0881e2375d@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-23 16:01, Evan Green wrote:
> On Fri, Aug 17, 2018 at 5:08 PM Venkata Narendra Kumar Gutta
> <vnkgutta@codeaurora.org> wrote:
>> 
>> Currently, boradcast base is set to end of the LLCC banks, which may
> 
> s/boradcast/broadcast/

I'll correct this typo in the next version.

> 
>> not be correct always. As the number of banks may vary for each 
>> chipset
>> and the broadcast base could be at a different address as well. This 
>> info
>> depends on the chipset, so get the broadcast base info from the device
>> tree (DT). Add broadcast base in LLCC driver and use this for 
>> broadcast
>> writes.
>> 
>> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>> ---
>>  drivers/soc/qcom/llcc-slice.c      | 55 
>> +++++++++++++++++++++++---------------
>>  include/linux/soc/qcom/llcc-qcom.h |  4 +--
>>  2 files changed, 35 insertions(+), 24 deletions(-)
>> 
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>
