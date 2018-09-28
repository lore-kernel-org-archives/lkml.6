Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F53EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6F320685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GxJomrvE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GxJomrvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6F320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeI2Bjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:39:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI2Bjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:39:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C565660588; Fri, 28 Sep 2018 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538162064;
        bh=4v3DUuIHyN5gPgEJvqSqd4QqPZE82H/vNycxjeC+ouE=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=GxJomrvEsL5pysrhKlBasfEHzgFatpC8UA7VQ9eIQxydZ9w5lRn4sSIQ4OLAPk9u/
         V/Xn74PIf/oHrfHgBE/yK/7QRbBhevPXRpVnHsL5Tl++hWNWhtXBdVmbW7/PU6BMI6
         gxNwiPrFRseVepMwdM6qAxsIa97znzRo5f8T+lPw=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D44C0605FD;
        Fri, 28 Sep 2018 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538162064;
        bh=4v3DUuIHyN5gPgEJvqSqd4QqPZE82H/vNycxjeC+ouE=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=GxJomrvEsL5pysrhKlBasfEHzgFatpC8UA7VQ9eIQxydZ9w5lRn4sSIQ4OLAPk9u/
         V/Xn74PIf/oHrfHgBE/yK/7QRbBhevPXRpVnHsL5Tl++hWNWhtXBdVmbW7/PU6BMI6
         gxNwiPrFRseVepMwdM6qAxsIa97znzRo5f8T+lPw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D44C0605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     Timur Tabi <timur@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-gpio@vger.kernel.org
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com>
 <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org>
 <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
Message-ID: <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org>
Date:   Fri, 28 Sep 2018 13:14:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2018 8:04 AM, Jeffrey Hugo wrote:
> On 9/27/2018 6:19 AM, Timur Tabi wrote:
>> On 9/27/18 1:51 AM, Stephen Boyd wrote:
>>> Looks OK to me visually. I haven't tested it because I don't have access
>>> to the locked down hardware anymore.
>>
>> Same here.  Please wait for Jeff Hugo to test it before applying.  
>> Thanks.
> 
> I guess its lucky I saw this then.
> 
> I should be able to test within a week.
> 

Nack.  Causes a XPU violation to the GPIO config registers.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
