Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F03B2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jmbMU2Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBQW1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:27:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41342 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfBQW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:27:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so8869398otk.8;
        Sun, 17 Feb 2019 14:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktIIposEqE8DQ5ymA8O5YNBfgmlFMUrpTzjyDYK9WU8=;
        b=jmbMU2Dp3jS8WU6m5XMURN88DNTgHY1RuEaWHEmc6GCFJs6NAmzmo7Eat6py/GQpMi
         Ta0wtJF6681FB3VzvxDXaRDLJ/QvEcFuZ5MHQ2bq7A6R7JuLRF99RjiWN6gHEDDQQg9Q
         V96ZoKZclH5GAuOgLbwG6PbKlllZwEwM1+whAKNPsO+MqOnVgJl9HnuK9bOYczoj9C6y
         kDswg+mk+lExH3H6gih/BepPeRspWXRt17WCtRcy7gDFPTWuKjngAljDcO/zHHZxKNrG
         /YEezAJ+j8YbTWync13GtsGpiyuSH75qmxR/ECM/ajpF6BR1KCnbfzMhZNv+Z0qrAQCh
         Pbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktIIposEqE8DQ5ymA8O5YNBfgmlFMUrpTzjyDYK9WU8=;
        b=HFcQNvoLlgI6UBXYkKvb/Pqb3IaJR2OpfH7njFq1wpFv0FH3N7mnDWU1IA4lLVWeZ4
         d9xOQbmrAWT7sRFVB2aLXSnJnv+bI/Ljbnrm8Kuqiwdq8KLeKEti0wMq0tSTcAMIH/8K
         CKes8a69ra/BK60ep8r6vw5ROx2gKT6GtL0ODcd8o2y7lrZsYCMRwPcu5mhmJm3oAXXG
         6kt0np6KosjI/5SrzEj3m98pG758VFe+FpqsK4zHQd+7y+IJ/DSfNkoASvfbiINwhYNC
         hu03AoG0anefvGyoaIvCTTk5DzxZp50YKSkVtP106knvdzcXUaPlpyyl1HNfn/NhQHUm
         +qFA==
X-Gm-Message-State: AHQUAuZrq7FSGHU8ga9Pxt2cv66rPz+dKBiWeIAh04zN3QZ+bwbQEre3
        UxGyTBLXKrpJ6JFWiQ7t+mF68Zl5Ah6SStJEbkE=
X-Google-Smtp-Source: AHgI3IaSoJMJVV/2dDrIjDJgm+0DPbGZKZrKO57qkRBvPApBy8OmVOrTi/dJ6/zsebuSXc1r2VuqmXHh3l+IJ8rePR4=
X-Received: by 2002:a9d:a11:: with SMTP id 17mr11531191otg.148.1550442466544;
 Sun, 17 Feb 2019 14:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20190218092536.39375e84@canb.auug.org.au>
In-Reply-To: <20190218092536.39375e84@canb.auug.org.au>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 17 Feb 2019 23:27:35 +0100
Message-ID: <CAFBinCCOqBumiAm6hM0MhVwPrUZydvvvOhrS34wTWRo6Jy87yA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Feb 17, 2019 at 11:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Linus,
>
> In commit
>
>   a5a0bbca16cd ("pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins")
>
> Fixes tag
>
>   Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
Linus fixed this one hour ago in the linux-pinctrl tree
so this should be gone with your next run


Regards
Martin
