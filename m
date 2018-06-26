Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08196C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0BC26866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0BC26866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934149AbeFZKBo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:01:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44247 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934028AbeFZKBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:01:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id c17-v6so618008eds.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KqfeDWG/gckwQ4rYnfislrZ+G/R5RF0C0HjkEWC60a4=;
        b=g8Zjfixfrq+o2YLDe39tTvN6IlW6Fme/3zb7+/Uq88ZdYgSVJyKGG92XGoE0b5LU9R
         cCPBxEO1rqWtgqg1ZiYWcIApbqcD/itt5vtTEPKWG5Cd4ZMs0JTshlHzu+glXbO6CvCO
         iqjcBcJrXoBNrc6XiuAST6BUTrPHH/z9/2+4qq/XbJYO10I9Czdraakf9waavcuqR5X2
         EcuZodnNHsj//caWVeXkZ3dq/bNEkYGOQIxCe1jrOg+JadtfqYxMpupQOyJdumwJICGs
         ZwIGUWclmbffYwKTT2IQw84uUT9u1D7tkVcoY9/JCmbOc1qhpM5mKcJsnMkysR7esK82
         tFyw==
X-Gm-Message-State: APt69E39GNm5pYlziSFVM3JhOBoGWjqQfEfwLSA7ThY8oX8up7b1eaga
        0ItKBlett7iyyVa5+m15/u828NqFfm8=
X-Google-Smtp-Source: AAOMgpfxq1Fd04vnajaQuf2rdtdkfYE425OKv/ApDqQaR6xhU2HioQR9daxl5ELs+qneRy3VpeRXlQ==
X-Received: by 2002:a50:cb0d:: with SMTP id g13-v6mr1175315edi.81.1530007297234;
        Tue, 26 Jun 2018 03:01:37 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o25-v6sm558311edr.75.2018.06.26.03.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:01:36 -0700 (PDT)
Subject: Re: simple-framebuffer enquire
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com>
Date:   Tue, 26 Jun 2018 12:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
> Hi Hans
> 
> In order to let it even registered the simplefb I have added this
> change. According on what I understand
> from the code seems that this is the way to acquire memory with the
> correct attribute
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index a3c44ec..7e61ce3 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device *pdev)
> 
>          info->fbops = &simplefb_ops;
>          info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
> -       info->screen_base = ioremap_wc(info->fix.smem_start,
> -                                      info->fix.smem_len);
> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
> +                                            info->fix.smem_len);

I'm not sure why you need this?  wb certainly is not optimal
for a framebuffer, the existing wc mapping is really what you
want.

>          if (!info->screen_base) {
>                  ret = -ENOMEM;
>                  goto error_fb_release;
> 
> Another question is
> 
>          aliases {
>                  display0 = &lcdif;
>          };
> 
>          chosen {
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  ranges;
> 
>                  stdout-path = &uart1;
>                  framebuffer0: framebuffer@86fd6080 {
>                          compatible = "simple-framebuffer";
>                          reg = <0x86fd6080 (480 * 272 * 4)>;
>                          width = <480>;
>                          height = <272>;
>                          stride = <(480 * 4)>;
>                          format = "a8r8g8b8";
>                          clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
>                                   <&clks IMX6UL_CLK_LCDIF_APB>,
>                                   <&clks IMX6UL_CLK_DUMMY>,
>                                   <&clks IMX6UL_CLK_GPIO3>,
>                                   <&clks IMX6UL_CLK_GPIO4>;
>                          nshut-supply = <&reg_lcd_nshut>;
>                          nreset-supply = <&reg_lcd_nreset>;

This looks like GPIOS to me why are you modeling this a supplies?

Anyways ...

>                          display = <&lcdif>;
>                  };
>          };
> };
> 
> How do you ensure that regulators that are bind to gpios can be
> maintain during boot?

Any regulators listed in the simplefb dt-node will be kept enabled
until remove_conflicting_framebuffers is called() from the native
display driver. To keep them enabled while loading the native
display driver, you should get and enable them in the native display
driver *before* calling remove_conflicting_framebuffers()
(and the same goes for the clocks).

Regards,

Hans



> A small minor comment is how to automatic switch then to normal
> framebuffer. Anyway seems
> that
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  ranges;
> 
> are mandatory and they are in the dts documentation.
> 
> Best regards
> Michael
> 
