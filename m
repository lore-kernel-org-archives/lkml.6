Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B6C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AF020645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AF020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeJWBuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:50:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55980 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbeJWBuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:50:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF1FB20E01; Mon, 22 Oct 2018 19:30:45 +0200 (CEST)
Received: from localhost (unknown [185.7.230.214])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9EABB20DE6;
        Mon, 22 Oct 2018 19:30:35 +0200 (CEST)
Date:   Mon, 22 Oct 2018 19:30:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: s35390a: Change buf's type to u8 in s35390a_init
Message-ID: <20181022173035.GX17341@piout.net>
References: <20181018214207.4223-1-natechancellor@gmail.com>
 <20181019204344.28080-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019204344.28080-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 13:43:45-0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/rtc/rtc-s35390a.c:124:27: warning: implicit conversion from
> 'int' to 'char' changes value from 192 to -64 [-Wconstant-conversion]
>         buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
>             ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> Update buf to be an unsigned 8-bit integer, which matches the buf member
> in struct i2c_msg.
> 
> https://github.com/ClangBuiltLinux/linux/issues/145
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Use u8 instead of unsigned char, as it's clearer that this is an
>   integer value and it's shorter.
> 
>  drivers/rtc/rtc-s35390a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
