Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F45EC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4475820672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6PNciP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4475820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeLEMRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:17:32 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42682 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLEMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:17:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so17304776oiw.9;
        Wed, 05 Dec 2018 04:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCrUJs821Yu92WMTz2CLkV1KZsPO/jLYFCnJEtYDGJs=;
        b=q6PNciP0arUTM+KUnKhL6PiyWHixa+HWqMqT4KgOKm677hgBXyo5glgDWmaLsu2zgQ
         IxmPwWDF8ajLiBfa1IzjL4P49V10zyxTbyA8YJ6hCcMalMxI6KVECtz+oBOVxMLmCJMf
         W7BrA3/ZQ75FDHk1FW6k+QeYqmZ/uILoHDPMUBivH1v6QJ21rO++DyApkS7R/UGWw6NX
         8lbzW6bUG20C1OfBVQX+WFahYQy78wa+dcIOxvthAXz3DtySylIndnO6Yo47MPA0CeJU
         Yddl98uBgjAwmrxZWCkF2vOiJibF2gZy8Q9dz72AgIINJf9S5bgw1nnjO5HgxJndXAZ4
         DwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCrUJs821Yu92WMTz2CLkV1KZsPO/jLYFCnJEtYDGJs=;
        b=HNlj8gNkfr1wsRiEbredldZI7Al//JXmdCYtXE0yji8y2EmsJpADgD6bHcXT86e+/6
         Elh0bSAfOXB+Vn0d7jDM35wZAw6OOZ3zynj7Wcs29Zpb6KR979HLusFjV1ZsHbgiIl0N
         6/MKqRLiUmAmoY042LAyrkxMhRzDzcAq6GLM0ffEV7XIQ+mH7j/yf+VyTfME1QOT90UR
         KVanZBnKBB6BP6640GxK0UKju9qnBe16FP2t9UcV6JVekN+/qtwB1d5XX7sIK/qn3Yd7
         4Vfx8OUGDcGnrdu1J0FfQuixuVaZhYvZ/kuBY7V8gVo4WDevzNAk6Pj8xEKdeEK+HvuC
         wOtg==
X-Gm-Message-State: AA+aEWYYFV9yxIdseTY+/X//dxuRDwJxyy3DCqynCmwAHF6yp+3o1Lpb
        ye5vT6zAJpJVEUyIssLCS3jd6jXAFRr2lpMVIZw=
X-Google-Smtp-Source: AFSGD/UDvORwQm10nk95tzk4QaXDBYCZQOnzawIrVCVqe5MHi/jElNZWzRUg2rwcyNsgYPf77WNjtJxnRPBrhbe7H1I=
X-Received: by 2002:aca:d056:: with SMTP id h83mr15495745oig.67.1544012250786;
 Wed, 05 Dec 2018 04:17:30 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com> <1544001240-18622-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-3-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Dec 2018 10:17:35 -0200
Message-ID: <CAOMZO5Bg5=atQhEro+8Gjxxbu9Fn_MTZrsVBLotwxVy4j3XDAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6qdl-sabresd: add accelerometer sensor support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 7:20 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add accelerometer sensor mma8451 support on i2c1 bus.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
