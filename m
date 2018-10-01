Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8718C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A73C208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ul4BXx6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A73C208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeJAU7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:59:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33400 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbeJAU7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:59:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id u88-v6so1340326ybi.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrJwvn7E7SYE+c98aUhypRWKtL2AHGPLU/zM3zx4MQg=;
        b=Ul4BXx6IJ11f3fVU5Wcgz3DWxpCjA8AAAPt5eV9rGiFmIecuqByFiLB9Mx2HCZ+2sf
         0ob4QiaMMf5FWMSMtHn1gXEwH/R/k3uB+r6UgPyuZ01vMWEcGjjyTQJEYGYGxkH37bts
         PTLnoYa1zchrwVGLMZW7FpRihx3+4KEgUL6Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrJwvn7E7SYE+c98aUhypRWKtL2AHGPLU/zM3zx4MQg=;
        b=XZQlRe+yhdp6+P8PPaqT7egaa7+60HxHEDUaVhj54q2bqVxdN8jXotLL1xnB/AM+Qk
         TgpHMLI+6/ZnQDsXuBmUUvKhh1+/Ep3MTP6jcQYAgxTcZUTrw+WAGy8tVVoRl0S6LOdJ
         SdyWRNbfT8al66f8p/oZTQjzODO94trdeDZYIKsKA2hIcDSv7u7bWdJl/z3r90YJrnE+
         byG8wBmy4xjX2u3JVqw8WRYVCzDF+MxxHrZ9KMiyhhmQzs3iLVz+VmM2Z6TgmcuIJWzG
         lEm9Q+jwCRusydke5tHO57XBTaEGaP5aC9x14gDlm7B+Q1nzr0GfrR8JvR8mKzaFm2iw
         E66A==
X-Gm-Message-State: ABuFfogLnC7BmL7pC7bHqJEG0pWzpeyxUezw04bIZrE1F6waqOeIwRlv
        8678CaRnNTb0Z6pZT0lPLsC390emYhNtzWW06SXMRw==
X-Google-Smtp-Source: ACcGV62Od+bT4J/6lFNZmH5qLwHiOs1V46wklhlq0jRMRnj7F3O8uz4iq3ydrF1K3apagx13Ug/WrQRhUtnIJtoOIlY=
X-Received: by 2002:a25:2c4c:: with SMTP id s73-v6mr3929391ybs.378.1538403710022;
 Mon, 01 Oct 2018 07:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org> <20180928173044.GA16322@agluck-desk>
In-Reply-To: <20180928173044.GA16322@agluck-desk>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 1 Oct 2018 19:51:38 +0530
Message-ID: <CALxhOni76kqr795gDemsb6QQn7LeM7jL7DqFA8pesJuJaBKFHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] System call table generation support
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Fri, 28 Sep 2018 at 23:01, Luck, Tony <tony.luck@intel.com> wrote:
>
> Still does not boot. Last part of console log (nothing unusual
> before the "Kernel panic" line):
>
>
> EFI Variables Facility v0.08 2004-May-17
> sd 5:0:0:0: [sdb] 286749488 512-byte logical blocks: (147 GB/137 GiB)
> sd 5:0:0:0: [sdb] Write Protect is off
> sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
>  sdb: sdb1 sdb2
> sd 5:0:0:0: [sdb] Attached SCSI disk
> NET: Registered protocol family 17
> console [netcon0] enabled
> netconsole: network logging started
> Freeing unused kernel memory: 960K
> This architecture does not have kernel memory protection.
> Run /init as init process
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>  ]---
>

Thanks for the update. I'm planning to solve this issue asap.

- Firoz

> -Tony
