Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7C9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA082084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8wwagqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA082084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeH2R3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:29:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33694 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2R3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:29:43 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so9154494oip.0;
        Wed, 29 Aug 2018 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eD3FGp+PWMHnLeVYhbYgCNDCHd8W6jnjBx5+qDOpTE8=;
        b=F8wwagqX358cPCxZG/LABQ6wbkDhugonG13eEWqoJEcmN01dc7ThwJzvLPg9GCNIpt
         V2RH2HGR7zLNfrK+gOu1sCaSj5/PiaIPGl5XQ6zKNl/4yfDzCd3lUfafdnyDOJJgZJYk
         SeRLdyvgHahx6EWmmUa6mGN1UBT3tro+iUuGEiSMzigxaC+WJia14vGQWAROxT1Y8523
         u1hB1O9qjW2mi9xTdvY4moIXT31BMg8ZwD7NBw3LRzl7kBs6JM8k9N/VmGGWO2A7jx8V
         79fS5t53l6FrfPB348IaSEc0rN2GMKQyq8A0wGJQCAAoZhXYtl6VpZyq/Tkr1r65h74I
         DArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eD3FGp+PWMHnLeVYhbYgCNDCHd8W6jnjBx5+qDOpTE8=;
        b=Gw2LjklZBSfHCu2vRrp9J7E9k+6kOrzRKEyUDO080M6Lhisg+vH8upfhmQkhoE11+6
         UpXOs7YIxZXkYWxUVyhtIbr46+qgr1gTlXsvKzuyz9PaKFWGp6+hb2cm93sQ0+nWD8Mc
         WBB8pTjtpWaj7H3n1eJKp/4er0PyBf7i9eDND9jxxr1Y+nUtQIpi/MDWlNLKv6ahvS7H
         EbSaMsGBdOa4sFBR1LVBSiGOn4sdzl9e24fZTbHhyUkQRXLTSeRa5JhyXRzx4dxWltCo
         15A4q6O9wW41uVjeZJdXCP8NBRNjT81RBQescq+AHFsMzNdq6aDBe3zuRXfjnQxmBm+N
         rNnw==
X-Gm-Message-State: APzg51C9Wwiqq+ug7gRFKb+4kflHWsgAHMa2y/alz43q5wmM0b7wmx/S
        F57tJRWBIiMwczr67gsqrYefVdH7ZxQFKavIm/U=
X-Google-Smtp-Source: ANB0VdbfUaH8O/Djq7oHYM8PPcfslE7ZxREmlbVRX7PHqfMnBlpA2rTa3EzRX3lZ8szgQsIfDW0h2ksG1ljxTqSliy0=
X-Received: by 2002:aca:e184:: with SMTP id y126-v6mr2567263oig.313.1535549564596;
 Wed, 29 Aug 2018 06:32:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 06:32:44
 -0700 (PDT)
In-Reply-To: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
References: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Aug 2018 10:32:44 -0300
Message-ID: <CAOMZO5DvoxbSCLDDaMy9LnYRpHQR+Yr47qzZGtK_OD6WBGE7tw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: enable gpio buttons as wakeup source
To:     Anson Huang <Anson.Huang@nxp.com>
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
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:45 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> This patch enables i.MX7D SDB board's below GPIO buttons
> as wakeup sources:
>
> S1(FUNC1): KEY_VOLUMEUP
> S3(FUNC2): KEY_VOLUMEDOWN
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
