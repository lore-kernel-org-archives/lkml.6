Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeC2Uhf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:37:35 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46493 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeC2Uhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:37:32 -0400
X-Google-Smtp-Source: AIpwx4+Z4f8CFeXO25KMW02TqAG4m3Zz994vydx4mkd18PFZ5Pz870VuqGcV6iDedUpZO1L50YVUWZUWmjVq896T/Rw=
MIME-Version: 1.0
In-Reply-To: <1522059113-20418-1-git-send-email-tmaimon77@gmail.com>
References: <1522059113-20418-1-git-send-email-tmaimon77@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Mar 2018 22:37:31 +0200
X-Google-Sender-Auth: vP3pTOx9YKIlKdbDreq76IEt-Bk
Message-ID: <CAK8P3a2MhXOPKob++DzWrMdmDwSkUketpdv-_VAEsEQSMkkNCQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] arm: dts: modify Nuvoton NPCM750 device tree
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Patrick Venture <venture@google.com>, Joel Stanley <joel@jms.id.au>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 12:11 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> The NPCM7xx are a family of BMC's that include several chips as:
> NPCM750, NPCM730 etc.
>
> All of the NPCM7xx BMC's have the common modules like Cortex-A9,
> WDT, timers, etc, and there are a optional modules that can be added.
>
> NPCM750 device tree already pushed to arm-soc.git:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=for-next&id=d6bdd009c21db3f677dd1d1bbb8c20bc819074bc
>
> After discussion with Rob Herring we have modified the structure
> of the NPCM7xx device tree as follow:
>
> nuvoton-common-npcm7xx device tree include all common modules
> nuvoton-npcm750 device tree include specific npcm750 modules,
> the nuvoton-npcm750 device tree include nuvoton-common-npcm7xx device tree
>
> In addition, the NPCM7xx device tree include the following changes:
>         - watchdog module added
>         - clock module modification
>         - serial module modification
>         - Modify Makefile NPCM7XX configuration name
>
> Sorry if it cause more work after pushing NPCM750 device tree.

I only see one patch here, which fails to describe the changes and
combines all of the above changes into one commit.

Please follow the usual style for sending patches and do one thing
at a time. In particular, never move large parts of a file code around
in a patch that also contains other changes, those need to be split
up. Each patch should also have a description that explains what
it's for.

       Arnd
