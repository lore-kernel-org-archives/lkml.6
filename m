Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeBLWOx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:14:53 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:56074 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbeBLWOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:14:52 -0500
Subject: Re: [PATCH v2 4/5] ALSA: emu10k1: make sure synth DMA pages are
 allocated with DMA functions
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <619e9569-717a-1b4b-6470-4fa6b186bf41@maciej.szmigiero.name>
 <s5hh8qm5qed.wl-tiwai@suse.de>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <8df9709b-c7c5-17ac-3f15-a91e3b4903f2@maciej.szmigiero.name>
Date: Mon, 12 Feb 2018 23:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <s5hh8qm5qed.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.2018 13:44, Takashi Iwai wrote:
> On Sat, 27 Jan 2018 15:42:47 +0100,
>  Maciej S. Szmigiero  wrote:
>>
>> Commit a5003fc04113 ("[ALSA] emu10k1 - simplify page allocation for synth")
>> switched from using the DMA allocator for synth DMA pages to manually
>> calling alloc_page().
>> However, this usage has an implicit assumption that the DMA address space
>> for the emu10k1-family chip is the same as the CPU physical address space
>> which is not true for a system with a IOMMU.
>>
>> Since this made the synth part of the driver non-functional on such systems
>> let's effectively revert that commit.
> 
> Let's keep (or re-add after this revert) the simplification with
> __synth_free_pages().  Other than that I have no objection to this
> change.

Will keep the simplification via __synth_free_pages() function in a respin.

> thanks,
> 
> Takashi

Thanks,
Maciej
