Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeDMOq1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:46:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751091AbeDMOq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:46:26 -0400
Subject: Re: [PATCH 0/2] drm: Make it compilable without CONFIG_HDMI and
 CONFIG_I2C
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>, borntraeger@de.ibm.com,
        Farhan Ali <alifm@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <1523612456-14827-1-git-send-email-thuth@redhat.com>
 <CAKMK7uEB6L0-EQOH04Ktk5gr61VW_ED4eA+cZzM6Op-_0ZVqfg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8ad514ec-7126-30d7-1c3f-332b6e574764@redhat.com>
Date: Fri, 13 Apr 2018 16:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEB6L0-EQOH04Ktk5gr61VW_ED4eA+cZzM6Op-_0ZVqfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2018 16:32, Daniel Vetter wrote:
> On Fri, Apr 13, 2018 at 11:40 AM, Thomas Huth <thuth@redhat.com> wrote:
>> By enabling the DRM code for virtio-gpu on S390, you currently also get
>> all the code that is enabled by CONFIG_HDMI and CONFIG_I2C automatically.
>> This is quite ugly, since on S390, there is no HDMI and no I2C. Thus it
>> would be great if the DRM code could also be compiled without CONFIG_HDMI
>> and CONFIG_I2C. These two patches now refactor the DRM code a little bit
>> so that we can compile it also without CONFIG_HDMI and CONFIG_I2C.
>>
>> Thomas Huth (2):
>>   drivers/gpu/drm: Move CONFIG_HDMI-dependent code to a separate file
>>   drivers/gpu/drm: Make the DRM code compilable without CONFIG_I2C
> 
> What's the benefit? Why does I2C/HDMI hurt you?

Why should I be forced to compile-in subsystems that do not make any
sense on this architecture? It's just completely weird to see CONFIG_I2C
enabled on s390x.

 Thomas
