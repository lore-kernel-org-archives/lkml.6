Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeEGC3o (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:29:44 -0400
Received: from smtp-proxy001.phy.lolipop.jp ([157.7.104.42]:34646 "EHLO
        smtp-proxy001.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751831AbeEGC3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:29:40 -0400
Subject: Re: [PATCH v3 5/9] ALSA: hda/ca0132: add/change helper functions for
 R3Di and SBZ
To: Connor McAdams <conmanx360@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
 <1525547001-17588-6-git-send-email-conmanx360@gmail.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <9918d3d1-d843-6142-ca95-91ee0bde3d6b@sakamocchi.jp>
Date: Mon, 7 May 2018 11:29:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525547001-17588-6-git-send-email-conmanx360@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On May 6 2018 04:03, Connor McAdams wrote:
> Edit core functions to support the Sound Blaster Z and Recon3Di for
> startup and loading of the DSP, as well as setting effects.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>   sound/pci/hda/patch_ca0132.c | 1064 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 1018 insertions(+), 46 deletions(-)

In my opinion, this patch is too large. This patch can be split into
several parts:

  * Changes for signature of 'dspio_scp()' to get 'src_id'
   * dspio_scp()
   * dspio_set_param()
   * dspio_set_uint_param()
   * dspio_alloc_dma_chan()
   * dspio_free_dma_chan()
  * Changes for SBZ only
  * Changes for R3Di only

Could you please prepare for these three patches from this large patch 
in your next chance? Especially, you can describe enough information to 
the latter two patches as patch comment.


Thanks

Takashi Sakamoto
