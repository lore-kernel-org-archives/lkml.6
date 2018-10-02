Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B338C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66AB206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxCTDYGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66AB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeJBTMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbeJBTMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:12:54 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 556052064E;
        Tue,  2 Oct 2018 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538483389;
        bh=N9Xrqsw3X3prHIshh6QkFT/NteYWrhGGNo2C5IbjI6M=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GxCTDYGAKGb+1FtvFECH8pXvN9FyLjTcxoB8BVNC35uIoz9NfK1HZtngC/25yppBT
         3NB7l/Z7D+XlOLA6F9raJKJapiv2+Ow0P36Fyoqb2yZZKl4yV6Hk8BJ2FPENobTWry
         MUKBbCuxEYxCRaoscS/gMMIXyM8nH6Dm9cb2wPxA=
Subject: Re: [PATCH v3 3/3] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
 <20181002082731.20141-3-ricardo.ribalda@gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <b3b2e31d-f411-370d-21c9-3a141906ee58@kernel.org>
Date:   Tue, 2 Oct 2018 07:29:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002082731.20141-3-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/18 3:27 AM, Ricardo Ribalda Delgado wrote:
> +		/* REVISIT: most hardware initializes GPIOs as inputs (often
> +		 * with pullups enabled) so power usage is minimized. Linux
> +		 * code should set the gpio direction first thing; but until
> +		 * it does, and in case chip->get_direction is not set, we may
> +		 * expose the wrong direction in sysfs.
> +		 */

I don't think this comment applies any more.

Also, please don't use timur@codeaurora.org any more.  That address is 
no longer valid.  Use timur@kernel.org instead.
