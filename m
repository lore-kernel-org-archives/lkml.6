Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649693-1519123807-2-7189686867040377238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519123804; b=XussyvS4KUS+8E8OOJmykuVRQbdzYp0a1ySxjVcY5IEwwmQ
    lXQ4KnKyoO7ha6y8IC2i8+OGKFLsxNzEE8+1sxz/e4Ho7YeMgsaqM7ed0eb/nn+y
    4aLGg418rSqDRGT/iDgimFOUpv7Rv0aHI6KiBCjQvgADNwDCQTdJs5kNeac+l9gj
    jiNLpuFrGs69cAfktDIz0IxUMF9+lhDkN8MDynXyIStNbXWcFXIKHXK/uByb3l4Q
    UyaFfzZriQ08SQ/PisUNBeyeGCSQFwEFfQYWvLIsZNyT408RR3AL3l09MxujAeKu
    ZvVIJyS6epUe71xZFu96PG8bpqPjc5X5NFb/y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519123804; bh=nS0tfDPrKJpZTTiiXD/8JN7quGfv9UFpaTYrLpdkhZs=; b=O
    kvQr2CvuDgkzA77HSo2tBPaebVz33s0EsfWjJd5lO231SuJNSWjYQ7XX94RN8PxD
    hV0oKkdUDwYXc/eqryICbyfgGheY0AOE93wnREHfyG48qxLScTM9QDaF30CkBAf6
    vJkLvYHXS85uSNnAWcBMjioRw+XsQ0wTRshNL7KLeKsFkqNuxwVf9icNs0wioY/W
    1zuTRt9J1Wq7D8JDDlChMg7M5ooolnXnBq/dvib1pz9rHrMdWZiZrs+AON2BAbLZ
    dP3aGYbG0027+pJ23mOLKJY5qhAl6ECI8b6Z/1Q4EM+J7rvciHGS40TwLeazoAoY
    xckJ3QTY7MiW1YUDTaOjw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LZ9ROPm0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s9EdtmOA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LZ9ROPm0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s9EdtmOA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBTKtp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:49:45 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37548 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbeBTKtm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 05:49:42 -0500
X-Google-Smtp-Source: AH8x227HfU5uiI08yvMhrYHIXVutnsE1RWtDFEOkmQf3p70llAg+K4B1N+SyNxqMD+324YqJbtcdPP+R+F5hsbGPjZU=
MIME-Version: 1.0
In-Reply-To: <20180220103134.xfh2zl2vgonb2ywb@pengutronix.de>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-4-git-send-email-geert+renesas@glider.be> <20180220103134.xfh2zl2vgonb2ywb@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 11:49:41 +0100
X-Google-Sender-Auth: 5xtzAK334C1aBRJndnYIx4JXGj4
Message-ID: <CAMuHMdVMoEuOOffRNHDa0JwaLH1auByOQfNW8DgkXGaq5GFnsw@mail.gmail.com>
Subject: Re: [PATCH 3/9] serial: imx: Fix out-of-bounds access through DT alias
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <baohua@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Uwe,

On Tue, Feb 20, 2018 at 11:31 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Feb 20, 2018 at 10:40:18AM +0100, Geert Uytterhoeven wrote:
>> The imx_ports[] array is indexed using a value derived from the
>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>
>> Fix this by adding a range check.
>>
>> Fixes: 9206ab8a0350c3da ("serial: imx: Fix out-of-bounds access through =
DT alias")
>
> huh, this patch fixes itself?

Oops

    Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference b=
ack")

>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/tty/serial/imx.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 1d7ca382bc12b238..e89e90ad87d8245c 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -2041,6 +2041,11 @@ static int serial_imx_probe(struct platform_devic=
e *pdev)
>>               serial_imx_probe_pdata(sport, pdev);
>>       else if (ret < 0)
>>               return ret;
>
> I'd prefer an empty line here.

OK

>> +     if (sport->port.line >=3D UART_NR) {
>
> I would have used:
>
>         if (sport->port.line >=3D ARRAY_SIZE(imx_ports))
>
> which IMHO is better understandable

OK.

>> +             dev_err(&pdev->dev, "serial%d out of range\n",
>> +                     sport->port.line);
>
> Note that the same overflow can happen when a device is probed using
> platform data (and your commit fixes that, too). Maybe worth to point
> out in the commit log?

That's correct. But board code is tied more intimate to the kernel.
Will update.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
