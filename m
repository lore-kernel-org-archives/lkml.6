Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC1C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DC5206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545058568;
	bh=2wDGpgWI2SiiV85khxVfy0JphS9KHxDQw6lySVjy4+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RbmPU/pDDcIfJ6fRc7qwzpP/v2llKvKP9TO1RBvTP7jcCGjBXUEdKejIbDM7aih7S
	 AYRBzV5fepeAI7ZEReJMJU1k6Bv4W+Q5Anqzz3ML5wttTgGDyC/TH/h926aWg6Er+A
	 uFnCG/i8qKrQy2hf/A8UJFBw9Z/dlA8r/dApU+n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbeLQO4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeLQO4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:56:06 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A786A206A2;
        Mon, 17 Dec 2018 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545058565;
        bh=2wDGpgWI2SiiV85khxVfy0JphS9KHxDQw6lySVjy4+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2khJL3B594nyDHrrePnd/0CO/5AHGa6L7PRAr1cFto63SdfCgFvRFhBVBDeCznk/a
         qBwe3+V726GnWgwYWGLbVIHd0vt0scbbVC34FQTHEYJJZCbyxCNGQq3nVbModRNEgC
         KS3wMKFD2HL+EnnxJPnJG1MHT6qa5tHYPXXlUCFo=
Received: by mail-qt1-f182.google.com with SMTP id t33so11588131qtt.4;
        Mon, 17 Dec 2018 06:56:05 -0800 (PST)
X-Gm-Message-State: AA+aEWZ4PRtVb3PixlTovwbwwMmdAi/2dsurdS03sM/8ABus9O+8FTlW
        IlhA+W70yK5wY2tW4SiqQoOzJxU0lnf+4r1oYA==
X-Google-Smtp-Source: AFSGD/UxbmXgqXahXjJeAK1MGc7SvJeZrQ5wPrlhre8TsaaC9ksbfQhnHoTMhfJwAHBtlDta6cIlcAKCU0lDyArpruE=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr13838610qtf.26.1545058564930;
 Mon, 17 Dec 2018 06:56:04 -0800 (PST)
MIME-Version: 1.0
References: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Dec 2018 08:55:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+NKtKcV9xzSd11vZPfQWUVJMSQx8BB-5UX6O_4ptV44A@mail.gmail.com>
Message-ID: <CAL_Jsq+NKtKcV9xzSd11vZPfQWUVJMSQx8BB-5UX6O_4ptV44A@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] dt-bindings: iio: magnetometer: add dt-bindings
 for freescale mag3110
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        olivier moysan <olivier.moysan@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Phil Reid <preid@electromag.com.au>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:47 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add Freescale MAG3110 dt-bindings and remove it from trivial-devices
> dt-bingding doc.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/iio/magnetometer/mag3110.txt          | 27 ++++++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.txt        |  1 -
>  2 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt

trivial-devices.txt is gone now as it's converted to json-schema. I
can take this patch thru my tree and fix it up.

Rob
