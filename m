Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50FEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFA725A64
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qAerjVjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFA725A64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755584AbeFYN3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:29:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34187 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755484AbeFYN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:29:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so13715639wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VoF7uPmjIBf11HPtLKAwFxbjtVOFysmGXONtW6WV4HQ=;
        b=qAerjVjBEl1zhQquuvJa0C/YAg5RGt9drNrt0LsSjY44vWIfQJO0umSvitlyUMlS63
         vN/ko2L43FdPCN8iUsb8L0niT1RVB9HU/uYJK1CsoRpBVI7fZoe6yvDszaTLei8pqvVI
         Yg0o2bPiuJN5S13bOX9wvVTZ/yit58TURuMEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VoF7uPmjIBf11HPtLKAwFxbjtVOFysmGXONtW6WV4HQ=;
        b=fzVcuOjiyd2+LiGBe8bIiuew93MbbbLiK6V3oYL9uvYkvcbfOB2HY1MzUASVzdCftW
         Szc+9lxkdRSduuqFNkP40JrhbhifnDr4B8JPc5g+tDQFLM5BLdCnit9Avbef06pR8zXV
         4KSrSu247C6DF/ESU+kJPsWKMBB8av5IeCT6Qh7iU1e1pdeVIPwrAofkV1eY3+QV98GM
         AF8Ebub1MPTZDnoqmTGZ6Hs2cvMD/w9AXi2EyxreT9Bk147A0EYoInC1/TSFAcJuRYbF
         xo+WZGH19LaXkRxqyfyqQA4E4bqspt6aG3FePcp119wk6Vj4zdqu74yYe+XX4VWF89AG
         ru/g==
X-Gm-Message-State: APt69E0kWGA5pQBnn7cxy0hTTXSosg7p1N8Vmw0JF8Jdz8Zl+iQ25heh
        25hC5JcKMwqMM+8xokYxHoTE/MXNoGBXJPforwLNB+ktmQU=
X-Google-Smtp-Source: AAOMgpegE1gYajATfqi0ja/aDVLBtxzpUlNPjz6xtPIkx+f/XvtlAqlmIV3Sj7ncQBHUrNO5qXQGRYOfHdQbbJOgLeg=
X-Received: by 2002:adf:90af:: with SMTP id i44-v6mr6744230wri.146.1529933368487;
 Mon, 25 Jun 2018 06:29:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8684:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 06:29:27
 -0700 (PDT)
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 25 Jun 2018 15:29:27 +0200
Message-ID: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
Subject: simple-framebuffer enquire
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

In order to let it even registered the simplefb I have added this
change. According on what I understand
from the code seems that this is the way to acquire memory with the
correct attribute

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..7e61ce3 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device *pdev)

        info->fbops = &simplefb_ops;
        info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
-       info->screen_base = ioremap_wc(info->fix.smem_start,
-                                      info->fix.smem_len);
+       info->screen_base = arch_memremap_wb(info->fix.smem_start,
+                                            info->fix.smem_len);
        if (!info->screen_base) {
                ret = -ENOMEM;
                goto error_fb_release;

Another question is

        aliases {
                display0 = &lcdif;
        };

        chosen {
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;

                stdout-path = &uart1;
                framebuffer0: framebuffer@86fd6080 {
                        compatible = "simple-framebuffer";
                        reg = <0x86fd6080 (480 * 272 * 4)>;
                        width = <480>;
                        height = <272>;
                        stride = <(480 * 4)>;
                        format = "a8r8g8b8";
                        clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
                                 <&clks IMX6UL_CLK_LCDIF_APB>,
                                 <&clks IMX6UL_CLK_DUMMY>,
                                 <&clks IMX6UL_CLK_GPIO3>,
                                 <&clks IMX6UL_CLK_GPIO4>;
                        nshut-supply = <&reg_lcd_nshut>;
                        nreset-supply = <&reg_lcd_nreset>;
                        display = <&lcdif>;
                };
        };
};

How do you ensure that regulators that are bind to gpios can be
maintain during boot?
A small minor comment is how to automatic switch then to normal
framebuffer. Anyway seems
that
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;

are mandatory and they are in the dts documentation.

Best regards
Michael
