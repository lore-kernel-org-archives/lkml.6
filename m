Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD36AECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFD220658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIVQOEb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFD220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJTAdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:33:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44888 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeJTAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:33:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id p23so33720145otf.11;
        Fri, 19 Oct 2018 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwEQmXWzA3d0EklGgPppwi1VB5rwYkvRzzissq36qWM=;
        b=dIVQOEb8POgngXvUKYasHxNVmMR8Oa1nAj3tJdnaeYgT2tFqMNq0ITcYo6shYHm1J5
         N1AczV+DMXErFeJYUjrXp2s6juipCTaklocHQ/XPgeatlGH9zaJCdNvXi6HvPYPnE2os
         fnuOYb4JGtVKCBSaWu/ENcXN2smhMrQsQ/DgDR93SiOWsk0JIurvWd7I9Y5yFGTFQ8rm
         RBOLTDtOKq8Qrr8ppF5T6iLVxXmvfH98+tFrkEwNC4yB66sFhm0EZXMt6q6/joftmqHv
         IkjG7p7HOdBFpDalRKYryCr/27dIiOFfpX3Cu0q4745E9eBOF4r6NdJNDaxgldK0s/hy
         8u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwEQmXWzA3d0EklGgPppwi1VB5rwYkvRzzissq36qWM=;
        b=gcvHq2TnjI4ziySpbRzIvkigrOV/LRWZNhBg282sT9lhYhsRB2MZQG54Au82JFNpsb
         gdq4/vppKVZxtuQ7ON2+oAQ2monxbcHePwjUdyua4fQVIKqA731G50LVXhReXs2O+x/b
         G7GQcMJPZzp5Yz2K4PRiqol02P0c38vqUd1Y4j1ReIavplO5iE2mQ6y5JVSDJdnGhFeb
         qHytcc0oFuSdB7esyo8Kn4yAvIVsB7HAOpyFWfiVKQHlgQL/N1YRU1JR6Sm07ZR1FuoU
         5dVrUrRMBqS+EdmqG6OuXR04tcdRHAhr3I6ysro9ZzFMI2CrjoCCa4J99IYy/J5kZ4I6
         bnsg==
X-Gm-Message-State: ABuFfojxZpIgKRjFzgX/CVlI8YshXAmns91xHx869HcMeEWoC+JXhs47
        212ywd8RwnhoNHZacL0nlSOhWLR4Pz6hJL1xG2qc1Ikn
X-Google-Smtp-Source: ACcGV61I0doJUfaB1od2rQ65bOld/oCWoi37LPnnrTzV/lMWWUhRYwv6sRckDEeJCOW/Dy3vcJ+EaFu+oiMtrnYXEBw=
X-Received: by 2002:a9d:4374:: with SMTP id y49mr22039917oti.287.1539966388124;
 Fri, 19 Oct 2018 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <1539962141-32418-1-git-send-email-alex.gonzalez@digi.com> <1539962141-32418-2-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1539962141-32418-2-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 19 Oct 2018 13:26:20 -0300
Message-ID: <CAOMZO5BwqT5Y5xECqnLx6K6Vv2gur4HV2g6zJDJyDot5FdX+KQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless
 SOM variant
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

On Fri, Oct 19, 2018 at 12:17 PM Alex Gonzalez <alex.gonzalez@digi.com> wrote:

> +/* USDHC1 (Wireless) */
> +&usdhc1 {
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_wifibt_ctrl>;
> +       pinctrl-1 = <&pinctrl_usdhc1_sleep &pinctrl_wifibt_ctrl_sleep>;
> +       non-removable;
> +       no-1-8-v;
> +       bus-width = <4>;
> +       status = "okay";
> +};
> +
> +

Just a minor not: only one blank line is enough.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
