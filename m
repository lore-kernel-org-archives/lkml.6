Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1072153-1524212746-2-4183173632891997151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524212746; b=YDGKdPPvN0trMvnnmSmmvEaNAW3os/Ov/c/7Elv2WdqP88PaXv
    vp5dAEyaurrdhbavEsP+cB3Ebb1lJSEom15zW0dXTnKjsYtStYchu+Ir76KPpNSE
    5xR2QH3mWDifzmusQB4zpYDZZxkWKTsgHMPTB8cVaozE4jkJbjm6RxD3HoXbMcdp
    caAm//PqvqK2+2qfMwszJbLaGdUrwJyywvY69Mjm8rRUVkJTqHHHqwjLGdjR5vsc
    KzCmyzIp6Igk0p3h9bFZZu+wViAZ9QnU0HNFpZfpiKmWF8fTWILX5unOKP5Avk7v
    uX4yVE3jaWcxA5m51YoaxI8jbrW1DdHNORdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524212746; bh=SjJZScKMZBQs1a1oIOYIBl1CGEk2YIR/ESTZJfDLUy
    A=; b=C7DmUHV2Q0kwIMmxe1+IV9sdqO8HmDd3WeeZwxBk4CZv7EAMYEkRQbeKZT
    1OfghajjUWn795u5HwqovsyVqG0WB2glIMuSe971CV9rnfIbEwXLjQ1v0XNzWiUi
    d1xvAeaBTtT08uYEMc2qvS2Ze6GH10jOy3NwF8fRVOa6pKGmWa/rS4HG82NNcjBl
    5Y3l6d+E4MnwaiYj9cbt9IXewuh1xS83NgNdWIEfSHFdKsfvQHRjr3ZQ2wHJGY8U
    6nMaUOF69C6ZSuG4dNxgiyTsg+IROsOA7dYcj+zTtbOlMvVFp0o0DqIrZvphchAv
    /JenYn/Y0VwQrm34m27yGkFRMQ5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uC+v4obW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TuaXzRol;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uC+v4obW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TuaXzRol;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIYDsJfxfJ73Tr2IDPwN7LIgntsyM8ZGt5U5gE7A8nsEQ8EE6/Wg4AqSIbktnyhujAma6pQRFdDLo+hr0ATAn6XdRUWfAy8lN2bYZ+hUAgGpfxUm40Hy
    zqWkkX3VGLuP845X64Nr1HkSOMFmNlUWncAOD8Q0JM+YpezSWG59+anSwoScqKG/xR10FHyXVaiDneQ07DJi2v+rTcFRNTppELcavX5fM9bVR9BetPIgdk6O
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=unD1LOn5OY8A:10 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=6jyvMCM4a-NY-vWKxmEA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeDTIZn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 04:25:43 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35952 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDTIZl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 04:25:41 -0400
X-Google-Smtp-Source: AIpwx49civwb95P+keIVFDpio47DKn4zNwrNQrnpMhX2ZVJqRBVbhH5msL5c5JEQs2Wx5YyjX3tU8Akhf/jgpYq99sc=
MIME-Version: 1.0
In-Reply-To: <87o9iee2pb.fsf@intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com> <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com> <152397448099.13647.3490065625139821046@jlahtine-desk.ger.corp.intel.com>
 <CAFXWsS8o72qgO419muew4ei3VgorYWmGq0k=xPNe1es3DmD0gw@mail.gmail.com> <87o9iee2pb.fsf@intel.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Fri, 20 Apr 2018 18:25:40 +1000
Message-ID: <CAFXWsS9L+9tJX_yqoC9qYKD39ninS2JfqmU9Yec580aUgkEyrg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20 April 2018 at 17:50, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Fri, 20 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
>> I've performed backport testing and some additional analysis as follows:
>
> What testing did you do beyond booting? Did you run igt?
>
> BR,
> Jani.

I did some basic testing including running a 4K video on Chrome whilst
running intel_gpu_top. The intel_gpu_top program doesn't display
anything on 4.12 either with or without the patch as neither I nor
Canonical enabled CONFIG_DRM_I915_ALPHA_SUPPORT. Do you think that the
stable tag should exclude 4.12 because of the 'alpha quality support'
and if so do you want a V2 of the patch?

Best regards,
Ian
