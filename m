Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeDMJoz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:44:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752360AbeDMJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:44:53 -0400
Subject: Re: [PATCH] vfio: platform: Fix using devices in PM Domains
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1523438648-17672-1-git-send-email-geert+renesas@glider.be>
 <0cc6cead-cd75-0a18-7a53-5ce16b03e823@redhat.com>
 <CAMuHMdUHEkamgGORLx37QOns22LTrx_TGYHmxYWZ=TNyhABh=A@mail.gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, KVM list <kvm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4eedb2df-4bf8-814e-7e47-60faa646f4bf@redhat.com>
Date: Fri, 13 Apr 2018 11:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUHEkamgGORLx37QOns22LTrx_TGYHmxYWZ=TNyhABh=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 13/04/18 11:19, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Fri, Apr 13, 2018 at 11:14 AM, Auger Eric <eric.auger@redhat.com> wrote:
>> On 11/04/18 11:24, Geert Uytterhoeven wrote:
>>> If a device is part of a PM Domain (e.g. power and/or clock domain), its
>>> power state is managed using Runtime PM.  Without Runtime PM, the device
>>> may not be powered up, causing subtle failures, crashes, or system
>>> lock-ups when the device is accessed by the guest.
>> the device may not be powered up/clcoked or power/clock may be switched
>> off while the guest uses it.
>>>
>>> Fix this by adding Runtime PM support, powering the device when the VFIO
>>> device is opened by the guest.
>>>
>>> Note that while more fine-grained power management could be implemented
>>> on the guest side, if exported, this would be inherently unsafe, as
>>> abusing it may kill the whole system.
>>
>> Please can you elaborate on this remark please?
> 
> If power-management of the device would be delegated to the guest, and the
> guest forgets to enable device power before accessing the device's registers,
> this could lock up the system, and thus disturb both the host and other guests.
Wouldn't you need to assign another device or use para-virt to allow the
guest to perform this power management control? I think you can remove
this paragraph from the commit message.

Thanks

Eric
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
