Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EFAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BC320834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhPinUzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BC320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeLCLWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:22:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34024 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:22:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id h25so10574781oig.1;
        Mon, 03 Dec 2018 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sRkTbs8OPIr0qRohpAMmmkhuapeAcwEG8TNQgdpb1dU=;
        b=MhPinUzsqNAqoNRgZ9f0OUGEDLc0NqsAMTNckWonzLenTp0Z3Uv9mOj7xjGGrdCHTa
         yChPli/rlZA+TxaBZ9vK1wCAvizpq9PYil2Slk7+TAN2l9qtyr7yFCphw1rGiWdNQVMP
         8pIGSsIRsMsBW8CSJHp7E3asQNUMIdGzQA73aCQiY3+SqKa/lHcxzQeWhXqDOpWvHfBj
         tpY5lbMNRK3JYrwWa0zOFRcQryIK2IJbvLM7Fc34gwUtnzkBnBrL0puULgwLUETiEDLP
         y3ZaJylNoxHSsZxuobCBqtcQNQ7RgS+kF1CRDByqu3NqOlGGyHky3OfgiSvGfFkKrIes
         a/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sRkTbs8OPIr0qRohpAMmmkhuapeAcwEG8TNQgdpb1dU=;
        b=MkbmX7nfObuPghN2osvCesO6mE/h6Gb2NBi9G3kJMMdE2pWMnc7vaUVVj0qw36bvZB
         oVMZe3MSo+k9/CTWN7zrp4p8AAq865Syhp9Vijbx88DJtqUqHnVvUlz3t1SLiBhMrCJW
         yTktWdP5Hy9iQ2u6YT8PdsU2ViF7uA8Vg6caDVfgBQni1JaJSx+fqSsKpZ7WIKqg7LS1
         KSDADU58+dezZM+CUDyFI3vWGJqf62m8JtduH0TbsQAOOLrd1R9W9n2fv3Ocxx9jJXYE
         hac6RhbMfvu6aMQf8aUwW3mft8+YNTBvDCfKdt2IZKwCRTmfE746TX2zMozEzJ6vrPh8
         OFPQ==
X-Gm-Message-State: AA+aEWb9jmTepOk4eQ2Cc04La2XrkjTrJV10nPRIoQjHyiTN0zUQE8U7
        TcWcvKzCJX/trDGUFwW9LeSpl0c2Uwi67ruKUSKCIrzz
X-Google-Smtp-Source: AFSGD/Wq3yE5/KDXsKt6z/PUZ5ITWj6DIUc8V6hdgvTUMfWMAyVzfHCRhWiPpestN6ZzF9cksNJfZgeAp7F7CPI//GY=
X-Received: by 2002:aca:ab53:: with SMTP id u80mr10127830oie.261.1543836091432;
 Mon, 03 Dec 2018 03:21:31 -0800 (PST)
MIME-Version: 1.0
References: <m3o9a2hni5.fsf@t19.piap.pl>
In-Reply-To: <m3o9a2hni5.fsf@t19.piap.pl>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Dec 2018 09:21:32 -0200
Message-ID: <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Dec 3, 2018 at 9:13 AM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wrot=
e:
>
> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

Please provide a commit log, giving some context to your fix.

Is this a regression?
