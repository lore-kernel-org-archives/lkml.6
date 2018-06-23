Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A1C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27DD24C56
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpWSe+f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27DD24C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeFWPsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:48:46 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38523 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeFWPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:48:43 -0400
Received: by mail-oi0-f68.google.com with SMTP id e135-v6so1655919oib.5;
        Sat, 23 Jun 2018 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gvy95ewoXpfbr22CgA/ti7nRMvitI9qLX9Nou1r2cx0=;
        b=KpWSe+f7VKwM90Z99ku2o2GI7fYgcpXvcaG7J1kFYJBQNZ/HRGvNARzUd+gTQ5eSmf
         VQSFMypGpZt+SpBVhTFnVhHnV6/Ckuoz2+7BeYm87PTkzsf7sooYjCusWkPna35KXBFL
         0d4Ji6fpdldx0M4+6TJIBcqk+XG2ktmcfwQgFermZa/kRcwToItwBQMNLITmSSynle+y
         S45nwE2Rls1lBQxOD27Ot19Fjzwtferp4K6uicoZx9mDNHlvVdDsw5DKLuDFvVtdZSUl
         FFCl+MVp1Z2tIovumut77jus7CXHQuiltuSBkwvouMtCh0PdtFwxGrJHJrkKio2W1zNL
         wkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gvy95ewoXpfbr22CgA/ti7nRMvitI9qLX9Nou1r2cx0=;
        b=uSkhJkHk4RB/wzH+4OGN1aR/EdEu1Zw8Xki3ubipTVM/WWzXxlzILD2JHc3WFvWATY
         rvXq6S+DVB44k+dSMclrleHw8AadlYCCS8mzGyTO3en34eiNn5Q14US56tex1Q/6KAef
         HI18q3n5z0+O5uvcFvFOeX9aT6aOOCEbz2OoA1gekUOJ67gwoBzPrSUVGUi69AUm7SWR
         vzJKRnJcw9mvK7wmOt/LJHTXmDzwroqemUYb9yKz2CJlysFTGFRRBA78xAnmmW35Oeh2
         x+qzyigB1hJdwolK6Whnu5Z6+8RK1Weg1hu9mWqfS4vG5EtBuANwEKKt9/VOt6G/pd3Z
         cQjQ==
X-Gm-Message-State: APt69E21/M3qxdEJJwyLUnus15Mrk494m4jRlAsbKnrstfg3zNiD/aPy
        /KuqoTAM/de5LyAAu4YePtU7DQh5qre/qBMtrQo=
X-Google-Smtp-Source: AAOMgpe4LQtX0axsVx4H7zUNMrwuZ6mTy30QyTIKo/MnoVKCC1lc2OFPpn8lgjzZTFjucD6zzZsRBvNe9nk1eLbf5vo=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr3420658oii.198.1529768922874;
 Sat, 23 Jun 2018 08:48:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 08:48:42
 -0700 (PDT)
In-Reply-To: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Jun 2018 12:48:42 -0300
Message-ID: <CAOMZO5CgC2jj=7Gtuj=evi_e4ZoRYVuf8k=4Aiu5uEvXZiuK9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Ping Bai <ping.bai@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 3:32 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> According to Reference Manual Rev.0, 06/2017,
> there are GPIO LPCGs defined in CCM CCGRs,
> add them into clock tree.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
