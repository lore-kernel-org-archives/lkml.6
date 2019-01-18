Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEC020855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqa+S31i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfARKmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:42:47 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35458 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfARKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:42:46 -0500
Received: by mail-ot1-f46.google.com with SMTP id 81so14012333otj.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lA1euusP2mPLKLhFrW24JXMPb7DfqCZVnQAvm+7i8AE=;
        b=Uqa+S31i+ZNE4U8tJjcN6UlTYxb29hOxoL6a8+KYtpAvegETtqg4c9ad+YSgeKF6r5
         MjdVFbCy352JpZhH08bY5u+TLQozoDwC/Y7jvmmkHnxXMK4Z3tPPaGPMClzvHPW5vd+V
         +PUzarVfyyLPBgqDRx35SjSGagBrRYAivXV33FlIniXHr6qF7Aiogi0XAGDbCSE9Imi/
         7hSTGK/Rnaex6Nl3HJ3nzPaGykcaNqy57bW3f0MnlpWeq3zPml3tgY6pKk3gWM2NC0+P
         gb96owjl4kesH0uvdHF4IHl7wGTqqNV/oRmgoKLaEPTcNBftldvCGByPJbj9Kj9f4oB9
         UMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lA1euusP2mPLKLhFrW24JXMPb7DfqCZVnQAvm+7i8AE=;
        b=EbIFjDABpTgPuNwZCh+6Zc9/V4TwlWl+irGspoDtBSg/XHjngSgrkcbPa32aorkHF/
         v5n7Vr4ucx9WNuspg+u8IVo+Ft6g4tC9bZdQuQ0j55aYkaiDWlgbfzkNprwZ0j6RJMER
         +5TNdFan8dmDqCOT/1FAz0yVlAlJV5UKUyxft7CJ8+feOws+31hLzJVuDDCWSaUdDcLc
         buY98xkWT3Bh3QN1PSWu4eVlNj90T4o8Tfzf7TaivyT53c18p/fmYa7oc7qT8eQsZ9Yf
         +Ieh29t9donJRf10tZxNzPG3i2GPnA2GGR95A/HjuO0Q0vv74xoF2mEQWqefWRoKpqPY
         dGLw==
X-Gm-Message-State: AJcUukeaSCoAPzfqZhFs6WjfohL24vkLwcZCqmtGK6ypXyxy11GUTS28
        3og6wWyxZ/JmUU7b2B7yyZd34JOiepnDOkOnhho=
X-Google-Smtp-Source: ALg8bN4x4ejmLJBJMU8n6CAe6+UpB1B4nTsf1bv5U2UJNttip0cLgYH52VnAyacRpYggKmcM39jyPkG9ySnX6ItAEGY=
X-Received: by 2002:a9d:721e:: with SMTP id u30mr11631319otj.203.1547808165594;
 Fri, 18 Jan 2019 02:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20190118090656.14201-1-stefan@agner.ch> <20190118090656.14201-4-stefan@agner.ch>
In-Reply-To: <20190118090656.14201-4-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jan 2019 08:42:36 -0200
Message-ID: <CAOMZO5CDhEUnndEcfMEWCWBD9JF61FxNC0_6=r+58dn9oWbyrA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 4/5] ASoC: fsl_spdif: don't print
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
