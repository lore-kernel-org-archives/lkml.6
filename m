Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8027C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9973F208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7VFvRdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9973F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeGaJDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:03:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45884 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeGaJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:03:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so5712727pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zhez6SKdjmNwnx9u5rTGhiXo3ZG991RXG9j6RpPGerM=;
        b=b7VFvRdK8bI4yTG/QH2n/bDb2Sb6q8KmkvTVdxjajh+fNPgxy2XgW9Ke2pzQDg08CI
         3Ej7wi5Em5q/x8NnuJM40HZMgBRpFH2gMuQMwOlnWg0hdohDEeKkHM36ZcfrbD1U5GvX
         751n8vEJ5Fqymht6BvxhlMpGyRyUDN7DVmCrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhez6SKdjmNwnx9u5rTGhiXo3ZG991RXG9j6RpPGerM=;
        b=SwoAZmolk2JAcS6KWbc3exOx37pZ+yMSv2PO49rziqRmvzphMsw6nGYmJ75BVjVnyz
         GfqpE6KgxleWkBScmAzK4D2dP8fWx+Xmuv3XPeMFnrqWx2TanTxdDqt0srxnKoGLA6aB
         xKS1JWwq9q2G/OtHKsIUTBj+f4Mu/nv4Zi/zITi+pqob7n+9NmAVTt9WeIrPeQQINB2O
         n+/JkeIBUfR4BZBi2Bsx7QSOErPq6d5JdwkRV+GME5Jrmw7GbMa8StK24rrJjfkPCuar
         7+WTE7ui0SUPritT86Uo9F6aUjMEkI7hzbkUDLwpjobArs3AWGsajP8QfY7GAj8xaqrf
         dFLA==
X-Gm-Message-State: AOUpUlHSPOfq98mO5CgFFyZ1+oZYC01i38J+5vqw+xKCRS44cu1XmcLH
        EFRSTJOLPI7w7/bNmaAodN1Qnw==
X-Google-Smtp-Source: AAOMgpdW1ClhXSVjGesilKfzyRHfepe2apckfCgzfGaodGvFQ1yN4FVPf5x7FWPu5S2CmU3Nu3mMbg==
X-Received: by 2002:a63:920c:: with SMTP id o12-v6mr19420334pgd.141.1533021857075;
        Tue, 31 Jul 2018 00:24:17 -0700 (PDT)
Received: from localhost ([171.61.121.73])
        by smtp.gmail.com with ESMTPSA id z10-v6sm18409719pfh.83.2018.07.31.00.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 00:24:16 -0700 (PDT)
Date:   Tue, 31 Jul 2018 12:54:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: hisilicon: Add missing clocks property for
 CPUs
Message-ID: <20180731072414.vymng6k5uamgmyhi@vireshk-i7>
References: <6de0dde994326b3fdc2b746e22fdf1afe18067d2.1532315177.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de0dde994326b3fdc2b746e22fdf1afe18067d2.1532315177.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-18, 08:36, Viresh Kumar wrote:
> The clocks property should either be present for all the CPUs of a
> cluster or none. If these are present only for a subset of CPUs of a
> cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add missing clocks property.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

@Wei: Can you please apply this one as well ?

-- 
viresh
