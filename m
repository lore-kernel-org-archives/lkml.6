Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC15ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7247208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Au2nlLPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7247208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeGPRTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:19:19 -0400
Received: from vern.gendns.com ([206.190.152.46]:35906 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbeGPRTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UcYVNIc+6dt/DFY17Eu/bHZn1W52lNd9n0Km93s0nDg=; b=Au2nlLPXspf8Q8yeoIN99ivNnc
        xcysNQYC3FC1MlAMoNkxBfv6ey3OVjPXqP89HP1GTrXBEot9SDv+aD1WslC9M5/mg0og01dt0QyZ/
        wQwGpynrk74fFNFIfud9S+xEbwpVtjWjDUiUwdWjQHmBc+t4XhviNfv98cl+OXrFzF9Y6lpJj4ITc
        to7doz434D2UgnM9MhAwnZGFJaYAIdZZO3FWAKvf8VfbnOIj2JJJJyb2ctl+88hU8mmMARgwnuNZm
        LPI5McG6m1m8p3XiuvwSiKSFphksGi4qTwju48X79G+4EO3lvPT9y93mRU3PrWV/Jzy/2h51pX/2X
        M/Un+QhQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41982 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ff6iE-00BXyF-Bq; Mon, 16 Jul 2018 12:51:02 -0400
Subject: Re: [PATCH v5 1/2] leds: core: Introduce generic pattern interface
To:     Baolin Wang <baolin.wang@linaro.org>, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <05c235df7bbcc4b898e7b263bf38338d9c822005.1531711385.git.baolin.wang@linaro.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <6ecb22d5-fac4-dbe9-87e7-196d87d6d06f@lechnology.com>
Date:   Mon, 16 Jul 2018 11:51:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <05c235df7bbcc4b898e7b263bf38338d9c822005.1531711385.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 06:10 AM, Baolin Wang wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Some LED controllers have support for autonomously controlling
> brightness over time, according to some preprogrammed pattern or
> function.
> 
> This adds a new optional operator that LED class drivers can implement
> if they support such functionality as well as a new device attribute to
> configure the pattern for a given LED.
> 

Hmm... I was hoping that this would be a generic pattern trigger that
could be used by any LED (e.g. gpio LEDs), not just LEDs with hardware
support. I guess I cannot really test this after all.

I think it looks good for your use case though.
