Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E8AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34227BA7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Krj2X9Cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F34227BA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeF2IHn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:07:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54677 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934457AbeF2IHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:07:39 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so1690472itx.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4S7L2W8sOkdx/H5sUrQqxSWy1jLt0G5UOe4qXkS3HUU=;
        b=Krj2X9CyVd54plW9BrGFgp3ktfhBVdYUcQmTxHWtG46G8ArIx2/hLPGLqUYxAFMlwG
         ifCNwSSW7QRlLatXAJN2DY7QJDfQFgguJMEvdgHLtpyyvFx8kn3n/ViDMbOG5sT9D6sl
         v0fcCUHGjwB+6tzCnCaJRnTkRZ2jkuTD87V3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4S7L2W8sOkdx/H5sUrQqxSWy1jLt0G5UOe4qXkS3HUU=;
        b=MR7hsN5JUleIZTlInJg3LmxPs7WU9ncSXyk0GWptLS/8Ueqxq6K1r/47oqtDx3CxwX
         GRcri3fB02DyTFWV335MzhIiTwl+yG8CN1IPTUVsUi0uGsJBKj1EAKM/a8xyVJ6TrhNa
         2KRuqutEB9kH0JZi4X+J3kg6ciAK8KDAwALiL8+rAjrOE8Q+ChLFq/sQeNYx5Hb9vPpG
         rJgYS9Yx2DEd/YbWyiMuT/6Ezo2mdtGvdz5HCJtFd0bGwAV9ugzNR+cplwrWPIJlITtW
         bKEvqCSvtIqzuowoql3JP7XtH955Ty1pnAoIVZS/U8gYFMyMo+/Wp5xegV4LqKx5wgr1
         1E7g==
X-Gm-Message-State: APt69E0IMKH5f7r7t5afeuyqcSonEFQEr6aZ8+crnl53470h+/IynVxl
        J8uUk8HlfZs08ysnIGVoPtc4+WO54qqUqmWvbWeqVg==
X-Google-Smtp-Source: AAOMgpcDXaw+2hbl9iYW6PUhcxLxuIKvsuMyzpLBOZEBIME/lHUIifQK27m0trbNRDMVvLLtx0tpiHFLJ/Kbqje432c=
X-Received: by 2002:a24:79c3:: with SMTP id z186-v6mr630228itc.38.1530259658503;
 Fri, 29 Jun 2018 01:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <1529680549-22079-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1529680549-22079-1-git-send-email-abel.vesa@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 10:07:26 +0200
Message-ID: <CACRpkda-pZgmZTz-1AWcSDok4u1xLb=coqVHe5WjU5SSNTW9jg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] pinctrl: imx: Add driver for i.MX8MQ
To:     abel.vesa@nxp.com
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        abelvesa@linux.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:16 PM Abel Vesa <abel.vesa@nxp.com> wrote:

> This is the fifth version for the patch series sent by Lucas.
> https://www.spinics.net/lists/devicetree/msg212752.html
>
> Fourth version can be found here:
>
> https://lkml.org/lkml/2018/6/20/478
>
> Changes since v4:
>  * implemented all Aisheng's review comments

All looks good, just respin the DT binding patch so Rob
can ACK it.

Yours,
Linus Walleij
