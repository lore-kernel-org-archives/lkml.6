Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8EB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmjHnczI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8EB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeKMUIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:08:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38951 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbeKMUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:08:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id g27so10789248oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 02:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MXHbQRoenYPqmoJNBf+zWDkfiZu9DN4vUAFI7cLCNo=;
        b=vmjHnczIne3IJVO4hbl93L3M1fFTCn4tAUc9+hdsLcD2mjw0i5hh8pQLMLNFaSu0Jx
         XgUIPR3kRwcOPy/kU7RorkYYWgqF0TofPs9S999T2MNvbKtz4HcmbJgKcqv1VVMNkT9q
         ViDvdt3JOn7GZBYmpYwiwp13GM3nVvYDQNduF8S50c3Au+bSJhPI4RUkV770Iil1zI8g
         GZBu1grSHeVvhYEA7uJh6W7p5T04+A5+YPWJpFQ4DjbuDaCZlo7JRKzFxOF/oWm+mg/t
         7zKnya59z9uheM6R2X06s29ZxNHVURLVlpOpNlLx3Gy/4YxlXzIuYgV8U3q1Dv+0rVBG
         UIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MXHbQRoenYPqmoJNBf+zWDkfiZu9DN4vUAFI7cLCNo=;
        b=P6o6lUNg0P/kWC/5D00NM4CoWZY/sAnXkw0aKnfioSvde//UWmroQB7UNjEZU+VvrY
         c1s8iljjbxDaJ0oOrJeYxVMP4XROmFA4DIPp4HQSJiHn5ls6+srB/ovj2ZwVYSSUuhSd
         VWkxqk1Rm46nIHhYdvBqRETmAA+v1IqMpQ4VW5wiCr1qqY19oqSUQW1AbsbCfur47tHp
         D54WaUI3KUHT82fHhg+iYsU9OuNCEKhEF1JuADdAo439YoAGD91Xe7g0MrJDIf5J0+mi
         N0uYF2r/xvjv49NjHeDfO+D62bypN9ZZ0bWjXRLLhpL/EY7LGaC2vPM0jAXJD182gsCK
         bWcw==
X-Gm-Message-State: AGRZ1gLH34EFLSwHhcbTdN11IfWnHOvJFXdIpFZx9BdAKmv7irInz8Oz
        8jao0rWprIbBlGDjWfqxAzGgPSFhUwIKaJQbVa9CDA==
X-Google-Smtp-Source: AJdET5e6UMxEsqss1R37Ss8VyVmyN88L70555OwsjSDcUtbh1wrEPrxSRo0aotfVCMNJNzuOH/SMD5tZu86qouofy74=
X-Received: by 2002:a9d:3ba5:: with SMTP id k34mr2805025otc.364.1542103845971;
 Tue, 13 Nov 2018 02:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <f3682d48-6f27-5eef-8274-02f90dd65188@kernel.org> <CAFd5g45Tgcx4RisrCF8QHneR7ELezPfpEPKh_mH8KEUi3skE7g@mail.gmail.com>
 <04f677b1-bc44-f004-cf2a-51b47baf0965@gmail.com>
In-Reply-To: <04f677b1-bc44-f004-cf2a-51b47baf0965@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 13 Nov 2018 02:10:34 -0800
Message-ID: <CAFd5g46bzF-+1VzAFYb5cF=e45O2rjagX+NY4UFKgU7cyujc7w@mail.gmail.com>
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     frowand.list@gmail.com
Cc:     shuah@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:46 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 11/6/18 5:17 PM, Brendan Higgins wrote:
> > On Fri, Nov 2, 2018 at 11:23 AM Shuah Khan <shuah@kernel.org> wrote:
> >>
> >> Hi Brendan,
> > <snip>
> >> Framework looks good. I think it would be helpful to include a real test
> >
> > Great to hear!
> >
> >> in the patch series to get a feel for how effective it is.
> >
> > Alright, will do. Rob suggested converting
> > https://elixir.bootlin.com/linux/v4.19/source/drivers/of/unittest.c to
> > KUnit, so that might offer a good comparison.
>
> drivers/of/unittest.c might be a bit bigger and more complex test than
> you want to start with.

I already got it working under KUnit. Admittedly, structurally it is
not so different, so it will require some work to make it pretty.

I think now it is a question of whether you want me to start here or not.

Probably best just to share what I have now along with Shuah's
requested changes and we can go from there.

Let me know what you think.

Cheers
