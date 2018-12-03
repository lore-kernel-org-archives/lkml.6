Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E8C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6920848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZdFlTXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A6920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLCTIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:08:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33182 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLCTIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:08:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so13385803wrr.0;
        Mon, 03 Dec 2018 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CytzOKiCHdHUl8JgtAdUEWHOwsuMVACHkaAxlaVQGck=;
        b=rZdFlTXWTFSWkxAETb14J3bHUJDuirxg6NkZw/84g5xh1kEtL5yvlhLwceLd9GbVYc
         zWNl7TGsNy7YuBmeOFRw4saQ0oDgcTI2fVW+CzD6WERZ+e5M2nDZgwhnIxB1UVnm/5mk
         mZh4LLXo74uBj097eE9JJ3veeUjzhdMq7fkuSy9wjAp9n5iB/uU2AZZ3E+mL2qofS1Qs
         pArXLmQuOkuCvtqCIkF+6rKr/1EcKxrO5xv2B7bXP6O07zy8NfzdXWDrHB6ZJE4rIRib
         HCsNr4LReAQgfZm1AEz3Iq4wR532CVyeAHiZUquVFUWxeKtj1O2di1AUxZ4UWxMHSfsp
         48hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CytzOKiCHdHUl8JgtAdUEWHOwsuMVACHkaAxlaVQGck=;
        b=JRlj/hpw32OOKxShEkWNWoojuZ2pcHtHApXVdhFS3rhVZUl59qkapDxBx6l/Loj1HC
         4gywjqGjqgBsHjoJU3pS5Dc1I8gy/UkWpi4j1020OuwdTXwhdOMfqN/SAONNRYfwKpL3
         nYbt+DJEFsbOuLuKw2zx11F5Tex7pS+lc2jljIcggVYOeQ7j5HvH/f7wgnK9DNd0/x5t
         mALPZhMFVd5GguwG/O67BkUyCZ64HEBlMC4aK7AJbIWJKR+aIG1Q7QFeryos2sDF71cu
         U6TizjUR7h/T0GU4eMQOghNfatywh1EkOVUw9RmJEPtJSe1xwn7IYWcGVxJbkRbPrH7y
         M7tQ==
X-Gm-Message-State: AA+aEWamm2izfFm+bHfqO4jDtDVI+qdkCh9FaVZALZXsGmj/fwY3W9ea
        KbOwYXhUQfgJ0lYyzDy3f+k=
X-Google-Smtp-Source: AFSGD/WjStCFr26vctCzUlqlds53he+VgetjQHiSJ60h7DBFdo/3P65LTVYVr8IQ4lGI36PxuNMHyQ==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr15767752wrn.261.1543864104522;
        Mon, 03 Dec 2018 11:08:24 -0800 (PST)
Received: from localhost ([185.219.177.226])
        by smtp.gmail.com with ESMTPSA id c14sm3807910wme.13.2018.12.03.11.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 11:08:23 -0800 (PST)
Date:   Mon, 3 Dec 2018 22:08:22 +0300
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH v6 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Message-ID: <20181203190822.jt7sieazcapm722w@ThinkPad>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <b3d266d9f5f0f7504701c3bbec819acde6d19257.1543781680.git.mesihkilinc@gmail.com>
 <20181203085531.exlmkfs6b4ejv5dr@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203085531.exlmkfs6b4ejv5dr@flea>
User-Agent: NeoMutt/20180716-631-34bcda
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/03 09:55, Maxime Ripard wrote:
> On Sun, Dec 02, 2018 at 11:23:47PM +0300, Mesih Kilinc wrote:
> > diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > new file mode 100644
> > index 0000000..ea335a6
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > @@ -0,0 +1,541 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> 
> This isn't the proper SPDX format, and this is reported by
> checkpatch. I've fixed it while applying, but please make sure to run
> checkpatch.

Thanks Maxime, I will be more carefull next time. I actually saw that
warning, but I couldn't find what to do. I have looked to [1] and saw that
its spelled correctly. Now I think problem is, the licencse identifier
should be separate comment like:
// SPDX-...

Thanks!

Mesih

[1] =
https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf
