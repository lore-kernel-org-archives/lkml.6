Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeESWf7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:35:59 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37753 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeESWf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:35:56 -0400
X-Google-Smtp-Source: AB8JxZp2rqL9S143oT/zPk1sD0zqcsmtSo5e4UbEcr0YxME+TT/eOWUj40jVYyNPcKRlo8GfBQfSEeLgtMXW7G6qyU8=
MIME-Version: 1.0
In-Reply-To: <20180410183210.28052-1-andrew.smirnov@gmail.com>
References: <20180410183210.28052-1-andrew.smirnov@gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sat, 19 May 2018 15:35:55 -0700
Message-ID: <CAHQ1cqGCG0rwPcpoY+bnjcyupg18x1TvULJzvAjRxSkL6z1U_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
To: Shawn Guo <shawnguo@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:32 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Platform device core assumes the ownership of dev.platform_data as
> well as that it is dynamically allocated and it will try to kfree it
> as a part of platform_device_release(). Change the code to use
> platform_device_add_data() n instead of a pointer to a static memory
> to avoid causing a BUG() when calling platform_device_put().
>
> The problem can be reproduced by artificially enabling the error path
> of platform_device_add() call (around line 357).
>
> Note that this change also allows us to constify imx7_pgc_domains,
> since we no longer need to be able to modify it.
>

Shawn,

What's the status of these two patches? Do I need to change anything
or are they good to go?

Thanks,
Andrey Smirnov
