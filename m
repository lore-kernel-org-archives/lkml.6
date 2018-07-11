Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30695C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A662087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Bo4Shqdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A662087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbeGKPMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:12:10 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44982 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733215AbeGKPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:12:10 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so23894483ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BzRzKELxpdBJz9/E7dj4w5AVy+a7rjIm2RvxD9VU5I0=;
        b=Bo4ShqdlPiBc+AGaDjPPRDNlMnXW3HHpIvkUzacIN+PpWEtgFSL6zq6rtZYj8y0d2R
         RhtvOz+k/f1ZIGv0UIpOhcz9HokQYvAimmZWIC70V0dc7qrXxjgRwDtt1I3AK25mxhvI
         w8tVe4Z/HLCDKpOpsRoR74pZXOPKWWHepq13c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BzRzKELxpdBJz9/E7dj4w5AVy+a7rjIm2RvxD9VU5I0=;
        b=G2S8ZrVdfCO5x1FB1hOzgj16VjrCVBZel0UujfeQUPSZYmunKdXvwmHQXkfyeBNs0z
         CdV6XJy3sy8mWsKFBOEHqAwB3OOkBZdFH5a0FMzNbG80qL+FNTG8iTd3rVGzhFi4VOSK
         G2y+KsKaSJ8Z/ksx/gCPm05MSIdVxl8rfMYcfE/7gCO2UA180gNaBcqAssbHBkFVCQVq
         ipU7j3a9kHxh4W76XiMfIS7xI1qB98kzApjSUikDVbOavqKB0XM+k2jjazBkVvKSxA5M
         S6CI43mIRSAuqmeaWB2uRaGMhzsGpfHWy20sMi7dR8cymCU3xCNTH33TzxTQYwtT80rF
         kDoA==
X-Gm-Message-State: AOUpUlE1AyTapTq0Jjfzf0GbFCTxKReYx6TnvI6qzUQ6CUUizbv0oKvJ
        D5nm01W1Vllz2oZCal6v2sDFjiicdeYPu1kWKdkqfQ==
X-Google-Smtp-Source: AAOMgpfzXCIa69CEgIJ1XaHn4enM6hUUY5Jirwtn4nFmVLOcVjc1rb3uibkuw6mqtp/L2O6WFEwyREXHigZUEbzkLOQ=
X-Received: by 2002:a6b:f418:: with SMTP id i24-v6mr25735066iog.34.1531321643940;
 Wed, 11 Jul 2018 08:07:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 08:07:23
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <386d987c-899a-2e98-66ba-6e672dd532ef@redhat.com>
References: <20180628090351.15581-1-hdegoede@redhat.com> <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de> <20180711105255.32803a3c@gandalf.local.home>
 <386d987c-899a-2e98-66ba-6e672dd532ef@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 11 Jul 2018 17:07:23 +0200
X-Google-Sender-Auth: YaBf6XpPKO-h6CQ7Y_erEwCf570
Message-ID: <CAKMK7uEZiezTmiD+TRNspspo+C0xvzhVF_E8gPr_s81MeDWO1g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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

On Wed, Jul 11, 2018 at 5:01 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11-07-18 16:52, Steven Rostedt wrote:
>>
>> On Wed, 11 Jul 2018 16:46:11 +0200
>> Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>>> Hi
>>>
>>> Am 28.06.2018 um 11:03 schrieb Hans de Goede:
>>>>
>>>> Replace comments about places where the console lock should be held with
>>>> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
>>>
>>>
>>> Debugging fbcon sometimes requires to not take the console lock. This
>>> patch breaks the debugging workaround provided by
>>> 'fb.lockless_register_fb'. The dmesg is now filled with warnings about
>>> the missing lock.
>>>
>>
>> What if you make lockless_register_fb visible to fbcon, and then we can
>> have a macro:
>>
>> #define WARN_FB_CONSOLE_UNLOCKED()                      \
>>         do {                                            \
>>                 if (unlikely(!lockless_register_fb))    \
>>                         WARN_CONSOLE_UNLOCKED();        \
>>         } while (0)
>>
>> And use that instead?
>
>
> Yes I'm already preparing a patch like that :)
>
> Without the unlikely though, this is not used in hot paths.

Note that you don't even need an EXPORT_SYMBOL since this is all in
the same module.
-Daniel

> Regards,
>
> Hans
>
>
>
>
>>
>> -- Steve
>>
>>
>>> Best regards
>>> Thomas
>>>
>>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> Changes in v3:
>>>> -New patch in v3 of this patchset
>>>>
>>>> Changes in v4:
>>>> -Keep the comments about which fbcon functions need locks in place
>>>> ---
>>>>   drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>>>>   1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/video/fbdev/core/fbcon.c
>>>> b/drivers/video/fbdev/core/fbcon.c
>>>> index c910e74d46ff..cd8d52a967aa 100644
>>>> --- a/drivers/video/fbdev/core/fbcon.c
>>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>>> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int
>>>> user)
>>>>         struct fb_info *oldinfo = NULL;
>>>>         int found, err = 0;
>>>>   +     WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>         if (oldidx == newidx)
>>>>                 return 0;
>>>>   @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>>>>   {
>>>>         int i, new_idx = -1, ret = 0;
>>>>   +     WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>         if (!fbcon_has_console_bind)
>>>>                 return 0;
>>>>   @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info
>>>> *info)
>>>>   {
>>>>         int i, idx;
>>>>   +     WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>         idx = info->node;
>>>>         for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>>>                 if (con2fb_map[i] == idx)
>>>> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info
>>>> *info)
>>>>   static void fbcon_remap_all(int idx)
>>>>   {
>>>>         int i;
>>>> +
>>>> +       WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>         for (i = first_fb_vc; i <= last_fb_vc; i++)
>>>>                 set_con2fb_map(i, idx, 0);
>>>>   @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info
>>>> *info)
>>>>   {
>>>>         int ret = 0, i, idx;
>>>>   +     WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>         idx = info->node;
>>>>         fbcon_select_primary(info);
>>>>
>>>
>>>
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
