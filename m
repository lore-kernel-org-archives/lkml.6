Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E58C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775822088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hre85pPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775822088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbeFPTQl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 15:16:41 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45423 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPTQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 15:16:36 -0400
Received: by mail-yb0-f193.google.com with SMTP id x6-v6so4655958ybl.12;
        Sat, 16 Jun 2018 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4fYWdt8qcDdRJRxF6ANwncTVvA5v54Ksolkx660k4c=;
        b=hre85pPRct45yC9YIXqETBQ46v3pz4jNuR7QC9eLIy/Mby1T8fmZitC7+p2ZuSew0K
         m+eZyP7C7ga76YVUHtRUJXocBZR9Z2dCTXcjmN2wHWL7pDoWnRUKvpLPdGnDqbRbGUk6
         RMgqANGbH8CjAcn7rDt51G6QZfM7mCfEtOoH/+bawYlWgtymcyxuKy4F/5SNXggHdI23
         iVwasaPfCLPzqzoZTtafcFkA5dTqTu/M+Irmw+pKx+GQklkc2tobxMYvbU3vCZj2sC2t
         bDUY8b1ZLmhSVaz9UucOVbvnzdpqK4O7RiozC5Kx2LHIbJAtwtbEp5zahIg8LLMOpMDJ
         1+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4fYWdt8qcDdRJRxF6ANwncTVvA5v54Ksolkx660k4c=;
        b=ZPf4+w3H1x6T1zXQNaAgF42saB3kUqxHAk7MTL4fbs8/Y5xs5pQHWxBTygDR0YBsNb
         YJPirXWKkM++T8hZ28c+212RqtLB/elGPj6VT8M0/D6Z7/47eed8ysp9ZUqu5bzjtsyv
         ra1C4xb1FS4NGrvvh6T+T2lVffuWkumiT5Zlhnh8VsJSNMVN9xpfrxTphyMI0ToThiX8
         5sfjAmeifn16jD6GmjfjHHv+Ju2sk24Wa671VFhSR1zeQAq58v5XEJT59xB88WIexh89
         1j3ybXJ6YlMy44W5Mvq9/YQKnNe3fvzexCAZXl0XJf1rpW1eZ4PlC/6S/k9kDQdvBGlx
         msFg==
X-Gm-Message-State: APt69E1zZhwf+GrYGAPIOqxAMrn4I9v1HdavD9k+NH3tdm24CMjnYOG6
        3EK7liZmGRDV1f5fR1YOCsk=
X-Google-Smtp-Source: ADUXVKIhfQwlvoBBLTxWjyLYosY98sIHEzBptZB2E5VV/GIYDxB8srW29UamFUAYuEww+qufFnmkaA==
X-Received: by 2002:a25:d4c1:: with SMTP id m184-v6mr965741ybf.244.1529176595578;
        Sat, 16 Jun 2018 12:16:35 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id w4-v6sm3951742ywf.63.2018.06.16.12.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 12:16:34 -0700 (PDT)
Date:   Sat, 16 Jun 2018 15:16:24 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Introduce the for_each_set_clump macro
Message-ID: <20180616191624.GA20211@sophia>
References: <cover.1526400945.git.vilhelm.gray@gmail.com>
 <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
 <CAHp75VcGuJ0+qzUZZW=1VSeXmf_rht0tJvCH+yBsXPZz0z8qHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VcGuJ0+qzUZZW=1VSeXmf_rht0tJvCH+yBsXPZz0z8qHA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:08:28PM +0300, Andy Shevchenko wrote:
>On Wed, May 16, 2018 at 5:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, May 15, 2018 at 6:22 PM, William Breathitt Gray
>> <vilhelm.gray@gmail.com> wrote:
>>
>>> For example, suppose you would like to iterate over a 16-bit integer 4
>>> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
>>> represents the current 4-bit group:
>>>
>>>     Example:        1011 1110 0000 1111
>>>     First loop:     1011 1110 0000 XXXX
>>>     Second loop:    1011 XXXX 0000 1111
>>>     Third loop:     XXXX 1110 0000 1111
>>>
>>> Each iteration of the loop returns the next 4-bit group that has at
>>> least one set bit.
>>>
>>> The for_each_set_clump macro has six parameters:
>>>
>>>     * clump: set to current clump index for the iteration
>>>     * index: set to current bitmap word index for the iteration
>>>     * offset: bits offset of the found clump in the bitmap word
>>>     * bits: bitmap to search within
>>>     * size: bitmap size in number of clumps
>>>     * clump_size: clump size in number of bits
>>>
>>> The clump_size argument can be an arbitrary number of bits and is not
>>> required to be a multiple of 2.
>>
>> I must say I'm impressed. Very nice arithmetics going on there.
>>
>> If I can get some ACK for the bitops patch I'd be happy to merge
>> it all through the GPIO tree. The users are pretty clear cut.
>
>Give me also some time to go through proposed API, I think it might
>have needed more alignment with existing find_* and for_* helpers.

Hi Andy,

Are there any additional changes you would like me to make before this
patchset is merged through the GPIO tree?

William Breathitt Gray

>
>> BTW: if I could, I would pull out Donald Knuth's "The Art of Computer
>> Programming vol 4A" chapter 7.1.3 "Bitwise Tricks and Techniques"
>> to see what he has to say about the subject, but I don't have
>> that book as it turns out.
>
>I can also add the Standford collection of bit algos here:
>
>https://graphics.stanford.edu/~seander/bithacks.html
>
>-- 
>With Best Regards,
>Andy Shevchenko
