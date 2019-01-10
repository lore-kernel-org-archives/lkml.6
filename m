Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D81B214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CLGlrGmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfAJPRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:17:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfAJPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:17:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so11783976wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLob20iXtV9X7gzcBBmME2TKZCOWr+JMlcZgUCIIS/8=;
        b=CLGlrGmU/fE47yJC3vvgHYxs6IZbObwxvuEHj2kbL3oe8qZD9l53a/Kwe6Bk2FgaIp
         9xhXyueKPowmdUuSEU5VVuaL9D3TX/FsHNn/9hmmHiPlZdA0sWWZukhEQbqEhECiYsIN
         WT7jeR7AlwUyeyq/73ARJzgv/tk53UEQriCNroVKgClb78mcXnhyAhCF7TBMr5giV8ru
         43gf+XkYWee9+UBCgjHTcsMqHlYzZdcxFKq3t/5zvI1Jj9jyXKUoVvHXZeuTmrVJz8/f
         OCW9mq4yDCJlx+DeIK7DQCFh1XDaRkaehXQ6nPBEWN43lj+zZGHTXrXbCpLFZjKAtcZ4
         Gwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLob20iXtV9X7gzcBBmME2TKZCOWr+JMlcZgUCIIS/8=;
        b=owV3kEE/tENAsedsBjG5SmewKelC6ySnpeAazrj0QfpQLDKUlNX2LM8BBpmGZqRaWK
         e+F+1l1IrV6vC0kcllt0nDTSBWzx7VhUdizOvJyIp3cPo2/XBWkp4Ya9lnkHWHOsvjUv
         +rn02x0MDwAG98bt1kfjzhbv+hcqnujiLjPD/B/DyBC8BtByAGSRA139CEc8LrdygpGb
         PkTo0XuNlxGPr+zlPpr9dP7gNsuc2tGlmKWogWp9lwi/dxvSWFsDXB6rwJyKweq39UJw
         sm3IT1JcdqzCBoxkBfa0QHxlcnQhpgBYlooMdVUKCpqaMkyDr9h0lErbpJ62/xpjB1nD
         WGUg==
X-Gm-Message-State: AJcUukeV2NPtCrnnpuhHsqfg95bGHnO1CgMbQkwmlvaimEMwGjCXzrlL
        sWmGGpj5SyrnvThsTT/URwV9V7UgBkneSfiFLWwtyw==
X-Google-Smtp-Source: ALg8bN5ZocbycUhIhtxfAD5g5576IxpG75CRbU0PSgI/nKYxXHffObzlesBrmjU9pCsreCJcH7UYxVmM8Mc0OYhKeHs=
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr10352859wrp.59.1547133422301;
 Thu, 10 Jan 2019 07:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20181204135507.3706-1-anup@brainfault.org> <20181204135507.3706-2-anup@brainfault.org>
 <mvmbm4oehd5.fsf_-_@suse.de>
In-Reply-To: <mvmbm4oehd5.fsf_-_@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 10 Jan 2019 20:46:51 +0530
Message-ID: <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
Subject: Re: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
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

On Thu, Jan 10, 2019 at 7:37 PM Andreas Schwab <schwab@suse.de> wrote:
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  drivers/tty/serial/earlycon-riscv-sbi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
> index e1a551aae3..9c51b945b5 100644
> --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> @@ -15,8 +15,11 @@ static void sbi_console_write(struct console *con,
>  {
>         int i;
>
> -       for (i = 0; i < n; ++i)
> +       for (i = 0; i < n; ++i) {
> +               if (s[i] == '\n')
> +                       sbi_console_putchar('\r');

Instead of doing '\n' handling here, we should do it in BBL or
OpenSBI (i.e. SBI runtime firmware) otherwise all users of
SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
handling.

Currently, the BBL does not handle it but we have already
handled this in upcoming OpenSBI.

The SBI_CONSOLE_PUTCHAR is comparable to ARM
semihosting early prints (refer, tty/serial/earlycon-arm-semihost.c).
Even in ARM semihosting early prints the '\n' is not explicitly
handled.

Regards,
Anup
