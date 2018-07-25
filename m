Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D02C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D6420891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBIpMfol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D6420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeGYPMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeGYPMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:12:22 -0400
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com [209.85.216.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708E720894;
        Wed, 25 Jul 2018 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532527233;
        bh=J7IHpihLSFjCP2dOoYEM4IMZyLjWC/7EFDXuaoNqKUo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tBIpMfoljBYJ6CsqILuU3LgBk36B4leGYc46HkT4EtVfLCs2MMhkx5Rd8X1Jv5m38
         pXKheySiI7qa4Z4Sr3fGwtlGu8I6XfZSJ7fMoGiZLDTdJb5oKhvh4Qw4a/Xh5W2okz
         8AJDA6NN/YoaQiRdqbDc+GBWEAREQeR36wU/NKnI=
Received: by mail-qt0-f181.google.com with SMTP id d4-v6so7667166qtn.13;
        Wed, 25 Jul 2018 07:00:33 -0700 (PDT)
X-Gm-Message-State: AOUpUlH0B7X20zMBan+8sRa8OF0L4VsYhIUbEKPljHCrg6h2W2Pg25AT
        QhoVba9Ocq81jnF3JKHKBQ7FHCKLC82d3bn3yA==
X-Google-Smtp-Source: AAOMgpd9ouRFiAUN4vSYD6CgIyf1yCTgBMKUPAwJ2JZRQPMz7Oa5En7V93SxNm2xCCYuU98HbF2jBSUa2pzVijQ7Fcg=
X-Received: by 2002:a0c:e9ce:: with SMTP id q14-v6mr19317872qvo.106.1532527232618;
 Wed, 25 Jul 2018 07:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
 <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
 <20180720163515.GA16515@rob-hp-laptop> <ed56c8d3-f354-d311-8407-66268bcdf7a6@st.com>
In-Reply-To: <ed56c8d3-f354-d311-8407-66268bcdf7a6@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jul 2018 08:00:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+awnVr0qOtyMRYJzDON6k0c-G+bqLYz+WL5LNpigKhpg@mail.gmail.com>
Message-ID: <CAL_Jsq+awnVr0qOtyMRYJzDON6k0c-G+bqLYz+WL5LNpigKhpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: stm32: fix bank io port number
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:07 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi Rob
>
> On 07/20/2018 06:35 PM, Rob Herring wrote:
> > On Mon, Jul 16, 2018 at 02:57:36PM +0200, Alexandre Torgue wrote:
> >> In case the exti line is not in line with the bank number (that is the case
> >> when there is an hole between two banks, for example GPIOK and then GPIOZ),
> >> use "st,bank-ioport" DT property to get the right exti line.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> >>
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> >> index 9a06e1f..60c678a 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> >> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> >> @@ -55,6 +55,8 @@ Optional properties:
> >>      NOTE: If "gpio-ranges" is used for a gpio controller, all gpio-controller
> >>      have to use a "gpio-ranges" entry.
> >>      More details in Documentation/devicetree/bindings/gpio/gpio.txt.
> >> + - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
> >> +   used to select GPIOs as interrupts).
> >
> > ioport sounds like something else. Perhaps '-exti-line'?
>
> IOport is actually what is described in our datasheet. I could change it
> to -exti-line but I would prefer to match with the datasheet.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
