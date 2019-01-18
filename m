Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC01F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlYfjfg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfARKlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:41:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38969 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:41:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so13954886otl.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Qbhs1o3pEE6bXtc5SCfqyfCRL6vVUNKCsKMrUEaOEY=;
        b=dlYfjfg2bADA1jJn0imuW7oMotC0GrZbbVLyPp1h2QXeOUFN5t3O/5DCb3v/iY0YYN
         RCI6cxE3nTzqXXYIJdpIF3Il4QNGkyvnnu2b7tcpP0YImBI2s8FvDCj6/m1lOdA54ayO
         MOhBqw8r5lXU7ENfTo6DTh/mfk1n8yDisds91mYE1D7BYrwQ78ZzU4u03xqVLgQFb94e
         wb1n8w7CDCTDE30Ufj6fKFKUaS1PjHiaFXox3g5O1IT9vXBlYcPR/ih8e/XougQZCPb3
         7jqt7h2HdLYwbXKUbfMOft+qW2CY+NRJCwjKVcmGxeuXgwCOpHnCOSkKZwuzbXFdFe+B
         /gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Qbhs1o3pEE6bXtc5SCfqyfCRL6vVUNKCsKMrUEaOEY=;
        b=qhbFPTsdKOnkkBtsXGXtUfGlE72bwGhTYpdWB7QxHC2UgZ4r0eu5duaHPdfW+1R2sC
         KQ0qBDJJqknnR7Z7CwweUp5jKLUs8oQFIWlRVsBsJpa1r3l2ps+WLj6PI3obAESgSNX4
         ujJzZFYHVij+I5hjoz2zIPGX+V5r5OYg8MSMLARmnanbRtnOGdkkb47xUYRuTEFMf1rm
         FSi1u1Ju6t47DhurbVSRMbK/6ZKmwEsnWnhNZJ9jj872cYT7ljqv8x3pWtD8XG5P0q4I
         hBz0cD/tR0ID4j3L1CsLbaMBA/4w+4KIOtOdK9v4as3uGfy6tezheDC30wSdZ8ofUDKj
         NZ2A==
X-Gm-Message-State: AJcUukerVNnSpSjRzH52GXuD+iYnT36CndVK2Fea4i06QBHJU62IOrbB
        3uVzOEhm4LSTsYMbA82Vx3PjxIss8DkmYJ5KJFM=
X-Google-Smtp-Source: ALg8bN4FvHGqNuJvKW5nMddyOQ/QYD3/+EZwJbVv6xI93vNkkus0UVbT8BmseMbZ7kcoC/J+c2ZSnwW00FT3b2iufLQ=
X-Received: by 2002:a9d:5d2:: with SMTP id 76mr11118861otd.78.1547808095162;
 Fri, 18 Jan 2019 02:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20190118090656.14201-1-stefan@agner.ch>
In-Reply-To: <20190118090656.14201-1-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jan 2019 08:41:25 -0200
Message-ID: <CAOMZO5AmnKP1XMjEi5UKW-cOpD=f5uqJD=+KhFMyydHCnmSsSg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/5] ASoC: imx-sgtl5000: put of nodes if
 finding codec fails
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

Hi Stefan,

On Fri, Jan 18, 2019 at 7:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Make sure to properly put the of node in case finding the codec
> fails.
>
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000io  clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks for the re-ordering:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
