Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D23C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6123520824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQx/s7hM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6123520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438262AbeKWGKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:10:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38499 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732651AbeKWGKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:10:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so8542713ede.5;
        Thu, 22 Nov 2018 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13Dr+HWy8yL6wPju/+8iN+B0cwIJ6rD7dZ3PhmdxJLQ=;
        b=lQx/s7hMy0iWX5Yn5Dfwpc2g5/QsWkR4OsGJavXe0EGdkFh4xExx1QuuHoPNQ88vkX
         8PFFEdcPuTuXuXYRtSk9q5YNdBm7B7hfRwzPnIZwPV2iJiNSZfs3CLX5+uZJliVC7kpG
         84xa8YruOpk3KKiI/lneKC1v5Et7PQWUCMYayhYlGyAcG1ma7ZUzM/Fq/enLL5ktqRk4
         +vsS9+5ojb/A7MIbiYpRuDoUA1bjrU4HdlpJcdTcMOBC2NP5SamaAdSV4cukYpJVK+mY
         7ZycZrVd6UtXFOy3kNOBazmmr1xV/68vjK843vRWSVataUpVsGna4Vk7nno1+BZWRkD1
         3quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13Dr+HWy8yL6wPju/+8iN+B0cwIJ6rD7dZ3PhmdxJLQ=;
        b=l/2NRC/rXzghiE1jxp2GFNlpy/bfAtOvWTIGT3oms0CSY7CyKzfnvBIzqOCv0wPAd9
         rs1ZWep7vrb9wsXQm20vEG9RoKZbTobsEnhMC4SYAqdTAzwrDOA45VtzVr67MprrCSJL
         hGA92iB1HI0Npxi9yPYNdPpdtPOL2EFqHYymGcWQa3wK6JA6mNrS1Olo3rK+qvpRvkS5
         fDiie8BZgJ0JZRsoerPOlS3LsiXVjYgmm2DTYcrMoAuUASUIiRmBvHi85Ly0R1RqZV7a
         8ur3xiU0dRGW0cmHfjvkrcaAh29UGMn6jlPVuoUTmGG5YBSH2ck7LoaFH9cGXGklEtjT
         LR4A==
X-Gm-Message-State: AGRZ1gJloedjeFp1fy18cKC5GfeGKhGuUQxcLwpGHrnTRKpfCdI5KU1P
        UQdPYyLzA8JINPSFYD9bc4MrMbX5UX6CWV1ZqYA=
X-Google-Smtp-Source: AJdET5ey6eu+dFWRGiFHFyNppIOjnxpFKlHE4p4X6tEkp1FO4mMd57mlO2fP8aIUo9WztkPXsiUmjS1NCxdvKdH8WHs=
X-Received: by 2002:a17:906:abd3:: with SMTP id kq19-v6mr8981477ejb.116.1542914986744;
 Thu, 22 Nov 2018 11:29:46 -0800 (PST)
MIME-Version: 1.0
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de> <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
 <20181121202034.GA10697@lunn.ch> <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
 <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com> <7d6362e1-e197-d338-d6b0-9036c3802e2c@gmail.com>
 <CAB9dFdvw8QqzaVYV3bOMGtACyvqWnE9uy96m1tu2C+jjzQR9_Q@mail.gmail.com>
 <a995b6f6-c5b1-877c-581c-39c0897e7703@gmail.com> <CAB9dFdsq7EBNm1Y1nK2tqOvg5ikyTm4ZGTQddsNAp1BaA0J_XQ@mail.gmail.com>
 <d38a9ed9-b801-5622-1d3a-1b9620ed9d8d@gmail.com>
In-Reply-To: <d38a9ed9-b801-5622-1d3a-1b9620ed9d8d@gmail.com>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Thu, 22 Nov 2018 15:29:33 -0400
Message-ID: <CAB9dFdvscM_vjhautiNc6yNZ4_aMQOkcGeKmAyRv4E191q9jaQ@mail.gmail.com>
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
To:     hkallweit1@gmail.com
Cc:     andrew@lunn.ch, norbert.jurkeit@web.de, nic_swsd@realtek.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        michael.wiktowy@gmail.com, jcline@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 2:17 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Thanks a lot for testing. Could you please test also the following
> as an alternative to the delay?
>
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 55202a0ac..aeccb2323 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2254,6 +2254,7 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
>         new_driver->mdiodrv.driver.probe = phy_probe;
>         new_driver->mdiodrv.driver.remove = phy_remove;
>         new_driver->mdiodrv.driver.owner = owner;
> +       new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
>
>         retval = driver_register(&new_driver->mdiodrv.driver);
>         if (retval) {

That also gets me network reliably, switching between a kernel where
it fails (distro 4.19 kernel) and the custom kernel with the patch.

> > There's a side issue that network startup is taking a full minute
> > longer than it should, but that's possibly unrelated.

BTW that's an unrelated rng issue, for which I have a workaround.

> >
> Thanks, Heiner

Marc
