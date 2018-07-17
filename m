Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BF1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE73920C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+BTnApS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE73920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeGQLHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:07:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33080 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbeGQLHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:07:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id l10-v6so1102881oii.0;
        Tue, 17 Jul 2018 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vBuNjniP815EcWsfw2XvBXHwvfQQYauua7PZyy9IUX8=;
        b=U+BTnApS1I+17pzbKCMDgwhcbP3KL8IsBvrRMAIftxJ6CKxzTDXgPhX9zC7NNSKoTK
         XDXGZviZ15c/l4YnzmScpFaw69epesRf5VLTWJZzp9xk9Hgi0EKNaTS1aCxofdmiGicK
         S9vsoNfq4+OKRxpcighDY+J4m8u2VT8rflSkX0cs3LFAe+Di+6Ni2VHnUTUcdTDq7BJN
         58ldcfMPU3HrWRDGVLOXfSj9jrzXiWhAKhZh5PwWwJthUnI4DJSMHpYoXQGUDIxGtIuK
         +ziiXUU9qVNqKG6MEQvlf8M7wpkMgCdZVLq76lYx6lJYu2JiNe2citeiLozPDRMQwBsK
         ikiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vBuNjniP815EcWsfw2XvBXHwvfQQYauua7PZyy9IUX8=;
        b=n+CwpeCQI2o8cl7lizaIIsl8StOKyQhM1/T04vA773b0fFPnTAN9Akt8HWFDtgzzaH
         wMLb8LFNfhRBYxlT2Va3HfuRoclHGj/NPiTHwDap6aJC2TD43m47UEu7+kWtXQ37Sfhw
         /seYE04gFgxdk0q1x54UcLujXognArwM77FDoWUhTIt5UeyN0b+dmLOj28Eu2yDyoxUd
         On0XC2FD9YLpaWogySTGoi42D2m60yUYBPZGoar2u8CmkUuEGRXky9rxRS/Im94h8MdY
         7Jn1945Yupw/PTeBarBboeubqpqvplWgsMvHubR8w9Q+KmeTM3Ewut8Z7v5bF61WjeIC
         Z0Rw==
X-Gm-Message-State: AOUpUlEE/lWxmW2dD3tm70vAeTud/z6AfgLFcdSnCRNgEU8JjB/7bUlU
        jrVxsF2ibYkRZtqUhRLMRADRGYD8LmLslf6VCQ==
X-Google-Smtp-Source: AAOMgpdU66emNNLIfsF3fV5GK9P3xv8Nvz6b+vvP2CoJFafLOGeML4ePeVIKdsUtnC+q0+LLtHoY8AAW89dAS0Ndpjw=
X-Received: by 2002:aca:a982:: with SMTP id s124-v6mr1095664oie.80.1531823735114;
 Tue, 17 Jul 2018 03:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:761e:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 03:35:34
 -0700 (PDT)
In-Reply-To: <20180717085810.23502-1-geert+renesas@glider.be>
References: <20180717085810.23502-1-geert+renesas@glider.be>
From:   Ulrich Hecht <ulrich.hecht@gmail.com>
Date:   Tue, 17 Jul 2018 12:35:34 +0200
Message-ID: <CAO3366w+3v3vqNq=PHeKMB4uumwgJeXXqnby8HB4jLmBQiVDRQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Fix use-after-free on subsequent port startup
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:58 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> sci_request_irq() checks port->irqstr[j] for a NULL pointer, to decide
> if a fallback interrupt name string should be allocated or not.
>
> While this string is freed during port shutdown, the pointer is not
> zeroed.  Hence on a subsequent startup of the port, it will still be
> pointing to the freed memory, leading to e.g.
>
>     WARNING: CPU: 0 PID: 404 at fs/proc/generic.c:388 __proc_create+0xbc/0x260
>     name len 0
>
> or to a crash (the latter is more likely with CONFIG_DEBUG_SLAB=y, due
> to the poisoning of freed memory).
>
> Instead of zeroeing the pointer at multiple places, preinitialize
> port->irqstr[j] to zero to fix this.
>
> Fixes: 8b0bbd956228ae87 ("serial: sh-sci: Add support for R7S9210")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5808edfe3f7be404..f8e53ac5c17dfb94 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1872,6 +1872,7 @@ static int sci_request_irq(struct sci_port *port)
>                 }
>
>                 desc = sci_irq_desc + i;
> +               port->irqstr[j] = NULL;
>                 if (SCIx_TEIDRI_IRQ_EXISTS(port)) {
>                         /*
>                          * ERI and BRI are muxed, just register ERI and
> --
> 2.17.1
>

Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

CU
Uli
