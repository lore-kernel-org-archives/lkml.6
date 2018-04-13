Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754276AbeDMKkZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:40:25 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46419 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDMKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:40:23 -0400
X-Google-Smtp-Source: AIpwx4+JrAyQ77lEZE/qLNTwr4wAXkl4Hmgqz0LLANZn0NZThUNw55kxTA1K3ZIbm2v7Hn1sd7rV03ypZd9G+mDhfcA=
MIME-Version: 1.0
In-Reply-To: <20180413100921.GM6014@localhost>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
 <20180413040233.GJ6014@localhost> <CAMuHMdWNyvveQ73SDrVy=EwkkO6Gd_4hmOkdstpcgzOL44a_mA@mail.gmail.com>
 <20180413100921.GM6014@localhost>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Apr 2018 12:40:22 +0200
X-Google-Sender-Auth: K9ybf_V3aCjsuT18i6TVMV1EWuQ
Message-ID: <CAMuHMdUJifhi+CrrGc4oMGCESyypSAjaEg+crDH_XFVnXd10Qw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dmaengine: stm32-mdma: Fix incomplete Hw
 descriptors allocator
To: Vinod Koul <vinod.koul@intel.com>
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Fri, Apr 13, 2018 at 12:09 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Apr 13, 2018 at 10:39:48AM +0200, Geert Uytterhoeven wrote:
>> On Fri, Apr 13, 2018 at 6:02 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Wed, Apr 11, 2018 at 04:44:39PM +0200, Pierre-Yves MORDRET wrote:
>> >
>> >>  struct stm32_mdma_desc {
>> >>       struct virt_dma_desc vdesc;
>> >>       u32 ccr;
>> >> -     struct stm32_mdma_hwdesc *hwdesc;
>> >> -     dma_addr_t hwdesc_phys;
>> >>       bool cyclic;
>> >>       u32 count;
>> >> +     struct stm32_mdma_desc_node node[];
>> >
>> > some ppl use node[0] for this but i think either is fine..
>>
>> node[] is the correct one, node[0] may hide future bugs, cfr. commit
>> a158531f3c92467d ("gpio: 74x164: Fix crash during .remove()")
>
> Yeah but it this case it is the last element. But yes it helps to avoid such
> mistakes in future..

It was the last element in 74x164, too. Unless someone changed that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
