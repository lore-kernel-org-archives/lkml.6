Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E456C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B5220868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+Fmjh95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B5220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLGJQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:16:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36698 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:16:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so2940348ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6zChaRXWKGKCK/yRFrR4cl7Yu8edzrg6g/y6OhKRfU=;
        b=X+Fmjh95QcHRUEcwh/H89W6anORVw5TQuSOC6lb4nTjlgW5KaxmDCZpsc2ouzYRoTB
         KpG5RsmiFGUoZCl4BPr0zO7xXgqJgysjWJ9DuRrsP7KddpvCyt1p9ld3HFQotE1P4MO0
         xViMOYKbC/xgtVQGYU4kXJmtQf+yu7BAHvoeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6zChaRXWKGKCK/yRFrR4cl7Yu8edzrg6g/y6OhKRfU=;
        b=CdpzyaEEPJZW7Bo9fqcqXS/QBsPnAfSMd6eG+u2z38pRiiuAfTpiAWZL9XCHLiNh5Q
         r+wAAl/w7SALvrUwrPSPcDwH/pt9t0x12+sHwFql75YXSvB67Ek3I6v0NPNM4z5pag4p
         owX83gSuxHMR+BKWjJK/l3uDFXJO+VpLyLqczQoGSHu5jQGWyINLshM5eJ424KdJZKsk
         3VmIdanzLoN9lGtmANkLo10GmaDdWoL4hQmgBrdzVFP7fMTjvMU0PHPIbnyKZeJ4Uvvk
         mr2DNCnqdJk+VTvWG2AHUGAfLcQJIBo28ILoVH2VRp1Yas1gweaWfQeETRrNqNYtm/qV
         rXqw==
X-Gm-Message-State: AA+aEWbIpMHRgeGo5kiDDagPEmD1L0gp5xHUlWLSIjYbf4L/gfsRPY7j
        ZRUGD7VPm0NiF9KFZ07gVcjZllButSnrdt2IIRr25A==
X-Google-Smtp-Source: AFSGD/WgSzWwmWu6+yyEjHi/JVawCSzVFp6Q28mLniLtpzaPbaisq5MHxmyWj/mgCG312JdJwKIwBwD7s41WDRmAOe0=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr854752ljp.12.1544174216309;
 Fri, 07 Dec 2018 01:16:56 -0800 (PST)
MIME-Version: 1.0
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com> <1543509663-26128-4-git-send-email-christophe.kerello@st.com>
In-Reply-To: <1543509663-26128-4-git-send-email-christophe.kerello@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 10:16:44 +0100
Message-ID: <CACRpkdZuR-Qud1E6sm-qWx1knWx+1_J1rxT+COh76z7BxYjz-Q@mail.gmail.com>
Subject: Re: [ v3 3/3] mtd: rawnand: stm32_fmc2: add manual mode
To:     christophe.kerello@st.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 5:42 PM Christophe Kerello
<christophe.kerello@st.com> wrote:

> This patch adds the manual mode, a basic mode that do not need
> any DMA channels. This mode is also useful for debug purpose.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

This is a bit of drive-by comment, but "manual mode" usually
means there is a person "a man" pulling levers and pushing
buttons. There is nothing manual inside a computer system.

I think the more appropriate term is "polling mode" which is
what we call code that read registers directly waiting for status
flags rather than relying on IRQs or DMA flows.

Yours,
Linus Walleij
