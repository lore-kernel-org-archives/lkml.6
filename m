Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E8BC65C24
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD192087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOA6JlaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD192087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeJHAsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:48:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42638 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJHAsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:48:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so7127140pfn.9;
        Sun, 07 Oct 2018 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rzj4WBPERV6NV6KlWv+B38vbbotyd5Ub02NEKFxe13w=;
        b=TOA6JlaCR3wP++7kPykgvYnfDfmgdAb9aR6I1H8cjZ8wZtsCYh1Y5HbC5fQqpXAfSp
         RTmSHNAVY6UDdVKz33wNG/R4bfGtDvo0X2ztBPiLj+h9gGWM4iS9X5GqzV7enei7Qwq2
         xwGwZxEYVy+jTV6FidPy9ssRs30UH4hfhMOBG7UWQEQ40SF1UjvXOrVmwQqPrqd6V6yf
         uGPv/MDmnx8x5Owu0SNi6KniJv4t3I2ziCgrqHm1pEXrMu+AUtpKM51SNL2vb5svqRso
         pshrTn6iwXLh3vurnETBG6xm5xESO5LSTeQtNM5EA4d8hEnVENI/SfH4jcBu54oGYUu3
         vzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rzj4WBPERV6NV6KlWv+B38vbbotyd5Ub02NEKFxe13w=;
        b=tgZ8ikPLiHfVoWUjo2zfxhqn+Jp3Baj9XAXG0+AdxSzPX+okkxMlbeTDnY/GqaPNcq
         zdCBUYIpFwMDokpAKp8zxIDq2VVRcZ+5JKjPzXI68ovmY3BKAlry7i1hSct6nwZoNbf3
         jv1FPM6QkQXEKEvD6aAFgng1kkm+JMTfVh6fjPluqYIiAdw3tyazNW7LlfX7Wc9Yw8tT
         fE6k6NK/plHofl7Jug/l5U7oqC37npZZm7ywogd3j4Wu1A8MyK6a4mdAdQpdZGypOag0
         cZmy0Aulh06fzo4apQinH0FkZp0y028f4X9UvxGLw2xwJmzkzIrF51t4K2SZALh8vn94
         4QUQ==
X-Gm-Message-State: ABuFfogLIyRCbsayTaqtbUV7xizSRIv81qv4Xw1zD9X93iU0piV46q7Z
        eW+tATTWMBxzWy0vI5xAM6FNp1R8
X-Google-Smtp-Source: ACcGV60Li2SzGnPf9vWZr/2K18y0cGgxptmTOc/mpTulW1e6w1Zy+Kk0yY29M9Gtctn4bWVWyZZnag==
X-Received: by 2002:a63:1c6:: with SMTP id 189-v6mr18279840pgb.136.1538934023614;
        Sun, 07 Oct 2018 10:40:23 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id g123-v6sm7855818pfc.67.2018.10.07.10.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 10:40:22 -0700 (PDT)
Date:   Sun, 7 Oct 2018 23:10:14 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad2s1210: fix 'assignment operator' style
 checks
Message-ID: <20181007174014.GA21345@himanshu-Vostro-3559>
References: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:24:26PM -0300, Matheus Tavares Bernardino wrote:
> This patch fixes all "Assignment operator '=' should be on the previous
> line" checks found in ad2s1210.c by checkpatch.pl.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

As already pointed out tabs -> whitespace issue.

I assume you attached or copied the patch into your email
client and sent it. Usually, these clients wrap the message
which leads to patch corruption and hence it would apply
to the maintainer's git tree cleanly.

Therefore, I would suggest using `git send-email`.

Also, as a safety measure you may use the `--dry-run` flag
of `git send-email` to see how it would look like when you
send the patch.


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
