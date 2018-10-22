Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF6C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A889320658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3AEXZfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A889320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeJVUyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:54:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32873 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbeJVUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:54:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id a203-v6so32081626oib.0;
        Mon, 22 Oct 2018 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZWN9N4TDtHlwAZcxQXuzseruTFpp0sQ6eBGKS67XbE=;
        b=E3AEXZfZLMsWFxEBjmGgTVCtTPJU6EdxRlFutycwuohxdAYI3AiFMjelTyIAUxwhP+
         gNipND3tjvL6dONMWor7py5CzNrmz2+6kj/VAFdBM10znhgpVwZk851fIWirmw1W7LcV
         NsdZjG98WtuQAUN70UO9uqNxBF2rO0WQdZ7rRwnaLBgrZDtME3LWbAGj7fdEVBifvsUx
         qkgBx5zKsOy9fr9VAj+tnt5pHlbh8KIRuWe6fuYNGeQwMWsRxIQB5h8Ofj7tvAKPICIs
         459e3XLjV4quJs72CmB9sJFymvWIq9FwDnbyWqgeNPU4tt4H2MdCy8Z7OOGjJD5PQtYA
         NlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZWN9N4TDtHlwAZcxQXuzseruTFpp0sQ6eBGKS67XbE=;
        b=XZMHWHiHcSJQ4v4nHyqts2QaiyIdLnvE3YeV0ZufOkiDAy6pc4y2QCHgJiVaKKkTwo
         qBSjjeGE6+tvVhcD2gOYwAfL02zZonTxeqMYAvkt+YX09pidbd8NSps0nOouAi3/UQm5
         gfXEHZvXwwajnhRyeVf+MHLdm2sove+nvfMmbuUTnvklPbDBNxVeuHRW2Xkue0Nv9sX1
         sLnohSlICXfR2Gm/AhzV7eOZSXQFZgPHtp31AHY6IyfR8Hl5MDISwKra0kUkTg/MkGn5
         D3VnD4AeknfdQniuJavfrxpnuDKrFEyAqr8EWlE/KOngVl4wsRe2K8vNWGmp2jM7HtsF
         dmoQ==
X-Gm-Message-State: ABuFfoisgVaIpmQl011LxGsqbbkiqVLkhb3nexT6bsAzIKu50lzVeCrl
        7SSKwJ+WlyOMMB5mrAWuDYFdATb2W5xAyJGWP9M=
X-Google-Smtp-Source: ACcGV63ZH9gBey9fI/WtmvKt7VBrTnikxuq+92yvwKO+D+9m8CrTOQo9n6N/0y8Li/lsMWNZuXDqCniBZzFsCXTB1xw=
X-Received: by 2002:aca:c7c9:: with SMTP id x192-v6mr22920237oif.43.1540211735654;
 Mon, 22 Oct 2018 05:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com> <1540204399-12982-2-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1540204399-12982-2-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 22 Oct 2018 09:35:32 -0300
Message-ID: <CAOMZO5Ad8DMSq+bs21fqpcDqwzDnEgvnRgEsGUiLxUw87K1QAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: ccimx6ulsbcpro: Add support for AUO
 G101EVN010 display
To:     "Gonzalez, Alex" <alex.gonzalez@digi.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Mon, Oct 22, 2018 at 7:34 AM Alex Gonzalez <alex.gonzalez@digi.com> wrote:

> +       g101evn010: display@0 {
> +               bits-per-pixel = <16>;
> +               bus-width = <18>;
> +
> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       timing0: timing0 {
> +                               clock-frequency = <68930000>;
> +                               hactive = <1280>;
> +                               vactive = <800>;
> +                               hfront-porch = <120>;
> +                               hback-porch = <0>;
> +                               hsync-len = <8>;
> +                               vback-porch = <10>;
> +                               vfront-porch = <0>;
> +                               vsync-len = <6>;
> +                               hsync-active = <1>;
> +                               vsync-active = <1>;
> +                               de-active = <1>;
> +                               pixelclk-active = <0>;

The recommendation is not to put the panel timings in the dts file anymore.

You could add an entry for this panel into the simple-panel driver and
then reference its compatible string in the board dts.
