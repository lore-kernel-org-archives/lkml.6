Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7481C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE222082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="nEev0yLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE222082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeKZHlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:41:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37866 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZHlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:41:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so14011172oia.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=dqAVndQ9OdujxZFYFJ+S64NR//MJ30fYRZfwEXWIDek=;
        b=nEev0yLPMcqgQhkuaOcu6AWzi3aI3OV6zleziuANdl6ZM02FIx4YtorXJk8tPOHzZx
         l3BZJZ0fK/5VsGTRGn3gwfOzRoPHBUPurcDFfONfbBtM1icZs1FDsiX0TzR57a9WGBo3
         EqAjsoIJfyWwMHFBPcUM0oKcwfYKFFk8Fg74q1qEPtS7M2/6B/DsgeCzljN1jz4PpdEv
         2b8u0gWsp8yHe6vQCaktPFUn6/UfJ+GquKiMGWWxx/6hzClcBeyC42IJN7rtUupCf1R5
         2mEWs7DIeKiHluXvqrgCd5XDUkQ2EPdRkoLDgRUtR67pFBpLsARXLf+OL3LORSY25SAW
         OdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=dqAVndQ9OdujxZFYFJ+S64NR//MJ30fYRZfwEXWIDek=;
        b=kbXdVnWj4x5Dc46VALJS3NIMS6eC/yyG3cgMiytdaFO53Oy+nDU7kOVLozFc6PUCcO
         qTQE4/kPU3fHkiz36N4M7xvF1fjPGciqJTyQIINtTkEwC1CmpRX6RuAaa28GSGLmoUBG
         hC7RoGX+ASfWBfL0E4arZ+LzZO7IqO3agwt7eDteO2FY/fIIiOJiCx6Hdab5cZeepUfX
         nzsXQY6IIypXI5dUS3Jd+RHK2D5woHTC3e6Ts/TwJkmd7Zb5ZI7xVlwUHCqEwkW6ke96
         QrzAS9uE76lrCGJpWedNtDJgc0kTToVERLhPC0R9/h0ldnsGcYvgiWxt+cSjo+zAOzXs
         mdlQ==
X-Gm-Message-State: AGRZ1gJ1LDC0tXQLHRD1GvV4wIKQfUbWwGB5UYATZ+RRGQKyZUnx02iO
        jTSAmb6G2wsbqsSFnsV6DA2lCTxDVhquhA==
X-Google-Smtp-Source: AJdET5dvtLeVda8/QByTuiFiCA6S7M+2YfnAGsmcOK7s8oo43mOgQw0QQDPIuEGvB51tUcqZ02aRmA==
X-Received: by 2002:aca:5205:: with SMTP id g5mr14181493oib.149.1543178981148;
        Sun, 25 Nov 2018 12:49:41 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id 187sm2590529oic.12.2018.11.25.12.49.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 12:49:40 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f52.google.com with SMTP id u16so14779054otk.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:49:40 -0800 (PST)
X-Received: by 2002:a9d:12f1:: with SMTP id g104mr9955217otg.22.1543178979496;
 Sun, 25 Nov 2018 12:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20181125201729.19836-1-otavio@ossystems.com.br> <CAOMZO5AVWbk_gdtDvXQfYqmENr8d3z5oxQVtzFtex0WrfY6tZQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AVWbk_gdtDvXQfYqmENr8d3z5oxQVtzFtex0WrfY6tZQ@mail.gmail.com>
Date:   Sun, 25 Nov 2018 18:49:22 -0200
X-Gmail-Original-Message-ID: <CAP9ODKrpde0tpRgoRMihvDur=ftQsT59h4Cqr3VQAOOimoSB1Q@mail.gmail.com>
Message-ID: <CAP9ODKrpde0tpRgoRMihvDur=ftQsT59h4Cqr3VQAOOimoSB1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Remove CONFIG_ARM_UNWIND
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabio,
On Sun, Nov 25, 2018 at 6:30 PM Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Nov 25, 2018 at 6:18 PM Otavio Salvador <otavio@ossystems.com.br> wrote:
> >
> > The setting is removed when running a `savedefconfig` using the
> > current setting set. It is being applied in preparation to some
>
> "setting set" is a bit confusing.
>
> > patches making changes to this defconfig.
>
> It would be good to mention that CONFIG_ARM_UNWIND is still selected
> automatically.
>
> Otherwise it may give the impression that such functionality is being removed.
>
> You could reword the commit log to something like this:
>
> CONFIG_ARM_UNWIND is removed when running  'savedefconfig', but it is
> still selected by the Kconfig logic.
> This is done in preparation to making further changes to this defconfig cleaner.

In fact, was removed and now selected.

I changed the commit log as:

ARM: imx_v6_v7_defconfig: Remove explicit ARM_UNWIND disable

CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
selected by the Kconfig logic.  This is done in preparation to making
further changes to this defconfig cleaner.

Do you agree?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
