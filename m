Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B483C282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168FC21929
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMCLYksd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBJAFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 19:05:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39960 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBJAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 19:05:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so8271797qta.7;
        Sat, 09 Feb 2019 16:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e6ubDiyQQtWehDDOmAQygkA56UGFONp4YdZOU97vLOI=;
        b=PMCLYksdawD6nRSwSU1EGOcZFK0LWnawbI3Q1730+RGj37jYy36OFh7PJgQiW1BKue
         R0suS9rFAmHd84NLRNuUypuTaIJzo2mtGYZNGkMOYE8ZJnS9Etz48faZk4+Ig6szJKxS
         9wgsqens+cmSy0PdJLf42OZsZz9982LDskXAahPQhZ+WlpRjmfmQrkerO/rhSOinggbh
         zQVAQuYx5EmBgSSaXCz7ia9wVzKX3V9UJr1o1rV/hGNmgnFETt0f5gN/i6LPt95TzCHM
         5rAdwbgnmjyfHWdge22ngf/Yl9qJhk0s/8DONlV8ZUMuv3gsHMyd/qvpQRvYai+L7DsR
         u2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e6ubDiyQQtWehDDOmAQygkA56UGFONp4YdZOU97vLOI=;
        b=b3bImu2aon8aiIi1j0XnyorF+TVp00x1/sWVRhPjqZhHdIN6yczm+Md/4EPLIw3kId
         F1KS/n0pCHsZCMsWw8Xk3crkqUA4rwDSR7QCnlZgQPzHDfMIkIFdAeoZKYqUYbPbwSQ5
         ZOSXiwgQ7Jz6Atete/xZqh5Gz9BvpLB3VN+42Tkw/YUBJX+1iQhLM29pyKvx0KtYhs8e
         KS7rcQR5pqgBmJpnrrnag4Zn5X5RPQE+uR+e0kt1F4oSfEdQNbQJWDGful6nWWATVo7V
         kH9NQ5nFM/A9i6U9JoFUoimv4c71fpiDaRZs0151Ekihob5AImw7TgSzOJglpAqXtkjN
         qF0g==
X-Gm-Message-State: AHQUAuYfu8wvCWgOq8E7n5jK42LD0qvn3ZsoJ869h4uoV6M+l2zmrMRF
        LPW4c9+dwR9Zbrfvzsq/ZzU=
X-Google-Smtp-Source: AHgI3IZXGAHQ8uN0s0/0pXW1RT6AAOD/IWcYUQG7PIC7oOipudk+jW+H9EbZi2SDJqTEOWxMWV7lMg==
X-Received: by 2002:a0c:84e1:: with SMTP id m88mr21624752qva.112.1549757117087;
        Sat, 09 Feb 2019 16:05:17 -0800 (PST)
Received: from [192.168.100.2] ([187.38.229.162])
        by smtp.gmail.com with ESMTPSA id q17sm6795146qtc.19.2019.02.09.16.05.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 16:05:16 -0800 (PST)
Subject: Re: [PATCH] iio:potentiostat:lmp91000: solve codestyle WARNINGs and
 CHECKs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Perches <joe@perches.com>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
References: <20190129183656.15656-1-lucasseikioshiro@gmail.com>
 <a8ae5209f676171a97cae7211411e7ced3ebefbc.camel@perches.com>
 <d2c70e04-f20c-6847-9740-d883c327c55f@gmail.com>
 <20190202100044.678a9a9c@archlinux>
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
Message-ID: <810b3bae-434e-5433-4bdf-8458768dcb01@gmail.com>
Date:   Sat, 9 Feb 2019 22:05:11 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190202100044.678a9a9c@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! I'll send those changes in my next patchset.

On 02/02/2019 08:00, Jonathan Cameron wrote:
> On Fri, 1 Feb 2019 12:29:11 -0200
> LSO <lucasseikioshiro@gmail.com> wrote:
> 
>> Thanks for the review!
>>
>> On 29/01/2019 20:48, Joe Perches wrote:
>>> On Tue, 2019-01-29 at 16:36 -0200, Lucas Oshiro wrote:
>>>> Solve most of the checkpatch.pl WARNINGs and CHECKs on lmp9100.c. They
>>>> are the following:
>>>>
>>>> lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
>>>> lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'
>>>> lmp91000.c:214: CHECK: braces {} should be used on all arms of this statement
>>>> lmp91000.c:216: CHECK: Unbalanced braces around else statement
>>>> lmp91000.c:258: WARNING: line over 80 characters
>>>> lmp91000.c:279: CHECK: Please don't use multiple blank lines
>>>
>>> Some will say this is too many things to do at once.
>>> I think it's mostly fine, but there are a few nits
>>> that also could use fixing.
> 
> Always a case of personal judgement.
> I agree that this one 'just' falls on the side of not too many things for one
> patch.  If there had been a few more items then it would have been too much.
> 
> I would also have been happy with it broken out.  If I had been spinning
> it myself, I would have done it as 3 patches in pairs from your list
> above with the last one grouping the white space changes.
> 
> The test inversion below is also stretching beyond simple style
> so probably should be broken out.
> 
>>>    
>>>> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
>>> []
>>>> @@ -211,9 +211,9 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>>>>    
>>>>    	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>>>>    	if (ret) {
>>>> -		if (of_property_read_bool(np, "ti,external-tia-resistor"))
>>>> +		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
>>>>    			val = 0;
>>>> -		else {
>>>> +		} else {
>>>>    			dev_err(dev, "no ti,tia-gain-ohm defined");
>>>>    			return ret;
>>>>    		}
>>>
>>> This could use inverting the test
>>>
>>> 	if (ret) {
>>> 		if (!of_property_read_bool(...)) {
>>> 			dev_err(dev, "no ti,ti-gain-ohm defined\n");
>>> 			return ret;
>>> 		}
>>> 		val = 0;
>>> 	}
>>>   
>> Thanks for the suggestion, I'll do that in the next version.
>>
>>> Also the dev_err is missing a '\n' termination
>>
>> My aim in this patch was only solve style problems, but I
>> can put that missing '\n' too. Do you think it could be done
>> in the same commit or it's a better idea do it in another
>> commit and send both as a patchset?
> 
> Separate commit given as you say it's not style and this one has
> enough different things in it already!
> 
> Thanks,
> 
> Jonathan
> 
>>>
>>>    
> 
