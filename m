Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB0DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D8206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFkhdaLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbeLQOep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:34:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36954 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbeLQOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:34:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so11163469lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fnpxwydDvAj68RDMnuzjUKTngPjaUu1Gr5ZSIsieWg=;
        b=EFkhdaLasFqYoAK0oTRicblRLC3jUaxl0x49bXNa3FAI4Tk8BF4MJvOwmqvSfca0eG
         1f/IcSkSJot/dZrssiXIzs6ucJp1YZNc6DJaD/tg0xU561onCXVPSI1efE953SKbcosu
         oHrkw3cREvoRM2kUaLj1SRFzNE9kIqDMkCSMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fnpxwydDvAj68RDMnuzjUKTngPjaUu1Gr5ZSIsieWg=;
        b=fRLic6bF69bNjxOeX+MqCFelYxBkf/Ra1Bn30WukBlRrF3gHbUTnPY7ZFqeFiGthpk
         paT9ReHNO9AbN2gOk5rhTSuD1Jqya/ALYYfNARVSfa+jII5OXyPzmesqttW6P+ovRwj9
         +rmbP62LB9daE8IFZF8qM9/b9FsP9egwBXL2tUiHAWXKyLDsflnJHOnbCi9wz3wCoVjp
         tnWrUTKCP9t/2FfkKO0tZd+ZoqWuw0juR9buiPDnnqVtkKThVS5mw1Kfwpxjvhfg7a2Z
         RugnzukqV8n+T4VVtXuBSon1IANOYQmiLGgR72Y/Shfq5O8UXgrVX4CkUVTz5hBWjBLG
         W3WQ==
X-Gm-Message-State: AA+aEWbkHgVF2It8nTmGm21DrCeZExNa1fR3Ppes2SnFuMtjzUDvnh3A
        VbPLFAuxJ2EWLBVoH4uDBaATk25qk7vc06Hw695tcw==
X-Google-Smtp-Source: AFSGD/WwgSzhWdbfSXnShmWd1N2baE8ee/QYaOHj0bIuQ6U2L/dbJFwvVRXQVZYdJ5smVA4YF7UZtcazhdFyDaUpyLE=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr7685457ljj.9.1545057278601;
 Mon, 17 Dec 2018 06:34:38 -0800 (PST)
MIME-Version: 1.0
References: <1544732294-5996-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732294-5996-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Dec 2018 15:34:26 +0100
Message-ID: <CACRpkdaCUg9pgS3bsuXpdzi3zTB5YYF-R0Be0w4QbaiHspw9gA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: rcar: Add r8a774c0 (RZ/G2E) support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:18 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:

> Document Renesas' RZ/G2E (R8A774C0) GPIO blocks compatibility within the
> relevant dt-bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Patch applied with Geert's and Simon's ACKs!

Yours,
Linus Walleij
