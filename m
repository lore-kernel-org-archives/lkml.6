Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAECF206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/tRj+Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfANRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:34:42 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35854 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfANRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:34:41 -0500
Received: by mail-ot1-f46.google.com with SMTP id k98so20039286otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iZoINDsCogDlsBtTm9onwfox9UQ/Qsv94qIAFZtz2Mo=;
        b=b/tRj+UotVPcCvbk0eEJFGS/w3zWdHT+s6pnyfLRLq8mOH/yoe++jpmApILhxkevsq
         I20pjPA/nlRx/eH7qPKTMQ/nNGz2H+syU9M90hKldtEH+1dF3jiAW7OZ0ix7Qug61AMT
         za3mxScFkTwkxmiqAGmq2XdixiL4p98yRdQIhHUOc7Mi0ym/S0fDZIFqKNGVIeH60G2O
         JM4mNGf+YByTP0IF9QJ/XNS3hjjV5X+YM8a56mRBTJ5ed5vmS6jcy15SwAutj2l6c47C
         CwX7WmLCAe5WK6JX/38HViTECNknzXjGNm5+NzMpR1ARern1yDoMa4Rnbt2v3I4+WvaP
         FYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZoINDsCogDlsBtTm9onwfox9UQ/Qsv94qIAFZtz2Mo=;
        b=HfM27GYONrZ22TIqDJa7TzVNW1JP4bM5ZlrxtBTpBc9I7hT87gLMry9152p73SANMq
         4Ap2+/xcotxnz90K2+o+g3Vy9geiaJLw9P7CMH5I+m5/ny44Hnzb/ZI+wBEfk9H79E1w
         6RG8KSV+ISVcPLJ9Pn7oTT1kzXDfizw76Uq1Oz8uardz/kb7VGrwj40pB9pusYMzyJHJ
         EJZJALXRIWiL9+QzpfV77vjAQmYnkIsUpT9r6Mt0f6BPhr6i+tnb1HlEaEF/EZb3Uu6M
         aPWnaa+Ub3nlCTmK7kP9uqw/A0cDcmYBvqiN6by/cVBVBRzSE2OcMRYDO/V45TrkAApM
         2s8Q==
X-Gm-Message-State: AJcUukdUJnHrI6BQ/4RpO+jijJxVEybUJUayAnXOIpHmJEC7Swr5ta3W
        GcMnmi06C7dN+yP1WBFaNOeXw/hTJqHX8o+rtCU=
X-Google-Smtp-Source: ALg8bN5f8RWUlVwmbQwj7J+WRzC0IQve+/U2IIHJGeI0cGvyxBgZZNIldMG8i5Kj6CgnnR6Vw5bT52fJN7BEIuh6aHU=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr698945otp.225.1547487280922;
 Mon, 14 Jan 2019 09:34:40 -0800 (PST)
MIME-Version: 1.0
References: <e1b63429-30d6-1f52-ce6a-72b1171286f9@nextfour.com>
 <CAOMZO5CB_b3QbPQRPEW-0ybU1j1Vg1qah0xZhxynf-5d13-ogg@mail.gmail.com> <8b6b2967-9ca7-b7dc-49c6-1cd5cd77851f@nextfour.com>
In-Reply-To: <8b6b2967-9ca7-b7dc-49c6-1cd5cd77851f@nextfour.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 14 Jan 2019 15:35:08 -0200
Message-ID: <CAOMZO5AjQcLbAWR7jR27nu3pH+XVFgX3P8k8rocqYxsibKv0sA@mail.gmail.com>
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

On Mon, Jan 14, 2019 at 3:17 PM Mika Penttil=C3=A4
<mika.penttila@nextfour.com> wrote:

> I am merging mainline and this regression is present in 5.0-rc2 so it sho=
uld have the mentioned patch applied.

Merging mainline? Could you test this against a clean mainline tree?

> Obviously I had to revert them both ("pinctrl: imx: fix NO_PAD_CTL settin=
g for MMIO pads"
>  and "pinctrl: fsl: add scu based pinctrl support"), and after that it wo=
rks. Is there something more I could test?

Please share your dts so that we can try to understand what is going on.
