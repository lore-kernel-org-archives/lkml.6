Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CA5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA42220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547195805;
	bh=zsUHTTVINsjlHI5FBdH13Jf4fqIhKhQzxLcKPBKKj9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lSZOoW6CIHW7o7+up42xJWnuN6rVBhPqvanZQaWPwC13WL4JKiAlW9ZP4KMrm62Kw
	 UQBImIrAUB681Ye1q42zgzuTXBabdwc177pWr36Fp5yw7m/G0AUVdCZ5MR1yaud2gt
	 LalW2wKf6D8ForYCRDhjOby68rZK10/QoEYPZm64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfAKIgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:36:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34889 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfAKIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:36:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so12206929ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yWIx6MvpRcpOxP9cc1mUNZ3iCi/q8dkikbOxQVqraYQ=;
        b=ltQOQBiGXZZGPLBKfTtQtQshCE2rfh4nINlaAyoE8y3HI7UEufgQiHu/vXEwTKujBX
         X5xyGUDxctAUcUUAQlf8Vt71e0WAWVgo0JFHqEsjGzQWcnCH+a9Xj7YDTOLdhR1RLKst
         /Dfbf3wE4XfYNz4CSNa6xpCUeLpl3yLSGtg538sPkjUO/HvinfbP78QdYxnMMcjvhh9W
         wZqg2zqBJepgEVdEuY0piR0UkCPVmgyZB3HjugNHdWeXO+IybMNu613mOKaIGdS+nhhf
         NoiHP9Bh4z9efMGbA8OnxiOdzRZ5AYAabGPjrkt9iKDQe38FM7kpzxJqqEZen58eNc8l
         Jqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yWIx6MvpRcpOxP9cc1mUNZ3iCi/q8dkikbOxQVqraYQ=;
        b=sIkmcoHk+zRGtjKwIgjOj0+qE4w+s9wtCjq4Hqd0E2WL1weMcvFnYP9BW2O6KCgpHc
         1D1sS0dU1C6SwiPnRQIZ3dPPDR03QOb1N+V0Q1sWVMgS9q9bv85wdGV5W8PU9hJ4PwFh
         5g1UV4UE0lQ3IWWlUo6s3fkdNNKIXezXpB7RJz8DmnnzK+8tJtm+9fw8Z5EGimGH1I17
         TExpU2fRvFQ36cQiUlsyr2l8Qxl6aSpIdirTYPtdXd6j38fmldtVCD8zV/sIOYglcdcG
         /n0OMAmnS2z5Bl00SI4tz5QQcRp+VS0BOPP1uAGoCAQUqkMdbVFhKvlLCapxFiANKXMO
         4Wsg==
X-Gm-Message-State: AJcUukePr4gQPuIp/8VYifGXJTtkjCrTcrFrNOZx2c14yVzN2/EnY77T
        gZ7gRQ7xgnePBhU3rgoRB5g=
X-Google-Smtp-Source: ALg8bN4yfKWJW1HfbPl+wQzwx6UfWT2ue9P1MTu6/KWH9jdshhInh7gCZIaMiOsGJyM4Ha4RbpfE2g==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr7774588ljk.114.1547195801170;
        Fri, 11 Jan 2019 00:36:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h3sm14694781lfb.49.2019.01.11.00.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 00:36:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghsIw-00027P-Jt; Fri, 11 Jan 2019 09:36:39 +0100
Date:   Fri, 11 Jan 2019 09:36:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: greybus: gpio: switch GPIO portions to
 use GPIOLIB_IRQCHIP
Message-ID: <20190111083638.GB3383@localhost>
References: <cover.1547141413.git.nishadkamdar@gmail.com>
 <8685966c02d3e209b8a1881c5a12d85d9b556edc.1547141413.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8685966c02d3e209b8a1881c5a12d85d9b556edc.1547141413.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:24:28PM +0530, Nishad Kamdar wrote:
> Convert the GPIO driver to use the GPIO irqchip library
> GPIOLIB_IRQCHIP instead of reimplementing the same.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v5:
>  - Restore "struct irq_chip irqc" in "struct gb_gpio_controller"
>    This is because we cannot use the gpio-chip irqchip, as that
>    will register the irqchip automatically and possibly in an
>    incompatible way.
> Changes in v4:
>  - Remove changes related to conversion to gpiochip_get_data() to
>    include it as a new patch.
>  - Remove the 'struct irq_chip' field from 'struct gb_gpio_controller'
>    as struct gpio_chip will have an irqchip whenever
>    CONFIG_GPIOLIB_IRQCHIP is selected.
>  - Update the TODO file as per the changes.
> Changes in v3:
>  - Combine patches as into a patch series.
> Changes in v2:
>  - Retained irq.h and irqdomain.h headers.
>  - Dropped function gb_gpio_irqchip_add() and
>    called gpiochip_irqchip_add() from probe().
>  - Referred https://lkml.kernel.org/r/1476054589-28422-1-git-send-email-linus.walleij@linaro.org.

Looks good to me now, thanks for sticking with it.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
