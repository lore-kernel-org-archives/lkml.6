Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3562DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105A5218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyVleIXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbfAaH12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:27:28 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40328 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfAaH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:27:28 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so2475110ita.5;
        Wed, 30 Jan 2019 23:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eCYAkvyeadpqPRlU1R0w7M++z7FL/w1/uEMj/8FkFE=;
        b=oyVleIXcEVhJsz1SCvyKrbwpazPyieCcqWIM4J66mf8DPjuzYOCgk3PSL59N50ORej
         gUPTopV18FLtF1JHAY++ZEU8p6j3g4tX4hQEuX+G1CoPEw/pDxGfSccUm5tgHi27w5aS
         BPCXFoXJeijOakEqzSU+Qv78s/MAUjkDn+E4fsVInLvuoC7b/R+a1AcxNgXqEvsBfneo
         M673h5sZ5pHdSSdIxWmcHqgdOelCI39RfOM2kYsLAXjzq1GQobetwUTPZL6topeotkwW
         ak0X3keg70k4cgZrMg4ix2GeEQaPcQudnp73Ct5fxrhhszU+OgpQFSqsgVVYSOFFzu56
         iPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eCYAkvyeadpqPRlU1R0w7M++z7FL/w1/uEMj/8FkFE=;
        b=kUZfCHQqxbBiQbiFNOvLgolGkjvRIAs/dWh/tG/csTtW7524eIoyagV63fByPutUed
         Boj/lDM8dBzCbE4wAUf4Wm6t/92UipYqBrPA0UExN/qgRdNy9igvL70A83F++TQIep5o
         p0fbl8IHe5B7ZmjA+KhoIgVnJYh3ZfbEdXshz08+uAklTAb32hvDOevtk+DBXLJPTOTn
         yzXyzfmTUpf6rprhqeJiWaZS3TFaHHhYCd8rNFPFrt7XSIW+ZkwXdJeA4fsv803vLbNq
         8NtRXctDdQ2CYNnOvcwTEmwQiRaUX3SpC/61Ph5bwzP6TOWhMvNhYfmlym8OIjT3n0JH
         8q5A==
X-Gm-Message-State: AHQUAuaiWfxTvZSF7I5fECAUP9ajq1+V1rwpGwzv328wd0r77Cpb9aQO
        iWUon7FZ06w+AUOuiTLUZ5p6Hca+gKz/WiPk65Q=
X-Google-Smtp-Source: AHgI3IYqEIxysIWWuLWpPnLi6EfEBbGyUppFOr77z5GO73Avwq5q9HOyHVDmMP8epfUbdagI6H3MAZANjNvC+YK4QsU=
X-Received: by 2002:a24:9b87:: with SMTP id o129mr3966987itd.128.1548919647379;
 Wed, 30 Jan 2019 23:27:27 -0800 (PST)
MIME-Version: 1.0
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-4-git-send-email-aisheng.dong@nxp.com> <1548854523.6869.25.camel@pengutronix.de>
In-Reply-To: <1548854523.6869.25.camel@pengutronix.de>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 31 Jan 2019 15:27:16 +0800
Message-ID: <CAA+hA=RMjER6v3u4GzvCiOEJXJyBrpVed7KWUJPGQKhZvne0AQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] irq: imx-irqsteer: change to use reg_num instead
 of irq_group
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 9:23 PM Lucas Stach <l.stach@pengutronix.de> wrote:
[...]
> > > +   /* one register bit map represents 32 input interrupts */
> > > +   data->reg_num /= 32;
> > +
> > >     if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> > >             data->saved_reg = devm_kzalloc(&pdev->dev,
> > > -                                   sizeof(u32) * data->irq_groups * 2,
> > > +                                   sizeof(u32) * data->reg_num,
> >                                       GFP_KERNEL);
>
> Does this last parameter now fit on the line above?
>

No, 81 now. :)

Regards
Dong Aisheng
