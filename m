Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDDD20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnUNvloz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDDD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbeGWOsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:48:00 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38078 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbeGWOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:48:00 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so1190461oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i5C7Pe3qRcvfDxekO67n4rhrdY7EUOUqLniAaxHkCDY=;
        b=OnUNvlozZ2CkF7NOtUrm8HRLeE2TgbBJa49Chg8SbVL8fdodBzbykJRbRAEH98+L3O
         4L3L4blYR42nC+rP3RW+cbcjA4KFQfkIZ7iOukHZsrbMcbHjHirE/JOOzn28U6lbc+QF
         exL/WyFzE5tmoc1il3570bVHU1w9dnfeuwxutDY1DyblBUeku5lUYR7MFbB1fE9E3wEI
         rcVwQC8Jd9Vqd0uxsgt6WdHpYAgGV19lkTZ4uEDO67CqgNiNhEgmN9Qt4eRyIS8iOOf7
         OKwQSkIXfN6YX3DFT8OTvVpmfn7EkKzuxA1pQvbeI5660kyDm2oUBGc9QyHhJ4kuoB2/
         qZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i5C7Pe3qRcvfDxekO67n4rhrdY7EUOUqLniAaxHkCDY=;
        b=UldcfvBePtC45WwUDYPDMOa1VJ/m6Eco3vBZKHkdD0CD7ukQObe27k767Qe2KeZ8V+
         pB21MDop+rER40m8x83bpAYlC0MwPfxN90QR88P7jdJvTppFb0pKYYQBbmZ3UfKqV90+
         Rtp9NILEkQByY+OnX+ba2f/i2KhE3siR95Snfcm9JCAbSTj+nYQYqMjSKV8B+50CYTEL
         d/PFw0wOUrt6P7RU3usPmyUakYI7CtkMdzB2rOEv4iD+g0afOBjIVMC34ptiMDfHa2Xq
         bv58pSX1DtqZorGLRh/ZPgjfzwRsuHhS2DSy9Ko5nReBTGAClE5aTj4vwdU0etJYoT/P
         shMg==
X-Gm-Message-State: AOUpUlHkNjK7zNj5xFHOJg0v0ZTa1Z2KhXPN3oW3jwFnjlqFk2j6L9vl
        UYPzGysvHbltjztnD3ivXTXRm0G+OCOnFVUlxsA=
X-Google-Smtp-Source: AAOMgpfVbeZSM8hFu0hd+v34ImdMDosbm1MliQjw4F2ZpRFvuv7b9qMofFCr/m4R580K98rIZZOXc1FCVe6vahnea+8=
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr9152116oia.336.1532353600200;
 Mon, 23 Jul 2018 06:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 06:46:39
 -0700 (PDT)
In-Reply-To: <8c6f4f407f363ec6980b59f7a2a9f29221dac29b.1532353109.git.leonard.crestez@nxp.com>
References: <8c6f4f407f363ec6980b59f7a2a9f29221dac29b.1532353109.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Jul 2018 10:46:39 -0300
Message-ID: <CAOMZO5B8q7Lp9m5PaxdjWVE9GfFKGvYn+NoLfsLK++rSYog0cw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable DRM_PANEL_SEIKO_43WVF1G
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marek Vasut <marex@denx.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Marco Franchi <marco.franchi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Mon, Jul 23, 2018 at 10:42 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> This is one of the default lcdif panel options for several imx
> development boards. Now that we switched to CONFIG_DRM_MXSFB=y this
> should be enabled as well.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Already sent as part of a series last week:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/592676.html
