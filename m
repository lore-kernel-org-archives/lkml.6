Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDMOxP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:53:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53919 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeDMOxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:53:13 -0400
X-Google-Smtp-Source: AIpwx4+X+/lGf9LTEOA1e+D3kIpWskTfo6LlOb4l/KHIwXEoUJ+Tt9qi+A7Ue7QsQTX/wIHuEj3oYnU2p757Y9I1Kzw=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <8ad514ec-7126-30d7-1c3f-332b6e574764@redhat.com>
References: <1523612456-14827-1-git-send-email-thuth@redhat.com>
 <CAKMK7uEB6L0-EQOH04Ktk5gr61VW_ED4eA+cZzM6Op-_0ZVqfg@mail.gmail.com> <8ad514ec-7126-30d7-1c3f-332b6e574764@redhat.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 13 Apr 2018 16:53:12 +0200
X-Google-Sender-Auth: q9U6JQQaoPKYMGiJ-60Lmmfg-8E
Message-ID: <CAKMK7uHY5zEz04EEGf0KXbKZVP1+ch276rcALzH_wCpCS5wLhg@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: Make it compilable without CONFIG_HDMI and CONFIG_I2C
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>, borntraeger@de.ibm.com,
        Farhan Ali <alifm@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 4:46 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 13.04.2018 16:32, Daniel Vetter wrote:
>> On Fri, Apr 13, 2018 at 11:40 AM, Thomas Huth <thuth@redhat.com> wrote:
>>> By enabling the DRM code for virtio-gpu on S390, you currently also get
>>> all the code that is enabled by CONFIG_HDMI and CONFIG_I2C automatically.
>>> This is quite ugly, since on S390, there is no HDMI and no I2C. Thus it
>>> would be great if the DRM code could also be compiled without CONFIG_HDMI
>>> and CONFIG_I2C. These two patches now refactor the DRM code a little bit
>>> so that we can compile it also without CONFIG_HDMI and CONFIG_I2C.
>>>
>>> Thomas Huth (2):
>>>   drivers/gpu/drm: Move CONFIG_HDMI-dependent code to a separate file
>>>   drivers/gpu/drm: Make the DRM code compilable without CONFIG_I2C
>>
>> What's the benefit? Why does I2C/HDMI hurt you?
>
> Why should I be forced to compile-in subsystems that do not make any
> sense on this architecture? It's just completely weird to see CONFIG_I2C
> enabled on s390x.

"Looks wierd" is not really a good engineering criteria, especially in
graphics :-)

For context: In DRM almost nothing is optional, and it greatly
simplifies life and coding. We don't have epic amounts of #ifdef
battles to make trivial code changes compile, except in all the places
where external stuff is optional (like backlight).

So making something optional will have a pretty clear cost on the drm
subsystem, and it doesn't make sense to pay that cost to "look less
wierd". To get this merged we need some clear benefits, which will
balance out the inevitable cost of having to maintain this forever
(and most likely getting yelled at by Linus for making some rando
compile config no longer work).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
