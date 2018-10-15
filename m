Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E47C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6215B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc8VvMPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6215B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJOVtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:49:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41519 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:49:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id c32so18983019otb.8;
        Mon, 15 Oct 2018 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Po7VE+5iLeu9HaINSuQBH26SMou1uRVrwVYXxQfTSlk=;
        b=Fc8VvMPU7jzyCSGvw4gzw+Pez1ffkHM79oyv/I4ueXExE7RoyFU9hBzycEd/SjzLLz
         mdwHTGm5LWZqE384mTRZWWyUu3xmwqwcwyQ9sF2LXijOaWNgnBWejFQUrzQahsLF4E3C
         7crmrxG5Aq7K4JtzXVRJ9gcWr5tYH/cp9qgOFTTWGjDNhpSTsmSSoQnvsjLq/fz2WT+6
         jTB6Y8zvdc5f6Phtkj4KtIYjTRhjRWyiWmOKIt28mRpnH0ujCSsmOX27wrz1I11JTEOo
         PQDxv0+6XQ+CQMP7K64iO9kkfyeKKkgG0UJ8B5s6NxmxaRpFq1hNoAsNeE1DnsCxdTVz
         giAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Po7VE+5iLeu9HaINSuQBH26SMou1uRVrwVYXxQfTSlk=;
        b=l5Gq/FKCvWCZOkkoyIeja4yLgA7TQCNkQ8rnrWT3OoWWdWcVbN4Hg6LlYiPgfvVA+p
         6shJk2ew/X9+q+dNFE2XkUO11G0geqsCW8auBxMwD8knpRPYl9MTq1TQLNovTxwkpSza
         1klj6LlhRSOYcbNsjQgPQksFDH6ibSbyhm7u1Va+Y1d0aVwoehI17/K8B0JqgBzu6YsD
         TxaKLLlIvZrLQsuJU3iPXcRAsoUIw7OIGY3oRBE5LOQdiKlmc+KWhRGshixEjTSxhFb2
         KHXCjyI0S18ZuAnOxIuc6904W0rz8at4/rszFwqBiY6KFW25JJx23o7MaRAeBHGB2rKv
         Or4w==
X-Gm-Message-State: ABuFfoi55fVw1rGs98775glW/Q6TOd2YXMCCxeYeUROkcwz44AyQW5+m
        bsAhjHUGv3A1Yey65lCAlGdv74hnRKwE6t6dNus=
X-Google-Smtp-Source: ACcGV613dNpQCnCXkxWXbkTMXysJmpBe66aYVR/KhkLwkOYvY/CkD5HtBZyfD+ZHOMp1tClz4a0ThYsGHMTK31Z+l7Q=
X-Received: by 2002:a9d:2a67:: with SMTP id t94mr11619960ota.203.1539612238705;
 Mon, 15 Oct 2018 07:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539609921.git.leonard.crestez@nxp.com> <275ca8850bd5863f79bcafdb11cf9544318a691f.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <275ca8850bd5863f79bcafdb11cf9544318a691f.1539609921.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 15 Oct 2018 11:04:05 -0300
Message-ID: <CAOMZO5Br5fXGKQAUJ3jPJWzwmXNtb-9NCZEdfhrayYJ1iXZVuA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta Neag <horia.geanta@nxp.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:28 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> This block is present in 6sl, 6sll and 6ull so it should be enabled in
> the default imx kernel config.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
