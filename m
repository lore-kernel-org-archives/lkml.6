Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 89C94C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404C8208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxD6TBKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404C8208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755167AbeFNLjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:39:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33411 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeFNLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:39:17 -0400
Received: by mail-it0-f67.google.com with SMTP id k17-v6so2154242ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oUm66GOOcjzWsziZPw9G2cZcErAXTNumM3G5C6H8Cgg=;
        b=kxD6TBKlN2PswCEZ1AceTMZ0ftj1WIPbxyGKZLPn+ewjppYiEx7Ssv62HErKvTU0gM
         eMOGiGnr0xeDah6+ZyB+gdjALEfrBGQ7EaBPCsJeZGSs4/K6xrq6nCDwOTOBPxpaJAgN
         79IrTTOo1u65OyvfugSwPJlp1rzorMaKWRQDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oUm66GOOcjzWsziZPw9G2cZcErAXTNumM3G5C6H8Cgg=;
        b=eDES7XepWxICtogqOKsObsqgMueGkstQcrXYl1PU7dBJOG0f4GcROnnwQFXziF9PMs
         QZD5essGSC4fTWOjjphAfAsvBsPzbj1pJtllmj9ws9dBBTSsJ3RnMTW2yjMmd50M+IjL
         ncDaEmuZ4PQUVrxunpodHbkG0/EDLHt0PDand4BGeM30WikT7f257s5L+F2ex853Ugpf
         QcfYooCL97GBU6kPKfoNss2bKmf8DSBWWtGaSGJAzBffy6aJMVaLDyTJ6JH0yyrNfqQ8
         byDRU7NOY+IOeTaQrhCRdALtMr8yBzPNk2ardNnw8zifNWmMqTQwlKMfOwQ8tFsHj5hH
         HDCA==
X-Gm-Message-State: APt69E00gOvuYJTllvuRlEi+N4KDHC08dUgMPYbSR/g2rg1k+wWwSpy8
        hJK5+MLvoc6YQe4gYEc4qagI8SOBtu5dDtgCAMTQ+A==
X-Google-Smtp-Source: ADUXVKKZTCXS3EBV//bdLlKqms3FwPamPmLWG0zb/Gv1AowOXjHK1kz5+CEZq33j8ObYhHfgJ8RXtRA6e3E7uUVpzD4=
X-Received: by 2002:a24:5746:: with SMTP id u67-v6mr1849662ita.38.1528976357163;
 Thu, 14 Jun 2018 04:39:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:39:15
 -0700 (PDT)
In-Reply-To: <1528861237-24254-2-git-send-email-j-keerthy@ti.com>
References: <1528861237-24254-1-git-send-email-j-keerthy@ti.com> <1528861237-24254-2-git-send-email-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 13:39:15 +0200
Message-ID: <CACRpkdbBmEWPZBdKZNiGew5oZmFBgwnEyRG2bjpWZ0FjTEMjkw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: davinci: Do not assume continuous IRQ numbering
To:     Keerthy <j-keerthy@ti.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 5:40 AM, Keerthy <j-keerthy@ti.com> wrote:

> Currently the driver assumes that the interrupts are continuous
> and does platform_get_irq only once and assumes the rest are continuous,
> instead call platform_get_irq for all the interrupts and store them
> in an array for later use.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

This v4 applied with Grygorii's ACK.

Yours,
Linus Walleij
