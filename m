Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87291C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE3E208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pm4OluYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE3E208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754881AbeFNIfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:35:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36793 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754834AbeFNIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:35:32 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so7596440itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bhVuv2mslLrrZ6jcD0uKZoUkkwT6Q+PvF1FUuv2rMDA=;
        b=Pm4OluYGjgPlFYqmsDbjRi50p6hGJOLyNbDtNJmZfFEtwdFk4TC9/+oXym7R6q8MhB
         5f64oIlUx2wqN9vtVwtDegi04eYlGDNFrrhrVnFzFLI08UMvzEBefLbfuHuvLZ1qh10W
         /3m4be9cmm3PGLUb2e3s+R6/N8xRPRz1xOzVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bhVuv2mslLrrZ6jcD0uKZoUkkwT6Q+PvF1FUuv2rMDA=;
        b=hqMsz/pXosiiAErd11D8jHOgw1tEnRk69dL0uPbfSIQ7R3zkQ/rf0KdSeT8zaw9ciY
         AFo5CqcTabeMB5+L9m0A5y0eHxj2wFEic+JNEox8nNzkP18ff0MGZkjkbrwlTxNfocCF
         7ssL6FNozLkuMRbBTnnRxrJesTY+caOSXJE1/22acuLQ1Ppt87QzkMD4i59CNNIjIJ3Y
         fYk5EnNXOnx1WHQa+u80wAPYPMtGNi2NkvvafLgBR8HaxW+4H+N0k6WGFTfh5PaEbKg1
         +d5mv3LkFuAVnuPxSzr4RZ3ma6bjKvVMZZ5W5w6pEZ+qHZfFahGYkdaOg0FQqgYSGX8k
         qccQ==
X-Gm-Message-State: APt69E3maYpHnT8a7mqt/49h2AncgRazR8dQdvGbLzaBpgBRC1FHfgaF
        R5SrWHJX27PNcjQi0za0j999ljvGZibWk5+WKKLe2g==
X-Google-Smtp-Source: ADUXVKL8JhenpMABdQ/cKwwR2CkACdFiQCYuMZn8jmIOoIInwiMBgEYZKszaIBrhWzeqIzbDvwK51Ovydrm9ueAQa5E=
X-Received: by 2002:a24:19ca:: with SMTP id b193-v6mr1378523itb.135.1528965331963;
 Thu, 14 Jun 2018 01:35:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:35:30
 -0700 (PDT)
In-Reply-To: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
References: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 10:35:30 +0200
Message-ID: <CACRpkdbMogW3oVv0NEX1b622H8g4k-3MtzLONhog5TKsPn5qCA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: actions: Fix uninitialized error in owl_pin_config_set()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 12:05 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> With gcc 4.1.2:
>
>     drivers/pinctrl/actions/pinctrl-owl.c: In function =E2=80=98owl_pin_c=
onfig_set=E2=80=99:
>     drivers/pinctrl/actions/pinctrl-owl.c:336: warning: =E2=80=98ret=E2=
=80=99 may be used uninitialized in this function
>
> Indeed, if num_configs is zero, the uninitialized value will be returned
> as an error code.
>
> Fix this by preinitializing it to zero.
>
> Fixes: 2242ddfbf4d699b5 ("pinctrl: actions: Add Actions S900 pinctrl driv=
er")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch applied with Manivannan's ACK.

Yours,
Linus Walleij
