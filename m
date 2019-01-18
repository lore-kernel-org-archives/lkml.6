Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB0CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453F20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJDplZm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfARKnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:43:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42722 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfARKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:43:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so13951646otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3fS0669xseaoyP2fKku7tvDoFkSyo+RmEdYhFaN15A=;
        b=EJDplZm7ON7P+AFr4fUFNalSmfK8zEGd8AGEs08SxnMCJKG7+z8OzYOlpY3WUm0Oph
         eFJ6/pyIrY3c66nXgfclBo4qlUZayZ9D77of0hAeAuPOCSUaxCSCqW555KlLyT1QW/6y
         D5hEAddxPdS3iujFKt1AseI0WQxE1FMWe8P9UF06kMDDRBufJkmhmYg2M2MxPXOkktjr
         zlMAB+PzSv8Wj1W+YlzguOks8SC6k0Iuuy6VgE53z5utNudW3sglpnSi7MzjaanHpYGs
         LEo2y9niFAGggENfo/LX4iBl3sQj9WSVWHWKFB/NLF7ezvOBLCXHVe/U5Fk0+lEOWw3m
         +Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3fS0669xseaoyP2fKku7tvDoFkSyo+RmEdYhFaN15A=;
        b=CW//glgVvNKzwD0coUs66RMqA7D7/AR1BAJAp8uUeOyM6rDHwCG77u0xhNwFrwEKb7
         dnznJQcEw4jNHah0o2+kQhJ5uLBt0GpBWHWB1V1FOlPJ9LAJjmQSHhj1RJPDpsAhLMuS
         kjtGg9Vk+TgrqEP0eR+a3/BcHGIXNZQG1uGVahN83idaudhSnTOYMBW20jtwEtlbBXe1
         kSfTF4aiNYkb9OBbMalEfa6Q/1Dy5Msa1E6ULZQ1TXKuFPjR9Bnb9bJhAILGi7WAR4qh
         oR42JX07ga6737460vfasDHLTMydsrnOMMxWfmYXrauREEBTGwYrOIKfDjWSyjhUSHeK
         XSZQ==
X-Gm-Message-State: AJcUukffWtYSlHqIsnGqYwyFFW2Gf65pzV6LOd4jmp8sgTWeCAph6Zog
        T3vYOdeonXLb/kE92u0FtKDUehD4QVFXCeqmr7o=
X-Google-Smtp-Source: ALg8bN6BTZK939tM5y3fQw6xFtf5tWAkPr33tFIrLscbwy6tALhffuGoqvHOxOnlMrLpyyvzRbkrWcmPsI1Rvxq7rWs=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr12215243otp.225.1547808200059;
 Fri, 18 Jan 2019 02:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20190118090656.14201-1-stefan@agner.ch> <20190118090656.14201-5-stefan@agner.ch>
In-Reply-To: <20190118090656.14201-5-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jan 2019 08:43:10 -0200
Message-ID: <CAOMZO5BSxm2D3u7ns8G8EEi+jHG3EX+6Q52Sk-1cptJ0ATVL=Q@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 5/5] ASoC: imx-spdif: don't print
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
> Removing the goto would not be strictly necessary. However, if
> code gets added later, the cleanup in the EPROBE_DEFER case likely
> would get missed.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
