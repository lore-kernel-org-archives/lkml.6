Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DEA20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XParHtd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DEA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeLFJLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:11:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34904 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbeLFJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:11:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so20093102oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OkFya+LvZuwwjtMnxth+NO6mwN8h2pWDKcOwBP9BysA=;
        b=XParHtd52lOLNOnbWk0D0nST1hHeRzxG1xpdHdNkE9Yb3gtPneWOwZooOdvUaYW86X
         lmx4sLPyoMrt8tk2ey585WPF/bqHLUOJn8KbH+Y4v7+aTOv9OX5Y/kSaIrtLR9A8vWJl
         4ELtC6bKrmxi2PFqmVw/8oCbUMMIqLCaq5vCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OkFya+LvZuwwjtMnxth+NO6mwN8h2pWDKcOwBP9BysA=;
        b=EN3lw780AQw1pee+tv3u8aW49IDX9zKZWYvmT4bMLDPzZqODm2/um9CA1m7U8zyYIN
         6k66LWziP0yG3bMx5zPWZbRYgYThOdf/MgIXFjJboWhILLpQLbzjOAoIbSPAK3VKTUC0
         dVMdgZ1deMswVWazpF6MHsRktq8yKGz8/pLhsYrmgN3TZcQo9vvBTbulUxtN3I/T/GXL
         YpAlxlv0s9J9THwy7Il1wnkmg4yxSdW4Aubo0DKBNXRxUlvB4al8jonPF9zInbZqc3/g
         6GHuGXxv6VYppEVRCcmJOHE3qmgC2JvC4dho9C+trcQojWUOocWKqrTtDbFTsxSu9kam
         nmAw==
X-Gm-Message-State: AA+aEWY5+p+3K+g8um5yH/H5gFezgNVlFceacwFOuzivtLledKn1Ug7c
        ilRp2kkI0+FX1+AlrQLycR3qC7zG4a6NS7+ncPgHWQ==
X-Google-Smtp-Source: AFSGD/V5kI/9KgVWzMk0CoBDzREHKEV8VtER11k0UdWhY4RcgQZ7SiJBBvBNi7bu7+Em8ZfX4gIFbWZsMB2h6R3Z1ww=
X-Received: by 2002:aca:4282:: with SMTP id p124mr16295974oia.327.1544087459581;
 Thu, 06 Dec 2018 01:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
 <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com> <20181206011045.GA23336@builder>
In-Reply-To: <20181206011045.GA23336@builder>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 6 Dec 2018 10:10:48 +0100
Message-ID: <CA+M3ks5-5OWPz7Dan5fO6vTp74NpgCNxRhj1CL14hHSaTwrouQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 6 d=C3=A9c. 2018 =C3=A0 02:12, Bjorn Andersson
<bjorn.andersson@linaro.org> a =C3=A9crit :
>
> On Fri 30 Nov 06:45 PST 2018, Benjamin Gaignard wrote:
>
> > Le mer. 14 nov. 2018 =C4=85 10:00, Benjamin Gaignard
> > <benjamin.gaignard@linaro.org> a =C3=A9crit :
> > >
> > > This serie adds the support of the hardware semaphore block for stm32=
mp1 SoC.
> > >
> > > version 4:
> > > - add Linaro SoB
> >
> > Gentle ping on this series
> >
>
> Sorry about that Benjamin, I was convinced that I picked your patches
> already. Applied first two patches to hwspinlock tree.

Thanks.

>
> I expect the dts update to go through the ST tree, and I guess the
> complaint from 0day tells us they already are?

Yes I will send fixed dts patches for stm32 tree

>
> Regards,
> Bjorn
