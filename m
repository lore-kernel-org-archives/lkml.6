Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2183DECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B6020673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwrYv2CW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B6020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeGRIRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:17:17 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36803 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbeGRIRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:17:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so7019968oie.3;
        Wed, 18 Jul 2018 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FpU8WVkxWhkRm+pIvNPan/KwKZOMLKKTeKz2qWZPgY4=;
        b=CwrYv2CWVp9w/n0fsEbbdiGfNUzg5wAtslcBE/kXXh9VKKDyPan6NZjVCsi+0kGr8q
         6t1TKVsfR4DxJFS5AOgoHwksxEx2sMHqa3LA4SjW1YDrJHZ9ay5CwPCE7pr3YpIFBRE+
         O6+Nj/Ely/mIA0ZzbEGTVKczCtuFI8W2GOpQqxXdI/hrAqgS+79wkIepw4bCP8eKlnfS
         q5KlP41gOepjrEj+lQTQ4NcSoNPdRg1vivhZEfOPL5PbU5xoJJO3UKSJRR/YD63GoIqJ
         QLK+rPv1PtOFmNE1oqkQagt8D2SETB4zJdsnKDHg9Ss43Buj67e31+6caCjb0MPY6S/U
         zgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FpU8WVkxWhkRm+pIvNPan/KwKZOMLKKTeKz2qWZPgY4=;
        b=P+yqMcaeA1rmsIIEw5+3R6EcHp9R0ZhLLx4+kVBXTi+vGMK4sE1Hv1EewUI/kOmf4p
         sIj08a7c52Tjlvi+u3bpoa/jee4vssf0+HKe2SfBrfAJ2Kc9iEPRNgBk7Jt02/KnH8o4
         nuC1bPprVEdOswVEekz47m92y02ZStKpugMQjP8TZfE8m/66oIdR+Wn/mHmngMPa521S
         NNgNKmeWFrbiJ9losXGeRZuGQEbYrcrEGaKNxBXvOuLq/W6T82dHOKj+BwhwGLZuuAv4
         dKeZ4xAfmm2uUcrkULHmcP+vuqYCud3uMZEw848Fnuek4V6sUX41b1MC/Q6TJGhlA8s8
         GY7w==
X-Gm-Message-State: AOUpUlH3d3qkBCYSnofp7Ny5CGf+fA74zunRd0eKJYauEPdV3USOvBYC
        7QSqEk8P5csDM22KeZ3G/a2x5lduP8wWrvMt5zY=
X-Google-Smtp-Source: AAOMgpdE49kbnqHo9Dffw48WCNLpSirv4r77hucRkvxFhypAFPijFuaISTFc5l+BaIHLOfwWfYHHIVuQZ8x+DAjbfNc=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr5558344oie.233.1531899644480;
 Wed, 18 Jul 2018 00:40:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 00:40:44
 -0700 (PDT)
In-Reply-To: <2dbe75b1a83c025b9cddc229dbca9af6fb30111e.camel@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de> <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
 <20180717182041.GA18363@wunner.de> <cb5af1611622a080fdcbcf3bb794d8ebc39cae2a.camel@redhat.com>
 <20180717183211.GB18363@wunner.de> <2dbe75b1a83c025b9cddc229dbca9af6fb30111e.camel@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jul 2018 09:40:44 +0200
X-Google-Sender-Auth: C2fGXLzxkqbA8QVdsz7e-Cp14jI
Message-ID: <CAJZ5v0jQXwxXCzxiLcVnBQPvrAX=GRUr2O=TknmhAS3U_ZTAtg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback recursion
 in suspend/resume paths
To:     Lyude Paul <lyude@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>, nouveau@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 8:34 PM, Lyude Paul <lyude@redhat.com> wrote:
> On Tue, 2018-07-17 at 20:32 +0200, Lukas Wunner wrote:
>> On Tue, Jul 17, 2018 at 02:24:31PM -0400, Lyude Paul wrote:
>> > On Tue, 2018-07-17 at 20:20 +0200, Lukas Wunner wrote:
>> > > Okay, the PCI device is suspending and the nvkm_i2c_aux_acquire()
>> > > wants it in resumed state, so is waiting forever for the device to
>> > > runtime suspend in order to resume it again immediately afterwards.
>> > >
>> > > The deadlock in the stack trace you've posted could be resolved using
>> > > the technique I used in d61a5c106351 by adding the following to
>> > > include/linux/pm_runtime.h:
>> > >
>> > > static inline bool pm_runtime_status_suspending(struct device *dev)
>> > > {
>> > >   return dev->power.runtime_status == RPM_SUSPENDING;
>> > > }
>> > >
>> > > static inline bool is_pm_work(struct device *dev)
>> > > {
>> > >   struct work_struct *work = current_work();
>> > >
>> > >   return work && work->func == dev->power.work;
>> > > }
>> > >
>> > > Then adding this to nvkm_i2c_aux_acquire():
>> > >
>> > >   struct device *dev = pad->i2c->subdev.device->dev;
>> > >
>> > >   if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
>> > >           ret = pm_runtime_get_sync(dev);
>> > >           if (ret < 0 && ret != -EACCES)
>> > >                   return ret;
>> > >   }
>> > >
>> > > But here's the catch:  This only works for an *async* runtime suspend.
>> > > It doesn't work for pm_runtime_put_sync(), pm_runtime_suspend() etc,
>> > > because then the runtime suspend is executed in the context of the caller,
>> > > not in the context of dev->power.work.
>> > >
>> > > So it's not a full solution, but hopefully something that gets you
>> > > going.  I'm not really familiar with the code paths leading to
>> > > nvkm_i2c_aux_acquire() to come up with a full solution off the top
>> > > of my head I'm afraid.
>> >
>> > OK-I was considering doing something similar to that commit beforehand but I
>> > wasn't sure if I was going to just be hacking around an actual issue. That
>> > doesn't seem to be the case. This is very helpful and hopefully I should be
>> > able
>> > to figure something out from this, thanks!
>>
>> In some cases, the function acquiring the runtime PM ref is only called
>> from a couple of places and then it would be feasible and appropriate
>> to add a bool parameter to the function telling it to acquire the ref
>> or not.  So the function is told using a parameter which context it's
>> running in:  In the runtime_suspend code path or some other code path.
>>
>> The technique to use current_work() is an alternative approach to figure
>> out the context if passing in an additional parameter is not feasible
>> for some reason.  That was the case with d61a5c106351.  That approach
>> only works for work items though.
>
> Something I'm curious about. This isn't the first time I've hit a situation like
> this (see: the improper disable_depth fix I added into amdgpu I now need to go
> and fix), which makes me wonder: is there actually any reason Linux's runtime PM
> core doesn't just turn get/puts() in the context of s/r callbacks into no-ops by
> default?

Because it's hard to detect reliably enough and because hiding issues
is a bad idea in general.

As I've just said in the message to Lukas, the fact that you need to
resume another device from within your resume callback indicates that
you're hiding your dependency graph from the core.

Thanks,
Rafael
