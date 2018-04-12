Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeDLQLZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:11:25 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:46702 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeDLQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:11:23 -0400
X-Google-Smtp-Source: AIpwx4/pmS2bYmsk7zgN7zAAYHDBb45kKPmbHaAyeJ0WVtTwpGYs8Bh1T39xhy0hV/6JtS+ys5p1Zg==
Subject: Re: [PATCH 0/5] for-linux/sndif: add explicit back and front
 synchronization
To: konrad.wilk@oracle.com, tiwai@suse.de
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com,
        jgross@suse.com,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <d5ede3f5-200e-f1c7-71f4-4ebfb938ca48@gmail.com>
Date: Thu, 12 Apr 2018 19:11:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Konrad, Takashi!

Could you please review the *Linux Kernel* version of the changes?
As I said in the cover letter below there is no functional changes
comparing to the corresponding Xen version, but spaces to tabs.
Still, formally, I have to drop the R-b tags and request for the new review.

Thank you,
Oleksandr

P.S. Minus GlobalLogic e-mails which bounce

On 04/12/2018 07:00 PM, Oleksandr Andrushchenko wrote:
> Hello, all!
>
> This is the syncup version of the sound protocol changes for
> Linux Kernel with the only difference from the corresponding Xen
> version being spaces to tabs conversion. Regradless of this only
> change I have dropped R-b tags received for Xen version.
>
> In order to provide explicit synchronization between backend and
> frontend the following changes are introduced in the protocol:
>   - bump protocol version to 2
>   - add new ring buffer for sending asynchronous events from
>     backend to frontend to report number of bytes played by the
>     frontend (XENSND_EVT_CUR_POS)
>   - introduce trigger events for playback control: start/stop/pause/resume
>   - add "req-" prefix to event-channel and ring-ref to unify naming
>     of the Xen event channels for requests and events
>   - add XENSND_OP_HW_PARAM_QUERY request to read/update
>     stream configuration space: request passes desired intervals/formats for
>     the stream parameters and the response returns allowed intervals and
>     formats mask that can be used.
>   - MAJOR: changed req/resp/evt packet sizes from 32 to 64 octets
>   -  Reworked XENSND_OP_HW_PARAM_QUERY so it now sends all
>     parameters at once, allowing to check all the configuration
>     space.
>   - Minor documentation cleanup (added missed "reserved" fields)
>
> Oleksandr Andrushchenko (5):
>    xen/sndif: Introduce protocol version
>    xen/sndif: Fix missed "reserved" fields in comments
>    xen/sndif: Make requests and responses 64 octets long
>    xen/sndif: Add explicit back and front synchronization
>    xen/sndif: Add explicit back and front parameter negotiation
>
>   include/xen/interface/io/sndif.h | 322 +++++++++++++++++++++++++++++--
>   1 file changed, 306 insertions(+), 16 deletions(-)
>
