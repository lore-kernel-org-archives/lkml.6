Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 187E3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D38208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alNrT1NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D38208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934766AbeFLQfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:35:07 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44209 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933640AbeFLQfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:35:05 -0400
Received: by mail-vk0-f68.google.com with SMTP id x4-v6so14762598vkx.11;
        Tue, 12 Jun 2018 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9g+YNya/oiudvFRC2Fn99o7O/QWr3/U5iyQW70kvuG4=;
        b=alNrT1NC6oqh4UP3uv+1db5RfNoZdEe3YJTTTbUnL0elXzEA4hPCLpCqEqBf+7hc6e
         G25BFjGrq98Gq9DuVBi5FfJ2grecy7AmLDCmlBwARY8b0BIhOCvSQfS7B3A9gdfio4Jb
         8ioX4yg3v6h6VjwSFhnWYukf0IQO390gfak5cXEm6O9Nyq/2w4A4qPH1NnToMyYWQhgi
         0kEt/FyA/vtatBA1WYLJsAjBS7xmvH1PLq15rYo2JhexGttI+aQ7u7eFrpHNltn4pXSl
         wnKQ6KUJzeG4/RN+CLrYxdsAip68yhgwsAUX4I5UkYQ6I232HP+y65pWndFrt1fUHV3f
         vnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9g+YNya/oiudvFRC2Fn99o7O/QWr3/U5iyQW70kvuG4=;
        b=gHOm+cddPYLBxia3GP1ZT/g3eTtiDps/JYnuMA+XZ133WpILgZMedU5046xK+WDEIU
         Fs6Eg+kMQT6g5EkHiNfohRqm8QBQEJi1ylmzIF5VZjPb7Pna5ZNWI1daG7DfYW1+XPfl
         Jgxl0dnDuTH8/YVSQZa5GhhVX1oWo3fFcu+gZvAv2Is9BZTajwAtJ+Cyai988TA10oAV
         1tvzDP6cJsuSIqnViBrXKa5n+pVarMm069bbriGCWiGf0bTHEGRUJDQO+VQBltEPd639
         +9iGdqKx68DxJFAza0dpkfLT1kfAdHBewFszVQgILRA8vMie8i/D2RXN7OhXO6F0+FSu
         yA5A==
X-Gm-Message-State: APt69E30Vp8GPN+Sk8TFh+QkJ6yDzpQei7QzWZFJowELz7uD8SzIlWpe
        jaYsQzVOlOBHUIoIeuyZAZSsn4Ja5ifGZ6TdVj8=
X-Google-Smtp-Source: ADUXVKJQ5GmfcSGnepM5w2AtZGns1yLPKWEhrZSKoG16fzoVPyG5P0DzqLuNQB/4mXXDv2UUk8gAkK+rgDn4coEzlPc=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr762141vkc.26.1528821304754;
 Tue, 12 Jun 2018 09:35:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 09:35:04
 -0700 (PDT)
In-Reply-To: <20180608.105926.600207780816212953.davem@davemloft.net>
References: <1528310722-11512-1-git-send-email-clabbe@baylibre.com> <20180608.105926.600207780816212953.davem@davemloft.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 19:35:04 +0300
Message-ID: <CAHp75VdaOuK2F0ENpwGf7HKVqXa13fe10rugYjLaQCTY7DbiaQ@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: fix build failure due to missing COMMON_CLK dependency
To:     David Miller <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 5:59 PM, David Miller <davem@davemloft.net> wrote:
> From: Corentin Labbe <clabbe@baylibre.com>
> Date: Wed,  6 Jun 2018 18:45:22 +0000
>
>> This patch fix the build failure on m68k;
>> drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.o: In function `ipq806x_gmac_probe':
>> dwmac-ipq806x.c:(.text+0xda): undefined reference to `clk_set_rate'
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.o: In function `rk_gmac_probe':
>> dwmac-rk.c:(.text+0x1e58): undefined reference to `clk_set_rate'
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sti.o: In function `stid127_fix_retime_src':
>> dwmac-sti.c:(.text+0xd8): undefined reference to `clk_set_rate'
>> dwmac-sti.c:(.text+0x114): undefined reference to `clk_set_rate'
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sti.o:dwmac-sti.c:(.text+0x12c): more undefined references to `clk_set_rate' follow
>> Lots of stmmac platform drivers need COMMON_CLK in their Kconfig depends.
>>
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>
> Applied.

I think Geert has a better fix https://lkml.org/lkml/2018/6/11/122

-- 
With Best Regards,
Andy Shevchenko
