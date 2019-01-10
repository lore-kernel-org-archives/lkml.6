Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63706206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eU/+6VpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfAJQRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:17:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51456 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfAJQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:17:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so11838960wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7zd4F4iCg7LqUJrAtDsKz7+E+kJNDA5tf+6CtbsY7Q=;
        b=eU/+6VpX2yaywkjodLF6Hqp2XAB7DKmZTsrA7KnUGxFncAS2CJADrKxdofrFgLRw4P
         eHTNOAh1gHe46rsFeSp2MFaNJM2XL1q1hbbBBgVLpvbebUHzGaDuhyTaQ6scTu7gK7W+
         JO4pL6k/kY/3+Geqs0v2vSmuQwVhq1eoIXJZq8Y2GOAvx9G2mRE3hymg+A25pc9zOe5I
         +T5/SlxjLqqM0IiV4vfUPBow9aT+D4DYXMyuC+UYOg4rSBbYgRzB1iQgfuE66Xl9b3WF
         HZDIv757/25JbpwnUqO3hbQp4zUVnHUQ8DLs2TNClWyUnMCGMZ5iAvE6T5Y0P+hoUkJK
         H0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7zd4F4iCg7LqUJrAtDsKz7+E+kJNDA5tf+6CtbsY7Q=;
        b=ALuXlFxEyU+V7XtZWWNN9et7yoyafmkqZqxucLCTUYY9zIJIYbnMZkjNjA7XbQGAVz
         52twKPgiUKHsv3RYYvnNxMKybeFkvBNqX7ikaYAPHtOrmeyvrlidWIQ3prpLZ2nXe3Au
         i+WwIqACtdHMd88b9HORt3yWnwbfN5pbVnX/UIH4hMfystP8op6MMESyCFaE5VrEzETA
         DqGdtbhjNH+GkXV/qe2yA84DRW9IFw2IGXV/zHKjUAUeIwlY5yPKEjaGArmgKiDNwdhz
         beycFFXy+d3/gByZcR7lgYNf69asYgjq52gu3NsMI9az7Ozg+liZ6qm4F7Fq/cqHLMF8
         yzpg==
X-Gm-Message-State: AJcUukcZ4Qn9UDqsGK8fhLyE9v8o3dNeYlV1+M2F+m0BLd4bbewr/39K
        6vLAvk0Vh+4GNm56q0AWImH0EVNKMjbw8ABZACaR/Q==
X-Google-Smtp-Source: ALg8bN6AAzhTc8eiJ5/RdCwaMAu4nfBEQKLa3Fg3gFECP6GCQfpAJuksSHlEu/FiybRFHYBOZWIeRK1cc9EwWF5FhM8=
X-Received: by 2002:a1c:f509:: with SMTP id t9mr11115100wmh.76.1547137038333;
 Thu, 10 Jan 2019 08:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20181204135507.3706-1-anup@brainfault.org> <20181204135507.3706-2-anup@brainfault.org>
 <mvmbm4oehd5.fsf_-_@suse.de> <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
 <mvm7efcedop.fsf@suse.de>
In-Reply-To: <mvm7efcedop.fsf@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 10 Jan 2019 21:47:07 +0530
Message-ID: <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
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

On Thu, Jan 10, 2019 at 8:56 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:
>
> > Instead of doing '\n' handling here, we should do it in BBL or
> > OpenSBI (i.e. SBI runtime firmware) otherwise all users of
> > SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
> > FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
> > handling.
>
> I don't think the serial driver should do NLCR handling on its own,
> without being instructed by the tty layer.  Since the earlycon does not
> have a tty layer, it needs to handle it explicitly.

I tried to investigate more. What you suggest is correct
but we should use uart_console_write() API.

Instead of explicitly doing NLCR here, we should do
something as follows:

static void sbi_putc(struct uart_port *port, int c)
{
    sbi_console_putchar(c);
}

static void sbi_console_write(struct console *con,
                                               const char *s, unsigned n)
{
    struct earlycon_device *dev = con->data;
    uart_console_write(&dev->port, s, n, sbi_putc);
}

The uart_console_write() does the NLCR handling.

Regards,
Anup
