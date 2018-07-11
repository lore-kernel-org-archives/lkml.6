Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB7AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE4D20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L5TMjr7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE4D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbeGKPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:48:01 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35110 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeGKPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:48:01 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so24067234iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yrQEUmfdgnCBmdq4M73Cr6u2o/D4W/9esJB04sWbDuA=;
        b=L5TMjr7SpbAVWMy3MLjw37VvimNrhsLUiOwbJIO5Fru7lroi+SfkU0Se+EGTF7jRR8
         XHpOzd1I2GtT4wEsGweJWvd6h2SoUB+dILUp178T1rORtoRcfEs+3dM7/S2thN39YpEj
         KmKHR4hoB0TjxtJRDKugxTDhOTEkjYjBK9NY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yrQEUmfdgnCBmdq4M73Cr6u2o/D4W/9esJB04sWbDuA=;
        b=aGnKoo9NIYv4kXjPSrp8eTBiwfoDsKhJHprQ3D/GJDVTkKlvN+lfv8XLLXbdCIfF/U
         0pNeGHbjvJ6bIw1eCM+QkRxLwfXYgr3H9Nr7ShUrDSaR7Wb/OLEjc9bcTE3Cie9PsjKA
         q2rE7IE2qKYUQXGrceWAMaTnn+0BJk0kGf/aToOsitI4YnrQE5XCuI8mqqi68Z+vHtbw
         j+KQ9ZGnRif29dLKEvq5VTkQJE8tdDyn6ueZzvc+k13H7hWLu6Sw3NJpeMTaTXuRKNM+
         QnK5av5W0pQ53Mn1AItmUdH8QeY6s18OUmZMVmjAYNA/y+phDWCT83jbl6J3U3m6GTPH
         ygIQ==
X-Gm-Message-State: AOUpUlE9fwPJmTzAM0AVr3OY8zPxRq0idItR9YMg14GxUzDBgS93/+3m
        vrni74RD4coSYmRHFJ310DJUlI3DYXcmn4TtCwJN5g==
X-Google-Smtp-Source: AAOMgpexZUCoI4XdMXOLqj3XoezSI7x+h+/ZgtxbhkNq1EzZcQCAijH1ZPwod1rRGmXNZsEEYh8l1BWrf5E2uxFDAWQ=
X-Received: by 2002:a6b:30c9:: with SMTP id w192-v6mr26624417iow.291.1531323775809;
 Wed, 11 Jul 2018 08:42:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 08:42:47
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
References: <20180628090351.15581-1-hdegoede@redhat.com> <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de> <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de> <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com> <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 11 Jul 2018 17:42:47 +0200
X-Google-Sender-Auth: Y59jChlfO2mHlNSEoBL1Nmf1ljA
Message-ID: <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 5:35 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11-07-18 17:28, Daniel Vetter wrote:
>>
>> On Wed, Jul 11, 2018 at 5:14 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 11-07-18 17:07, Thomas Zimmermann wrote:
>>>>
>>>>
>>>> Hi
>>>>
>>>> Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>>>>>
>>>>>
>>>>>
>>>>> What if you make lockless_register_fb visible to fbcon, and then we can
>>>>> have a macro:
>>>>
>>>>
>>>>
>>>> There are more of these macro invocations under drivers/tty/vt, which
>>>> also mess up the log during debugging.
>>>
>>>
>>>
>>> Hmm, so this option is already broken (in a way) then, my first reaction
>>> to your mail was that we should just remove that option. But that seemed
>>> a bit harsh to me so I've been working on a fix for the last 10 minutes
>>> or so.
>>>
>>> But if it is already broken I'm tempted to just remove the option and
>>> be done with it.  We really need less cruft in the fbdev/fbcon code not
>>> more.
>>
>>
>> Please don't remove it, it makes debugging kms driver issues on
>> initial modeset (which is usually run from framebuffer_register, while
>> hodling the console_lock) impossible.
>
>
> OK, so if we don't remove it, we should probably make it so that it
> can be used without triggering any WARN_ONs, which would require changing
> the existing WARN_CONSOLE_UNLOCKED() so that the calls from
> drivers/tty/vt/vt.c
> also do not trigger it ?
>
> I guess one can just ignore the oopses when debugging, but debugging surely
> would be easier if there are just no oopses ?

I'd say let's only bother with the ones in fbcon.c. Avoids the trouble
with having to expose the fb module option to vt.c somehow. The ones
in vt.c are as old as the git history (from a quick check at least),
and in my debugging they never have been annoying (or I somehow didn't
ever hit them, not idea).

Also note that none if this matters long-term because I have a really
fancy plan to fix up this entire console_locking mess, which will also
remove the need for the lockless_fb_register debug hack.
-Daniel

>
> Regards,
>
> Hans
>
>
>
>
>
>> -Daniel
>>
>>>> WARN_CONSOLE_UNLOCKED is already protected by an '#ifdef 1 ... #else
>>>> ...' construct [1]. I thought about turning this into a config option.
>>>
>>>
>>>
>>> Ah I noticed the #if but I did not notice that it was a "#if 1".
>>>
>>> If you want to fix lockless_register_fb it really should be replaced
>>> with a runtime check, not a Kconfig option. This would require having
>>> some lockless variable in the console code itself, which then gets
>>> set by the fbdev code during init based on its lockless_register_fb
>>> setting.
>>>
>>> But as said I think we should seriously consider just removing
>>> lockless_register_fb.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>> [1]
>>>>
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/console.h#n203
>>>>
>>>>>
>>>>> #define WARN_FB_CONSOLE_UNLOCKED()                      \
>>>>>          do {                                            \
>>>>>                  if (unlikely(!lockless_register_fb))    \
>>>>>                          WARN_CONSOLE_UNLOCKED();        \
>>>>>          } while (0)
>>>>>
>>>>> And use that instead?
>>>>>
>>>>> -- Steve
>>>>>
>>>>>
>>>>>> Best regards
>>>>>> Thomas
>>>>>>
>>>>>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>>>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>>>>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>> ---
>>>>>>> Changes in v3:
>>>>>>> -New patch in v3 of this patchset
>>>>>>>
>>>>>>> Changes in v4:
>>>>>>> -Keep the comments about which fbcon functions need locks in place
>>>>>>> ---
>>>>>>>    drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>>>>>>>    1 file changed, 11 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/video/fbdev/core/fbcon.c
>>>>>>> b/drivers/video/fbdev/core/fbcon.c
>>>>>>> index c910e74d46ff..cd8d52a967aa 100644
>>>>>>> --- a/drivers/video/fbdev/core/fbcon.c
>>>>>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>>>>>> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx,
>>>>>>> int
>>>>>>> user)
>>>>>>>          struct fb_info *oldinfo = NULL;
>>>>>>>          int found, err = 0;
>>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>>> +
>>>>>>>          if (oldidx == newidx)
>>>>>>>                  return 0;
>>>>>>>    @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>>>>>>>    {
>>>>>>>          int i, new_idx = -1, ret = 0;
>>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>>> +
>>>>>>>          if (!fbcon_has_console_bind)
>>>>>>>                  return 0;
>>>>>>>    @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct
>>>>>>> fb_info
>>>>>>> *info)
>>>>>>>    {
>>>>>>>          int i, idx;
>>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>>> +
>>>>>>>          idx = info->node;
>>>>>>>          for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>>>>>>                  if (con2fb_map[i] == idx)
>>>>>>> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info
>>>>>>> *info)
>>>>>>>    static void fbcon_remap_all(int idx)
>>>>>>>    {
>>>>>>>          int i;
>>>>>>> +
>>>>>>> +       WARN_CONSOLE_UNLOCKED();
>>>>>>> +
>>>>>>>          for (i = first_fb_vc; i <= last_fb_vc; i++)
>>>>>>>                  set_con2fb_map(i, idx, 0);
>>>>>>>    @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct
>>>>>>> fb_info
>>>>>>> *info)
>>>>>>>    {
>>>>>>>          int ret = 0, i, idx;
>>>>>>>    +     WARN_CONSOLE_UNLOCKED();
>>>>>>> +
>>>>>>>          idx = info->node;
>>>>>>>          fbcon_select_primary(info);
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
>>
>>
>



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
