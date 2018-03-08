Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965528AbeCHKvs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:51:48 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38687 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933352AbeCHKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:51:46 -0500
X-Google-Smtp-Source: AG47ELuUXE8YAObBrMRipx/9AEP/9LcEXglHxU9lPc8h6tPROOameJmyGgmyqDQ15rVBGBYcex6D4zEpMUvxpSOOPaA=
MIME-Version: 1.0
In-Reply-To: <CAKKbWA5F29HJFOTNfVmt14Qg5rMgrLSsHjY4NQESZL6OKmA95w@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de> <20180307162430.2664523-2-arnd@arndb.de>
 <CACPK8XeVMSeQNkPNp1_vms97H_9rMuk1-DzUAc=s-7o=FmVncw@mail.gmail.com> <CAKKbWA5F29HJFOTNfVmt14Qg5rMgrLSsHjY4NQESZL6OKmA95w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Mar 2018 11:51:45 +0100
X-Google-Sender-Auth: _TPr3GpUACcAIUZ8KfPMho9Z5qs
Message-ID: <CAK8P3a3fCRAuBjLXbjzc+1rYJsW90TDN2URZ=sOHvRNB3kyd6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: npcm: drop extraneous 'select' statements
To: Avi Fishman <avifishman70@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 11:46 AM, Avi Fishman <avifishman70@gmail.com> wrote:
> So at least replace CACHE_L2X0 with MIGHT_HAVE_CACHE_L2X0 then
> CACHE_L2X0 will be selected by default and user can still remove it.

I looked at the other platforms for this one again, and found that most simply
select CONFIG_CACHE_L2X0 directly, so we probably want the same here
after all.

The ones that use MIGHT_HAVE_CACHE_L2X0 are the platforms
that have multiple SoCs in one family, and only some of them have an
L2X0. Is that the case here as well? Usually, the L2X0 is used with
Cortex-A9 and A5, rarely on older cores, and never on newer
ones.

       Arnd
