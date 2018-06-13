Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B2A65C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D6E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6ZIaU10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D6E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935002AbeFMA2y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:28:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38428 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934895AbeFMA2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:28:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so1968567wmf.3;
        Tue, 12 Jun 2018 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X+Akh5nhLns2+cV7fY/bk9B/+Eo28aYazQRt/xPdrVk=;
        b=J6ZIaU10wsKsvZnSRk5g0I9AqhXhIsrYu2gOgsBi1ijRxU75SC01hg4Zcs/Ok131cA
         pNC+HvrCnOx7/ub35F91sirU5yS78JC5Ol56ng++bTamLE4LyGxoAysuVQ60kgOtsw7p
         NmN2xTLnUasaYt7RmJJwTR+Bo1OEjy6H0rKShClvZZfDuKzm9FuG9n/xdn8Y8svaXSWS
         DIrEU3diJM/f2jccK/ohsu7tAOajgF18QBM8cIjS2YVMOFca20Ip6S2bklmfIUsJTUWl
         2lpeijz90nPWs7L4jnYVR2aMqeWRloSTdrI7ZeSF+azzEjiVODLpiXZD8sLuzga3SPf6
         sk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X+Akh5nhLns2+cV7fY/bk9B/+Eo28aYazQRt/xPdrVk=;
        b=sDtPKiB+Mxc2H8wf+XPwzTfn8BP3LEzoVI3BtvpBK6n3LIb9ymaoOwT50+E3LcLpUU
         GtJ+U9fp/+3+haRqsSYHTH6LPYD5tpLApi84P3ypKV+isYvTCauNqRxxtb/ruHLrApIY
         mMnENOjFIdjSJvJ8qObAiNquqroYHxHjrODM43qqrWxzw9zHXxf5LjPpk5QSYqI9Zeze
         rV7Qf70VQ4qgPlj4aRqPRyIjNtYFgiXkXolzKoa9X4sHqflxQvb27W9r8zR68b8OzduB
         smqoVrGcISi2QLbdj97CjgzimbD9xGWABahsauvh/xcenqv6e8q26E1uifPqwtflAHrg
         Zt1A==
X-Gm-Message-State: APt69E0Z8MsDOOC28Ii8rvBhyMI1BIwWsPcW9Q9G2+gMhlmQF4e6Krfw
        I1tV10B6q1yMcqfJ7ybQtUZL4nnbdu2yu9d2qWY=
X-Google-Smtp-Source: ADUXVKLJdsz2YvtVv7pwXD2SgvA47RCCr45EksKpGrjgfo+gvWYsUhbheAwV+ca3Y6uBH5khjQZHNnNIYykbUIE+5pU=
X-Received: by 2002:a1c:448:: with SMTP id 69-v6mr2064303wme.31.1528849730767;
 Tue, 12 Jun 2018 17:28:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4004:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 17:28:50
 -0700 (PDT)
In-Reply-To: <CAB=otbSidge7CYyR21744_2xy400tUw51nbaZy0HPmjADt3oTw@mail.gmail.com>
References: <1510019522-15155-1-git-send-email-ruslan.bilovol@gmail.com>
 <CAB=otbSWbN7T2+pHc-DkxrciC88eb7wDx3tdEMe64JS+5OS6zg@mail.gmail.com>
 <87tvx6u3m2.fsf@linux.intel.com> <CAB=otbSidge7CYyR21744_2xy400tUw51nbaZy0HPmjADt3oTw@mail.gmail.com>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Wed, 13 Jun 2018 03:28:50 +0300
Message-ID: <CAB=otbRytSfQftf5JKz-QhXFVE1RuGivJNtNP8DYMS7vd8aK=A@mail.gmail.com>
Subject: Re: [PATCH 0/1] USB Audio Device Class 3.0 Gadget support
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2017 at 1:18 PM, Ruslan Bilovol <ruslan.bilovol@gmail.com> wrote:
> Hi Felipe,
>
> On Mon, Dec 4, 2017 at 1:36 PM, Felipe Balbi <balbi@kernel.org> wrote:
>>
>> Hi,
>>
>> Ruslan Bilovol <ruslan.bilovol@gmail.com> writes:
>>> On Tue, Nov 7, 2017 at 3:52 AM, Ruslan Bilovol <ruslan.bilovol@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> This patch adds USB Audio Device Class 3.0 [1] function
>>>> support to gadget subsystem.
>>>> I didn't add UAC3 support to legacy gadget as it will
>>>> make preprocessor configuration too complex (UAC3 device
>>>> must have two configurations for backward compatibility,
>>>> first is UAC1/2 and second is UAC3), yet also I'm too lazy
>>>> to do that and verify all possible configurations.
>>>>
>>>> For modern ConfigFS interface I'll provide my configuration
>>>> for testing below; testing was done on a BeagleBone Black
>>>> board.
>>>>
>>>> This patch depends on uac3 header files from include dir
>>>> which I'll post as part of ALSA host UAC3 patch and will
>>>> provide the link to it here.
>>>
>>> http://www.spinics.net/lists/alsa-devel/msg69071.html
>>
>> Once that patch hits upstream, then we can queue this for merge window
>> otherwise we will just have issues and create unbisectable points in the
>> tree.
>
> Takashi promised to create an immutable branch for that purpose.
>
> However, I'm currently reworking configfs part of UAC3 for channels
> configuration handling, which is now more clear after sharing missing
> parts of UAC3 spec by Pierre-Louis Bossart during host side patches
> review; so I will send v2 soon.

OK, so now we have both UAC3 initial support patches [1] and
also UAC3 BADD profiles support [2] in Torvalds tree, and I'm going
to refresh this patch series and send v2 soon (perhaps in next few weeks)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a2fe9b801f585baccf8352d82839dcd54b300cf
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=17156f23e93c0f59e06dd2aaffd06221341caaee

Thanks,
Ruslan
