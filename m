Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3025739-1519656011-2-15687448638954348138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519656011; b=deDplqEIEN2+1ws+I4AWIMp4psHtatrlmi3VM05eLB/g9jY
    veACEF0ihesn2zK9Rso3aAOC2e49uqXMHckGcrppLrio4xsP/Jbq9xDfITBxySRg
    zXxhXJIip6ezb5hbczwMDC2ImDpJAeNULcXaRl7fjXYG5hA6hLwxcP8hqZAbuTKz
    fjHfM4A8WSJK1FU4jFDvhB4dvy7FPQteLv/UpdCFXIL7FBk/J9IcRDeme3AZhcaN
    oJSckCaT61BivEomGXewXDseobRHc6MlYLivxa9CffxZ33vjDqVB6w2l93vGuVkQ
    Nczf1ouGeYv92wZyFFWfz8IVZQ41k9QSDiNRnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519656011; bh=n69VCYPKeIt9YB2cIMuKLgfHW4pQfDN48G7jOG
    KWcqU=; b=mGb+qzG3nCbgNOghUphKW1W2RELO9r10VrK5Y2pEGmD5eOgPJz3q9N
    d/s8wfsJIuwC4L0b6Tm8jkuumSSW41AzHm99jZAMvsaHYxgKmSYUoOe6YPS5ILpl
    gkH5kAiuHi1aGOVXHkFCdC63XdZ4I/YPA+qJ2SOPZtIpnHG0IIkQRun1fPS0M2xG
    +s0Roj0TQ8PVEQ2qkFF48UHUATXY8PJgu3x+KG93Xix7uqI8bqSTgs7a84VEjycY
    EXbhjzKE/WaIJsBiven7itfJijW7KnFkYSSdH/l43ZvZJMI5u101q/hTq9w8tPcu
    48NWDVUr8zpQUPy9oVF6eHfyxrkKK0Fw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nqeROpOj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BAxLMO6h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nqeROpOj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BAxLMO6h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbeBZOj5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 09:39:57 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39430 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753706AbeBZOj4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 09:39:56 -0500
X-Google-Smtp-Source: AG47ELsQW09BphOGb5bZXCqvUB+caZPuBQQdHBLNGJRfQetyPHXrcQwynkuCtkkxK9WvBdriBJIo9gRYfXgxSXLwlyA=
MIME-Version: 1.0
In-Reply-To: <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com> <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:39:55 +0200
Message-ID: <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation for
 32-bit systems
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: linux-mmc@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Stable <stable@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 4:34 PM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> In commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> have been made changes which can cause multiply overflow for 32-bit systems.
> The value of cto_ms is lower the drto_ms, but nevertheless overflow can occur.
> Lets cast this multiply to u64 type which prevents overflow.

> -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> +
> +       cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);

IIRC, someone commented on this or similar, i.e.

DIV_ROUND_UP_ULL() ?

-- 
With Best Regards,
Andy Shevchenko
