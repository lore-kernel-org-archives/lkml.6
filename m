Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBADBC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB742087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z562I0Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB742087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJGUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbeJGUKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 16:10:54 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E25A32087D;
        Sun,  7 Oct 2018 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538917424;
        bh=nBKlX//jUzI7wZ3nhQG2zraEXMAcbWA898rZWCV5fNY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=z562I0PkR1MY00U8i1h8vElaWh4SwIAUp4b+kb6oAl/MmxEfjqwXMYJp+er2Y43GJ
         zyBIgsSkZ7HIXbDbp/FyfNYE+G0jdR1qvFdGmy2R39zG6NO0tqP6Vd7uuXtkYYTcOI
         s25lJBhT2xbUb109K1uc6GQrAGewNQ0AqKqYrBls=
Subject: Re: [PATCH v5 2/3] pinctrl: msm: Use init_valid_mask exported
 function
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-2-ricardo.ribalda@gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <e57b6b66-a9f5-de6d-8876-0e3013b0ab40@kernel.org>
Date:   Sun, 7 Oct 2018 08:03:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005065300.22882-2-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/18 1:52 AM, Ricardo Ribalda Delgado wrote:
> The current code produces XPU violation if get_direction is called just
> after the initialization.
> 
> Signed-off-by: Ricardo Ribalda Delgado<ricardo.ribalda@gmail.com>

I'm not the maintainer of pinctrl-msm, but this looks okay to me.

Acked-by: Timur Tabi <timur@kernel.org>
