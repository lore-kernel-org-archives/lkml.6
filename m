Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F74C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FCC23FBC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="hghleviB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FCC23FBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeGFGpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:45:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39703 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeGFGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:45:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id w14-v6so7877737eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3J0OBrA0QeSoc/Wpva1Opg938FGWpIUN3NjQ2Jz69o=;
        b=hghleviBinNQsowPKLiyX4fwr9OpYxuwYjKwUyuR+ajImCNwuqcKVsy+NffXy25MAB
         zFBirKnMeC/2YSPQKw3NjOa5ogyxzO1NgtZeFZUhkX0C6/3fttyy0bjB3B0Kay67EDkS
         mw5x1tV583zv1XpzqFKEGpYRbZwtudOMfqdS+bP1Sccy5C4dIjSOwIdBuNxQNf4vND9w
         UeosjB9RMEOSjNx0YQ0aX8fYk1LQacXXYeqC6/il10NVOEHVfIjQUtCJNHf2GyO7E327
         YJzo+PISdqc0lF8mZESlAnOmj9Jf2GUfttcGu0N+bON1+hIq15f05S7DCxfxG9RUf92M
         yPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3J0OBrA0QeSoc/Wpva1Opg938FGWpIUN3NjQ2Jz69o=;
        b=kPXoFZy5iShK7ryxIwO7xPhvXSErKVbDjO9K8NtvEt5qxA4Xk5JALs68+IwPWmeeiM
         7QYnqft+RpW8SaJet5Pu6lOoQRAiowV8cErZs07Bnu380x9UagZjfACa4U5fNxGl+7dY
         TKIhs83VZj54B+vw8szWZi7bDnP1FbbE0z7KBme8XVZeTaFitdCcCNr/bIp+gygBODvk
         rp7g6K9BqTqmpqWzS53bAhzxif8P82Yh6YHxQeFC3XhMIMoDRgTP4yzpr84QCYiOpFN9
         bFy84akGnt3cBHIVP39XOf8THlykIZSSxOIPeD8SAtbAxSqxxzjrwYr4XdzTAWVtbzA9
         bq+Q==
X-Gm-Message-State: APt69E0EjOyM6P+e+SF/hFzSIuRqvwo+Gqyp5iMbbXynNHgHLdV8N7+x
        4vWdWkGfuaihZgeBV+aIf2WVw3rydX35tKiIjPYm3g==
X-Google-Smtp-Source: AAOMgpdqVS18jgQbLwQaeZi6bkcF+rwkn+tnlLjckHxQMv9BIAIvG2QBLoCmZ/aM0rIyk2N9AkR2BmeyfoM4ds9uUnE=
X-Received: by 2002:a50:a0c5:: with SMTP id 63-v6mr9320224edo.47.1530859499126;
 Thu, 05 Jul 2018 23:44:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90f9:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 23:44:58 -0700 (PDT)
In-Reply-To: <20180705144009.GC5565@intel.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <20180705144009.GC5565@intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 6 Jul 2018 14:44:58 +0800
Message-ID: <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 10:40 PM, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> On Thu, Jul 05, 2018 at 03:58:36PM +0800, Chris Chiu wrote:
>> Hi,
>>     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
>> i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>> the HDMI connector status stays connected even the HDMI cable has been
>> unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>> checking the status while plug/unplug the HDMI, it shows
>> "disconnected" before plug in HDMI cable, then switch to "connected"
>> after plugin, and still stay "connected" after unplug. This would
>> cause the audio output path cannot correctly switch from HDMI to
>> internal speaker after unplugging the HDMI.
>>
>> I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
>> present. The full "dmesg" log is here.
>> https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>
>> The HDMI cable is plugged in at ~26th second.
>> "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>> audio support"
>> then unplug the HDMI at ~73th second.
>> "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>> audio support"
>>
>> Please advise what I can do to fix this. Thanks
>
> Pull the cable out faster?
>
> I presume this is the same old case of hpd disconnecting slightly
> before ddc and we still manage to read the EDID when processing
> the hpd irq. We kinda tried to fix that with the live status
> check but that thing failed spectacularly.
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

Thanks for the suggestion. I tried pulling the cable out faster, the status
shows correctly. I also tried branch drm-tip of
https://cgit.freedesktop.org/drm/drm-tip
but the symptom persists.

Anything I can help here? Or any old commit/patch I can try to do some
experiments?

Chris
