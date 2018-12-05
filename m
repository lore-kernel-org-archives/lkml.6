Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5064820879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544052093;
	bh=kKs9fCjH09ZYm7xIE8xjsTEj1WWem4u06phWTgOm4Wc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ArFW8ff/DwYK4jrmdaJeKLS9VgXtFIOF7+hvL/Xg4D1sXYUWDUwvN0VAvoKnibDEL
	 G78KD2l9C8jSsC6h9APblTugGqPeuGZjCZhO5Fck6zwtdzNmyL6Z7WvVjlT4TKMr+v
	 Jkuvyr2l4z8XviSh/00+5GlqmQD9KdBqh79emb/A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5064820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeLEXVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:21:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbeLEXVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:21:32 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1515020879;
        Wed,  5 Dec 2018 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544052091;
        bh=kKs9fCjH09ZYm7xIE8xjsTEj1WWem4u06phWTgOm4Wc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LhoFOd+C13cM3fJ0Om/QJR/cR3eItuN2ztEWxG1Bhd164OJ0Y57Q7feAgumhHDP2u
         K0lvp+TpfNVazwxof2Y5HqgjkhAAr/P4d1XgE45u05MMVixg89mFDR2vlV3S6ZJcXQ
         +qpVouwljMK1ZhQ9ItL9kIDajCXpDZSAUSSfe0eI=
Subject: Re: [PATCH] selftests: gpio: Find libmount with pkg-config if
 available
To:     Anders Roxell <anders.roxell@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Bamvor Zhang <bamv2005@gmail.com>, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20181016214659.22362-1-daniel.diaz@linaro.org>
 <CACRpkda1i_NDnBGgrEoY2ewdSvSnJFVLWWvmSGCu0sNS0hLyiQ@mail.gmail.com>
 <CADYN=9LEVUgz_ou6kWrXZGBpUZ5Ti7BB+0Uxp1NtP18BJDVHCg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <6dc6f709-6940-4f63-c8d0-9cbbbd39ac2a@kernel.org>
Date:   Wed, 5 Dec 2018 16:21:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CADYN=9LEVUgz_ou6kWrXZGBpUZ5Ti7BB+0Uxp1NtP18BJDVHCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 4:15 PM, Anders Roxell wrote:
> On Wed, 5 Dec 2018 at 22:50, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> Sorry for top-posting,
>>
>> I don't understand the selftest environment very well so I do not know
>> if this is the right thing to do.
>>
>> I can merge the patch through the GPIO tree but I need a nod from
>> someone wise, like Shuah Khan or Anders Roxell (Anders has been
>> using the GPIO selftests) that this is the direction we want to go.
> 
> Yes this makes sense and its already in linux-next.
> 

Linus,

Great. I pulled this in last week into kselftest next for 4.21-rc1 
thinking that this is a good direction.

thanks,
-- Shuah

