Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61362C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2650E2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asYpvmay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2650E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeKZHrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:47:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40491 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeKZHrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:47:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so14781470oth.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuTCK2M4KqcOndsUDIlPbsX2VUFgkCtRrMxO5U7y7zI=;
        b=asYpvmay1LZCL30y7zisMljjdSBgVlK2An9U64evGLHITv02JM6X3oMc3d9zHCEl8l
         p831RC5PAYqHiza9xFppwbEkMIszGOJh89FtIEl1MnI5Em356mQu31rZzKQhzY7dewcb
         j3ur0suxhTeMFLob7pr9G6IGaWuG+cQmc7HCOMP7n7DrBmcc59sYnFnf2t5USTGMmcNd
         GgNRzwpGDOTQb8iNUDxYgNFu1fDrfuM/AY0YrXFVDEUQ6fP723dOj5z/15sveTOW8TtP
         kFNBSbBBsdG0RB+UbI70+DtE14Xhziinn3Xhs502EUhOYcHF+R6YUxZuTYPlLdR6K4cO
         cyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuTCK2M4KqcOndsUDIlPbsX2VUFgkCtRrMxO5U7y7zI=;
        b=YysrSzl5j7LjIbCWWIqxkiJ1Jqzri+LfYW4emh2BpvKcInWyXyWbCohmgVVNcZ8HdR
         Y74halFoTUhVGqnrfmu8vLpc0ZLaoN0p5WmdNoZcsBIAk0ASFyovEMyCYdJjFF9pMorN
         eUW0kQFTsNTqtAJqyVUeJEBGx5OiKlhgN9CdRrn82q/b76ZsgZkCf+i2xov4zWrc1X+t
         kDE1Ef3UMsJPgVcVUr4d4MV3jhuVIRM4Z/7V/1oNCa/T9fyYGZIZ+uTKJw+SVsA77Fwu
         +Du+SOHmBSgYnLR8oIbYoGATowq0xJHoLIQ9q6NaubZ9n7Y2l4AX2qS67tGTGTQfsC+Q
         hitQ==
X-Gm-Message-State: AA+aEWbs5TMpNoUsmxOahHkZFRdy3BjtBQ6c4EJyC8NCf2tXuxwjqMu8
        J+QDiBXnzUbqoPPHSVFKne8U6f+zl7Kx7mRPooM=
X-Google-Smtp-Source: AFSGD/UvcfyfAZq/kEe5cXTriJb4yKxNU8a8aZXVo+x2aVSzlQ2pq4e7E7eVPHR8LqjVJLzSfWVpYqE3OWMzoCt9l6E=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr12727460oty.203.1543179304854;
 Sun, 25 Nov 2018 12:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20181125201729.19836-1-otavio@ossystems.com.br>
 <CAOMZO5AVWbk_gdtDvXQfYqmENr8d3z5oxQVtzFtex0WrfY6tZQ@mail.gmail.com> <CAP9ODKrpde0tpRgoRMihvDur=ftQsT59h4Cqr3VQAOOimoSB1Q@mail.gmail.com>
In-Reply-To: <CAP9ODKrpde0tpRgoRMihvDur=ftQsT59h4Cqr3VQAOOimoSB1Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 25 Nov 2018 18:55:01 -0200
Message-ID: <CAOMZO5APMEksc3B0pxGzaEGMuwqC+TeuBcdhUSqR1+M7VOdTKw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Remove CONFIG_ARM_UNWIND
To:     Otavio Salvador <otavio.salvador@ossystems.com.br>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Otavio,

On Sun, Nov 25, 2018 at 6:49 PM Otavio Salvador
<otavio.salvador@ossystems.com.br> wrote:

> In fact, was removed and now selected.

Yes, correct. In 4.20-rc1 this option is automatically selected.

> I changed the commit log as:
>
> ARM: imx_v6_v7_defconfig: Remove explicit ARM_UNWIND disable
>
> CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> selected by the Kconfig logic.  This is done in preparation to making
> further changes to this defconfig cleaner.
>
> Do you agree?

Looks good to me, thanks.
