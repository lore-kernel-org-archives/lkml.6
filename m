Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F17C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185C821855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duiBY6T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfAXOAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:00:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfAXOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:00:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so2930303plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 06:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndgmZO7nN9JTvhIHfuwRjqa/EtsLFt6gAomPwOuH1nA=;
        b=duiBY6T0EQBkSQTZQ6G4rGsIO/qamdDZTy8eXAcPpg0Rd90GRpCaKqsPk4tWbXM4aJ
         bCSk+Pz+eZ3BNVkqxHOkMo7iUKLqraFJUIrI3qmrTQx0JiNNabdUblrj2CSOft1DDUY4
         8fHHHX8Kt52t1YtuSS7DgkgdxOoccZhrtqdUw2EBdgAqedCv2gBOy4uyhp4QDX89TXjj
         r6TG5YIPoy6J1qynvVQfLqS2SwpCK7w/hlaa96oeC6mr5uAJGCZSqjE9uhoziB9ob9TW
         49XwQgsvDRjqBZ8vmy3J6l3+S0masJoe+rc3yMBoehYdVoxURUVYl3kGbp8Fb3KyCc4P
         7dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndgmZO7nN9JTvhIHfuwRjqa/EtsLFt6gAomPwOuH1nA=;
        b=OXvCRbbIF253+NgDFN0skwIQYsjFBfvLEh4PIa72TRKtLc6dUazO8YVG0OlDzVMWOn
         u9OVI9vnQYe4UQ4xIEEucULmmqquPK9lVRxQHT7t5/PMTM4uMHftPs3tanv84M3cEgJh
         2CWD6PYjGF1cM/wZF1b6ls250dz5Q3OGrHJnM0yK8dNI08byOPj+YmIb8v+L90Prxkro
         8nADuicmX+ya0DhbPISXGG1qdCS29z+8rAQLB3oCGeLbLTlATSisHZCTcAMHAOZLcxT2
         u2CDo3BtOA7M3zbNpRaR3TlA9F1WsEcRjczeuJpQbO7aGO0Vet3IRoPiiCwOF3XZGP1Z
         +0Bg==
X-Gm-Message-State: AJcUukeo0m6qHpSQamUSriyxYcZIaJTg2OFf8TxFC5cG1QWCgNU8ZNMk
        dokFcz7XWitGt9xwzWZucC8BRG4xUjFngePsgzM=
X-Google-Smtp-Source: ALg8bN5LzpCuR6NNfglyT43H53hZADe8WD+qb4yt5URDkPkIHdOJ8h9Vx6sVBpF1EJO8D0UYIqmuzS+OBqbYB0TkQrE=
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr6758259pld.87.1548338414454;
 Thu, 24 Jan 2019 06:00:14 -0800 (PST)
MIME-Version: 1.0
References: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 16:00:03 +0200
Message-ID: <CAHp75Vfh26ija7trPts0U8OfmPAMQzcbj4Y7wdcxb18yYQiCZA@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] add pvpanic driver framework
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:17 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> QEMU community requires additional PCI devices to simulate PVPANIC
> devices so that some architectures can not occupy precious less than 4G
> of memory space.
> Previously, I added PCI driver directly to the original version of the driver,
> which made the whole driver file look a bit cluttered. So Andy Shevchenko suggests:
> "I would recommend to split it in a way how it's done for ChipIdea USB driver,
> for example. (drivers/usb/chipidea if I'm not mistaken)".
>

Thank you for an update.

The series has the bisectability issues.

Try to use the following approach (if I got your idea right):
1. Convert to use common probe() etc functions inplace
2. Split ACPI part
3. Split OF part
4. Add PCI part

In Kconfig and Makefile follow the example like present under
drivers/usb/chipidea/.

> v3 ---> v4 : add help text info in Konfig from patch_0004 to
>               patch_0006
>              adjust structure definition position in patch_0002
>               and patch_0003
> v2 ---> v3 : add change infomation.
>
> v1 ---> v2 : add patch 0000 to descript the whole patch series.
>              modify text infomation from patch_0002 to patch_0006.
>              modify "SPDX-License-Identifier: GPL-2.0-or-later"
>                  to "SPDX-License-Identifier: GPL-2.0+"
>
> Peng Hao (6):
>   misc/pvpanic: preparing for pvpanic driver framework
>   misc/pvpanic: Add pvpanic driver framework
>   misc/pvpanic: add API for pvpanic driver framework
>   misc/pvpanic: add pvpanic acpi driver
>   misc/pvpanic: add pvpanic mmio driver
>   misc/pvpanic: add new pvpanic pci driver
>
>  drivers/misc/Kconfig                |   9 +-
>  drivers/misc/Makefile               |   2 +-
>  drivers/misc/pvpanic.c              | 192 ------------------------------------
>  drivers/misc/pvpanic/Kconfig        |  34 ++++++
>  drivers/misc/pvpanic/Makefile       |   8 ++
>  drivers/misc/pvpanic/pvpanic-acpi.c |  77 +++++++++++++++
>  drivers/misc/pvpanic/pvpanic-of.c   |  53 ++++++++++
>  drivers/misc/pvpanic/pvpanic-pci.c  |  56 +++++++++++
>  drivers/misc/pvpanic/pvpanic.c      | 131 ++++++++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.h      |  14 +++
>  10 files changed, 366 insertions(+), 201 deletions(-)
>  delete mode 100644 drivers/misc/pvpanic.c
>  create mode 100644 drivers/misc/pvpanic/Kconfig
>  create mode 100644 drivers/misc/pvpanic/Makefile
>  create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic-of.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic.h
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
