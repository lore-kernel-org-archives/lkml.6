Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D950BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB9126C92
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB9126C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965356AbeFZOrO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:47:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39859 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965103AbeFZOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:47:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so2136940wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 07:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=olO8NJVbUE6+ocyrzqnTCLj2kpWEoN8vj3cQi8+2iLE=;
        b=hOzOaXxTUNR57Rvz/myUMQgymoLR+lYMA9N6Dl+1KxmphZXlAbH/9zqyB1ukcsZBt0
         YGR7pQCmTjnqpvJg1uSbwJEbsjuVpWCbBueoN2yLrLJEu/kLw49/f4mEhnL89idWsysY
         +wRLP3S5WgkmnZT5Ho70qv5cLgcXNwsI3+nouRzkLfLxnt78lI4/Z1rkrGn6CJuhY3fo
         0OUpepjoHaxUARbIY5PWQvFaHZaW2s8gNKzg2aLDsgMAV1WWkTfDTeujlrd2jDpLeUNO
         4SjUUGdLA7YscIBk0FD4Kij9oAhD5k+RHBQ3TcjUP6pzOf1HqxOeIoz/kjV4lKoRBNJN
         XUtQ==
X-Gm-Message-State: APt69E1tqKS5E6DeogZuHWHrXWoWuAj+Afe/mUvlUqurEfuRIw32AWJQ
        Biwc8FbWnUFY6eQfTANsuk/CsEx5qcY=
X-Google-Smtp-Source: AAOMgpfQ6X+p46dQ2qhYyoemNO8j2i9yjwsDQiCj47Ic6ah+vdkk/YX5+Va78Ajm644AcqaYtyu8dQ==
X-Received: by 2002:a1c:bf0c:: with SMTP id p12-v6mr1801849wmf.120.1530024429552;
        Tue, 26 Jun 2018 07:47:09 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c18-v6sm3100835wrq.17.2018.06.26.07.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 07:47:08 -0700 (PDT)
Subject: Re: simple-framebuffer enquire
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com>
 <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
 <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
 <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com>
 <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
 <CAOf5uwnVoXw1MA=n3vphMhtto=fc+NVf11idLF8nwC6JCvf4+A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7b996681-3a94-1f93-10c0-5369fe843cbc@redhat.com>
Date:   Tue, 26 Jun 2018 16:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOf5uwnVoXw1MA=n3vphMhtto=fc+NVf11idLF8nwC6JCvf4+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-06-18 16:42, Michael Nazzareno Trimarchi wrote:
> Hi Hans
> 
> On Tue, Jun 26, 2018 at 3:38 PM, Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>> Hi
>>
>> On Tue, Jun 26, 2018 at 3:36 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>>
>>> On 26-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>>
>>>> Hi
>>>>
>>>> to be more specific
>>>>
>>>> On Tue, Jun 26, 2018 at 3:06 PM, Michael Nazzareno Trimarchi
>>>> <michael@amarulasolutions.com> wrote:
>>>>>
>>>>> Hi
>>>>>
>>>>> On Tue., 26 Jun. 2018, 12:01 pm Hans de Goede, <hdegoede@redhat.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>>>>>
>>>>>>> Hi Hans
>>>>>>>
>>>>>>> In order to let it even registered the simplefb I have added this
>>>>>>> change. According on what I understand
>>>>>>> from the code seems that this is the way to acquire memory with the
>>>>>>> correct attribute
>>>>>>>
>>>>>>> diff --git a/drivers/video/fbdev/simplefb.c
>>>>>>> b/drivers/video/fbdev/simplefb.c
>>>>>>> index a3c44ec..7e61ce3 100644
>>>>>>> --- a/drivers/video/fbdev/simplefb.c
>>>>>>> +++ b/drivers/video/fbdev/simplefb.c
>>>>>>> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device
>>>>>>> *pdev)
>>>>>>>
>>>>>>>            info->fbops = &simplefb_ops;
>>>>>>>            info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
>>>>>>> -       info->screen_base = ioremap_wc(info->fix.smem_start,
>>>>>>> -                                      info->fix.smem_len);
>>>>>>> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
>>>>>>> +                                            info->fix.smem_len);
>>>>>>
>>>>>>
>>>>>> I'm not sure why you need this?  wb certainly is not optimal
>>>>>> for a framebuffer, the existing wc mapping is really what you
>>>>>> want.
>>>>>>
>>>>>
>>>>> Well in this way raise a WARN and get a nice NULL on memory remap on
>>>>> imx6ull
>>>>> SoC
>>>>>
>>>>
>>>> [    0.397484] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:303
>>>> __arm_ioremap_pfn_caller+0x80/0x1cc
>>>
>>>
>>>
>>> This is causes by a mismatch in memory attributes, which means the
>>> memory is already mapped by the kernel as regular RAM and may
>>> already be used for other purposes by the kernel!
>>>
>>> Memory used by a simplefb framebuffer must be reserved by the
>>> bootloader, so that it does not get used by the kernel as regular
>>> RAM. See e.g.:
>>>
>>> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/video/sunxi/sunxi_display.c
>>>
>>> Near the end of the file where the framebuffer RAM gets excluded from
>>> the memory-range reported to the kernel as usable RAM. Note this relies
>>> on the u-boot sunxi video code putting the framebuffer at the end of the
>>> RAM.
> 
> +       aliases {
> +               display0 = &lcdif;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               display_reserved: framebuffer@86fd6080 {
> +                       reg = <0x86fd6080 (480 * 272 *4)>;
> +               };
> +
> 
> This should do the trick but I have still the same problem on memory
> type. Any idea?

For starters your start address and size are not page-size
(multiple of 4k aligned), you need to fix that.

After that double check in the memory map reported by the
kernel during boot that your reservation actually works.

Regards,

Hans



> 
> 
> +               linux,cma {
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +                       size = <0x1000000>;
> +                       linux,cma-default;
> +               };
> +       };
> +
> +       chosen {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               stdout-path = &uart1;
> +               framebuffer0: framebuffer@86fd6080 {
> +                       compatible = "simple-framebuffer";
> +                       reg = <0x86fd6080 (480 * 272 * 4)>;
> 
> Here I try to use the same. I will create in uboot a dynamic way to
> track down. I think that
> we can even add to the simple buffer a way to get hand of reserved
> region automatically
> 
> Michael
> 
> +                       width = <480>;
> +                       height = <272>;
> +                       stride = <(480 * 4)>;
> +                       format = "a8r8g8b8";
> +                       clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
> +                                <&clks IMX6UL_CLK_LCDIF_APB>,
> +                                <&clks IMX6UL_CLK_DUMMY>,
> +                                <&clks IMX6UL_CLK_GPIO3>,
> +                                <&clks IMX6UL_CLK_GPIO4>;
> +                       nshut-supply = <&reg_lcd_nshut>;
> +                       nreset-supply = <&reg_lcd_nreset>;
> +                       display = <&lcdif>;
> +                       status = "okay";
> +               };
> 
> 
> 
>>>
>>
>> Thank you very much for this lesson ;). I will try to document better
>> after my tour ;)
>>
>> Michael
>>
>>> Regards,
>>>
>>> Hans
>>
>>
>>
>> --
>> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
>> | COO  -  Founder                                      Cruquiuskade 47 |
>> | +31(0)851119172                                 Amsterdam 1018 AM NL |
>> |                  [`as] http://www.amarulasolutions.com               |
> 
> 
> 
