Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PQwVL2x8HlsITQAAmS7hNA
	; Mon, 11 Jun 2018 13:43:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A388360792; Mon, 11 Jun 2018 13:43:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baDsWe+S"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E00A260541;
	Mon, 11 Jun 2018 13:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E00A260541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933217AbeFKNnG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:43:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41059 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeFKNnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:43:04 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so30594700lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eLE1+Xqa4ovl+iM3K6g5LThkrbboXYHn47RULbSeKao=;
        b=baDsWe+SYSHwITlzqYGAatf3otBRVQF0Vo3Jih7Z/6ynEdU6yk3cA8todjTETuCkdu
         XeEP4Z/P3Mp0C2tpy3Y/kZQ5InxZlC9tb7buJ+rrd4IOv2s21VJJCxzpOFrYhGTSQTQc
         0sFrFjM+HH+2gd6DJI1D9mvrWetoqZiIxgdxetrVHG2jnsY+mfemlAx0+imY4IBq97SB
         s5AoWSDkDdDgzjimGy6PpEs904lwKPx2xYkpaTQ7DxfUXzCR0tEOA/mXmLdq5jKqGRDU
         V1t49NADcAhxuavo0FBoI2MRao9ftReY2rLveHZWfFm0DEVHxyV1zFjdiqbXxsIaD7/9
         17fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eLE1+Xqa4ovl+iM3K6g5LThkrbboXYHn47RULbSeKao=;
        b=r3AQ1PBglOVYm0RGbwHrYRZo7urYgHJEblKV0P5995M58uwVC4XdFZjmLvtRBnkYkO
         QbrGZfg5LnUUotu6wO9NAu9GtHvyZJGgexo8HAk16L6T0M0Wsmb4ThmGCPK77EMgtV/F
         XUYch7ScivEvFhVeCUsvnSiT96O2AkzKxHGD2W++QMoOtm4m+h0tLCLkBXdorEPkPHNl
         2m325rXmNKQwdUId507hADwAQ4NT77CQWzHuIbRinJFe945LnG6tqtI+n6fzXHQKdhhG
         Gq4oKp+o1QGA3T5qJEfdpTZZJo4qKjFhW0QkturF+qzhimltoo9x+eKCiQWBYBbf2Uve
         5GeA==
X-Gm-Message-State: APt69E0ouYtSrTPdAUZqpdCWooqU1sesWWo5qOgXXMKhNrRC3R2vnRPj
        ifzZ0rGs5HOoI9JpbzZxVsWanuHqGMVxKvTPkcM=
X-Google-Smtp-Source: ADUXVKLaggzvIibJxjRsQa9bSlG9zoToHW8t4fUqlUeQliCaJfuwi9ciOd6E/mlriTUY2II8+tLtQiC7/L3pkJ8Vcn4=
X-Received: by 2002:a19:3b0e:: with SMTP id i14-v6mr10258430lfa.48.1528724583057;
 Mon, 11 Jun 2018 06:43:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 06:43:02
 -0700 (PDT)
In-Reply-To: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Jun 2018 15:43:02 +0200
X-Google-Sender-Auth: YNOABGTAJGiWQKsIJPkIvtVEY6o
Message-ID: <CAK8P3a2aPshgrAp6=e62mvEpmmLYCAwRa_HxG_A1YKJ5we5XVQ@mail.gmail.com>
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
To: Don Bollinger <don@thebollingers.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        brandon_chuang@edge-core.com, wally_wang@accton.com,
        roy_lee@edge-core.com, rick_burchett@edge-core.com,
        quentin.chang@quantatw.com, jeffrey.townsend@bitswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Xin Liu <xinxliu@microsoft.com>, steve.joiner@finisar.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 6:25 AM, Don Bollinger <don@thebollingers.org> wrote:
> optoe is an i2c based driver that supports read/write access to all
> the pages (tables) of MSA standard SFP and similar devices (conforming
> to the SFF-8472 spec) and MSA standard QSFP and similar devices
> (conforming to the SFF-8436 spec).
>
> These devices provide identification, operational status and control
> registers via an EEPROM model. These devices support one or 3 fixed
> pages (128 bytes) of data, and one page that is selected via a page
> register on the first fixed page.  Thus the driver's main task is
> to map these pages onto a simple linear address space for user space
> management applications.  See the driver code for a detailed layout.
>
> EEPROM data is accessible via a bin_attribute file called 'eeprom',
> e.g. /sys/bus/i2c/devices/24-0050/eeprom.
>
> Signed-off-by: Don Bollinger <don@thebollingers.org>

> +
> +#undef EEPROM_CLASS
> +#ifdef CONFIG_EEPROM_CLASS
> +#define EEPROM_CLASS
> +#endif
> +#ifdef CONFIG_EEPROM_CLASS_MODULE
> +#define EEPROM_CLASS
> +#endif

I don't understand this part: I see some older patches introducing an
EEPROM_CLASS, but nothing ever seems to have made it into the
mainline kernel.

If that class isn't there, this code shouldn't be either. You can always
add it back in case we decide to introduce that class later, but then
I wouldn't make it a compile-time option but just a hard dependency
instead.

> +struct optoe_platform_data {
> +       u32             byte_len;               /* size (sum of all addr) */
> +       u16             page_size;              /* for writes */
> +       u8              flags;
> +       void            *dummy1;                /* backward compatibility */
> +       void            *dummy2;                /* backward compatibility */
> +
> +#ifdef EEPROM_CLASS
> +       struct eeprom_platform_data *eeprom_data;
> +#endif
> +       char port_name[MAX_PORT_NAME_LEN];
> +};

What is the backward-compatibility for? Normally we don't do it
like that, we only keep compatibility with things that have already
been part of the kernel, especially when you also have an #ifdef
that makes it incompatible again ;-)

> +struct optoe_data {
> +       struct optoe_platform_data chip;

Maybe merge the two structures into one?

        Arnd
