Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5936C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE6C2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jQwAd2bu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jQwAd2bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE6C2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeI0UxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:53:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0UxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:53:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BDAAB60B19; Thu, 27 Sep 2018 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538058878;
        bh=zUMriUKWJ3AE1u40QFKJNYHJKHqQn11QzXzkoiV4S+w=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jQwAd2bu7hjLkteKoSUVXjwaHfph0UEQ9zE2HF/DLAWYWL91fiByDHatL19kYMByF
         UEOdUjvAV8tEo6oEXjNUO8xResT72FQ7CXtoOiIJyKjPYrlcVByY8P8ygrn2ZWE/KE
         u3YpA2lEZuCHOG/YmJOX8kqJWgU/zYtwC6brIfPk=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A306860C5F;
        Thu, 27 Sep 2018 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538058878;
        bh=zUMriUKWJ3AE1u40QFKJNYHJKHqQn11QzXzkoiV4S+w=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jQwAd2bu7hjLkteKoSUVXjwaHfph0UEQ9zE2HF/DLAWYWL91fiByDHatL19kYMByF
         UEOdUjvAV8tEo6oEXjNUO8xResT72FQ7CXtoOiIJyKjPYrlcVByY8P8ygrn2ZWE/KE
         u3YpA2lEZuCHOG/YmJOX8kqJWgU/zYtwC6brIfPk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A306860C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
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
 <c9c24958-a020-a6b4-5ee4-51356bf345a5@kernel.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <73154ad3-0c53-b2e5-7fa4-f6c67bc00fdc@codeaurora.org>
Date:   Thu, 27 Sep 2018 08:34:37 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c9c24958-a020-a6b4-5ee4-51356bf345a5@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2018 8:19 AM, Timur Tabi wrote:
> On 9/27/18 9:04 AM, Jeffrey Hugo wrote:
>>
>> I guess its lucky I saw this then.
> 
> Did you not get this email: 
> https://lore.kernel.org/patchwork/patch/989545/#1173771

Apparently I did.  I found it in my deleted items.  I must have 
accidentally done that when sorting through my backlog after Linaro 
Connect.  Sorry about that.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
