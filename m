Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C3BC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A831820823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Ra/i5C11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfBIS4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:56:19 -0500
Received: from vern.gendns.com ([98.142.107.122]:42554 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbfBIS4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g1vQtrMzSJBOpxZiNlEvjWT1VUNRvlBXleY3eINxXHg=; b=Ra/i5C113gY8Oa0rKOxB2hbJir
        nMvZ4qCGmgG1As47600fQD4pQ88IiJnQ+r6qO3xfgmijmKZFwAqj+KWOVE4hnUiZM5gZjXjo7liDY
        6aSQy+r8WveCYo6d/LC7TeCKblXy0m5YqDLEJNuWY0h39QX2z3UgZLG6HMzt41mm9P15LI3C/eUe/
        AQJfFu3/ZibvfeCDqUD6OafJCYeRRBXjy18ODS+aKrIP5oH6tmV1v6IOmYY2LJyBxD93zAjYGvW9e
        lWpSgS9XBlLpylmBWzHR9y8YX1WrM3byKo7X5VacjG+F0r/1blwzuMf6Oj/0Nl9ot4ACtbZgESZcv
        x7WQgmTA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41636 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gsXjm-0006ae-PV; Sat, 09 Feb 2019 13:52:26 -0500
Subject: Re: [PATCH] iio: adc: ti-ads7950: add GPIO support
To:     Jonathan Cameron <jic23@kernel.org>, justinpopo6@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
References: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
 <20190209170042.69a78684@archlinux>
From:   David Lechner <david@lechnology.com>
Message-ID: <2e692086-4be5-10ea-34b0-4444995c4275@lechnology.com>
Date:   Sat, 9 Feb 2019 12:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209170042.69a78684@archlinux>
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

On 2/9/19 11:00 AM, Jonathan Cameron wrote:
> Nope.  This is a state lock used to protect against transitions between
> different modes of the IIO device (buffered vs polled), it
> isn't suitable for general use.
> 
> The driver should be modified to handle that correctly.
> We have iio_claim_direct_mode etc that deal with the case
> where a device can't do certain operations whilst in buffered
> mode.  Note it can fail and should.
> 
> Seems there are more drivers still doing this than I thought.
> If anyone is bored and wants to clean them out, that would be
> most appreciated!
> 
> If you need locking to protect a local buffer or the device
> state, define a new lock to do it with clearly documented
> scope.

Just as a reminder, there is a use case for this particular
chip that requires buffered mode and direct mode at the same
time.

https://patchwork.kernel.org/patch/10539021/
https://patchwork.kernel.org/patch/10527757/
