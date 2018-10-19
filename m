Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E54ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5C921476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5C921476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeJTDzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:55:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45965 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeJTDzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:55:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3A05207A3; Fri, 19 Oct 2018 21:48:06 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C7C5A20703;
        Fri, 19 Oct 2018 21:47:56 +0200 (CEST)
Date:   Fri, 19 Oct 2018 21:47:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: s35390a: Make buf an unsigned char in s35390a_init
Message-ID: <20181019194757.GN17341@piout.net>
References: <20181018214207.4223-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018214207.4223-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 18/10/2018 14:42:07-0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/rtc/rtc-s35390a.c:124:27: warning: implicit conversion from
> 'int' to 'char' changes value from 192 to -64 [-Wconstant-conversion]
>         buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
>             ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> Update buf to be an unsigned char, which matches the size and signedness
> of the buf member in struct i2c_msg (__u8).
> 
> https://github.com/ClangBuiltLinux/linux/issues/145
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/rtc/rtc-s35390a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 77feb603cd4c..9fd51337cfae 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -108,7 +108,7 @@ static int s35390a_get_reg(struct s35390a *s35390a, int reg, char *buf, int len)
>  
>  static int s35390a_init(struct s35390a *s35390a)
>  {
> -	char buf;
> +	unsigned char buf;

I would use a u8 directly which has the advantage to be shorter :)

>  	int ret;
>  	unsigned initcount = 0;
>  
> -- 
> 2.19.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
