Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC9BECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC493214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="NSbHV3/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC493214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeISQ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:57:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44094 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeISQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:57:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so4538736edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hA0fQ3tpM8Gwj2bmKphRGaCfWpsJsg7qrXsk9r4dn1Y=;
        b=NSbHV3/3kjqBfNS6aMej4bJqKmMkk/YdaSLgGvUCXF7xNghJxx06wMoswhHVolWSOP
         hGFdKhL4Mbq3HlbfiFL1dToisaDrKkN5RzvY8xfJuFR+YV7oPA/ohK3dsYwOK0ix4xrz
         1vht3XPl08IhbOZStDqWs7swrwLunw4N4WjdO/Vx+6RSg4Lq+TNvG+kXKgqAWexP0eYd
         oMj+I/uVfV/hbE5vEZ+wtYpYs2yARA6K/l65dnk11ExIvsoX728Z0CmsjZLlJTBpPeQK
         VXS+ORuPZrHNHvsFRCmYHvEcQ5VkbVEoTM7lVdiLWfYouUemyoee/HNKTSmN9Y4ipjf3
         jPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hA0fQ3tpM8Gwj2bmKphRGaCfWpsJsg7qrXsk9r4dn1Y=;
        b=d1yJyzZKeDxhBDPC6Z/Cef6f/wksqD0zOzFAq7kijBK2GmFxpKLDjrWdZPT7cGd50c
         m2yEBF4aRlR13EAY5vvhBioNDZbO+QCcNMDAXhy5apOl/zYg5khsuk3+TkaM1ZuzEdh4
         wRxFMOic3h5MTQNOzgxiVa3luAozkdjkv8StHkOZoUMq5hJOldYPvhVCAeZtrAuvjflF
         Fgn7pzkhSQ9MmyMvLq5cmERHvoL8wrbxeWvjG2xtakCHwBrpZqf1b6y9z07m10kWuAk/
         G89m9DrMoEYCmcIsDcMGtegyB3rzn1zBPUlQdSTgu4wTg3M0CBUsOUd7MsZdISVbFhs1
         hmPQ==
X-Gm-Message-State: APzg51ChCt8AQWF4IYlMnRCUvifakH3Ma+tK2lEG1C2FTiSiCBcHbK3O
        mBXK1nEPHd1yV7mR4xb9/zKsud67B4R8f2gdySfK4g==
X-Google-Smtp-Source: ANB0VdZ+Age7Uhv5+Br1SSkHTvaOSpEa7JQvlPrEPd4gXsn5jQCrULchZqqseKdezGm3ze0MVkhpmU0+T9+l4iIme80=
X-Received: by 2002:a50:98a3:: with SMTP id j32-v6mr56293417edb.6.1537356003318;
 Wed, 19 Sep 2018 04:20:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:94ae:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 04:20:02
 -0700 (PDT)
In-Reply-To: <CAB4CAwdUiFrPVTFsz3iC=x2yTTis0n1V4BzozXPMf7EeD52gvA@mail.gmail.com>
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
 <20180705144009.GC5565@intel.com> <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com>
 <CAB4CAwdjPFLTj+bL+bAeXw2cwAtk9tWFxPPaATpQ4QbuZsM0ew@mail.gmail.com>
 <87tvnjlsap.fsf@intel.com> <CAB4CAwdUiFrPVTFsz3iC=x2yTTis0n1V4BzozXPMf7EeD52gvA@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 19 Sep 2018 19:20:02 +0800
Message-ID: <CAB4CAwdfTZ879LXpXGMiMrYi4kCJJBxggGGTi_REYkuRMvz2PQ@mail.gmail.com>
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

On Tue, Sep 11, 2018 at 6:25 PM, Chris Chiu <chiu@endlessm.com> wrote:
> On Fri, Aug 24, 2018 at 11:04 PM, Jani Nikula <jani.nikula@intel.com> wro=
te:
>> On Wed, 22 Aug 2018, Chris Chiu <chiu@endlessm.com> wrote:
>>> On Fri, Jul 6, 2018 at 2:44 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>>> On Thu, Jul 5, 2018 at 10:40 PM, Ville Syrj=C3=A4l=C3=A4
>>>> <ville.syrjala@linux.intel.com> wrote:
>>>>> On Thu, Jul 05, 2018 at 03:58:36PM +0800, Chris Chiu wrote:
>>>>>> Hi,
>>>>>>     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (int=
el
>>>>>> i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
>>>>>> the HDMI connector status stays connected even the HDMI cable has be=
en
>>>>>> unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
>>>>>> checking the status while plug/unplug the HDMI, it shows
>>>>>> "disconnected" before plug in HDMI cable, then switch to "connected"
>>>>>> after plugin, and still stay "connected" after unplug. This would
>>>>>> cause the audio output path cannot correctly switch from HDMI to
>>>>>> internal speaker after unplugging the HDMI.
>>>>>>
>>>>>> I then try to verify with the latest kernel 4.18.0-rc3+, the bug sti=
ll
>>>>>> present. The full "dmesg" log is here.
>>>>>> https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>>>>>>
>>>>>> The HDMI cable is plugged in at ~26th second.
>>>>>> "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>>>> audio support"
>>>>>> then unplug the HDMI at ~73th second.
>>>>>> "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
>>>>>> audio support"
>>>>>>
>>>>>> Please advise what I can do to fix this. Thanks
>>>>>
>>>>> Pull the cable out faster?
>>>>>
>>>>> I presume this is the same old case of hpd disconnecting slightly
>>>>> before ddc and we still manage to read the EDID when processing
>>>>> the hpd irq. We kinda tried to fix that with the live status
>>>>> check but that thing failed spectacularly.
>>>>>
>>>>> --
>>>>> Ville Syrj=C3=A4l=C3=A4
>>>>> Intel
>>>
>>> There's a patch https://bugs.freedesktop.org/show_bug.cgi?id=3D107125#c=
8.
>>> And I verified on the X705FD/X560UD which were easy to reproduce, the p=
atch
>>> works as expected. Can anyone kindly give comments about this patch?
>>> We can do anything to help fix this issue upstream. Thanks
>>
>> Seems like a hack. Should look into hw based debouncing or a slight
>> delay in the hotplug work processing I think.
>>
>> BR,
>> Jani.
>>

I tried to add a slight delay in the hotplug work as follows

--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -378,6 +378,8 @@ static void do_i915_hotplug_check(struct work_struct *w=
ork,

        spin_unlock_irq(&dev_priv->irq_lock);

+       msleep(100);
+
        drm_connector_list_iter_begin(dev, &conn_iter);
        drm_for_each_connector_iter(connector, &conn_iter) {
                intel_connector =3D to_intel_connector(connector);

It does work in most cases, but still fail to update the status if I
unplug the HDMI
cable very slow. I basically pull the HDMI cable in loose connected
state first, and
hold in that state ~1 second, totally unplug after that. The status in
sysfs will report
connected as it used to. There was no problem when I tried the patch
https://bugs.freedesktop.org/show_bug.cgi?id=3D107125#c8

I'll try to modify this patch a little bit and send upstream for
discussion later. Please
advise if any. Thanks.

Chris

> So you're suggesting to add a slight delay directly in i915_hotplug_work_=
func()?
> And any suggestion about the 'hw based' debouncing? Maybe some examples
> that I can refer to?
>
> Thanks
>
>>>
>>> Chris
>>>
>>>> Thanks for the suggestion. I tried pulling the cable out faster, the s=
tatus
>>>> shows correctly. I also tried branch drm-tip of
>>>> https://cgit.freedesktop.org/drm/drm-tip
>>>> but the symptom persists.
>>>>
>>>> Anything I can help here? Or any old commit/patch I can try to do some
>>>> experiments?
>>>>
>>>> Chris
>>
>> --
>> Jani Nikula, Intel Open Source Graphics Center
