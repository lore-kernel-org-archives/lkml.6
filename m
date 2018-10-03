Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F1C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50612082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ui4ebIZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50612082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJCJQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:16:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43172 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJCJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:16:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id s69-v6so3251249oie.10;
        Tue, 02 Oct 2018 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VlXbAaWQ/vPwU2ZVgZ1WkiLfj/rDoQS4BvbORdJcwg=;
        b=ui4ebIZjaahQQGCG/jygtNK1OE+HMHjr92rf8h77giGYChQg+u44+sMCqz4OfjlBMr
         WkhcqW4XjwtjklBfcW7Gvr2KlPqM7lrQlA7kceZjC1Czi9cNsJjEszPKh88wzSpEM+/U
         WuXzy3P+TSMlE/AM05xfN8kEYon+emone7OfFHViwS788XknQHzQm1b/yfeOiTSMiPUw
         LmmoPVvVKtLD27rWrldOBUaHhE+TrdG5QLnG4uArQ388Di11kABn4W6JDp85liUR5gDd
         tCNiey79ezKpXDU/3tHHrBku0uy7IW7Nd8ZqYRSShDmS3OcgTLdQRnhiw0hz5d3Q0vVj
         bPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VlXbAaWQ/vPwU2ZVgZ1WkiLfj/rDoQS4BvbORdJcwg=;
        b=jMhfye/Dp/9TjjyiUk3Frcf7kik69NKJ0z1ugl+XqN0nc3Z+iY/xYB1qaGar6fQj3r
         JmTOXtTP5DyIvzLbX0kzsjsfvpq6Lqkxz9wQgXwCgBKLAesycqhYEXyjkVYGTuhz3FVf
         w4VM/ErnHXwBkGk3cEVWdzofBNl7qkHq1H1qF6D66KdpZtQta2JGTBWMYhFHcJqXjko1
         c2VR6SqKYvyhXikNcedMi7WFTqp02RPrdFiio+JvbRj+9n2JJxLpZobpxsPyvKJqa1sw
         +3dgQUJdXwps3g68mnS04fWxSbUhBg8BlfksKddn9QrMpVpMfRyu6MEm6KMgqtfALTF4
         2MSw==
X-Gm-Message-State: ABuFfojy0YNXBlQkEJE5tgELeOMBln+8jSRkIpTAztKB242FjQKi31OO
        9KqoWA/qoT+WB4Bke/IL0i0tmn55bRuVnFW9PQQ=
X-Google-Smtp-Source: ACcGV62B/XDVUiV8Fs03IAf1+RoX1fkLRYvB4BRVNevDCUL9eVPKhmNtwG2NqA+7rnzh66DaNCTpE42NyGZ/Zk+AkmU=
X-Received: by 2002:aca:895:: with SMTP id 143-v6mr6754971oii.309.1538533811531;
 Tue, 02 Oct 2018 19:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538505573.git.leonard.crestez@nxp.com> <8c75f5c5dab117430313e0cfd4f2af88c9ed3d57.1538505573.git.leonard.crestez@nxp.com>
In-Reply-To: <8c75f5c5dab117430313e0cfd4f2af88c9ed3d57.1538505573.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 2 Oct 2018 23:30:31 -0300
Message-ID: <CAOMZO5Cr7N9Kg2sDgL7evGiCCoBW+_WjkjMDg_fghwUz0WVmYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: mxs-dcp - Implement sha import/export
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta Neag <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dan.douglass@freescale.com, Dan Douglass <dan.douglass@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

Thanks for working on this series.

On Tue, Oct 2, 2018 at 4:02 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> From: Dan Douglass <dan.douglass@freescale.com>

Please use Dan's nxp address so that it matches the Signed-off-by tag.
