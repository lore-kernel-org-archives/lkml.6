Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99DCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2120865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcN2S/s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA2120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeK0B0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:26:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39843 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeK0B0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:26:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so4346186oia.6;
        Mon, 26 Nov 2018 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMgiYS/ocxZXr6hfcNqt+1X+5le6ojnPLaFXl4MCScs=;
        b=hcN2S/s0G1UtbXGZBryZTVsCvOUkcUOEtg9+lr1jyVb9yB5MMNrA7z7O50r925Jr/x
         2LYse40aE3r2xBAyqBQCs4l4Lkalr7zj0lwsThyBcQP77jBEG8ofsbT/BujHLsSgKIDf
         ZlhenP2LfIy5hJoyvMHE507RKswoiM1RE/I0OOE9Cy+3k1MR6Z4hWc+kx4TCKrdRCKjP
         58nucoB/vaeV1sx93Yy0jAp5xRf01AEWDwmvMbEe/Mlmee679WwK99iw/hzKquNm6BnD
         fWt5tBF866wRvpxZAwDNtpzlzFstRAU1ZbxMYDkDE6PYsloGkHgJ+X8cJf+H0tzip44b
         IzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMgiYS/ocxZXr6hfcNqt+1X+5le6ojnPLaFXl4MCScs=;
        b=Y3XwyGJiS7mhGqtoHcHLgGjS0oLKQjRxkkAHlf5x7YXJ3S6VxQ1cYoaqpQ3kEY1WDr
         y2QQWteotjDOZmTzUjwXBJl2bqmuMqfzCRuZOZdDTKKgUp8J4ZeQgsQYaHtLrTqxK+up
         exTeO4AzZkCzqAuuqmqMitOeieGIR+oQj8T7h/1uqfbnuriLcVfyuqsmGyal9ejtC8+P
         2a14epetPtveCI8NB5Jhx7LVyQhaFFp3R4Nsoglq9K6gGf+cbX+Q8se4XmXgPd+or1Bk
         JjuN8m4IFLwFT0KA3gcUsouJ+uoVghbMtj22oF1yrXxQwE54etcDSW+baYuA1TL0Z/D4
         gvUA==
X-Gm-Message-State: AGRZ1gJ3qwJGvIx7peLo24Hnt0Fs2IaIu7je60Q7cy0VLkLjCMRpeUuO
        9aBh5oxves27Zs/EgOCqN3x+HQAHozgNtoNyOgo9rg==
X-Google-Smtp-Source: AJdET5dO3uNERhlTmik4rA+wGecpR5Is/ada1OxydvA5ehtFl6akUEtr/xVzgQEWkt02cfz5iRk6sA8dK1ecP7piYBE=
X-Received: by 2002:aca:3011:: with SMTP id w17mr15813917oiw.342.1543242704146;
 Mon, 26 Nov 2018 06:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20181126142133.16966-1-govinds@codeaurora.org>
In-Reply-To: <20181126142133.16966-1-govinds@codeaurora.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 26 Nov 2018 12:31:40 -0200
Message-ID: <CAOMZO5Dne5utQ6i+n_Ab1=9AG7WYcZRhq7GY72rqyEdyau0swA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device node
To:     govinds@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:22 PM Govind Singh <govinds@codeaurora.org> wrote:

> +
> +               wifi: wifi@0A000000 {

Please remove the leading zero. Building with W=1 would warn you about that.
