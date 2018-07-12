Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB87C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8E021476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFtdW8tX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ZcYNmrV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8E021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeGLICC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:02:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33939 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeGLICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:02:02 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so23352650qth.1;
        Thu, 12 Jul 2018 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=umaRSsomfK1AGA5JYxVGzEcUVXcPqgUkiVNVUFEAPX0=;
        b=fFtdW8tXnsSyBq5shO4Re2H2nvaWzixQLxxuc3Az21W3+LnbWAaGwQ8xSyHhMVcirn
         7jT00i2B2ER8CW0FCOdEBuar/8qQNArGczcBMPbuLm8qaysXXaeNTtqgjwZoXFmtSkWB
         CmerVRjwXnLl28aC3lae0cYSeJ8lsUHxVOGZHm5zfHz/U8EPuSuEapV8CBn6aCcVMesc
         6zn3wbcVN8fczNWC3arEuMeBrKYcd64dN6lZznNUaNu9bJwbF+dS0vOTCqt9G4q9LfnQ
         6vOED7KvWeFEoR22dROv1NGf+ks4vJlMCM0nabihbvpch3tCx13E/XN/DYxT522NSBbB
         7gsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=umaRSsomfK1AGA5JYxVGzEcUVXcPqgUkiVNVUFEAPX0=;
        b=ZcYNmrV1ZMCAIhvVXeq+kSSFqG0ynUT5CIGjU/ZA6rfR5p/vErzRyawJ6cqL/XI4s4
         WXp58ridlc8eXYdzXbh7QdIw1IZ/HLRPWiwdcxxSvZV4fUKuzA0fQasDzXVc14XCt7dL
         ek2p3cKlhali+MxRZqe4dvv4n6l0+lOnFsD+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=umaRSsomfK1AGA5JYxVGzEcUVXcPqgUkiVNVUFEAPX0=;
        b=Ptw5d97E+qBvzevNesuNfRxglHLOAeYqh5KGPrdGAP3iYGxiln/tJ4ZJmlkK+4PT4Y
         adPo9Im/vUyEN1UWBGTVDqP62+Y8TSOMVqQPkkZF4aHrp2h8GDuA8WyTlQVmSAHCViB6
         zcOcbM8R0J+qyR3+Qx8JVFEgZFnykhHnMg22ArB8/e/XWUDnRO/0djsPPXJjuACCXxmG
         IhjfwVKymvCQ9xF9oaa56nlFRwVGZKosMQ8qN2mT811D+P+eg+3/wWgpcbY/5N9dJmWx
         rgFwIc8XkcmUaFy8R1NZ7Qp2B+RidwpPOBqfiZ6sHPrRAj8dJEYVrt6W2HQGbcDRVP2h
         DXdw==
X-Gm-Message-State: AOUpUlGmy/nXj/lmkTLLZvur5/HVx0O23EzM6CuSXqYoGALtpgKPkORM
        T1FmyB2e1nWoBTvEN6OqhIFjqh9s7Ul5vbUlRgY23Q==
X-Google-Smtp-Source: AAOMgpcenqW6JfXzYejz22drDTzxF+UCd/z65v0rH9d5/T275LnY1c5SuS5M8cCTk4VlD2qemb7SlyKN5IcTSeBj7OE=
X-Received: by 2002:ac8:322:: with SMTP id q34-v6mr913548qtg.342.1531382017803;
 Thu, 12 Jul 2018 00:53:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 00:53:17
 -0700 (PDT)
In-Reply-To: <20180712034847.12878-4-benh@kernel.crashing.org>
References: <20180712034847.12878-1-benh@kernel.crashing.org> <20180712034847.12878-4-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 12 Jul 2018 17:53:17 +1000
X-Google-Sender-Auth: _jN1OIqmHZD8kuuJsta4l61bVgE
Message-ID: <CACPK8XdZKbh2NLQaiZOx66FAo+3csS_D9-BXjJKeppKm8aEM6w@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] fsi: master-ast-cf: Add new FSI master using
 Aspeed ColdFire
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 July 2018 at 13:48, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The Aspeed AST2x00 can contain a ColdFire v1 coprocessor which
> is currently unused on OpenPower systems.
>
> This adds an alternative to the fsi-master-gpio driver that
> uses that coprocessor instead of bit banging from the ARM
> core itself. The end result is about 4 times faster.
>
> The firmware for the coprocessor and its source code can be
> found at https://github.com/ozbenh/cf-fsi and is system specific.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/fsi/Kconfig                      |    9 +
>  drivers/fsi/Makefile                     |    1 +
>  drivers/fsi/cf-fsi-fw.h                  |  157 +++
>  drivers/fsi/fsi-master-ast-cf.c          | 1438 ++++++++++++++++++++++
>  include/trace/events/fsi_master_ast_cf.h |  150 +++
>  5 files changed, 1755 insertions(+)
>  create mode 100644 drivers/fsi/cf-fsi-fw.h
>  create mode 100644 drivers/fsi/fsi-master-ast-cf.c
>  create mode 100644 include/trace/events/fsi_master_ast_cf.h
>
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index 322cec393cf2..e0220d1e1357 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -27,6 +27,15 @@ config FSI_MASTER_HUB
>         allow chaining of FSI links to an arbitrary depth.  This allows for
>         a high target device fanout.
>
> +config FSI_MASTER_AST_CF
> +       tristate "FSI master based on Aspeed ColdFire coprocessor"
> +       depends on GPIOLIB
> +       depends on GPIO_ASPEED
> +       ---help---
> +       This option enables a FSI master using the AST2400 and AST2500 GPIO
> +       lines driven by the internal ColdFire coprocessor. This requires
> +       the corresponding machine specific ColdFire firmware to be available.

The "machine specific" part isn't true anymore, is it?

I gave this a spin on a palmetto and it appeared to work fine for me.

Tested-by: Joel Stanley <joel@jms.id.au>
