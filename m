Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id z0tyCAq2G1vLNAAAmS7hNA
	; Sat, 09 Jun 2018 11:13:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3E01D607A4; Sat,  9 Jun 2018 11:13:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 62BBC602FC;
	Sat,  9 Jun 2018 11:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62BBC602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeFILNK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 07:13:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37243 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeFILNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 07:13:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id r125-v6so8085758wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 04:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRnisjfJBMU1k2iZopeUCNWrVgkKc16NWGbXuZFacGc=;
        b=ebNc/ECcwkKP4ZKrtUGWxS6nFk/b0cnWC5BW230GvRuyypXOu5+kXrVTe+f/Z/UJsZ
         lx0rhBJ5KMpMcHPVhcdpTOYYwZoluF85b/QiR9HW83KCMvvv6MrGZiSpiQWVqG+RCNuX
         /Z35YtZAryelp9pgB9qU+FMT1UgxA/7e2NDWMHswejG+jCyyLIM63gXWbhAdK5Vf1bAV
         s1c468KaI448Eqr6mzK456Zfn+Y3A5xqPyO/q9k4ETQOyNN6ae8eXgnPEb/seUZ10Hl3
         NpMO8N8AbcZ92LJff9M7FWf1AofUMl89tq0faSPU3goKUb9Xjhh24frhxyw0FEUEHy9B
         hBKQ==
X-Gm-Message-State: APt69E3RQMcFUycLe+flq67CFgFsmwKbHr8GVf2UCrOmhGdO2jCGNYUR
        jBn9UpM6a3xN2vcCAKMgkrBNsw==
X-Google-Smtp-Source: ADUXVKLTC+Ihm4nzi5QGExIxR/X4RtDAohD7FESwr95812y8lJXzJ7+2OHvcZl5TAdLM6EVfEWx0WA==
X-Received: by 2002:a50:adfd:: with SMTP id b58-v6mr6053490edd.168.1528542786849;
        Sat, 09 Jun 2018 04:13:06 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e56-v6sm23775075edb.31.2018.06.09.04.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 04:13:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Darren Hart <dvhart@infradead.org>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
        Chris Chiu <chiu@endlessm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <38cb3527-8480-bdb9-a5d9-b601bc494a5f@redhat.com>
 <71df09bc89619aba975147e6b07920f1dfc2f46f.camel@hadess.net>
 <cd6a5d86-1fdb-2561-1e29-0553be53c41a@redhat.com>
 <94789b55b88ae5a296e1fca3b0311318e7b507ee.camel@hadess.net>
 <0443419b-3147-163b-374d-bb8651b08837@redhat.com>
 <cfb6ff791a9034f8ade738085475e946b3d7519b.camel@sipsolutions.net>
 <362131bf-3b6b-58aa-bda6-003f5ffb5e8e@redhat.com>
 <CAB4CAwfZtA8mf4MwJq1AA1wqwJB-HLXuiMmkzkow3NykRsHkSw@mail.gmail.com>
 <33c55842c8d9ce199f0f8ef314dea85fb848b0be.camel@sipsolutions.net>
 <173fdeb2-8129-57eb-fe2e-3ae16eec54b6@redhat.com>
 <20180609003303.GD111314@localhost.localdomain>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8b752582-f5b5-9144-ad33-c8e7ace19942@redhat.com>
Date: Sat, 9 Jun 2018 13:13:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180609003303.GD111314@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-06-18 02:33, Darren Hart wrote:
> On Wed, Jun 06, 2018 at 05:32:52PM +0200, Hans de Goede wrote:
> 
>>>>>> If we are adding hwdb entries anyway to control the userspace
>>>>>> interpretation of the TOGGLE key, then we could also add the new CYCLE
>>>>>> key and explicitly re-map it to TOGGLE. That requires slightly more
>>>>>> logic in hwdb, but it does mean that we could theoretically just drop
>>>>>> the workaround if we ever stop caring about Xorg.
>>>>>
>>>>> Hmm, interesting proposal, I say go for it :)
>>>>>
>>>>
>>>> So maybe the next stop is that I can follow Darren's suggestion to eliminate
>>>> the is_kbd_led_event() and send a v2 for review?
>>>
>>> I believe the best compromise we have right now is to do what Hans
>>> suggested in an earlier proposal. That is implementing the two separate
>>> behaviours in the kernel
>>>
>>>    1) handle this in the kernel as if the hardware changed it, and
>>>    2) send a new KEY_KBDILLUMCYCLE event [default].
>>
>> I think you mean or, not and, depending on a module option the
>> code should do either 1) or 2) not both :)
>>
>> Darren, Andy could you live with a module option for this?
> 
> We are of course strongly opposed to adding module options.
> 
> I agree we can't ignore Xorg.
> 
> I agree policy in general should not be in the kernel.
> 
> I also see many of these drivers as the last mile to getting a platform
> fully working. If there is a place for one-off fixes, it's in these
> drivers. I'd love to refactor and use proper abstractions and all that
> as the patterns make those abstractions clear - but I don't want to
> delay getting something working waiting for the ideal solution.
> 
> So I have two questions I'd like to confirm before saying "OK" to a
> module option.
> 
> 1) Hans I think you said that doing the code conversion from TOGGLE to
> UP based on the LED value and the max value was racy with userspace.
> What is the failure mode here? Is it not easily recoverable? And how do
> I enter it?

g-s-d can currently already auto-dim the brightness of the
kbd backlight when idle (if there are enough brightness levels).

Lets say that the brightness is at its highest setting and the user
wants to cycle the backlight to off.

But just before the user hits the cycle key, the timeout expires
and userspace dimms the backlight, now the kernel processes
the cycle key event, sees it is not max and sends an up, instead
of the expected toggle.

Note we already have this problem on machines where the cycle
behavior is implemented in the firmware/hardware rather then
inside the kernel.

A bigger problem with sending up-up-up-toggle is that g-s-d saves
the current brightness (max) on the first toggle and restores that
on the second toggle, so the second up-up-up-toggle sequence we
end up restoring the max, going from max to max on the toggle.

So the user needs to press toggle twice at max brightness to get
to off (and then once for the next cycle, then 2 times again for
the cycle after that, etc.).

So I think it is fair to say that sending up-up-up-toggle is not a
good idea.

> Do I have to simultaneously modify the software brightness
> control AND press the keyboard brightness control? How practical is
> that? If recoverable AND hard to trigger, I think there is value in the
> very simple 3 level brightness cycle being handled in the kernel.
> 
> 2) Why is a module option preferable to a compile time option? It seems
> to me the policy will be largely distro dependent, and the same kernel
> needing to support both modes seems likely to be pretty rare.

Because lets say that we have everything in place in a recent Fedora
to handle the cycle-key in userspace, so we have a mapping for the
new event at all levels and g-s-d code to handle it. Then this will
still only work for GNOME3 and possibly other wayland based desktop
environments. While some of our users will keep using the X11 based
XFCE or mate desktop environments.

So what we actually want is a module option, with a configurable
default. So that we can make the default send the cycle event in
a future Fedora, while XFCE / mate users can override the default
using the module option.

###

So typing all of the above has made me think about this once more.

Specifically about how most popular brands handle the cycle behavior
in firmware/hardware already and that userspace already needs to
deal with this and that sofar this does not seem to be a problem.

Combine this with the ugliness of adding a module option +
adding a new cycle input event requiring a lot of work at various
layers to actually work and I think that taking this series as
is, is not so bad. Esp. since I don't see anyone doing this work
soon.

This comes down to faking the cycling being done inside the firmware/
hardware as e.g. Thinkpads and the Dell XPS series actually do,
so, as said, userspace already needs to deal with this.

If we in the future actually get around to implementing a kbd-illum-cycle
input event and have userspace support in place we can always add the
module option then.

TL;DR: lets just go with this series as is for now, we can always
add a module option to opt-out of handling this in the kernel and
sending a new cycle input event later.

Regards,

Hans
