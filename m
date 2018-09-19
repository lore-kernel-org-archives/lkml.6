Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F90C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE192151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLwMoSUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE192151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeITB1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:27:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32973 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbeITB1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:27:02 -0400
Received: by mail-io1-f67.google.com with SMTP id r196-v6so5521349iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkoKjI6Bwg4HbkxJPms4LpCpDI6F846hnXnsCWb13IY=;
        b=aLwMoSUsnMC6nJKEbFO/yysI/+UUdJEOJnY0xwTtcbWOoBpxcB35uU/beaUWkeP6OI
         XUlK2vJCdI+hjhpQQ8G19hL6RhVfecvJ7OnblgdhhA6Ut723j3CHikc7PdHlAGk31i9Y
         sBkywtBqQ4v6rYi3ye28AmVA10Oxcuq7p6mg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkoKjI6Bwg4HbkxJPms4LpCpDI6F846hnXnsCWb13IY=;
        b=cGa1/HfLk0fkJISvxSG1FUUqiw27ozNrPRE2HfY/4dHe22nzf5EBFEDXMzNJfstMkF
         EzEkRR2Ih9jV12ll8dip/wFmRkEbtzxPBc3exfTO6hVYQClvBLLhipKT+hfps5xmskLK
         fov7xIrl6KkztTOLd36T4DWPW+x0IoIiRm2GkKI2480iDJUmYmFv2gz6u74hcf2yZz31
         KlVN1M2p7t9GuAo1uF5U0Obe7R0wXjkaZ0WkicejnboU0EuIjzLG0nx33zxvm0L5czQh
         DT32uAEzHmLj2q4uBnltz9pMKMYUNk7dXt/48uAVb0mb/wMv0CBro3oxrNGO6dgaQ+Su
         +qqw==
X-Gm-Message-State: APzg51Cxj0Lb1qG/uO+U2dQAnAVk3exfqGE+luxDYcjAtMrgOdWO/fvQ
        ncnVXyt2hH79xrj8Nx/MwMnV5PPpmMvqiXhvcV5Yzg==
X-Google-Smtp-Source: ANB0VdZA8ATZlY/AV5uUAEGs6NEkfdzfUy3cwSfhaGw2aPeM3QjUpdkKw8Q7x9PiXkbfzRZP1pdgBTBv1CTwbOZbUqA=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr30105820iof.304.1537386456711;
 Wed, 19 Sep 2018 12:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com> <1537363669-25991-6-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1537363669-25991-6-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:47:23 -0700
Message-ID: <CACRpkdbeaMG48K5my=Lc51L3RryCZZExmye+wzNc_bHooyToXw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] ARM: dts: stm32: add STMFX support on stm32746g-eval
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This patch adds support for STMicroelectronics Multi-Function eXpander
> (STMFX) on stm32746g-eval. It is connected on i2c1.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
