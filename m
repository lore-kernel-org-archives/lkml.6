Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519129679-2-2144211937626557687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519129679; b=SCk5oWKCtw5005P4DdYHkJVJvDiHRwBh3HxiKo5e9X5szJX
    oONZNDAP/jRRj9s0o5XxQjIuZ3Jg8sEq+6CPNf7FIWEMRPDjO9UXX9xJsH6r18ia
    fMxVBT9prjwJ6sCeR3yaZoKRClKMX08UpiuLkQD0J9ko/YxvQmMLubpHUB0HmA3A
    FuQnltbmRRIUroIuMfyTKmitJ4vxxBebXVsFywmH5/kt0eF+eJyPRBAl9wjPB+qD
    /xwtvDAhzvzOdkgwVZpQpluJ2rQfqT+PKEpBBzbV2N+62CoGBTjS9OjvJS8b3MMt
    yZrca/cMFssANuSRDZJ/CJejMi3YUpHyBrWp3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519129679; bh=hfVVDJ6TghiL66y36162YwsXuc+nqKuoWSmVnj
    tp9T0=; b=Svg17UhSE7fNvrjFh9jZifG4iPPgwVwknBrqc/+ttNU6rAIzx+M6jq
    a8siGRb8hhK5voe3avu4rtQRbngGx1ds9h4F+pLpJeI1c91bYT5akUnz2UQiZwEc
    DN2G3GR4Y4pdtkl9cAqDKC3dNvzGzY6wOjxEdwEWPv/l/R3N5L+MZLmD0nv06Mii
    dwRLo0zyOvATpI7oSZf9hyhX5VqqJdjRgPWFMSsWxThU+mg5JR4SqVPQGK5EPvKr
    qZnfDifY1D7umxvGIrNMYqty/iaDKCr3ARKe3WabjYb8HI7ex9BGsPlT5yNu8G7J
    dxVKrYwVtIRX7EVpbFjD65xF/tUCbk9Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tex48B/t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n9AWUs9Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tex48B/t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n9AWUs9Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBTM14 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:27:56 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44723 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeBTM1y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 07:27:54 -0500
X-Google-Smtp-Source: AH8x22509K/QJME5UQzO+YXJrl/68oVK7/m4TyM6SCQPYRTeD4DW2LafhuhNz9Te18i2AYSMjcF/rgdQMOAQDqQwIK0=
MIME-Version: 1.0
In-Reply-To: <6cabf7c6-302e-efa9-8f4d-25fd35ecddad@xilinx.com>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
 <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com> <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
 <6cabf7c6-302e-efa9-8f4d-25fd35ecddad@xilinx.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 13:27:53 +0100
X-Google-Sender-Auth: HWRotW6Me8vxPxg9i6FT59x6N_I
Message-ID: <CAMuHMdWe9XkoDKkyfu1pOG0oS0_Tdx1w=OOk05EvTr_dK=tp7Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT alias
To: Michal Simek <michal.simek@xilinx.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <baohua@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Michal,

On Tue, Feb 20, 2018 at 12:27 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 20.2.2018 11:38, Geert Uytterhoeven wrote:
>> On Tue, Feb 20, 2018 at 11:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> On 20.2.2018 10:40, Geert Uytterhoeven wrote:
>>>> The cdns_uart_port[] array is indexed using a value derived from the
>>>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>>>
>>>> Fix this by adding a range check.

> I have checked 4 patches I have sent in past which didn't reach mainline
> (probably because of RFC)
> Take a look at
> https://www.spinics.net/lists/linux-serial/msg27106.html
>
> I have removed cdns_uart_port array completely there.

Nice! I'd love to get rid of fixed arrays in serial...

However, IMHO it's still worthwhile to fix the out-of-bounds access first,
as that fix can be backported to stable kernels easily.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
