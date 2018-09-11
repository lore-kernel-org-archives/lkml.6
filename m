Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27112C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E932086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="qZZhDtaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E932086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeIKPYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:24:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33366 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeIKPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:24:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so987121edv.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fGwz5EVxz7vL7Cbc7KbAQfh8xRaxmKJv25lLpDVzBhs=;
        b=qZZhDtajc2dkTUyGvED1/lHD+aD/f5mlt1xmG+AZZPUxifWM0L9gw6kPJtPNmm3Ydw
         pLOBP1Y05898Q9rO8VputrwGWZpyyyA+F17R/k1tikZJStMh0ngeC0IlVQQFW6rkpVQ2
         vgl9QJPDsZI+43V79QxFnxOVG05qAp0mbxNyNRF6q3rd814DT/nOh2vNCyoeY9lmoM6z
         fs1SigxjXRGqsrqhNGj7ItPq64m8ECvKjyYV1l1A8KvjkhrZX88akULmc0uNjWZUNKvC
         F2Nj7Qb6FKgEk1XYgnjMyAOoHvSPW1uTdvJOVJo2DBis2FFsZmnJqdnqLD8oE2GcsbFs
         38lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fGwz5EVxz7vL7Cbc7KbAQfh8xRaxmKJv25lLpDVzBhs=;
        b=hqqGFopk35R+qMYLBuP7khpWn4Jlye1lTMiqwBW42qxbZtX0TtBW3NHQLeVX6TygGZ
         Jmeb/2ABjNQZ2XMvLkOgBQn6QGSAuOECsqaG+4ITLR6dI00hssRhc+mLr903yyqk9kpk
         QDH/MMLjjhAzowFCbz+tbG8gjOUJHjpsr+tZKLb4mja6Eq3QGMai1g1aM2u+NncOBOzr
         N0G2zNOZ3cMRE9rvp+NcAvFOsZra+3wm+P26iyU3Xv/heaFNK6+WZk9qNiSMBB3ioSNE
         AkWbzyrkg+vb8ehMxOvvzMXNEHfQ4pgAHdkr7UrBZgACQzVZI35cDTffUvkLNS6+QrKU
         Pjpg==
X-Gm-Message-State: APzg51DkwBe71OEkdMdhSB2ToZiM7D6ongqDpIFimq9IS0UGNrLoaE0o
        +/TJZlW6+TOjoQbb+eolhjGzBTa366KxV590dbrzrg==
X-Google-Smtp-Source: ANB0VdZXGs7rn658qkhjqhkQXKuZ8usjL5fCJrdiRUPRLdwmke2Gd1j2iSh6gl3I8GEu213XKn6wTAzDqw7C6CrLSds=
X-Received: by 2002:a50:98a3:: with SMTP id j32-v6mr27414773edb.6.1536661537920;
 Tue, 11 Sep 2018 03:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:94ae:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 03:25:37
 -0700 (PDT)
In-Reply-To: <87tvnjlsap.fsf@intel.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <20180705144009.GC5565@intel.com> <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com>
 <CAB4CAwdjPFLTj+bL+bAeXw2cwAtk9tWFxPPaATpQ4QbuZsM0ew@mail.gmail.com> <87tvnjlsap.fsf@intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 11 Sep 2018 18:25:37 +0800
Message-ID: <CAB4CAwdUiFrPVTFsz3iC=x2yTTis0n1V4BzozXPMf7EeD52gvA@mail.gmail.com>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
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

On Fri, Aug 24, 2018 at 11:04 PM, Jani Nikula <jani.nikula@intel.com> wrote=
:
> On Wed, 22 Aug 2018, Chris Chiu <chiu@endlessm.com> wrote:
>> On Fri, Jul 6, 2018 at 2:44 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>> On Thu, Jul 5, 2018 at 10:40 PM, Ville Syrj=C3=A4l=C3=A4
>>> <ville.syrjala@linux.intel.com> wrote:
>>>> On Thu, Jul 05, 2018 at 03:58:36PM +0800, Chris Chiu wrote:
>>>>> Hi,
>>>>>     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (inte=
l
>>>>> i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>>>>> the HDMI connector status stays connected even the HDMI cable has bee=
n
>>>>> unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>>>>> checking the status while plug/unplug the HDMI, it shows
>>>>> "disconnected" before plug in HDMI cable, then switch to "connected"
>>>>> after plugin, and still stay "connected" after unplug. This would
>>>>> cause the audio output path cannot correctly switch from HDMI to
>>>>> internal speaker after unplugging the HDMI.
>>>>>
>>>>> I then try to verify with the latest kernel 4.18.0-rc3+, the bug stil=
l
>>>>> present. The full "dmesg" log is here.
>>>>> https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>>>>
>>>>> The HDMI cable is plugged in at ~26th second.
>>>>> "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>>> audio support"
>>>>> then unplug the HDMI at ~73th second.
>>>>> "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>>> audio support"
>>>>>
>>>>> Please advise what I can do to fix this. Thanks
>>>>
>>>> Pull the cable out faster?
>>>>
>>>> I presume this is the same old case of hpd disconnecting slightly
>>>> before ddc and we still manage to read the EDID when processing
>>>> the hpd irq. We kinda tried to fix that with the live status
>>>> check but that thing failed spectacularly.
>>>>
>>>> --
>>>> Ville Syrj=C3=A4l=C3=A4
>>>> Intel
>>
>> There's a patch https://bugs.freedesktop.org/show_bug.cgi?id=3D107125#c8=
.
>> And I verified on the X705FD/X560UD which were easy to reproduce, the pa=
tch
>> works as expected. Can anyone kindly give comments about this patch?
>> We can do anything to help fix this issue upstream. Thanks
>
> Seems like a hack. Should look into hw based debouncing or a slight
> delay in the hotplug work processing I think.
>
> BR,
> Jani.
>
So you're suggesting to add a slight delay directly in i915_hotplug_work_fu=
nc()?
And any suggestion about the 'hw based' debouncing? Maybe some examples
that I can refer to?

Thanks

>>
>> Chris
>>
>>> Thanks for the suggestion. I tried pulling the cable out faster, the st=
atus
>>> shows correctly. I also tried branch drm-tip of
>>> https://cgit.freedesktop.org/drm/drm-tip
>>> but the symptom persists.
>>>
>>> Anything I can help here? Or any old commit/patch I can try to do some
>>> experiments?
>>>
>>> Chris
>
> --
> Jani Nikula, Intel Open Source Graphics Center
