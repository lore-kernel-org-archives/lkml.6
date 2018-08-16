Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BAEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFEA20B80
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1VAiAHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFEA20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeHQBXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:23:01 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39859 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeHQBXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:23:01 -0400
Received: by mail-wr1-f45.google.com with SMTP id h10-v6so5448436wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 15:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j5KeK4GrjywvjEI2xJ0Vdkr18VOyW7qCkD+dgRvVaAs=;
        b=Y1VAiAHCyhz47DPHgkgQMLy6k7V54ylQ5L+CI+Ij7zHpwUkE7/5/M6lIS3Nml8pcPN
         eAwX88+MB6n9oufMrucoJzm0WCFu1hrlrsoHo0hSZ45NlPq3VtOuCv3WkpNbXfOGNxno
         bosbDgFqD7kQosN/AKMBcYV5mxE41f8WS1VWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j5KeK4GrjywvjEI2xJ0Vdkr18VOyW7qCkD+dgRvVaAs=;
        b=FVP6OSaUHRvA9lu7UdZSpGLiXMVZQa6VPovPWlp20YoyK4k1O9np0HP5p37pFjdELa
         KeN7xATLDqcpvCzgcTHkb21y8wEJNA5PBp81dtOeIEh+Uf3INmn2DZ3YdScMVhT3QgNz
         asSWNwQOhUC0z3pLauo5OTyglSag3d2hpw9viLZb5hGkgVu3df6rYGLZQID+FozmbDRM
         p3DYxG2cQPvd4MlKAFfhOYyKht9bdCOhcwj43vDomUXf4ECCfAD7heZCbvoJXnrvQfVD
         hVvqNf7+Ug/ZwLEt+fDYCW0rotqGF8GSYIZ3U53oWJ347RiNX+a/I5OlK9Kpo29RCVq2
         +b4g==
X-Gm-Message-State: AOUpUlFZ4ap8BBTEDbdvcQTpuUPtGnPnTNQqCU8RT3j/UE6+ss4S8jIV
        Gb2oBoNNItBF0ZTOff4Y4Qdokux9jtekPgmv+L9o7fj3
X-Google-Smtp-Source: AA+uWPwnekfNprQmwhpIVzs3OCfH2nkJcAduRK2c64Xf4kFZE8uRqylwN2khZpDQ86NMPmyCvXczwT4TFPoSKLq4abM=
X-Received: by 2002:a5d:66c4:: with SMTP id k4-v6mr20789366wrw.154.1534458126609;
 Thu, 16 Aug 2018 15:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 15:22:05
 -0700 (PDT)
In-Reply-To: <CAKMK7uHrCAQpUhd2D4PpiizascLwP1kYgMM6cZv3B8OGez66Sw@mail.gmail.com>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
 <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
 <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
 <CALAqxLWq-wgbc+aS0p45rvxmPj3KicsOV5ucCB-tcKWr74uqCQ@mail.gmail.com>
 <CAKMK7uEbfa24DaDbWjxgerzH69q-niHS5==z6NqJd3Yxi0q+7A@mail.gmail.com>
 <CALAqxLVrZXRT875-AxN=jt_kSD5=Nb9SuCW4PEsVL=pQkT_ugw@mail.gmail.com> <CAKMK7uHrCAQpUhd2D4PpiizascLwP1kYgMM6cZv3B8OGez66Sw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 16 Aug 2018 15:22:05 -0700
Message-ID: <CALAqxLUf33tfMNOJMnpwGpjG7MnKBhTRmZCSGyLrXxsgs1zDqA@mail.gmail.com>
Subject: Re: [git pull] drm for 4.19-rc1
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 3:16 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Aug 16, 2018 at 11:21 PM, John Stultz <john.stultz@linaro.org> wrote:
>> On Thu, Aug 16, 2018 at 1:46 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> You happen to have set drm_fb_overalloc respectively
>>> CONFIG_DRM_FBDEV_OVERALLOC? Was added so that mali blob can pageflip,
>>> would explain what's going on at least.
>>
>> Yep. CONFIG_DRM_FBDEV_OVERALLOC is set to 200.
>
> So ->max_height is indeed the limit (or should be, minus driver bugs)
> for framebuffers. That's enforced in drm_framebuffer_create_internal
> for everything (both ioctl and should also for all internal callers),
> except the cma helpers never made sure this is correct. So I'd call
> this a bugfix.

Sure.  I'm really not sure where the max_height=2048 comes from (and
if its the real limitation or a vendor guessed value - the hikey960
driver I have uses the same), but yea, the old code wasn't checking
it.

> Now the question is whether the fbdev page-flipping actually worked on
> older kernels for you or not ...

It sure seems to work ok with the changes reverted.   Any suggestion
on how to check this?

thanks
-john
