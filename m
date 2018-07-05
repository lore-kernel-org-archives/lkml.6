Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E602BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8824723EA1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Qki0B2VG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8824723EA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeGENac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:30:32 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44892 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGENab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:30:31 -0400
Received: by mail-ed1-f44.google.com with SMTP id f12-v6so6356491edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cv0jqeYOwx1I+SN3bb1a0jV8KBeSC7Zk1bv6eMh1x4E=;
        b=Qki0B2VGLmJcEf9kO4u57j85gQsEILyEXRulgNq6pZpJ6sWzRO1CNc7Oz9UFsGie8D
         phvVfq7ug9AJRFLTpvUU9FLCFgdVHfpe4sEVGTRAta4Y4RMwaoloFU+7GtswUTfVht9i
         2Zlzwvi6vw0fFsQVdsjtrf6+GWmbzY4V04Og7TZ6ZIQawnvC09HAMkmR7POZTKbnGKoc
         s89Tdn7ZSw9Ai07yhbvWSLUtRnCgAzWMSFiaNpi1KUvZ9EQ4rqOY9t5JU3Q6JvWCNvZV
         0m03guYBcCZjIh70k6gumhofLi16eynhbn1Bezj6196Xg3Nu0z5SOWjXo3+ypR1V0RRQ
         MASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cv0jqeYOwx1I+SN3bb1a0jV8KBeSC7Zk1bv6eMh1x4E=;
        b=JTJqgJi7SnvUsE/hL9b9hRsAtdlNKW3T4V0UxDrL7skXhjJ+quTr2hdn+DpbSDqkAj
         5gJ5quC3XUv/QCNd5UOtLLGinVTOZPnha18doiGMtXajgtLhIKqSuT17G29z1OxygEz4
         7sIxZ/Hd82BmZBbxcqRzE6+o8N9qHa70dbGEGq/wQ9JXIBT6oA8YxBoI6lwo/S5cxPHv
         VJL+4ao3Wb8Ohi9d7dBkqdLRpUUKxT4VnIMajPuS4Go6K9h8xdn7KLd3x+DAl2svUEDZ
         WQynY7h53fVn6V591JSjNgujcmWuAO1RKzpsTRdRmQJHZ97Iukd2oFf3zCr6PntnbBs5
         C8gw==
X-Gm-Message-State: APt69E3yBfFMyfrkR3OdBnL3sLRaQY24Kyc61xlh1dgNBjCyip5SJaEc
        FUwH/rUNJHfITMJ5npd/wKwYlNy0S/3vS11ptLOOvA==
X-Google-Smtp-Source: AAOMgpdjpQ0sKig8e44JOel9KBbggTXurKSZ6vWbCQqTtv5NqvTeC/umpC0pORf91as8u2PAUBBZ3mOLXfO5ch6JeoY=
X-Received: by 2002:a50:f4aa:: with SMTP id s39-v6mr6868742edm.262.1530797430165;
 Thu, 05 Jul 2018 06:30:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90f9:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:30:29 -0700 (PDT)
In-Reply-To: <87wou9om7o.fsf@intel.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <87efgioy7i.fsf@intel.com> <153078146934.15734.3696654838092752426@skylake-alporthouse-com>
 <87bmbmowek.fsf@intel.com> <CAB4CAwe2Q7ZUUDucE60y97V9A8apF6MhM4+G-eNU0W7u6RiQPA@mail.gmail.com>
 <87wou9om7o.fsf@intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 5 Jul 2018 21:30:29 +0800
Message-ID: <CAB4CAwci_Q873hjS86GSvKCqoBdvV6drACNEVi6eM=jYRHTZhw@mail.gmail.com>
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

On Thu, Jul 5, 2018 at 9:18 PM, Jani Nikula <jani.nikula@intel.com> wrote:
> On Thu, 05 Jul 2018, Chris Chiu <chiu@endlessm.com> wrote:
>> On Thu, Jul 5, 2018 at 5:37 PM, Jani Nikula <jani.nikula@intel.com> wrote:
>>> On Thu, 05 Jul 2018, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>>>> Quoting Jani Nikula (2018-07-05 09:58:57)
>>>>> On Thu, 05 Jul 2018, Chris Chiu <chiu@endlessm.com> wrote:
>>>>> > Hi,
>>>>> >     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
>>>>> > i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>>>>> > the HDMI connector status stays connected even the HDMI cable has been
>>>>> > unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>>>>> > checking the status while plug/unplug the HDMI, it shows
>>>>> > "disconnected" before plug in HDMI cable, then switch to "connected"
>>>>> > after plugin, and still stay "connected" after unplug. This would
>>>>> > cause the audio output path cannot correctly switch from HDMI to
>>>>> > internal speaker after unplugging the HDMI.
>>>>> >
>>>>> > I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
>>>>> > present. The full "dmesg" log is here.
>>>>> > https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>>>> >
>>>>> > The HDMI cable is plugged in at ~26th second.
>>>>> > "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>>> > audio support"
>>>>> > then unplug the HDMI at ~73th second.
>>>>> > "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>>> > audio support"
>>>>> >
>>>>> > Please advise what I can do to fix this. Thanks
>>>>>
>>>>> Seems rather odd. Please file a bug report at [1]. Attach the dmesg on
>>>>> the bug. Please attach 'xrandr --verbose' output before and after
>>>>> unplugging on the bug.
>>>>
>>>> Note that 'xrandr --verbose' will trigger a reprobe of the devices,
>>>> papering over any missed probe following hotplug.  I would suggest
>>>> preceding with 'xrandr --current --verbose'.
>>>>
>>>> If all you are doing is checking status, you need to 'echo detect >
>>>> status' to trigger a reprobe after hotplug.
>>
>> It's interesting that reprobe triggered by 'xrandr --verbose' after unplug will
>> get the status back to "disconnected". But if I just do 'xrandr
>> --current --verbose'
>> before and after unplugging the cable, the output shows the same status
>> 'connected'.
>>
>> Here's the output of 'xrandr --verbose' before unplugging HDMI
>> https://gist.github.com/mschiu77/ea2e843078297f344596243418dcdaf7
>>
>> And the output of 'xrandr --current --verbose' after unplugging the cable
>> https://gist.github.com/mschiu77/55756c0801046d49cd9bc3f87712b079
>>
>> Then do 'xrandr --current --verbose' to trigger reprobe, the ouput
>> https://gist.github.com/mschiu77/72e6ab5438cbe64443300fc4fd71770c
>>
>> It means that the HDMI unplug not detected by the driver?
>
> Please do file the bug, and attach the information there. People go on
> vacations, the pastebins will go away, and the memory of all of this
> will fade.
>

Sorry that I missed to list here. I've reported the bug as follows
https://bugs.freedesktop.org/show_bug.cgi?id=107125

Thanks

> BR,
> Jani.
>
>>
>> Chris
>>
>>>
>>> I was curious about the logs seemingly indicating that we can read the
>>> EDID even after the user says they've unplugged the cable. The updating
>>> of sysfs status attribute is another matter.
>>>
>>> BR,
>>> Jani.
>>>
>>>
>>> --
>>> Jani Nikula, Intel Open Source Graphics Center
>
> --
> Jani Nikula, Intel Open Source Graphics Center
