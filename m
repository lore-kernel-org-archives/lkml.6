Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41423C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D65204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7v57mex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D65204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeKGFc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:32:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41356 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeKGFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:32:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id g188-v6so5891599oif.8;
        Tue, 06 Nov 2018 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLV1ZLV6bEBiwFfEIulQTxqa2Qx+/ZSqVGOVx9qG7D8=;
        b=M7v57mexC9eeEkuGNnR1Hm0ualap8tGgxDF6sDaBSj4PNWtwXgvzxzYhc9AO4Ijq8t
         BxAHzjWXTUUZJHKlWNAAbXaDaVweT//aaWdrq0d81r7/F698WZ303z6sz3NzzJFhe57H
         qUt4fJ5R/43uYIuiXKDM02t2GHRhYTaWEMvHj9205vF4tCBNBGudfll76isw+DxxhcBD
         sBjdUaD60faDuV02LFB7d8X5SuDSp4do9P0KV/nFnxSbY/71CUqEAPpF80iXE/9rE5Lk
         29Jt5Gmu6OW5HYkjPrYN32Imx/M7s2QI9w5jdwhygt1LahDPoXH9pyu2PV2j8/CEBxsv
         hGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLV1ZLV6bEBiwFfEIulQTxqa2Qx+/ZSqVGOVx9qG7D8=;
        b=XDGPfAnrLQi248DFIRj5ULoRfOEkhy7poaEQqa923PHejCueGCR9z1jjGVovo0eMVR
         8uhh7jPjvxCxzG7VdIqqmPQfjs3Dt3RlFrCdrrXgH+yIdbjFHkv5JHPYajNCfaNp63jy
         1vrd/XRSJuJhoIHPP82QCXXDnz6511+QQUmg65pWugjntwk2knrLt+pIrKQl+tMXxTeB
         wpi8N55VVQcFV8g6c/b6j9OJsw5J257HC8Pkx6xHBhFMpHJyt031pKzGKcZWhHb+bVQh
         93DoHfkofLdW6QMYQYEj4n7W4KhQ7Ehx53N4HEuf5600fFGb6InbcDgWJYLA1bE0VWxR
         a7Ow==
X-Gm-Message-State: AGRZ1gLceLnO0pZMiKRBzChUPfizN0jM4cc9RMhMknS4QijQ/78rFJTs
        K5JBip/74smk3Xuj5mYiIM0aqPmtyuaLlFAmysQ=
X-Google-Smtp-Source: AJdET5dgpB7/ae3yg0k0ZB+mbSQfOQFD+Ae2fhLkWZEaHUtS3QoX13ToQKbX+JnZcwc7ip34XtBkNmxvVoNe9WLJhpQ=
X-Received: by 2002:aca:3884:: with SMTP id f126-v6mr17054972oia.239.1541534735259;
 Tue, 06 Nov 2018 12:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-2-TheSven73@googlemail.com> <20181105212049.GA320@bogus>
 <CAGngYiUZTm-r0KJ07tKsPmgKCUWcqAOx2S82iLPRjkcDiw0R3g@mail.gmail.com>
 <CAL_JsqLgz9Z3J0x+QFU6jHOoHn6A1KASc+HbVLnW1=ow0RHv6w@mail.gmail.com>
 <CAGngYiXczK6dsfyDGxe1ym-vQQfH5XS0jeEkuWW_og23JmTAZg@mail.gmail.com> <CAL_Jsq+YeW+BtVh=L8PBjXYLj9sp91BcUQrJJrwnmChRnXoK_w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+YeW+BtVh=L8PBjXYLj9sp91BcUQrJJrwnmChRnXoK_w@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 6 Nov 2018 15:05:24 -0500
Message-ID: <CAGngYiXfmD-EVKcN-L1fBOgyX4JrMqRx295F1p90shygL7zccg@mail.gmail.com>
Subject: Re: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
To:     Rob Herring <robh@kernel.org>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 1:31 PM Rob Herring <robh@kernel.org> wrote:

> If the host is not a h/w component, but just a s/w protocol then it
> doesn't belong in DT. Perhaps it could be a library which the bridge
> driver can call into.

Anybus cards have an id register, which identifies what they are, so
that the appropriate client driver may be instantiated.
In that sense anybus is very suited to the bus/client abstraction of
pci/usb/etc.

> What are the resets connected to? The slots? Maybe you should model
> the slots in DT.
>

Yes, the resets are ultimately connected to the slots.
I'm happy to model the slots in DT. It makes sense, they are physical,
hardware components.

>
> A block diagram would help. Something that shows the host SoC, your
> CPLD, reset, irq, etc.
>

  +------------------------------------------------------------------------+
  |                                  SOC (i.MX6)                           |
  |------------------------------------------------------------------------|
  |     i.MX WEIM bus                                   | i.MX GPIO        |
  +------------------------------------------------------------------------+
                ^                                              ^ ^
                | parallel bus                                 | | irq x2
                v                                              | |
  +------------------------------------------------------------------------+
  |                                     CPLD                               |
  |------------------------------------------------------------------------|
  |             anybus slot 1             ||            anybus slot 2      |
  |------------------------------------------------------------------------|
  | memory bus               | irq| reset || memory bus       | irq| reset |
  +------------------------------------------------------------------------+
                ^                                               ^
                |                                               |
                v                                               v
  +--------------------------------------+ +-------------------------------+
  |          anybus card                 | |           anybus card         |
  +--------------------------------------+ +-------------------------------+
