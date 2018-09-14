Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8687CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAC720833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwp5zsoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAC720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeINWqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:46:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40578 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINWqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:46:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so4612575pfi.7;
        Fri, 14 Sep 2018 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ee8eiz9klqk9Kkx3o9qE7t9GefInEOemujD8Z/WM++U=;
        b=cwp5zsoIjwSFuzLlmut5qjV04NMYfgIHrdOu5bo5tGPJ/zxWKvLvBdS01P3s/3h2Sc
         GFUB9caqAPpf+ROh0el661dleaKp0x029qWDgcyPXga+htcWvEpIUa1cXo/YiNo7puyF
         ZL1T2n2jv8w+Pp5jSXT8oAOOJCtVcUeP/BG9fKVEeWnsEOt2/82Qp9oeAUnNOMVFovs1
         GRyorOKOwjRYhv67hGMu8tBO/bmEuvNxUk8EAXQzetukaHTvoPmgjRQLzH2+P+xjugKP
         bl7hDedX0zPOxGo0F/rdP5mz9N6+u9Ilmj0gLosInh0lUaELbFXdmNuJG6tpTF35tv1x
         Fb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ee8eiz9klqk9Kkx3o9qE7t9GefInEOemujD8Z/WM++U=;
        b=kBh5fGGJs8BTxBdH9/EMZGXHpbpKuRhkLaDebTUPJNF8RVBU+VzSnlaXELa4yQIz9x
         XBjkbsFffjeofW9+AWDK1k1DHSFk+tGis98dG9HSoWKfMF3SkiD/IivULizMBiRx5tUX
         iBf1cr7tXhqAHOWXCSBxrvjHCQIP97hUr4xiAbi3sPvzffMKgu6XLAdVEipmgcB9VkFj
         +PcCQxJH+XljZhhiP5ndC/vtBOspewVFOgzSkjuY4KuJ2q+Jg+9YM1CTBYPFz+EfLXgR
         MZz11CZnql7c29lTpYfZokfK7x03qjVQkS963NFe/J7oz3TOP0vSV24aSnfFModT0xKB
         jNEg==
X-Gm-Message-State: APzg51Ae288BviIyJTBAzKUP28PSfYL5B/fd3ZG6yLdU03mTT+IMUM6a
        EIsXk12ZhhLyIeCAgW+g70xKhKafw3A=
X-Google-Smtp-Source: ANB0VdbYW1yikxkbp7woJQYMe+xWh31+5h6xSt4fOl15m8IeoCoPqrT8DJYAZgpJ0/B/naDR4jGgDQ==
X-Received: by 2002:a63:6283:: with SMTP id w125-v6mr12455102pgb.83.1536946266585;
        Fri, 14 Sep 2018 10:31:06 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id z20-v6sm13397828pfd.99.2018.09.14.10.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 10:31:05 -0700 (PDT)
Date:   Fri, 14 Sep 2018 23:00:58 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
Message-ID: <20180914173058.GA8405@himanshu-Vostro-3559>
References: <20180911150011.31964-4-afonsobordado@az8.co>
 <201809121715.5Babt1QC%fengguang.wu@intel.com>
 <20180912182350.GA13032@himanshu-Vostro-3559>
 <2cd9b1674ae88f153a5afe65c151cabf308e4fe7.camel@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd9b1674ae88f153a5afe65c151cabf308e4fe7.camel@az8.co>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 04:26:44PM +0100, Afonso Bordado wrote:
> Hi,
> 
> Thanks for your help with this.
> 
> > And I suspect it may be originating from your code snippet:
> > 
> > #define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500U >>
> > (scale)))
> > 
> > and looking at the implementation:
> > 
> > include/linux/iio/iio.h
> > /**
> >  * IIO_DEGREE_TO_RAD() - Convert degree to rad
> >  * @deg: A value in degree
> >  *
> >  * Returns the given value converted from degree to rad
> >  */
> > #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> > 18000000ULL)
> > 
> > This '/' operator might be the culprit!
> > 
> > Just for checking that the error, remove the macro declaration
> > `FXAS21002C_SCALE`
> > plus its usage and re-cross compile using `make ARCH=i386`.
> > 
> > In my case I used the `div64_s64` function handles builds for both
> > 32/64
> > arch accordingly.
> 
> Yes, this is indeed the culprit. If `div64_s64` works the same way, I
> wonder if the best option is to change the macro definition.

"....works the same way" ?

Let us assume that the problem arises due to the 64 bit division, in
which gcc places the __divdi3() runtime function to promote the
"freestanding" environment implementation. And then linking fails
due to unavailability of definitions/declarations of the aforementioned
function.

With `div64_s64` usgae the linker binds the definition present at lib/div64.c
and the build completes successfully whether building for 32/64 bit
environment.

But then why didn't this error showed up in the past, in the rest 
of the drivers ?

I see its wide usage in IIO without bug reports:

himanshu@himanshu-Vostro-3559:~/linux-next$ git grep -w "IIO_DEGREE_TO_RAD" drivers/iio/ | wc -l
34

And that concludes, that there is some problem within your code!

In the meantime, you can try to look the disassembly of the function
where this macro is actually used and search for __divdi3/__udivdi3
function referenced in the plt.

I might be wrong though...

Wait a while for the experts to join in!

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
