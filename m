Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeEGNzU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:55:20 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44527 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbeEGNzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:55:16 -0400
X-Google-Smtp-Source: AB8JxZorcsabzMni6o7xz0Lmfb9crBIaZoQPXgp/nheev/OpnkhrrKX3KIa+ZaU9RlY0BVgA165wbjrS4FPpwnOV9gs=
MIME-Version: 1.0
In-Reply-To: <9918d3d1-d843-6142-ca95-91ee0bde3d6b@sakamocchi.jp>
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
 <1525547001-17588-6-git-send-email-conmanx360@gmail.com> <9918d3d1-d843-6142-ca95-91ee0bde3d6b@sakamocchi.jp>
From: Connor McAdams <conmanx360@gmail.com>
Date: Mon, 7 May 2018 09:55:15 -0400
Message-ID: <CAM8Agx3QjC79su82yP+4btKQyFsyU-f_QESXqLnZAXAMetkZmQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] ALSA: hda/ca0132: add/change helper functions for
 R3Di and SBZ
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?B?SsOpcsOpbXkgTGVmYXVyZQ==?= <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to make sure, do you mean that I need to add more comments to the
SBZ and R3Di changes, or are they good as is?

Thanks,
Connor.

On Sun, May 6, 2018 at 10:29 PM, Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> Hi,
>
> On May 6 2018 04:03, Connor McAdams wrote:
>>
>> Edit core functions to support the Sound Blaster Z and Recon3Di for
>> startup and loading of the DSP, as well as setting effects.
>>
>> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
>> ---
>>   sound/pci/hda/patch_ca0132.c | 1064
>> ++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 1018 insertions(+), 46 deletions(-)
>
>
> In my opinion, this patch is too large. This patch can be split into
> several parts:
>
>  * Changes for signature of 'dspio_scp()' to get 'src_id'
>   * dspio_scp()
>   * dspio_set_param()
>   * dspio_set_uint_param()
>   * dspio_alloc_dma_chan()
>   * dspio_free_dma_chan()
>  * Changes for SBZ only
>  * Changes for R3Di only
>
> Could you please prepare for these three patches from this large patch in
> your next chance? Especially, you can describe enough information to the
> latter two patches as patch comment.
>
>
> Thanks
>
> Takashi Sakamoto
