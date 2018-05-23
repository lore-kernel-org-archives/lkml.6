Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeEWGOi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:14:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56319 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeEWGOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:14:36 -0400
X-Google-Smtp-Source: AB8JxZqcvMEAgsnSl5CCjLmaW5wiOeynMT4NIL0uXQvsLDSi0FDGGLYPQhBJGCX7ds5wQJgnQqm4Wg==
Subject: Re: [PATCH v3 5/6] ALSA: xen-front: Implement ALSA virtual sound
 driver
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180514062742.25879-1-andr2000@gmail.com>
 <20180514062742.25879-6-andr2000@gmail.com>
 <510b107c-c136-7748-0cfa-9de849887c61@sakamocchi.jp>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <de973ded-8dba-24c3-b0a3-7b8ff30dab5f@gmail.com>
Date: Wed, 23 May 2018 09:14:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <510b107c-c136-7748-0cfa-9de849887c61@sakamocchi.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 07:00 AM, Takashi Sakamoto wrote:
> Hi,
>
> On May 14 2018 15:27, Oleksandr Andrushchenko wrote:
> > diff --git a/sound/xen/xen_snd_front_alsa.c 
> b/sound/xen/xen_snd_front_alsa.c
> > new file mode 100644
> > index 000000000000..5041f83e98d2
> > --- /dev/null
> > +++ b/sound/xen/xen_snd_front_alsa.c
> > ...
> > +/*
> > + * FIXME: The mmaped data transfer is asynchronous and there is no
> > + * ack signal from user-space when it is done. This is the
> > + * reason it is not implemented in the PV driver as we do need
> > + * to know when the buffer can be transferred to the backend.
> > + */
> > ...
>
> In ALSA PCM interface v2.0.14 or later, SNDRV_PCM_INFO_SYNC_APPLPTR is
> available. This flag express that userspace applications are expected to
> call ioctl(2) with 'SNDRV_PCM_IOCTL_SYNC_PTR' even if they oprate to
> memory mapped page frames for PCM samples. For detail, please refer to a
> commit 42f945970af9 ('ALSA: pcm: Add the explicit appl_ptr sync
> support')[1].
>
> As a supplement, please refer to below commits:
>  * 4b671f577474 ('ALSA: pcm: Add an ioctl to specify the supported
>    protocol version')[2]
>  * b602aa8eb1a0 ('ALSA: pcm: Disable only control mmap for explicit
>    appl_ptr sync')[3]
>
> Alsa-lib v1.1.5 or later supports this flag and existent applications
> can run transparently.
>
> For developers, a tracepoint may be useful:
>  * fccf53881e9b ('ALSA: pcm: add 'applptr' event of tracepoint')[4]
>
> For your information.
>
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42f945970af9
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b671f577474
> [3] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b602aa8eb1a0
> [4] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fccf53881e9b
>
Oh, this is very useful, thank you so much for such a detailed
description. I'll take a close look at the above and see if
Xen sound driver can benefit from this.
>
> Regards
>
> Takashi Sakamoto
Thank you very much,
Oleksandr
