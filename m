Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DA5C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA6020652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ/OhRVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA6020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeJVUzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:55:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36072 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJVUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:55:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125-v6so32050301oic.3;
        Mon, 22 Oct 2018 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jE+SCTPvm6VCF+wfI2cCT3bJreG4cqCze0iU0TKfR2g=;
        b=VJ/OhRVCR+WZJ1hCSxETyv1ouhGOra98h+p2WkKQdALKaYFFMeKuGTtkvRcYQwFXU3
         ttUWdAaLBdmEpZrnrPTtCdgG4z081grX+ecAgdAUStt8Uy/t7xRND6sCnOZELc2njGG4
         nENUc+Sc8SXl+MJst8RiFFRlw3iVBU+er1R/vCz4iCe7PL7GKfKni+TBFFKdyCWjwRT6
         M6GjCT1rCicbDqZm4p5K5AJNj8hIWtvIbNMbIXu0B9W5BFql1QkH9nQnhTtVXQDoIAf5
         FAUx/ay1CcIz4W5tEdICjG6+7VaDnZPLss15iVluYd5ipXHVm5Krc0XOA3npoSanDMWn
         BhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jE+SCTPvm6VCF+wfI2cCT3bJreG4cqCze0iU0TKfR2g=;
        b=NmnJ2nw2UXwRIjOcMB36oGuCbVLmRJsz3CAD7mlB5Hw1KjLg3bfhvwj+mnfXYBVGIu
         Y/lb9x/SaUCWzOOGVicnjpV2WGiiIVdqp8syts0stgbSEo69/u26sX0HcQpqaSDFii8x
         /wragn6EAK3Qw3M6YZWRUxb4o/Qt+iggFKZG3MVEeI8+tbJK9PORjoIU41vQLahG+fp2
         QBpLvaeC8akRRuoT1x8wqASN3NlZGa9eDtmhXgWc3RUPi+8djoPXWhEGa8gbbsQOD7ha
         2x1gZW5kdh/X67K8q1tiHMhczWOVSVj2yp7wXyNQ+Wh8RPSbKSv0dmkAYk8/rtq5dJlc
         2KGw==
X-Gm-Message-State: ABuFfogHvisaEyHHhScpdNeTvy9rZeLv4RODxr20Qkw0aptVOV4e4DkY
        V615U+bQ513DUZJDkkEzN5VOqRd0aMXmKiGEuyw=
X-Google-Smtp-Source: ACcGV61FyDx2lcLI7z2L4qaBNWHlXF3SaRlTT0I12pjXiC3yFZrATHLThxaJItUNzbNQ7krrWE0qXFw1dhYBsdqHl7Y=
X-Received: by 2002:aca:3006:: with SMTP id w6-v6mr24865798oiw.342.1540211818799;
 Mon, 22 Oct 2018 05:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com> <1540204399-12982-3-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1540204399-12982-3-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 22 Oct 2018 09:36:56 -0300
Message-ID: <CAOMZO5BhwsaLOG--kdpk4XB9jvOpxvTxx7rP22Ns9HZgrit83A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: ccimx6ulsbcpro: Add support for Goodix
 touch controller
To:     "Gonzalez, Alex" <alex.gonzalez@digi.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 7:34 AM Alex Gonzalez <alex.gonzalez@digi.com> wrote:

Please add a commit log.

> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 19 +++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig        |  1 +

Please split this into two patches: one for the dts and other for the
defconfig change, thanks.
