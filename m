Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47200C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98FB26982
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oaQA48ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98FB26982
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935034AbeFZOmb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:42:31 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42431 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934936AbeFZOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:42:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id p1-v6so1944101wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rMIf5v8KN0Mrdw6RsquqaCi7MR/DnnFhzmeZFVtVBWc=;
        b=oaQA48irM72Jm90d71orxeXYW9mk30XgBVhXnY4i3W3QTyGnyPQjaFwqjZ+0VBXWsU
         5txhFZxSFsB87LJmngv1P6qSOHcwqlZJENRuwojA9EkGT1eimTgCjJqEQgV6crne4Sgu
         dFPo273LdNQMBv/4jJKpLreMrgoL5xwmPxSTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rMIf5v8KN0Mrdw6RsquqaCi7MR/DnnFhzmeZFVtVBWc=;
        b=DYvRC63kKqVOjqg4hOsP69rAdxoDcC5szQJgOZWgX9+RDywuA6m7s1WYcE7jMMwi/w
         RL2axuhufdaafg2EuYwkTsrhTOjUvZzFHrUNWy3cUfnPvkGU9GIpPXGfl6zMrZqjFoJP
         5gYBFEwdshei2AqgrLJdEvY6y9N+TtAcXdiYt5gD3COUnGX7fuW22jdqWPGrPZqYeRt6
         RALtKMcW+5yWyQUEwy72+ugJAzrT7EeQxUWo7w1MySAWAptSBxTD126ubL77kRa+CsqW
         5U1TgTcsbM3Nw2Gn+94kqouWua7yANwvxTT3RD1GMUSSHlNNfSl5L1Kt53Zi43FyjsLm
         Ijgg==
X-Gm-Message-State: APt69E2JvcsZe1NRM2VxiXfn56VixXiDQg5Un9dMR3OZOz8NU7ax8qlL
        28xaCxBfiUdNaW3obtKrOF3nocbCzsaNqQHtRrwS0cP72t8=
X-Google-Smtp-Source: AAOMgpcSOPDwN0iR5Wwi+Ms/Rp7+OlDqen56DIGvq8sVh/Vv1/XSjJhx9yZapucrQDX2m34ke2UNP4kR6SZ1XyfcXnQ=
X-Received: by 2002:adf:bbc9:: with SMTP id z9-v6mr1324324wrg.183.1530024147824;
 Tue, 26 Jun 2018 07:42:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8684:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 07:42:27
 -0700 (PDT)
In-Reply-To: <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com> <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
 <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
 <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com> <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 26 Jun 2018 16:42:27 +0200
Message-ID: <CAOf5uwnVoXw1MA=n3vphMhtto=fc+NVf11idLF8nwC6JCvf4+A@mail.gmail.com>
Subject: Re: simple-framebuffer enquire
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

On Tue, Jun 26, 2018 at 3:38 PM, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> On Tue, Jun 26, 2018 at 3:36 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 26-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>
>>> Hi
>>>
>>> to be more specific
>>>
>>> On Tue, Jun 26, 2018 at 3:06 PM, Michael Nazzareno Trimarchi
>>> <michael@amarulasolutions.com> wrote:
>>>>
>>>> Hi
>>>>
>>>> On Tue., 26 Jun. 2018, 12:01 pm Hans de Goede, <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>>>>
>>>>>> Hi Hans
>>>>>>
>>>>>> In order to let it even registered the simplefb I have added this
>>>>>> change. According on what I understand
>>>>>> from the code seems that this is the way to acquire memory with the
>>>>>> correct attribute
>>>>>>
>>>>>> diff --git a/drivers/video/fbdev/simplefb.c
>>>>>> b/drivers/video/fbdev/simplefb.c
>>>>>> index a3c44ec..7e61ce3 100644
>>>>>> --- a/drivers/video/fbdev/simplefb.c
>>>>>> +++ b/drivers/video/fbdev/simplefb.c
>>>>>> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device
>>>>>> *pdev)
>>>>>>
>>>>>>           info->fbops = &simplefb_ops;
>>>>>>           info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
>>>>>> -       info->screen_base = ioremap_wc(info->fix.smem_start,
>>>>>> -                                      info->fix.smem_len);
>>>>>> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
>>>>>> +                                            info->fix.smem_len);
>>>>>
>>>>>
>>>>> I'm not sure why you need this?  wb certainly is not optimal
>>>>> for a framebuffer, the existing wc mapping is really what you
>>>>> want.
>>>>>
>>>>
>>>> Well in this way raise a WARN and get a nice NULL on memory remap on
>>>> imx6ull
>>>> SoC
>>>>
>>>
>>> [    0.397484] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:303
>>> __arm_ioremap_pfn_caller+0x80/0x1cc
>>
>>
>>
>> This is causes by a mismatch in memory attributes, which means the
>> memory is already mapped by the kernel as regular RAM and may
>> already be used for other purposes by the kernel!
>>
>> Memory used by a simplefb framebuffer must be reserved by the
>> bootloader, so that it does not get used by the kernel as regular
>> RAM. See e.g.:
>>
>> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/video/sunxi/sunxi_display.c
>>
>> Near the end of the file where the framebuffer RAM gets excluded from
>> the memory-range reported to the kernel as usable RAM. Note this relies
>> on the u-boot sunxi video code putting the framebuffer at the end of the
>> RAM.

+       aliases {
+               display0 = &lcdif;
+       };
+
+       reserved-memory {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               display_reserved: framebuffer@86fd6080 {
+                       reg = <0x86fd6080 (480 * 272 *4)>;
+               };
+

This should do the trick but I have still the same problem on memory
type. Any idea?


+               linux,cma {
+                       compatible = "shared-dma-pool";
+                       reusable;
+                       size = <0x1000000>;
+                       linux,cma-default;
+               };
+       };
+
+       chosen {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               stdout-path = &uart1;
+               framebuffer0: framebuffer@86fd6080 {
+                       compatible = "simple-framebuffer";
+                       reg = <0x86fd6080 (480 * 272 * 4)>;

Here I try to use the same. I will create in uboot a dynamic way to
track down. I think that
we can even add to the simple buffer a way to get hand of reserved
region automatically

Michael

+                       width = <480>;
+                       height = <272>;
+                       stride = <(480 * 4)>;
+                       format = "a8r8g8b8";
+                       clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
+                                <&clks IMX6UL_CLK_LCDIF_APB>,
+                                <&clks IMX6UL_CLK_DUMMY>,
+                                <&clks IMX6UL_CLK_GPIO3>,
+                                <&clks IMX6UL_CLK_GPIO4>;
+                       nshut-supply = <&reg_lcd_nshut>;
+                       nreset-supply = <&reg_lcd_nreset>;
+                       display = <&lcdif>;
+                       status = "okay";
+               };



>>
>
> Thank you very much for this lesson ;). I will try to document better
> after my tour ;)
>
> Michael
>
>> Regards,
>>
>> Hans
>
>
>
> --
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> |                  [`as] http://www.amarulasolutions.com               |



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
