Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeBVVtj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:49:39 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34999 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeBVVth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:49:37 -0500
X-Google-Smtp-Source: AG47ELtSI/7vHvx12p7z1CNCoZ3bxuEuKH5+juQ3G+YxWbuLzYPPyfKLYfkc92PbSzTYOg7aUtkbtnwoCIqXdx+ZtZk=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jyuMsVfyT-UNMqPdu33yLCRtQAwVUcOx1Hfr4FgKzZyw@mail.gmail.com>
References: <4287858.bFmM5lK9H6@aspire.rjw.lan> <20180220213839.GA12082@light.dominikbrodowski.net>
 <3352336.6IBe4RuE7s@aspire.rjw.lan> <20180222164532.GA15359@light.dominikbrodowski.net>
 <CAJZ5v0jyuMsVfyT-UNMqPdu33yLCRtQAwVUcOx1Hfr4FgKzZyw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2018 22:49:36 +0100
X-Google-Sender-Auth: d7rjCiQEz7L-oBJE3xGksiS-uNc
Message-ID: <CAJZ5v0gCfaGdniLqVLRfS0riVgAYg6-5waj4=HeNFRWk8G9nAQ@mail.gmail.com>
Subject: Re: [PATCH] PCMCIA / PM: Avoid noirq suspend aborts during suspend-to-idle
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 6:32 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Feb 22, 2018 at 5:45 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
>> On Wed, Feb 21, 2018 at 01:24:16PM +0100, Rafael J. Wysocki wrote:
>>> Avoid that by using a new socket state flag, SOCKET_IN_RESUME,
>>> to indicate that socket_early_resume() has already run for the
>>> socket in which case socket_suspend() will do minimum handling
>>> and return 0.
>>
>> That looks to be *too* minimal: For example, yenta_socket does some
>> socket set-up in ->init(), which is called by socket_early_resume().
>> That needs to be undone by ->suspend().
>
> I see.
>
>> What about this variant (untested, not even compile-tested)?
>
> It looks fine to me, I'll test it later today.

I had to make it compile (by fixing a typo), but it works for me after
that, so I'll queue it up.

Thanks,
Rafael
