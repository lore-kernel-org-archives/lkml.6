Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B23B8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A7C208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc2MsQma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A7C208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935159AbeFMBQC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:16:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35113 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935096AbeFMBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:15:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so1284190lfc.2;
        Tue, 12 Jun 2018 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENBz7kFlg+AuLVnFI5OvkhBcVfjMFUit9NKNtFmn4mM=;
        b=Nc2MsQmapTbrut8Tv+j7Sb7I79mu684PqL8gKf7QwMVEFpwMR8UjhRnnsmruDTplCq
         C0x1JEHMGzkwAXdlkOpSvCMXkpTawQv+ILsTH3l0U961nhAfiS77T1xsYU+NDpwkId5C
         FD3JcxcezuoDeKVcOGBIf9d2PuEvaVxdY4Z9gWDaVtx/nfSjjkhqX/13l9dslGq23i1t
         N2osTqFOv1Gmw+shBfFGpiqH85+ufh3XjRBoXO43Z/tjEDQlD2tER1uztl1ve3Fdd4Pi
         t+m9K6PW05apKX+daegjBI07tlruh9ytryE3HL3QQnZ6Pxm4DfqlaizwFAPcTpcFiDfq
         XCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENBz7kFlg+AuLVnFI5OvkhBcVfjMFUit9NKNtFmn4mM=;
        b=nBWx5TUqzf3+0NvcLQyyG5DMD8Ig5DPdN7ex0Imw1pMhYFI6BQM+X/GKtQqJJSTMU1
         DbgYAzDs6Ywb7GsPf5+VaaQHhICrtosC+IsyGOU1xtOdSOFmyPpkf1Ki3LLPpt9gN45G
         5o5YsrADgEvIFunRpjQcdpb7Xmxph1Yw2AdP4RXa2EQWAH3WJxsG2QPNvB5gGs7oi1Tg
         J7afCQIeLJ2FS4NF7kL7snHoYOvpVXL+Hb/zeu8J7UIn+pQIR1UFDFRAoHYW2AxdxQkt
         Kw82GghNt5QRC+xBAnoIRjtD7Wac0tF6pDOWAXORu2lSWWuh96nAuOVNwsNU0C8pcF0y
         X2wQ==
X-Gm-Message-State: APt69E0XYWitUofU+I1hEOz+eSb1eimFQZDL9Pfiysjbcf8B5kL+iGBK
        tqvN+MLWIiYE1USYdG79NZA=
X-Google-Smtp-Source: ADUXVKIyPhoRCdUgENmsr/Xh8C/kEq/I0JgmcJShzZBQ5CH6XCtzyEZzPlsdz2Y8My6t2cURsfTJQQ==
X-Received: by 2002:a19:f71a:: with SMTP id z26-v6mr1424567lfe.137.1528852556859;
        Tue, 12 Jun 2018 18:15:56 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id u25-v6sm286779lju.76.2018.06.12.18.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 18:15:56 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-omap@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] ARM: OMAP1: ams-delta: drop GPIO lookup table for serio device
Date:   Wed, 13 Jun 2018 03:16:20 +0200
Message-ID: <69494657.T0PeNZxiFJ@z50>
In-Reply-To: <20180612222356.GD38773@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180612222356.GD38773@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 13, 2018 12:23:56 AM CEST Dmitry Torokhov wrote:
> Hi Janusz,
> 
> On Sat, Jun 09, 2018 at 04:02:15PM +0200, Janusz Krzysztofik wrote:
> > GPIO lookup table for ams-delta-serio device was introduced by commit
> > 0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables").
> > Unfortunately, a follow up patch "Input: ams_delta_serio: use GPIO
> > lookup table" was not accepted by subystem maintainer who requested
> > conversion of the driver to a platform driver, replacepemnt of IRQ GPIO
> > pin with IRQ resource, replacement of GPIO pin providing keyboard power
> > with a regulator and removal of remaining GPIO pins from the driver as
> > not handled by it.
> > 
> > Let's start with removal of no the longer needed GPIO lookup table from
> > the board init file.
> > 
> > Series created and tested on top of next-20180608 tag from linux-next
> > tree.
> 
> This all is really nice (modulo a couple of questions), thank you for
> implementing this. How do you want to merge this? Through OMAP tree or
> input?

Hi Dmitry,

If Tony doesn't mind, I would prefer it merged through OMAP tree as I still 
have a few board patches built on top of it in my queue.

Thanks,
Janusz



