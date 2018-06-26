Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C69CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF4126462
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EsfyvOn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF4126462
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965614AbeFZN3c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:29:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55021 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965545AbeFZN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:29:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so1937643wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9nxAPf4sKghV3dxynTnZhNIo/qfZz14pyZ4IOfbJPvI=;
        b=EsfyvOn70LPjmgi4H9/p4bCljPzUTmtryzFYrVv9dxaFMPpRp8FLfIAdIReVs+hrcs
         az5k2CQP6iALRAfLT+9hkCBZ6cX27yBXJnHXHAXi6oYpMFpbaNyn/n1HcfnguV0HuoTN
         hXDxgb68vymHgCM2JqKzXvrsxxRIvK+RO9btk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9nxAPf4sKghV3dxynTnZhNIo/qfZz14pyZ4IOfbJPvI=;
        b=SToSf/Zi/Sc+nt6tRsmj3xuf7kWCX5m4MYou1qmK4Vo4v9LetX93ALiVf+Q2lucCB/
         5cLiHlu/vvE10iMd8uUdKbfu+1Y1h3cDH+el95jhy63WiCkpWIHIUfGMy7GXA5KEe1Tr
         BZBjuvrb4aAJtzJxUeWZizX7aT31f2hL1iepgZVDAnUzEySiL5jF5UKaKoKTdDl6JvGu
         0tXBEDxEjpnMTdu05ZitN4tcr8ahnjDmeoMzuVEgdaJERHUHmsVvrT09nHsYXXmuAPSH
         3rGATcxYSNHwF5kGrrbqPhpZasfAxkecg94FrryUJJqxFajpwVNCuiCCa6eyXipkfzkZ
         605Q==
X-Gm-Message-State: APt69E2bkHDm8G1cMdxafUJeRx/bYShgyb20dsiRIeDHPzI9kg2KXQe2
        0s5BkeWRffynXsp0i2Mbnq/CBRZPJ2KMCJEGvfbjxQ==
X-Google-Smtp-Source: AAOMgpeJicEtzp9uvS2RA0zcok7z8fzwbFm8k6Dl7UrsLWJ0wDY5TcCsEhOG7LtaFvvHTUvRrnTye3kVemjQsqkuhz4=
X-Received: by 2002:a1c:1e86:: with SMTP id e128-v6mr1688824wme.85.1530019766792;
 Tue, 26 Jun 2018 06:29:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8684:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 06:29:26
 -0700 (PDT)
In-Reply-To: <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com> <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 26 Jun 2018 15:29:26 +0200
Message-ID: <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
Subject: Re: simple-framebuffer enquire
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

to be more specific

On Tue, Jun 26, 2018 at 3:06 PM, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> On Tue., 26 Jun. 2018, 12:01 pm Hans de Goede, <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>> > Hi Hans
>> >
>> > In order to let it even registered the simplefb I have added this
>> > change. According on what I understand
>> > from the code seems that this is the way to acquire memory with the
>> > correct attribute
>> >
>> > diff --git a/drivers/video/fbdev/simplefb.c
>> > b/drivers/video/fbdev/simplefb.c
>> > index a3c44ec..7e61ce3 100644
>> > --- a/drivers/video/fbdev/simplefb.c
>> > +++ b/drivers/video/fbdev/simplefb.c
>> > @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device
>> > *pdev)
>> >
>> >          info->fbops = &simplefb_ops;
>> >          info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
>> > -       info->screen_base = ioremap_wc(info->fix.smem_start,
>> > -                                      info->fix.smem_len);
>> > +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
>> > +                                            info->fix.smem_len);
>>
>> I'm not sure why you need this?  wb certainly is not optimal
>> for a framebuffer, the existing wc mapping is really what you
>> want.
>>
>
> Well in this way raise a WARN and get a nice NULL on memory remap on imx6ull
> SoC
>

[    0.397484] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:303
__arm_ioremap_pfn_caller+0x80/0x1cc
[    0.397533] Modules linked in:
[    0.397611] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #8
[    0.397650] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[    0.397686] Backtrace:
[    0.397767] [<c010ca88>] (dump_backtrace) from [<c010cd28>]
(show_stack+0x18/0x1c)
[    0.397819]  r7:00000000 r6:60000053 r5:00000000 r4:c1684b94
[    0.397877] [<c010cd10>] (show_stack) from [<c0a22dc8>]
(dump_stack+0xb4/0xe8)
[    0.397936] [<c0a22d14>] (dump_stack) from [<c01255e0>] (__warn+0x104/0x130)
[    0.397988]  r9:00000001 r8:0000012f r7:00000009 r6:c0d07b50
r5:00000000 r4:00000000
[    0.398041] [<c01254dc>] (__warn) from [<c01256dc>]
(warn_slowpath_null+0x44/0x50)
[    0.398093]  r8:c0dc3154 r7:00086fd6 r6:c0118d60 r5:0000012f r4:c0d07b50
[    0.398149] [<c0125698>] (warn_slowpath_null) from [<c0118d60>]
(__arm_ioremap_pfn_caller+0x80/0x1cc)
[    0.398197]  r6:86fd6000 r5:00000080 r4:00080000
[    0.398250] [<c0118ce0>] (__arm_ioremap_pfn_caller) from
[<c0118f00>] (__arm_ioremap_caller+0x54/0x5c)
[    0.398303]  r9:0000004b r8:c321d0d0 r7:c0b3ddc0 r6:c321cc00
r5:c321d328 r4:c0118eac
[    0.398358] [<c0118eac>] (__arm_ioremap_caller) from [<c0119008>]
(ioremap_wc+0x20/0x28)
[    0.398417] [<c0118fe8>] (ioremap_wc) from [<c04a499c>]
(simplefb_probe+0x224/0x8a0)
[    0.398462]  r5:c321d328 r4:c321d000
[    0.398519] [<c04a4778>] (simplefb_probe) from [<c055ceb8>]
(platform_drv_probe+0x58/0xb8)
[    0.398571]  r10:00000000 r9:00000000 r8:c1633910 r7:fffffdfb
r6:c1633910 r5:fffffffe
[    0.398608]  r4:c321cc10
[    0.398666] [<c055ce60>] (platform_drv_probe) from [<c055b334>]
(driver_probe_device+0x2ac/0x334)
[    0.398717]  r7:c1decedc r6:00000000 r5:c1deced8 r4:c321cc10
[    0.398774] [<c055b088>] (driver_probe_device) from [<c055b528>]
(__device_attach_driver+0xa0/0xd4)
[    0.398826]  r10:00000000 r9:c1dece94 r8:00000000 r7:00000001
r6:c321cc10 r5:c3059dd8
[    0.398866]  r4:c1633910 r3:00000000

Michael
>>
>> >          if (!info->screen_base) {
>> >                  ret = -ENOMEM;
>> >                  goto error_fb_release;
>> >
>> > Another question is
>> >
>> >          aliases {
>> >                  display0 = &lcdif;
>> >          };
>> >
>> >          chosen {
>> >                  #address-cells = <1>;
>> >                  #size-cells = <1>;
>> >                  ranges;
>> >
>> >                  stdout-path = &uart1;
>> >                  framebuffer0: framebuffer@86fd6080 {
>> >                          compatible = "simple-framebuffer";
>> >                          reg = <0x86fd6080 (480 * 272 * 4)>;
>> >                          width = <480>;
>> >                          height = <272>;
>> >                          stride = <(480 * 4)>;
>> >                          format = "a8r8g8b8";
>> >                          clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
>> >                                   <&clks IMX6UL_CLK_LCDIF_APB>,
>> >                                   <&clks IMX6UL_CLK_DUMMY>,
>> >                                   <&clks IMX6UL_CLK_GPIO3>,
>> >                                   <&clks IMX6UL_CLK_GPIO4>;
>> >                          nshut-supply = <&reg_lcd_nshut>;
>> >                          nreset-supply = <&reg_lcd_nreset>;
>>
>> This looks like GPIOS to me why are you modeling this a supplies?
>>
>> Anyways ...
>>
>> >                          display = <&lcdif>;
>> >                  };
>> >          };
>> > };
>> >
>> > How do you ensure that regulators that are bind to gpios can be
>> > maintain during boot?
>>
>> Any regulators listed in the simplefb dt-node will be kept enabled
>> until remove_conflicting_framebuffers is called() from the native
>> display driver. To keep them enabled while loading the native
>> display driver, you should get and enable them in the native display
>> driver *before* calling remove_conflicting_framebuffers()
>> (and the same goes for the clocks).
>>
>
> I will check it
>
> Thank you
>
> Michael
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>> > A small minor comment is how to automatic switch then to normal
>> > framebuffer. Anyway seems
>> > that
>> >                  #address-cells = <1>;
>> >                  #size-cells = <1>;
>> >                  ranges;
>> >
>> > are mandatory and they are in the dts documentation.
>> >
>> > Best regards
>> > Michael
>> >



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
