Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69608C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9652082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW+QLCto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9652082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJXTY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:24:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40055 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJXTY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:24:29 -0400
Received: by mail-oi1-f193.google.com with SMTP id j68-v6so3684861oib.7;
        Wed, 24 Oct 2018 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hvbf0hxukcB63kDIMWdcSJsjnL1VtJgh9L+Uif60YZM=;
        b=cW+QLCto+OPrv4ElEOZGuRlUq9xRzp9XMvW44DLeShOzeXs9bzoNw3ZiJWhEgbVDNM
         c/wuFdt2Hjk+lHCiRhGovDX4TResuNe5c9312SlRgAvIzWKdr1bHiRMzecNjk5wxpB/X
         Jfkn+V4LpGfABL0AC7pAm09Cc/w7RvoDsgVmEOiqRTKWSLN1y/HJWVXHKBNPqVy6/Cvq
         3Ds7SyiHgHIwcHux9UgPJ6pC3aE8cvKMqj6l00fQrwSXu97/h0gaLb5sXbxW2fky9ceY
         78u+w8xKKS2+uBw5e5UQHlwMVTlgAgY2/JhCyP28Hm2y+M2hDNmXR5+h5vMVWBKrukwy
         PK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hvbf0hxukcB63kDIMWdcSJsjnL1VtJgh9L+Uif60YZM=;
        b=V64LmmfwPDWU1yJQaC1/v9cdmNEdnKSIL2jaTiFYOEq+P/lMeyRbY1n+5wkI/ltCsK
         txeeUDXTsDEeEiaG4BFdTQ3wjIkTKnWZsbmtUIgP745kVKVlyGZ4tRnFHN1HYklqeEX2
         9hrHIE8Wep0ZCN50RsA9d84XDXImbjlYOOYzBSm1FgL5NKIw+kNozurtrNbHEWJNYcIg
         P7TdeF6jiYGjcSmh7ZmC/uH/DUNY/bqoD6o8B43piKECLj62vjW2Q+ZyWNrMvv2qUrq7
         YXGv54POMkyLkBtSps1F6eq08cg8qKTC4PpP8vWLjSMQ6snyoxfl9U3UACCAQ801/bIt
         GZ2A==
X-Gm-Message-State: AGRZ1gJI9UjQ73n5TVUKSp1JGVJxnMMaZrnIoUATxHueSrqP2qWCcn7W
        R/0cd5JYrsEPAW7aJeVGZlmwMRJhZKF7BTbHcuY=
X-Google-Smtp-Source: AJdET5e1xWe5ZAacPdnpLB4JSGx/i08+qct18/l/HdM4i0SI5BQiMTO20ybJVawL7RfT8Tqmq+kYZ3Rsv20VEoBIONo=
X-Received: by 2002:aca:3083:: with SMTP id w125-v6mr1169755oiw.67.1540378610932;
 Wed, 24 Oct 2018 03:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181024075617.19548-1-xiaoning.wang@nxp.com> <20181024075617.19548-4-xiaoning.wang@nxp.com>
In-Reply-To: <20181024075617.19548-4-xiaoning.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 Oct 2018 07:56:47 -0300
Message-ID: <CAOMZO5DFgd2RsjRojWaDBOc2XxD47aQ1fkhxXYX-7BCAJnnVdA@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] spi: lpspi: enable runtime pm for lpspi
To:     xiaoning.wang@nxp.com
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

On Wed, Oct 24, 2018 at 5:01 AM Clark Wang <xiaoning.wang@nxp.com> wrote:
>
> Enable the runtime pm for lpspi module
>
> BuildInfo:
>         - U-Boot 2018.03-imx_4.14.y

This buildinfo piece is not very helpful in upstream. Please drop it.

> Signed-off-by: Han Xu <han.xu@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>

Also, it would be nice if your From field (Clark Wang) could match
your Signed-off-by (Xiaoning Wang).

As Mark mentioned in case this patch comes from Han Xu, then his name
should go into the From field instead.
