Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FDCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8220855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKhzwCcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfARKmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:42:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36378 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfARKmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:42:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so13981933otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lA1euusP2mPLKLhFrW24JXMPb7DfqCZVnQAvm+7i8AE=;
        b=QKhzwCcD/RjnZx9934hBfs3nvETRKdzGKTKgqJURDM8m15SzORyD6qY7RdSIDIdAcR
         I3ITZ7XIMYC8etL0kbkTzq3mJoqTNxu8MDr9xGCB1FGZtRNoZPXvqA2zqCQif8Wn/gM1
         xoODf/biZjFhD2q9cGsOL/jBgyGhE67tjtIxVoSVbNeaQhwgmQQU7401VOYOB6eONZ4U
         4fitaXdsIYi/suTs0Sp0zpPobOofPB0CMTyvQyl4ALtoPLKP0+tbQj4JjLHt/fxtJuJ0
         5+EplOWbA0zYh9njyfknlrOOooTySx+KwVHMYb+94D22Z61s8R8DnNxVXlExNnTEOLpZ
         kdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lA1euusP2mPLKLhFrW24JXMPb7DfqCZVnQAvm+7i8AE=;
        b=cNDtbZv26ZA524DVWbWKwn7OC0OaEcbqj3D5yTKGBPfJQjOZAnhhKTS7Faikc0FjQ7
         ry6qVuTiMlX9OPFZQsiyM2/SCcq/3O0V4p9ARVbXcuL8zV2a5xjoppFys3sln1e4hb3+
         OuA+vglanYO0LW3sjKxLbJmgMvNc4JqNcAhrHZGLW/G9i8Wgnj3gMq0p66ztgCJ232X1
         KVtjNFIot5RbvMSAlQhwhtM8E1BSbgBZaiTn74xo+wowlKuBFwYFYt0cgonGhdK/jgZ/
         cg6yUpk72pE2oBUDVJNJh1abgpLp4jAGoTHvx6RVLb2/ymUT71HkAMeErRoMfH5lKSEz
         I/dg==
X-Gm-Message-State: AJcUukcXQIsDj0vNC3T0CW3W6cLDN7Lln7Ofou/+lLhguqrLBoRD0/sk
        roLL7FefYnqcCVVxtUmyCi3fh4IDqP98g8d/4sA=
X-Google-Smtp-Source: ALg8bN7DbC6QRGhotIqY8aTkBgVf2TNhO3pldoBq3PbJ6mUXKty941IOaUdp2FNnL4x0cIGS7y3G/TR1MJSGNhdZ8yk=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr11080182otl.196.1547808142538;
 Fri, 18 Jan 2019 02:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20190118090656.14201-1-stefan@agner.ch> <20190118090656.14201-3-stefan@agner.ch>
In-Reply-To: <20190118090656.14201-3-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jan 2019 08:42:13 -0200
Message-ID: <CAOMZO5ALY4gk33evmgafK9mgPYWL59ZfTjQjUtKujchHiHkDLA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: imx-sgtl5000: don't print
 EPROBE_DEFER as error
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
