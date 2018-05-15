Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247740-1526419303-2-11100997847360881696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526419302; b=GHlxKzx6Oxs6dR28MDKPs2ncb0qJ1rPg2X6hpw6h5NLpOqKZQG
    d9WaKtBZqvqLtt0FFQxqPZ9BxP6b9FlBTHQTPY+Syrr5RgfTbVz6TkdikFnN5xt2
    qgXLRc2YwiT67Kw9XrWJewDT9fb9XTTFfguHBf7sdsI8efRA0TplQ4Qzl1cIlb3y
    TPokSEpzfVTzahVa6mGRXDJ+9JFcgwV+ZqayQXf+HU07NFB6pF/zPObdtgahl/0O
    Krjb6Iyq5HwqOOEBXdCfcE5emHe9OF4MiViIeDLDkbb7FE1TkdvE+mPcb270+06m
    B85G4YezFMinxIpAXdlsTEgbI8ywHUK3jdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526419302; bh=XCwvxtNk5DzVM8U5z9zEUxj1ddiMbZrf0N/aK+6Fj4
    E=; b=dd9Rim4mQ9pHoyiJ5DCU/nDNh3pnlZtFTFcDkIiEUKijxHjn9AbysD/TMa
    6yfI2iqskNHF+jtyQjJv7PEEbknOKXU8AtIiVzr9QWiZP4/nBZr4zyyA7+6ooqoe
    5Unl5txX+TotnKAqp1eRVFvHHstmolb/1llhub3aZWMAQJGY3bTzU1GQRODz+Ar1
    B/7YW3OKw4a5qSdamfPRL9uEMsQraYHsEZWnYEuXrxfrNf4AuzOHMPVQXuBsZXam
    HTE1iJYj/oOq/F+OHSmQQypLd8SfhlYXeyjyPeOQpoyl/2w699vw8ps63GXNwu23
    3DBHxeh/NLhrpjhyFdEExqZ2Otfw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GjXYeyXg x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=JKm867NU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GjXYeyXg x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=JKm867NU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOauHbshJPA3TYBLeOQqAagBz4aB2IsaSluDw/daIJJJWAWhFS22GHzwsPyD7DHH1QdBea9meSgH+V/FXN+wWbecGFOkhDl41ZEEOcPGrCm8OROuCbnM
    NNaQoeJTp5B0Pd0UHw4p4WJU410ZJ/CDWiJD5fm7V0urb9QHBL8031o2edKYAMLn0ps2zARdgmhiRivBTMCfVlgxhFOVq14WWpTLGtouQnhc0HsgECVhRVO+
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=CbDCq_QkAAAA:8 a=zeAeT-1tAAAA:8
    a=VwQbUJbxAAAA:8 a=kQ5SHOOPlEmXhBcScvAA:9 a=j9iOmTyA6BDeWNCR:21
    a=QWrBaOSXa8bhxGhO:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=q4mi67SYSo5Z2N87e4-W:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeEOVVj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 17:21:39 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36723 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbeEOVVh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 May 2018 17:21:37 -0400
X-Google-Smtp-Source: AB8JxZqi0xZPcyi45/szUYWmr5XylYAnXn4h1xa6ibkOTYgWl2kpg3ouL5RESynGOJ9ch4Ynbn3By9H85uT9f9LFqrE=
MIME-Version: 1.0
In-Reply-To: <1526394095-5069-2-git-send-email-oleksandrs@mellanox.com>
References: <1526394095-5069-1-git-send-email-oleksandrs@mellanox.com> <1526394095-5069-2-git-send-email-oleksandrs@mellanox.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 00:21:35 +0300
Message-ID: <CAHp75VctG5RBtLF3nT5e_j7_e9O12u=5gerJ6OMxWbABM9ft2w@mail.gmail.com>
Subject: Re: [patch v21 1/4] drivers: jtag: Add JTAG core driver
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Tobias Klauser <tklauser@distanz.ch>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        system-sw-low-level@mellanox.com, Rob Herring <robh+dt@kernel.org>,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 5:21 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
> Initial patch for JTAG driver
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.
>
> Driver exposes set of IOCTL to user space for:
> - XFER:
> - SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
> - SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
>   number of clocks).
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
>
> Driver core provides set of internal APIs for allocation and
> registration:
> - jtag_register;
> - jtag_unregister;
> - jtag_alloc;
> - jtag_free;
>
> Platform driver on registration with jtag-core creates the next
> entry in dev folder:
> /dev/jtagX

>  0xB0   all     RATIO devices           in development:
>                                         <mailto:vgo@ratio.de>
>  0xB1   00-1F   PPPoX                   <mailto:mostrows@styx.uwaterloo.ca>
> +0xB2   00-0f   linux/jtag.h            JTAG driver
> +                                       <mailto:oleksandrs@mellanox.com>

Consider to preserve style (upper vs. lower).

> +         This provides basic core functionality support for JTAG class devices.
> +         Hardware that is equipped with a JTAG microcontroller can be
> +         supported by using this driver's interfaces.
> +         This driver exposes a set of IOCTLs to the user space for
> +         the following commands:
> +         SDR: (Scan Data Register) Performs an IEEE 1149.1 Data Register scan
> +         SIR: (Scan Instruction Register) Performs an IEEE 1149.1 Instruction
> +         Register scan.
> +         RUNTEST: Forces the IEEE 1149.1 bus to a run state for a specified
> +         number of clocks or a specified time period.

Something feels wrong with formatting here.

> +#define MAX_JTAG_NAME_LEN (sizeof("jtag") + 5)

Interesting definition. Why not to set to 10 explicitly? And why 10?
(16 sounds better)

> +struct jtag {
> +       struct miscdevice miscdev;

> +       struct device *dev;

Doesn't miscdev parent contain exactly this one?

> +       const struct jtag_ops *ops;
> +       int id;
> +       bool opened;
> +       struct mutex open_lock;
> +       unsigned long priv[0];
> +};

> +               err = copy_to_user(u64_to_user_ptr(xfer.tdio),
> +                                  (void *)(xfer_data), data_size);

Redundant parens in one case. Check the rest similar places.

> +static int jtag_open(struct inode *inode, struct file *file)
> +{

> +       struct jtag *jtag = container_of(file->private_data, struct jtag,
> +                                        miscdev);

I would don't care about length and put it on one line.

> +       if (jtag->opened) {
> +       jtag->opened = true;
> +       jtag->opened = false;

Can it be opened non exclusively several times? If so, this needs to
be a ref counter instead.

> +       if (!ops->idle || !ops->mode_set || !ops->status_get || !ops->xfer)
> +               return NULL;

Are all of them mandatory?

> +int jtag_register(struct jtag *jtag)

Perhaps devm_ variant.

> +#define jtag_u64_to_ptr(arg) ((void *)(uintptr_t)arg)

Where is this used or supposed to be used?

> +#define JTAG_MAX_XFER_DATA_LEN 65535

Is this limitation from some spec?
Otherwise why not to allow 64K?

> +/**
> + * struct jtag_ops - callbacks for jtag control functions:
> + *
> + * @freq_get: get frequency function. Filled by device driver
> + * @freq_set: set frequency function. Filled by device driver
> + * @status_get: set status function. Filled by device driver
> + * @idle: set JTAG to idle state function. Filled by device driver
> + * @xfer: send JTAG xfer function. Filled by device driver
> + */

Perhaps you need to describe which of them are _really_ mandatory and
which are optional.

-- 
With Best Regards,
Andy Shevchenko
