Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeCPIT2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:19:28 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40777 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeCPIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:19:26 -0400
X-Google-Smtp-Source: AG47ELt2HeMVap7K73ZLrbEbv1+GQrITysHoM+ScA6HdKrkjix0zpN1z7pGXC6gK7A1DeY4M7KFmUOm2j40Jr1B9g3Q=
MIME-Version: 1.0
In-Reply-To: <20180316004843.GM26859@dragon>
References: <20180315151345.3089601-1-arnd@arndb.de> <20180316004843.GM26859@dragon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 16 Mar 2018 09:19:25 +0100
X-Google-Sender-Auth: 9NP3BiWFWYIq2wcxBhFjDjhGdP0
Message-ID: <CAK8P3a0aUHZ+64N1bDk+uozmMqQEVDgYRLhb1qZt42dqo7hbmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: fix imx6sll-only build
To: Shawn Guo <shawnguo@kernel.org>
Cc: arm-soc <arm@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, linux-imx@nxp.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bai Ping <ping.bai@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 1:48 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Mar 15, 2018 at 04:13:18PM +0100, Arnd Bergmann wrote:
>> When selecting SOC_IMX6SLL but not SOC_IMX6SL, we get a link error:
>>
>> arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
>> mach-imx6sl.c:(.init.text+0x14): undefined reference to `imx6sl_cpuidle_init'
>>
>> This adds the missing line to the Makefile to also build the cpuidle
>> support that we need here.
>>
>> Fixes: dee5dee2a5b2 ("ARM: imx: Add basic msl support for imx6sll")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Thanks. Applied both now.

      Arnd
