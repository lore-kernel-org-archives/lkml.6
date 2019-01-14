Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C55A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ+b1OCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfANQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:58:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42908 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfANQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:58:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so18406127oiw.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WK7Aa51yjPNYYBZGycUVCFb+eqDnPWPGuaHfRu6tTSY=;
        b=KQ+b1OCCkHTDLT5i1f166EPAdzssRohESZQcTb1kXxcXWcjQnrqLmf1HWXiyLf4MR7
         Jp1MTpiQv6H6JYa6Vybz8V0NjcrJoZkch1VZef2y2IKPoaTfcIawK50LhVsRDdOf1Ubg
         kcajqtloQhD2S3EKQEvVDzeVMvz6dxaUjurUYvfGNZYApziNI9Z6EIU1qVFkPhBqwyht
         KzzdS+/RAxcndRXHz4YwbCo1B6VlAzdzeHRBfvst/evg0sIuJ0rhUno3UT0OM02Br0l0
         saV/Wz/efFW2aCzOrFUzAk/6LeBSZMYe51w2LAEnDSGCP/BnezzGZctqq6h7OZHGO5O3
         VQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WK7Aa51yjPNYYBZGycUVCFb+eqDnPWPGuaHfRu6tTSY=;
        b=MM9VkMq6btAGjl6V8EgUYp316ujlfCcA5dG/uAle+Zon8i1QR7/CviUV6n0jahguek
         4+N8MP3sbiw5bmMOYUv8CDep5FFSljM7rork4YKEFCtI+UCM8iQI4qd9H0/+1MmESLQ/
         2qBJz85vGKdqpWEKSA+Gy297vyqJW0vi4MZ9UUeP/CJ63kQkRb1Q5pdil74AeHlUzHhT
         phDpDoojpWumq1c9LegO0MQmvGjhF/mm74CtbCo4FWx3NU8yhK1uXuLpyUPMjf3L0Ehe
         XV89xtkL3ilWWlm97YMGO1MuVQWwjkA5GuF2YWr9mxNAn1DjAxsUI174m6fiS7EqVDLW
         PpMA==
X-Gm-Message-State: AJcUukdhD4QlpM5c+vMO71MP9fx/Xs9nzBiARKosCazivGmLB/Ve5Isw
        0G9ntJbxN8I9rjZISP783JF+9zeccCHDQT0VTBM=
X-Google-Smtp-Source: ALg8bN49KR6CY6mSpP3JEASTMMkA1XMixTuZqEwEHni0bto4FBBTjpaTNkAu23ry8rMkee9KRlxQExtHDqlqsbTtih4=
X-Received: by 2002:aca:4d47:: with SMTP id a68mr15728794oib.43.1547485084029;
 Mon, 14 Jan 2019 08:58:04 -0800 (PST)
MIME-Version: 1.0
References: <e1b63429-30d6-1f52-ce6a-72b1171286f9@nextfour.com>
In-Reply-To: <e1b63429-30d6-1f52-ce6a-72b1171286f9@nextfour.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 14 Jan 2019 14:58:31 -0200
Message-ID: <CAOMZO5CB_b3QbPQRPEW-0ybU1j1Vg1qah0xZhxynf-5d13-ogg@mail.gmail.com>
Subject: Re: Regression: i.MX6: pinctrl: fsl: add scu based pinctrl support
To:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

On Mon, Jan 14, 2019 at 8:21 AM Mika Penttil=C3=A4
<mika.penttila@nextfour.com> wrote:
>
> Hello,
>
>
> The patch titled "pinctrl: fsl: add scu based pinctrl support" causes
> regression on i.MX6. Tested on a custom board based on
> i.MX6Q and sgtl5000 codec, there is no sound,  tested with simple wav
> playing.
>
> Reverting the patch makes audio work again.

Which kernel version do you use?

Most likely this has already been fixed by the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/pinctrl/freescale/pinctrl-imx.c?h=3Dv5.0-rc2&id=3D571610678bf344006a=
b4c47c6fd0a842e9ac6a1b

Please let us know if you still have issues with such commit applied.
