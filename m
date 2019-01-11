Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8120BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F61520874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="mvNnOY5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfAKLNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:13:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39370 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfAKLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:13:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so14740653wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCboTPOZEsIJhvmech9H+xpyazvbxiQ3ukJhOtVy2aI=;
        b=mvNnOY5KzGyN8P8YNvsZEJ4Ct9MEd8+eoEzDhrsjmnn/QF9XNOaP0rbwsZXrIevrSv
         lZaFre1lAEzrucFLWyzk2Z85iUlWnoDrcWcLDjwUCDElC5QbJigb41S1Ak6gNIAsXE2m
         A9GZX/zne+xt/vb522i2HTvAYmaYTR4/z+RViGQvRILyXopUg9tipBtUO4iTeuRkhvjj
         GdcngrN2I19NsJgPvkwUr77+DycOrKnxQhWpcqyEYXzZRPqZW8DO/8rVwJIyxJbBIRfW
         CdsAcV9rKvqMnKh4f4TpsGGM8vgkTZg/dF0i4Usht2KGiLvixzEU6Pe80sHpufq1q4D3
         LJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCboTPOZEsIJhvmech9H+xpyazvbxiQ3ukJhOtVy2aI=;
        b=D3rOo0NK4g8V6OXzSwE4HmqvOHHY7TcBUJSenDrWe3vRIorEi+qxTXFftT2J4CgLpX
         /xPtCrMmZN3hYG4OJ+QOS6GayqKAkhQ/VFhjm8ShMyXv+f3Nb0P7PdkulrsQjpIEQY1e
         Hr26seWEw22C4DVuQC75SIdS1dFS8NKR/w1n7G6zRdH7PINjdJ0KDFPaAi8bzfsIezY5
         Cgtf8dBPTQ0iCG+0rl9poyqp+e3Glqsry24xj++8Pmzlfo+3+S9DqYWdPItzAXMfQI9a
         aCmIhu5kioNYqzEcoc9DMpYnEQNFkwInOgV9a84LKoOJfP6yiKOiqLZXcwyLF7rkQ94F
         XS0Q==
X-Gm-Message-State: AJcUukcIsIIi1+Eya4JRcBeMXhrMoDQ3jd/uggUncgVEZuJaWjHv1CSo
        GBMOJCK4KFTftDMJmmUaI+nnxJql7GWq0QieZy5cPg==
X-Google-Smtp-Source: ALg8bN6Ec1kojcYvFeUW5rr25UH7Wf3VukkfEoGqS1eg/+zwFHebDO/0IWOt/Ya82T/KTYPn2fT49egMVw7cds/mRXw=
X-Received: by 2002:adf:f785:: with SMTP id q5mr13771853wrp.9.1547205221410;
 Fri, 11 Jan 2019 03:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20181204135507.3706-1-anup@brainfault.org> <20181204135507.3706-2-anup@brainfault.org>
 <mvmbm4oehd5.fsf_-_@suse.de> <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
 <mvm7efcedop.fsf@suse.de> <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
 <mvmsgy0cu9g.fsf_-_@suse.de>
In-Reply-To: <mvmsgy0cu9g.fsf_-_@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 11 Jan 2019 16:43:30 +0530
Message-ID: <CAAhSdy07AeWeMxQJvzRGzMQ84Sxc6O899T0dWO1vz0LB89ORyw@mail.gmail.com>
Subject: Re: [PATCH] tty/serial: use uart_console_write in the RISC-V SBL
 early console
To:     Andreas Schwab <schwab@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:41 PM Andreas Schwab <schwab@suse.de> wrote:
>
> This enables proper NLCR processing.
>
> Suggested-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  drivers/tty/serial/earlycon-riscv-sbi.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
> index e1a551aae3..ce81523c31 100644
> --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> @@ -10,13 +10,16 @@
>  #include <linux/serial_core.h>
>  #include <asm/sbi.h>
>
> -static void sbi_console_write(struct console *con,
> -                             const char *s, unsigned int n)
> +static void sbi_putc(struct uart_port *port, int c)
>  {
> -       int i;
> +       sbi_console_putchar(c);
> +}
>
> -       for (i = 0; i < n; ++i)
> -               sbi_console_putchar(s[i]);
> +static void sbi_console_write(struct console *con,
> +                             const char *s, unsigned n)
> +{
> +       struct earlycon_device *dev = con->data;
> +       uart_console_write(&dev->port, s, n, sbi_putc);
>  }
>
>  static int __init early_sbi_setup(struct earlycon_device *device,
> --
> 2.20.1
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
