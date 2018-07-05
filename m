Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BAAC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F38240FA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="EF8mG6b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F38240FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeGENC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:02:29 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42942 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753981AbeGENC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:02:28 -0400
Received: by mail-ed1-f52.google.com with SMTP id g12-v6so6290504edi.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FvDgZa0Wva+Tso+w+nRx0WxA3aRsah69Es3t1DHCh2k=;
        b=EF8mG6b76lzM2L6JXDvomCPKNI+5lesZRLa08Ltkv3eKByzgSmiUzMBDKkfUt+Ja61
         SBBRB7BUAWIOIELT6CEPwRceNs5CI662YSCpJiSJ3TXlgl2sy0ja+A8dSEfXgEV84Xwj
         RCGp+pSGZej7IfyAAjdhWVNajxB8e4AY9IHANATXuWVBAaVnI4YZb2G7ka7S85bYUna7
         wdE+uWAAersr6DVnQ1gzVpC0uX7vHWmFq3lIquKfpzd4U331Nf4kksQ4P83sALs/EV8p
         z/rdDCp/qPgOECCmp+JUksQlrL9RSX4NTJRpBqQJDbZqb7DPgxo7+0UajBj84mlXyd5Y
         X76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FvDgZa0Wva+Tso+w+nRx0WxA3aRsah69Es3t1DHCh2k=;
        b=q88qN8ypXrr2zr9wP7jydLIo8kgX3QYSa/mOlzGNCQOLEpPPy0s2CLg3VUPy3zVWES
         9u9IzBs8WU0RGUrSROC3mDseKghz6IYwyqPyQHmNY3ignB6RDpBxXY8ddp/6tvc7uxj8
         4uns88WRxGpEN+QXABGs4qXEeYf/0OlpfYpqtyWv4c6yjr0NQxPtKtek8tuCKGCogrwR
         rh/2dzi3iubhyKWPRDYihkZ3JRpvkMKXcJQoOUGQpsPpgO8pSkKSLDtOXc23DpyxJtyL
         K6sDisdk0HO57F3OJqJLMQ2n4SCtLBccyzNmG72wpkZWk61IsoUk+LFDX/vaz71n0a66
         rsUQ==
X-Gm-Message-State: APt69E2bgW2LmjpZ7Yuj9jHulFO2b+YmT1C+jpUkLZ0SfaDwp2s0Ry3O
        O0QG9d40mfkj/3FhKjJ7gmNFlxjDJuzQ1J4tHWh2PRqi
X-Google-Smtp-Source: AAOMgpesd2+EqaypB3in45BscLPGgX6sTP8b8/vaqvonOclf4J8oym15VpjQ4YSR7rDiw0Dv/P19RixksMXdw02u8Tg=
X-Received: by 2002:a50:cc01:: with SMTP id m1-v6mr6805603edi.171.1530795746927;
 Thu, 05 Jul 2018 06:02:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90f9:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:02:26 -0700 (PDT)
In-Reply-To: <87bmbmowek.fsf@intel.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <87efgioy7i.fsf@intel.com> <153078146934.15734.3696654838092752426@skylake-alporthouse-com>
 <87bmbmowek.fsf@intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 5 Jul 2018 21:02:26 +0800
Message-ID: <CAB4CAwe2Q7ZUUDucE60y97V9A8apF6MhM4+G-eNU0W7u6RiQPA@mail.gmail.com>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 5:37 PM, Jani Nikula <jani.nikula@intel.com> wrote:
> On Thu, 05 Jul 2018, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>> Quoting Jani Nikula (2018-07-05 09:58:57)
>>> On Thu, 05 Jul 2018, Chris Chiu <chiu@endlessm.com> wrote:
>>> > Hi,
>>> >     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
>>> > i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>>> > the HDMI connector status stays connected even the HDMI cable has been
>>> > unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>>> > checking the status while plug/unplug the HDMI, it shows
>>> > "disconnected" before plug in HDMI cable, then switch to "connected"
>>> > after plugin, and still stay "connected" after unplug. This would
>>> > cause the audio output path cannot correctly switch from HDMI to
>>> > internal speaker after unplugging the HDMI.
>>> >
>>> > I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
>>> > present. The full "dmesg" log is here.
>>> > https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>> >
>>> > The HDMI cable is plugged in at ~26th second.
>>> > "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>> > audio support"
>>> > then unplug the HDMI at ~73th second.
>>> > "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>> > audio support"
>>> >
>>> > Please advise what I can do to fix this. Thanks
>>>
>>> Seems rather odd. Please file a bug report at [1]. Attach the dmesg on
>>> the bug. Please attach 'xrandr --verbose' output before and after
>>> unplugging on the bug.
>>
>> Note that 'xrandr --verbose' will trigger a reprobe of the devices,
>> papering over any missed probe following hotplug.  I would suggest
>> preceding with 'xrandr --current --verbose'.
>>
>> If all you are doing is checking status, you need to 'echo detect >
>> status' to trigger a reprobe after hotplug.

It's interesting that reprobe triggered by 'xrandr --verbose' after unplug will
get the status back to "disconnected". But if I just do 'xrandr
--current --verbose'
before and after unplugging the cable, the output shows the same status
'connected'.

Here's the output of 'xrandr --verbose' before unplugging HDMI
https://gist.github.com/mschiu77/ea2e843078297f344596243418dcdaf7

And the output of 'xrandr --current --verbose' after unplugging the cable
https://gist.github.com/mschiu77/55756c0801046d49cd9bc3f87712b079

Then do 'xrandr --current --verbose' to trigger reprobe, the ouput
https://gist.github.com/mschiu77/72e6ab5438cbe64443300fc4fd71770c

It means that the HDMI unplug not detected by the driver?

Chris

>
> I was curious about the logs seemingly indicating that we can read the
> EDID even after the user says they've unplugged the cable. The updating
> of sysfs status attribute is another matter.
>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
