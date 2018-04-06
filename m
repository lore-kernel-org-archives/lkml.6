Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeDFJwZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:52:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38616 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbeDFJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:52:23 -0400
X-Google-Smtp-Source: AIpwx49wXXdvbXSHqNXic0xcEKwUJjYu44QrQPSUoZI8vcdLEgURmqNbq8ter7YefNHdDSd1F4yUGdCHNSH88hZTv/0=
MIME-Version: 1.0
In-Reply-To: <20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
References: <20180313154826.20436-1-kraxel@redhat.com> <20180313161035.GL4788@phenom.ffwll.local>
 <20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 6 Apr 2018 10:52:21 +0100
Message-ID: <CAPj87rPKtuQ4SZePYDUesWY9VSSGR=1p-LO=yByY_6Q8=BfoyA@mail.gmail.com>
Subject: Re: [RfC PATCH] Add udmabuf misc device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w369qUK4000828

Hi Gerd,

On 14 March 2018 at 08:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Either mlock account (because it's mlocked defacto), and get_user_pages
>> won't do that for you.
>>
>> Or you write the full-blown userptr implementation, including mmu_notifier
>> support (see i915 or amdgpu), but that also requires Christian Königs
>> latest ->invalidate_mapping RFC for dma-buf (since atm exporting userptr
>> buffers is a no-go).
>
> I guess I'll look at mlock accounting for starters then.  Easier for
> now, and leaves the door open to switch to userptr later as this should
> be transparent to userspace.

Out of interest, do you have usecases for full userptr support? Maybe
another way would be to allow creation of dmabufs from memfds.

Cheers,
Daniel
