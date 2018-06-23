Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0AC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AAF24C4D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qG8TUQ5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AAF24C4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeFWPrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:47:16 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38451 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeFWPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:47:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id e135-v6so1653948oib.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C+1O5tWyWpHTMHphG6uFDIAV0EcimLyiPL5hHjFmWPc=;
        b=qG8TUQ5/4pmm3d+YOHG+Hu1/zjaRQRlwvxjOOHwNDcTqzcKZzUnJW2GX1f56v62WHX
         uFEoYzpbH803cB5MjEPWCxQMJGapEu+iguVMW6liR0jeG7ORtehbk7w2erfwTQvBHJc1
         5Xer19pai0Qef4R+aehvCDdnbOIuD1wzOZn13wlxisFG/9ZbVluGUxGbhQ0y3HcEPawf
         d4iRmmcaXKLs8f4ICezq0yLaQab3qIOySm5tmnf1ibo+jMDsrVEvPEzf7SgfUC7DxdeY
         GUDFxzLWf7+vNNn6b7WDC7IFYNBSusiecxuf23azHKYkchwSLVbYMo1A6UpTD7h5warv
         0HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C+1O5tWyWpHTMHphG6uFDIAV0EcimLyiPL5hHjFmWPc=;
        b=ou9KvhkPGLYPXsDJeuKkqu9vto7jg2TkzfTHXaibaaZt/C0AEbd+1szuDdWahDR5Ny
         FN1qY538KOMYfeT33dOkMURui225Fkc04Dfn/1lYdV01QwrDXOUTAOQoMproI0Xha0pZ
         ogDIORtxJ2mowI/ucWHIhB1r6L7GczFm69J27ECMiGM/c/hfvbiwr8CtKaz0asicISqI
         SRDoh+bfYUOk/K3gbyAnEn4n1m/f5lLggIow57hQoV38tKknQFSaNrTv705Y4Cw8crZC
         gXbxMXSk5IZgBS5+d4aRZ89XA63XOMdHMgizk4uqCa6s+nMBb/V6GXXrb4Pa9gV1Nqz7
         naXQ==
X-Gm-Message-State: APt69E0a56GcVfgyDce6nnUirrXDUpkdidlsiEHBf+4oL88eFVo2Jz71
        LIj1AbDrKaCoFKQmempTMsjBDRzQlHbwDkkqFvY=
X-Google-Smtp-Source: ADUXVKIqg8w3lzcBkm9vyQsfmNV8i8jNP0iIdMrLHch/7HyRMCkT+nA3kSwXddwVkiFk8dzT1YSixBlPPHXNTAZ2vos=
X-Received: by 2002:aca:6144:: with SMTP id v65-v6mr3544131oib.147.1529768834355;
 Sat, 23 Jun 2018 08:47:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 08:47:13
 -0700 (PDT)
In-Reply-To: <CAOMZO5DJGCESqtSqbEw4O0Vxv3noUoCrTgbRCmwB2fJdVvu0RQ@mail.gmail.com>
References: <1529636119-4076-1-git-send-email-chakra@openedev.com> <CAOMZO5DJGCESqtSqbEw4O0Vxv3noUoCrTgbRCmwB2fJdVvu0RQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Jun 2018 12:47:13 -0300
Message-ID: <CAOMZO5BSVKSEjk1inZb_yA6VNkZiW_gWK3LdzkAzwZzJb+hVfQ@mail.gmail.com>
Subject: Re: [PATCH] Fix for clk disable issue on imx6ul
To:     Chakra Divi <2chakrass@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chakra Divi <chakra@openedev.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Yongcai Huang <anson.huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 12:38 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Looking at the CCM_CCGR0 register (address: 20C_4068) there is no
> aips_tz3 clock gate in bits 31-30.
>
> Bits 31-30 are gpio2_clocks and Anson has recently sent a patch adding
> support for it:
> https://patchwork.kernel.org/patch/10481351/

Sorry, the correct link for the imx6ul patch is this one instead:
https://patchwork.kernel.org/patch/10445059/
