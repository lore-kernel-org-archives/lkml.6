Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834658-2-16633727915779061909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834657; b=p+ZxwBXYWFphHyKd3mZMfhEETyKoVTcSjNmhInQaxNSNvvf
    FEiBFImG+tOQSYeIqbB726T1e7OVrVuzbnhosZk0ff304PEuPw2xdQEF/YC0HL+u
    yQBKC1HLOJc15Tf/5+SJq5iM84ZUzx3lj6iWNY7ZSK/FWjENkF/Fv4WMmPNKMkZW
    M0NcmfbiaJ6UQhmWjQZoYZqIGoJCX3tuxPken8Tu5q+c2Pk51vi4yQi6K30LT/o1
    ZMY+EjC3A85fARwOCtCYz+HKDhlq9Xg9tzt6ih8r25IM4XQzFah++wiWbEkw6NZH
    tWIHMEOc/KyAPTv74oHe502hYbk8XdHbMGZvhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519834657; bh=zvBpIHRie1nVwvtmg7+iJyh689MPjBSDBOThb6
    nOkq0=; b=tQZtAcpsBK0g2yygvWXy3aeCJIavgN5OC4bnBGWaI1GN0V2z9Y9L4t
    z2qzf4FCkfJKrdvE3BH+508FU4lOo5qUcHM5rcWWeapXzmDZOVOa214o6OteumIZ
    ix3b2Oaer5a42wlrDFnqbv5GmrlOczJOemDnqGKauC7HPNaprMgWh6flk4sxGgeg
    XsATzYgPWvRqnCBjRdWXGtApSLZPM/b16PZiippvqLliXg4HCqlK6V2MlYB/y4rq
    Ko/FkcMCRo3RD+y51g3/f+deBIqxEj6CeE7SQv5oC13O1sTRzg+QZgIf+ppRSxRo
    dWoUcsHWAOTwKyhoW7ijAkKaJaJU9L+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ZPJFwyHl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JjHymLiM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mqUguBjt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ZPJFwyHl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JjHymLiM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mqUguBjt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934626AbeB1QQZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:16:25 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40629 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932876AbeB1QQW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:16:22 -0500
X-Google-Smtp-Source: AG47ELugMQpSYoOXp5IQpNpLX/cDEVpXl7R/FPP4hgDh7nje3vd1RNvtmxVwQGvsw/3Dbkz5TDoQzdbD41QYulh24bU=
MIME-Version: 1.0
In-Reply-To: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
References: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2018 08:16:20 -0800
X-Google-Sender-Auth: 1Bx8Ty4Xy18_j8--We5KaOOqx5k
Message-ID: <CAD=FV=XSSpevXKO7h0s826qt7Fdo7Zzp6SrNa4VCzEgCJ-zWCA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: dw_mmc: Fix the DTO/CTO timeout overflow
 calculation for 32-bit systems
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, Feb 28, 2018 at 3:53 AM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") and
> commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> have been made changes which cause multiply overflow for 32-bit systems.
> The broken timeout calculations leads to unexpected ETIMEDOUT errors and
> causes stacktrace splat (such as below) during normal data exchange
> with SD-card.
>
> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
> | -  Info: Finished target initialization.
> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
> |  0x900, card status 0x0
>
> DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
> code gets compiled on all 32-bit platforms as opposed to usage
> of DIV_ROUND_UP when we may only compile stuff on a very few arches.
>
> Lets cast this multiply to u64 type which prevents overflow.
>
> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
> Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
>
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
>
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> CC: Shawn Lin <shawn.lin@rock-chips.com>
> CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org>
> ---
> Changes since v3:
> -Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL
> -Make one patch from two patches
> -Modify commit message
>
> Changes sinve v2:
> -add fix for cto_ms
>
> Changes since v1:
> -uint64_t switched to u64
>
>  drivers/mmc/host/dw_mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

FYI that your messages keep ending up in my spam folder and I just see
other people's replies.  Not exactly sure why...  Note also that your
patch really doesn't have all the tags in the right places.  All the
Tags including the Signed-off-by and Cc are supposed to be squashed in
one paragraph  ...and I believe "CC" is canonically supposed to be
"Cc".  Presumably the maintainer can fix this up when applying, but
please try to do better in the future.  Speaking of which, you didn't
include the dw_mmc maintainer (Jaehoon Chung) in your post?  That
seems not so great unless you know something that get_maintainers
doesn't know about who will apply this patch.

$ ./scripts/get_maintainer.pl -f drivers/mmc/host/dw_mmc.c
Jaehoon Chung <jh80.chung@samsung.com> (maintainer:SYNOPSYS DESIGNWARE
MMC/SD/SDIO DRIVER)


As far as the actual patch, at first I thought maybe we could avoid
the 64-bit math and just pre-divide bus_hz by MSEC_PER_SEC (just like
used to happen before my change), but I think there's still a chance
of overflow, right?  Because, for instance:

drto_clks can be a full 24 bits
drto_div can be effectively 9 bits

...we could do further tricks (further rounding up the result), but it
seems like just doing the 64-bit math is fine too unless someone has
any strong objections...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
