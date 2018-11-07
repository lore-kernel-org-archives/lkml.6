Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41CBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD34C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCxDCj/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD34C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeKHDSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:18:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39590 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKHDSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:18:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id n11-v6so8006611pfb.6;
        Wed, 07 Nov 2018 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LOKLPVL/KsT8t3RMSP3F8SnKPuBYykBW3BXpx0B7TBk=;
        b=aCxDCj/ZVIuuue4FlryrytMrDD0EdMT/YvVSappfIxQtBGieOhDw8WCTN4GE3GIzFE
         2URThU0PNOlGj2dA6/R0rJ1iwBN+xYmKDPpU9ZdT4I+kczrcm1PhoINeqzN83sUJQpTh
         oPq0fbneVwMMLnJd/TVQK4cZ3/j4k9LKNdCxr8VLZirxv9cfTKJ2iUtHvBBwbCZSXltB
         lQq+EeWwF2d9xmRgAXQC/Ziat/98DyTaQKvekErsbmH/n0n5ZPH6bI3dWJD7W2FEfbHh
         WYNfKw+l1tiCNs63eUmT65Ls9KLW8FTx88XVajKM24pplB1M9kR7i8BTMDJxCLYoodFY
         dr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOKLPVL/KsT8t3RMSP3F8SnKPuBYykBW3BXpx0B7TBk=;
        b=l2kuxLv/TtYIoja7DBW1qj7dHRHrbMRfSqkWlkMcD9jrJSdm9uNgXmktW9o8+XXcBN
         zYZ1m4r5EVK9Nj1nF17f8ZmeJO7Wo4x4UaF1gdta9cS8VAUwLcDN/NhPg8bZC4APYqL1
         Z+d9JW8v9kALVhneFY6xF3swASSqf2lB8Mfv9xRuSHaJZ7EjpaL3Q/yn0Q0fZNrJmAIA
         k7UnHWNvQmD50ryx1Ms+G+tt8tnsFeXzeVj1Kt/WqetZbESjisnGuiLHbize+sTuWCw3
         OR93bsiiYA5v5cZAkQ2MBJQzjpYRNeKOGJ1t9xvlzWYJCk9FVeSwgR8uaAy8jOvYvYnQ
         RVjA==
X-Gm-Message-State: AGRZ1gKPs3eygKo5OIPxtarKRkPs5afPaWMOr0dKiAtzi5DF9wV089A9
        7VJc2SJgwCw9SmHd9gT0SPcCydmy
X-Google-Smtp-Source: AJdET5fm+VT0HNl+ovu7FeIekxZ32XXMjJUp+qqAB++lxBuyeEeuRrgONhqLi+T7TgDhVwzZh0Pzaw==
X-Received: by 2002:a62:7f8c:: with SMTP id a134-v6mr1186753pfd.22.1541612804598;
        Wed, 07 Nov 2018 09:46:44 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id x123-v6sm1370196pfb.124.2018.11.07.09.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:46:43 -0800 (PST)
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <f3682d48-6f27-5eef-8274-02f90dd65188@kernel.org>
 <CAFd5g45Tgcx4RisrCF8QHneR7ELezPfpEPKh_mH8KEUi3skE7g@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <04f677b1-bc44-f004-cf2a-51b47baf0965@gmail.com>
Date:   Wed, 7 Nov 2018 09:46:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45Tgcx4RisrCF8QHneR7ELezPfpEPKh_mH8KEUi3skE7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 5:17 PM, Brendan Higgins wrote:
> On Fri, Nov 2, 2018 at 11:23 AM Shuah Khan <shuah@kernel.org> wrote:
>>
>> Hi Brendan,
> <snip>
>> Framework looks good. I think it would be helpful to include a real test
> 
> Great to hear!
> 
>> in the patch series to get a feel for how effective it is.
> 
> Alright, will do. Rob suggested converting
> https://elixir.bootlin.com/linux/v4.19/source/drivers/of/unittest.c to
> KUnit, so that might offer a good comparison.

drivers/of/unittest.c might be a bit bigger and more complex test than
you want to start with.

-Frank

< snip >
