Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0789C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F86C2088E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gv5NZQSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F86C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeIJMM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:12:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50786 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:12:25 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so28260290ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWrz/ur31ynMKXRg4JBPspIIKYDSm5ngQgyKxmimXH0=;
        b=Gv5NZQScQid53867VTltYumI5WH7G+EVAOkLCRz1SpW2PG9kFZwlDyMbcB2pQ63DJ8
         9Fwbinrv5bRokVRlYRp9A/H60acL4Sj5FsrV1qcJSJ/Ayq8Qjt3RHYO4wQu53aRdk3VB
         jVeKuW+O+v1EdhjcqXJsAqi4V1jcI9EeZMd4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWrz/ur31ynMKXRg4JBPspIIKYDSm5ngQgyKxmimXH0=;
        b=dnf+BuQIIXSYU6ZR+WwsvCL35c6OTVbqnoM1CUzesOLOhPAPFoUV6IqhbQNKQT8jNA
         XAPr5nFxcA10UBriNssM4jPfv+Ca/MydlZa5wwO7HL9sHfmOCs3G4hswsjmDGaOYkibC
         JAmqEZQ91WhfpVelUnmFkJDSs7NNMxWXX5GRaCpS3Pk4RAZzVcUXahHZ3uOP8DT7fXHx
         y+T3lZBaixoJl5x7fpzO91UBqZzlbijghGbswAUT1YxUYE7oQ06vFJRVmZA9euQGEKvS
         TqTlJyqdEVFdFPCqCi7ylVCIoM96oqwEIgDG1ESyyOEcgltB9TUz5MLw+0DuLMLihZmf
         C6pA==
X-Gm-Message-State: APzg51BqEgWokh17jHnCCEc2hDUIh+djsT/YGmgk9PFEJlRJQv/QzVN4
        lUl1xgz5K5J/CJChnRz4pS5Njzg4yIiv1IDd2pl2ZKgqyk8=
X-Google-Smtp-Source: ANB0VdY8gxkuQqqI1FGkzuA1GdJR894FAgbSGVljq7hB8608HmkmbbZrDWMx4RD91AjioSvXiPvr/egPtOVMkYJTC38=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr17201274itd.130.1536563988585;
 Mon, 10 Sep 2018 00:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <87ftymqdzh.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ftymqdzh.wl-kuninori.morimoto.gx@renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 09:19:35 +0200
Message-ID: <CACRpkdbGYt3UaWBgq2R3Ndhu2TchYBr_=LdixJHYCOhvBP1aqw@mail.gmail.com>
Subject: Re: [PATCH resend 0/2] irqchip: convert to SPDX for Renesas drivers
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 3:50 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:

> Hi Thomas, Marc, Jason
>
> 2weeks passed. I resend this patch again
>
> Kuninori Morimoto (2):
>   pinctrl: sh-pfc: convert to SPDX identifiers
>   pinctrl: rza1: convert to SPDX identifiers

Send these patches to Geert Uytterhoeven. He picks up pinctrl patches
for Renesas PFC.

Yours,
Linus Walleij
