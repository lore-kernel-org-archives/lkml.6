Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58D4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D175214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="GJ0sBtdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D175214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeHVJyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:54:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52995 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHVJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:54:12 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so1607777itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mWcrqUkUGdT0/ZPdn5cOKzjQXWX9ij+8FFianD/3IHs=;
        b=GJ0sBtdy+mSXzmE8SKEHLvNnvbifrBqxAuJwBlEvqoSrj0vyois86nTAQnQDswfxIA
         h3EsIi3SF6bbzA/jbYAoMwJ+VDcgyq/s2yfpy1BphgBlqBHjZtC32CyODGu6CcT3s/Qn
         QBQyLBUwTlLQpxhF6XuV32MwmFByvuVoA0jp/ewxb76IJrjXhXdp9oTW7taddSiZHd3x
         F/oQslJVSTVxZwtgRaobZ71mHzLI4Qo345lsZUrcNGLNszJYphWKEGiF+Y/wGGo7QgDh
         lGxOmatNieQGvtkwO+yTklAclGB2pzfN2WZbNN20ZQFq1HP0JWwL3n3ZGcUEcSY1F4pJ
         UV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mWcrqUkUGdT0/ZPdn5cOKzjQXWX9ij+8FFianD/3IHs=;
        b=Gu1fE23MJcqFB6+W28MWvxOvboOY/N7R9+wrWGy91GZLfok3l7QZIl6mcCjcVkh95E
         6z5rKiQRlqcnq6t69JXDUQMHcTIe1z2tA7+6DO5w4QpNic3LyBQF1hiJWYElaUrlHLVO
         EL8+aqVdrfWb+4XUJ9Hq09dMJQ8PLX8/7QlwxnTQnUhsjvfpnROY/oOJdk6/bWieDyPm
         0vJmWxRncmo4OVGMwYLY+zxXzndNfKj1YBJ5Tdy5OqV0i0KB4dnInZbwewSvbfVqad2K
         W2GeDo5O91A4cBwupCb2qJwnlQDMuh4V/EFZYGgQ2Q8iYybvKFBxlZcu5XghKh8l5mYQ
         7lTw==
X-Gm-Message-State: AOUpUlEm4S8cY3glBiHjY/LziaWsVsThz5Bhd/VBSaBiCF8bB9SJAVw7
        IcgBNL9R3Uk/jegfsn6nnrY/dqOaySv0xHEByugZzg==
X-Google-Smtp-Source: AA+uWPx4T+XOZbd3KoYc2lh/apEgtJtyjDGJ2C7fQn0rofXUvVPz6Ajtvl18HcZEP2i7L+1B+Cmw7QN3IqiOWBYsA6Y=
X-Received: by 2002:a02:4009:: with SMTP id n9-v6mr48525528jaa.19.1534919443761;
 Tue, 21 Aug 2018 23:30:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8704:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 23:30:43
 -0700 (PDT)
In-Reply-To: <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <20180705144009.GC5565@intel.com> <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 22 Aug 2018 14:30:43 +0800
Message-ID: <CAB4CAwdjPFLTj+bL+bAeXw2cwAtk9tWFxPPaATpQ4QbuZsM0ew@mail.gmail.com>
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

On Fri, Jul 6, 2018 at 2:44 PM, Chris Chiu <chiu@endlessm.com> wrote:
> On Thu, Jul 5, 2018 at 10:40 PM, Ville Syrj=C3=A4l=C3=A4
> <ville.syrjala@linux.intel.com> wrote:
>> On Thu, Jul 05, 2018 at 03:58:36PM +0800, Chris Chiu wrote:
>>> Hi,
>>>     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
>>> i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>>> the HDMI connector status stays connected even the HDMI cable has been
>>> unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>>> checking the status while plug/unplug the HDMI, it shows
>>> "disconnected" before plug in HDMI cable, then switch to "connected"
>>> after plugin, and still stay "connected" after unplug. This would
>>> cause the audio output path cannot correctly switch from HDMI to
>>> internal speaker after unplugging the HDMI.
>>>
>>> I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
>>> present. The full "dmesg" log is here.
>>> https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>>
>>> The HDMI cable is plugged in at ~26th second.
>>> "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>> audio support"
>>> then unplug the HDMI at ~73th second.
>>> "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>> audio support"
>>>
>>> Please advise what I can do to fix this. Thanks
>>
>> Pull the cable out faster?
>>
>> I presume this is the same old case of hpd disconnecting slightly
>> before ddc and we still manage to read the EDID when processing
>> the hpd irq. We kinda tried to fix that with the live status
>> check but that thing failed spectacularly.
>>
>> --
>> Ville Syrj=C3=A4l=C3=A4
>> Intel

There's a patch https://bugs.freedesktop.org/show_bug.cgi?id=3D107125#c8.
And I verified on the X705FD/X560UD which were easy to reproduce, the patch
works as expected. Can anyone kindly give comments about this patch?
We can do anything to help fix this issue upstream. Thanks

Chris

> Thanks for the suggestion. I tried pulling the cable out faster, the stat=
us
> shows correctly. I also tried branch drm-tip of
> https://cgit.freedesktop.org/drm/drm-tip
> but the symptom persists.
>
> Anything I can help here? Or any old commit/patch I can try to do some
> experiments?
>
> Chris
