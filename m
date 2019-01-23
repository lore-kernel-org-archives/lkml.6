Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E727FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33DD21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jaswnsz8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NYIUWhS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfAWHPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:15:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfAWHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:15:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E40E960988; Wed, 23 Jan 2019 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548227731;
        bh=88J7/67QlL6OqeUQld1nxuJiFh4K5ba3TOorJ53ZYIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jaswnsz8Tfz03lDaOqHOygbFouxBsjohsqzJLq5WB8bN4/QPeh4S1e7/yC9qo6e4D
         JcaLgsVomELEuxEW0EVEHsQ6lE4Tn1Dr4sMNLnvFsroIvqa4B/UKsEAozcaXV1A3UO
         99rSmFP+NeI19JVsaJKLxLXmZSnL4pwi0H2Z1TPk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D922160909;
        Wed, 23 Jan 2019 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548227730;
        bh=88J7/67QlL6OqeUQld1nxuJiFh4K5ba3TOorJ53ZYIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NYIUWhS/VRB+sE6fAm+Ku2IrehEjfv5W2NgJmRBoc8H3+aMyneQDdumZz30BVaKB0
         vOj/Xmi0N3GHaH91TMREWfgW2shVHaU7uU4veiizeYJtNx+02Ik8Nc7TKEBY/4SP1m
         wfUeQQ6PO9G4j6eTLJ4L+JmOOuM72dWiQBIRCiDQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 12:45:30 +0530
From:   alokc@codeaurora.org
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
In-Reply-To: <20190122202924.GL7579@sirena.org.uk>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
 <20190122202924.GL7579@sirena.org.uk>
Message-ID: <775cdd29a7d536772330a15a7013f251@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 01:59, Mark Brown wrote:
> On Tue, Jan 22, 2019 at 12:03:34PM +0530, Alok Chauhan wrote:
> 
>> Get the interconnect paths for SPI based Serial Engine device
>> and vote accordingly based on maximum supported SPI frequency.
> 
> Still not seeing anything except this patch here in my inbox - like I
> said what's the story with dependencies?

I've added linux-spi mailing list to all the patches sent as part of 
this series. Not sure why you didn't get other patches. Today I've 
explicitly added you in all the patches.
This change series basically enabled interconnect (as per 
bindings/interconnect/interconnect.txt) support in GENI QUPs based 
drivers so appropriate BW request can be put based on SE usages.
here is my complete change series: 
https://lore.kernel.org/lkml/1548069703-26595-1-git-send-email-alokc@codeaurora.org/
I hope I answer to your question properly.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
