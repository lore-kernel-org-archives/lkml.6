Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2485A26924
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2485A26924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeFZSpD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:45:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38353 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeFZSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:45:01 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so18257887wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ial3CyVPOMS0w8SHicP49SFHdkIzxzQ2+SavXQB1jUk=;
        b=CCjAWhqYvikaI62LAVuuTQdL+vy/lR2xTj+LxjWhr8GiqHie2P6j5yooIx1njGUku9
         lNpbulfyllybldfA5GO8/vHTsjxEipv8smEYxFJvLGuYmr1vpTRjDd6FvYBsryA5Dikz
         KiSq6JpCR/F4yX2KEqgW6YA19EfLqbxBB/ZNalGoGQDvyLV4Ktdp1rieEzvzOH1AfyjQ
         crWpYeHmbOaIxwmI/jbACV8h85aaffKwp/NYz5A44rIQhRNU2suBcUT7ILA7H6MdkQ1r
         QvtM/VmxGX1VSIgkM6KPEzLnEb51zBlV3w4SkPETJx5v968dvSh67PGXpGAdKHmhGo8e
         bIcQ==
X-Gm-Message-State: APt69E33lQZpdNbS0mBY28CLhQFjx64ukeaqwE7cCo6bReREPsvbhSBR
        Ln109NEfm9eygQQb0FAEXntZ8HKAvAQ=
X-Google-Smtp-Source: AAOMgpfaOtj6AcdMklq8e6Z4f0XYG/WUuo+9gH+YkDIt2UvqqQ+/DT+yfg3IX7KTjxNZVqMVLwa4Yg==
X-Received: by 2002:adf:8701:: with SMTP id a1-v6mr2605282wra.178.1530038699849;
        Tue, 26 Jun 2018 11:44:59 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s12-v6sm1998397wmc.2.2018.06.26.11.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:44:59 -0700 (PDT)
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
 <7b996681-3a94-1f93-10c0-5369fe843cbc@redhat.com>
 <CAOf5uwmxZxxKG0CnstnNaTYdt-1+=YZHr8eSac5TdwfANdobxQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <996603c6-9779-7412-d998-bd7b49194490@redhat.com>
Date:   Tue, 26 Jun 2018 20:44:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOf5uwmxZxxKG0CnstnNaTYdt-1+=YZHr8eSac5TdwfANdobxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-06-18 18:35, Michael Nazzareno Trimarchi wrote:
> Hi Hans
> 
> On Tue, Jun 26, 2018 at 4:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 26-06-18 16:42, Michael Nazzareno Trimarchi wrote:
>>>
>>> Hi Hans
>>>
>>> On Tue, Jun 26, 2018 at 3:38 PM, Michael Nazzareno Trimarchi
>>> <michael@amarulasolutions.com> wrote:
>>>>
>>>> Hi
>>>>
>>>> On Tue, Jun 26, 2018 at 3:36 PM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>> On 26-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>>>>
>>>>>>
>>>>>> Hi
>>>>>>
>>>>>> to be more specific
>>>>>>
>>>>>> On Tue, Jun 26, 2018 at 3:06 PM, Michael Nazzareno Trimarchi
>>>>>> <michael@amarulasolutions.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> Hi
>>>>>>>
>>>>>>> On Tue., 26 Jun. 2018, 12:01 pm Hans de Goede, <hdegoede@redhat.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Hans
>>>>>>>>>
>>>>>>>>> In order to let it even registered the simplefb I have added this
>>>>>>>>> change. According on what I understand
>>>>>>>>> from the code seems that this is the way to acquire memory with the
>>>>>>>>> correct attribute
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/video/fbdev/simplefb.c
>>>>>>>>> b/drivers/video/fbdev/simplefb.c
>>>>>>>>> index a3c44ec..7e61ce3 100644
>>>>>>>>> --- a/drivers/video/fbdev/simplefb.c
>>>>>>>>> +++ b/drivers/video/fbdev/simplefb.c
>>>>>>>>> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device
>>>>>>>>> *pdev)
>>>>>>>>>
>>>>>>>>>             info->fbops = &simplefb_ops;
>>>>>>>>>             info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
>>>>>>>>> -       info->screen_base = ioremap_wc(info->fix.smem_start,
>>>>>>>>> -                                      info->fix.smem_len);
>>>>>>>>> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
>>>>>>>>> +                                            info->fix.smem_len);
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> I'm not sure why you need this?  wb certainly is not optimal
>>>>>>>> for a framebuffer, the existing wc mapping is really what you
>>>>>>>> want.
>>>>>>>>
>>>>>>>
>>>>>>> Well in this way raise a WARN and get a nice NULL on memory remap on
>>>>>>> imx6ull
>>>>>>> SoC
>>>>>>>
>>>>>>
>>>>>> [    0.397484] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:303
>>>>>> __arm_ioremap_pfn_caller+0x80/0x1cc
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> This is causes by a mismatch in memory attributes, which means the
>>>>> memory is already mapped by the kernel as regular RAM and may
>>>>> already be used for other purposes by the kernel!
>>>>>
>>>>> Memory used by a simplefb framebuffer must be reserved by the
>>>>> bootloader, so that it does not get used by the kernel as regular
>>>>> RAM. See e.g.:
>>>>>
>>>>>
>>>>> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/video/sunxi/sunxi_display.c
>>>>>
>>>>> Near the end of the file where the framebuffer RAM gets excluded from
>>>>> the memory-range reported to the kernel as usable RAM. Note this relies
>>>>> on the u-boot sunxi video code putting the framebuffer at the end of the
>>>>> RAM.
>>>
>>>
>>> +       aliases {
>>> +               display0 = &lcdif;
>>> +       };
>>> +
>>> +       reserved-memory {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               ranges;
>>> +
>>> +               display_reserved: framebuffer@86fd6080 {
>>> +                       reg = <0x86fd6080 (480 * 272 *4)>;
>>> +               };
>>> +
>>>
>>> This should do the trick but I have still the same problem on memory
>>> type. Any idea?
>>
>>
>> For starters your start address and size are not page-size
>> (multiple of 4k aligned), you need to fix that.
>>
> 
> cat memblock/reserved
>     0: 0x80004000..0x80007fff
>     1: 0x80100000..0x81e030b3
>     2: 0x83000000..0x83007fff
>     3: 0x84000000..0x85ffffff
>     4: 0x86fa2000..0x87021fff
> 
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               display_reserved: framebuffer@86fa2000 {
> +                       reg = <0x86fa2000 0x80000>;
> +               };
> +
> +       };
> +
> +       chosen {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               stdout-path = &uart1;
> +               framebuffer0: framebuffer@86fa2000 {
> +                       compatible = "simple-framebuffer";
> +                       reg = <0x86fa2000 (480 * 272 * 4)>;
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
> 
> Still have the same on ioremap.

Hmm, I guess the kernel does map the entire region its get
passed and simply makes sure to not touch the reserved mem,
where as with the changes to the passed in mem-region the
sunxi u-boot code does the memory does not get mapped by
the kernel at all ?

I think at this point this may have more become more of a
question for the ARM folks then for the fbdev list.

Regards,

Hans





> 
> Michael
> 
> 
>> After that double check in the memory map reported by the
>> kernel during boot that your reservation actually works.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>>
>>>
>>> +               linux,cma {
>>> +                       compatible = "shared-dma-pool";
>>> +                       reusable;
>>> +                       size = <0x1000000>;
>>> +                       linux,cma-default;
>>> +               };
>>> +       };
>>> +
>>> +       chosen {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               ranges;
>>> +
>>> +               stdout-path = &uart1;
>>> +               framebuffer0: framebuffer@86fd6080 {
>>> +                       compatible = "simple-framebuffer";
>>> +                       reg = <0x86fd6080 (480 * 272 * 4)>;
>>>
>>> Here I try to use the same. I will create in uboot a dynamic way to
>>> track down. I think that
>>> we can even add to the simple buffer a way to get hand of reserved
>>> region automatically
>>>
>>> Michael
>>>
>>> +                       width = <480>;
>>> +                       height = <272>;
>>> +                       stride = <(480 * 4)>;
>>> +                       format = "a8r8g8b8";
>>> +                       clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
>>> +                                <&clks IMX6UL_CLK_LCDIF_APB>,
>>> +                                <&clks IMX6UL_CLK_DUMMY>,
>>> +                                <&clks IMX6UL_CLK_GPIO3>,
>>> +                                <&clks IMX6UL_CLK_GPIO4>;
>>> +                       nshut-supply = <&reg_lcd_nshut>;
>>> +                       nreset-supply = <&reg_lcd_nreset>;
>>> +                       display = <&lcdif>;
>>> +                       status = "okay";
>>> +               };
>>>
>>>
>>>
>>>>>
>>>>
>>>> Thank you very much for this lesson ;). I will try to document better
>>>> after my tour ;)
>>>>
>>>> Michael
>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
>>>> | COO  -  Founder                                      Cruquiuskade 47 |
>>>> | +31(0)851119172                                 Amsterdam 1018 AM NL |
>>>> |                  [`as] http://www.amarulasolutions.com               |
>>>
>>>
>>>
>>>
>>
> 
> 
> 
