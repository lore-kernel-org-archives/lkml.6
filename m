Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E943C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848452075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLvSqx/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848452075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeKTTGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:06:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40097 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKTTGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:06:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so853150oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kqJYfxRnFQiop1CyETTyAIIILPqYb9mzoIqszr+2Z5Q=;
        b=dLvSqx/Atg+ftvB41Y6e6IStG/Z2hiJWYrdi1+EXg0atsTuG53SwZudggMJRduLLsF
         fItL9SFwftNltcZVO8nZ94EhF499enzW0flWkEdWZ1OfKSQLTa4JB05cW3YcEdw28x+m
         fBbm1Arr955LY2Zuq67jbU3MI7q+uUeY/FyIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kqJYfxRnFQiop1CyETTyAIIILPqYb9mzoIqszr+2Z5Q=;
        b=GRjYdTGi1zfL+XbqBi8tdhgStK8DvS8cAr0hfYunpV+iIJOtRiUzysot317CCgit9l
         fuFRa+hU9opAfnOw4qevyErBErNYbadfx4xlE4vRgbSePpalUmu/6lLu9Mi1ogKFrTa2
         GFPHo6oZtry5Q81CYK5miwQiM6z6wOYSBlxVjdie/xAzKCxqIwg+nrsxZgJubwXlWg7I
         75092dqkJijsoSUEr0/OvGI0mUCEencr7jx8kDOBdKxHsLM7ME8mAyDV9KOvy5fawXPq
         blkOm2JpqvuJ3qlyoNX0nB6jcPphprwZC2izLS9ti7pg0+M1t0sJpu9enN7NAe3bs/E+
         Lfiw==
X-Gm-Message-State: AGRZ1gIp68NNoUDAOeX9Rb1nNZrXcIAPy0fPz5Ao0Aus3+ssH0vnW5gU
        EhAtEcEKzP3EZB58zoWs3gK3+yzeSpGUnUZWX/pgYQ==
X-Google-Smtp-Source: AJdET5dH3mFvHlcJepXyphU2K0uXXmnNxnH/HgzVA7Qw0i0FlRouZdfALwtD8LHyG/E1dQeD8y5teRRaLwoTkXV2Nrs=
X-Received: by 2002:aca:dd08:: with SMTP id u8-v6mr580144oig.94.1542703121752;
 Tue, 20 Nov 2018 00:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
 <20181113095142.32015-3-benjamin.gaignard@st.com> <CACRpkdZD5EurbTRyUg7AWRZqVQ-6rmUQDUmVVCFU3r0Y1bwnVg@mail.gmail.com>
In-Reply-To: <CACRpkdZD5EurbTRyUg7AWRZqVQ-6rmUQDUmVVCFU3r0Y1bwnVg@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 20 Nov 2018 09:38:30 +0100
Message-ID: <CA+M3ks6nnj69KJay=nGS=RP2jEkPa0wibfVkwYN9-CSq=fHowg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: stm32: protect configuration registers with
 a hwspinlock
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 19 nov. 2018 =C3=A0 13:20, Linus Walleij <linus.walleij@linaro.org>=
 a =C3=A9crit :
>
> On Tue, Nov 13, 2018 at 10:51 AM Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>
> > If a hwspinlock if defined in device tree use it to protect
> > configuration registers.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> Patch applied with Alex' ACK.

Thanks

>
> Out of curiosity: what is it protecting against?
> I would guess simultaneous access from another CPU
> but the commit doesn't say.
>
> Simultaneous access from two CPUs makes it extra important
> that all register access is read-modify-write, so I'd have a second
> check over the code to make sure this is the case.

Yes it is to protect configuration registers from being used at the same by
cortexA and cortexM.

>
> Yours,
> Linus Walleij
