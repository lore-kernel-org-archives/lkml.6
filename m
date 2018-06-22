Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CD623D14
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hLWV38/O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hLWV38/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CD623D14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeFVEab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:30:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFVEa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:30:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A6DB60714; Fri, 22 Jun 2018 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529641828;
        bh=7g+6n7e+8hsySzCnLXQvEDtu4Obejza7JK4cpm63fos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hLWV38/O7ZATzRslaDbvFR9QwwjBviwRKjDWaO1lNfpnd5cVNudD50nFinb2Jn03l
         f8+PteTYW7LZ/feZzCAuaRcxoa3IcJleeKKzuquL13LRZELZBfe9aAgzY8pmSCe9ZC
         eUEGkpDp5PRCjGPtsaypos8mWwQF2OfTB4TQtFVo=
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0012D60376;
        Fri, 22 Jun 2018 04:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529641828;
        bh=7g+6n7e+8hsySzCnLXQvEDtu4Obejza7JK4cpm63fos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hLWV38/O7ZATzRslaDbvFR9QwwjBviwRKjDWaO1lNfpnd5cVNudD50nFinb2Jn03l
         f8+PteTYW7LZ/feZzCAuaRcxoa3IcJleeKKzuquL13LRZELZBfe9aAgzY8pmSCe9ZC
         eUEGkpDp5PRCjGPtsaypos8mWwQF2OfTB4TQtFVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0012D60376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v2 0/2] hwrng: Add support for qcpm v2 hwrng
To:     Vinod <vkoul@kernel.org>
Cc:     linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <CAOZdJXUgYpLT=xMos4wKxMOTOZb8rV8is48YjGB8_9okZsuvhQ@mail.gmail.com>
 <20180622042747.GH27187@vkoul-mobl>
From:   Timur Tabi <timur@codeaurora.org>
Message-ID: <0383ce35-caea-dc0f-21fd-2f44e44ca8ce@codeaurora.org>
Date:   Thu, 21 Jun 2018 23:30:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622042747.GH27187@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/18 11:27 PM, Vinod wrote:
> I have checked the series.
> 
> I am not sure I follow that this is v2 and you read CONFIG register.
> Apart from that other changes look mostly okay with few nitpicks:)

It seems that there are two registers sets for v2 hardware, one with 
CONFIG and one without.  I just chose to support the one with.

> But there is a bigger concern raised by Herbert on this not being a true
> RNG and thus should be moved to crypto/

I've asked some of the crypto experts in Q to answer that question.

> I have the changes ready for that, I will test them later today and
> share with you, ACPI addition should be easy on that driver

Ok.  Feel free to just merge my ACPI changes into yours.  Technically, 
it's only a couple lines that are really ACPI-specific.

>> I will probably need you to test my patches as my last day at Qualcomm
>> is the 26th.
> Sad to hear that and good luck in your new adventure

Thanks.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
