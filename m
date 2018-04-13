Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeDMIjw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:39:52 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35078 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDMIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:39:49 -0400
X-Google-Smtp-Source: AIpwx48Bp0A/vWVMyn6csDk9G64cs/E5N+47djf7ifYw3K0dPlkEQJ1/NceSPrALMKxNI/ZXtUogNwgp9fwhEV40RUQ=
MIME-Version: 1.0
In-Reply-To: <20180413040233.GJ6014@localhost>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com> <20180413040233.GJ6014@localhost>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Apr 2018 10:39:48 +0200
X-Google-Sender-Auth: Z3I443S5LoBuJBfwZqc5fxJ9QCc
Message-ID: <CAMuHMdWNyvveQ73SDrVy=EwkkO6Gd_4hmOkdstpcgzOL44a_mA@mail.gmail.com>
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

On Fri, Apr 13, 2018 at 6:02 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Apr 11, 2018 at 04:44:39PM +0200, Pierre-Yves MORDRET wrote:
>
>>  struct stm32_mdma_desc {
>>       struct virt_dma_desc vdesc;
>>       u32 ccr;
>> -     struct stm32_mdma_hwdesc *hwdesc;
>> -     dma_addr_t hwdesc_phys;
>>       bool cyclic;
>>       u32 count;
>> +     struct stm32_mdma_desc_node node[];
>
> some ppl use node[0] for this but i think either is fine..

node[] is the correct one, node[0] may hide future bugs, cfr. commit
a158531f3c92467d ("gpio: 74x164: Fix crash during .remove()")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
