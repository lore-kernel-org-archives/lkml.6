Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8836C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEB420836
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kzutvwlX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c9TA5YX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEB420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHXWOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:14:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:14:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D15EA6055B; Fri, 24 Aug 2018 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535135891;
        bh=/I7/mgO8X8EYdFpFLL0eVJCIimgTfpI/v3Oah7iCPgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kzutvwlXe6VB1kGBxI/c6NXoGuzLA3wqddEECU6yzBxKvGQ7UIMMYZu7u1HBWBPlQ
         xjkbEcYjhXOBERMkI45MoZTdN5n//9Dd6vDHksuUuTSOYRKxy2Ze4aSNfOfcKJgcyq
         jU1/K0ApRsqOxm0Nx8eHD4VHUd4+fMJPyKaZl4jM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7E65660227;
        Fri, 24 Aug 2018 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535135890;
        bh=/I7/mgO8X8EYdFpFLL0eVJCIimgTfpI/v3Oah7iCPgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c9TA5YX5QqNphir2/NqoX/I89RCYmbvVGfdoDbYvo/T5LkpcsmMr7E40no8jJMI5I
         t0HS9cTwvddagSHqS+RwmLXsYdiexwKWFuS6rOkGNgsAWNJ1zjQv0bLhDZ3qvBIeEH
         OSbEIaS/BfMi2JrT9Tbyl0FQMPHWdKg0L/Pv2ftQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Aug 2018 11:38:10 -0700
From:   vnkgutta@codeaurora.org
To:     Evan Green <evgreen@chromium.org>
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Subject: Re: [PATCH v2 3/4] drivers: edac: Add EDAC driver support for QCOM
 SoCs
In-Reply-To: <CAE=gft6GTuk+j81J+jTNqD_6VFQym=gb6aJ==cbcg-6odVq3qg@mail.gmail.com>
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-4-git-send-email-vnkgutta@codeaurora.org>
 <CAE=gft4vheqe9Yqb3H_gMChUmQqvmBeeWvKWCf_j4sWrFceFiQ@mail.gmail.com>
 <CAE=gft6GTuk+j81J+jTNqD_6VFQym=gb6aJ==cbcg-6odVq3qg@mail.gmail.com>
Message-ID: <ffe2184066ddc9b4be4bf1bafc3497be@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-23 16:07, Evan Green wrote:
> On Thu, Aug 23, 2018 at 4:04 PM Evan Green <evgreen@chromium.org> 
> wrote:
>> 
>> On Fri, Aug 17, 2018 at 5:08 PM Venkata Narendra Kumar Gutta
>> <vnkgutta@codeaurora.org> wrote:
>> >
>> > From: Channagoud Kadabi <ckadabi@codeaurora.org>
> 
> Also checkpatch.pl complains a bit about this patch:
> 
>             WARNING: Non-standard signature: Co-developed-by:
>             #14:
>             Co-developed-by: Venkata Narendra Kumar Gutta
> <vnkgutta@codeaurora.org>

This needs to be there as the original author is Channagoud Kadabi
and I'm the one who is modifying and upstreaming this driver.
It was suggested to have this kind of signature from the earlier 
patchset comments.

Can we do anything about this?

> 
>             WARNING: please write a paragraph that describes the
> config symbol fully
>             #63: FILE: drivers/edac/Kconfig:460:
>             +config EDAC_QCOM

This is also, I will check if I can get rid of this by writing more in 
the description.
I don't really understand why do we need a paragraph here.

> 
>             WARNING: DT compatible string "qcom,llcc-edac" appears
> un-documented -- check ./Documentation/devicetree/bindings/
>             #536: FILE: drivers/edac/qcom_edac.c:430:
>             + { .compatible = "qcom,llcc-edac" },

This file is not added in the dt-bindings as there are no properties 
(like reg-names or interrupts) for this driver
and anyway initialized from llcc driver.

Do we still need to have the Documentation in place?

> 
>             total: 0 errors, 3 warnings, 533 lines checked
> 
> -Evan
