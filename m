Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74473C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2E020866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v7dKi3jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2E020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeIJOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:39:02 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:39678 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:39:01 -0400
Received: by mail-it0-f41.google.com with SMTP id h1-v6so27825398itj.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+e8JVKyHPLDrOOjWLnvgHpmlIf0JnEkcc8Bo/Zq94UE=;
        b=v7dKi3jmigfjK+74nTajI9CPHKsEbUPgvf50EMle05GFiau9iXMwh5qeVohutBr50c
         MyhmRmzk7Y17CxcASFok3scsKpu7TGrjcHVsFDrr7NStE2uWbMFbeHN5fUhgO7CQkY6j
         2KSEq5B9aU45mWF+JS6oKA1e42nyRG+bEwP56zIP8SNmMk4+IjAzy+uVkDXHoZbyvBtR
         pRcGU5ztXfAgpbj3GXrDFB3+EW4JuK5FBpRYMgeCeYBwmI61C/sh9BksUwmfV3kgBgTR
         ExJtcLmjqrmHCsrFPlNW8nUtglvjW5ou57niv4T4yD1FsjS030kDMRHhEbH/ksha/jqP
         5k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+e8JVKyHPLDrOOjWLnvgHpmlIf0JnEkcc8Bo/Zq94UE=;
        b=XZg5SziVIAHR7ENKeuScQ9PCKqzZnhWzWL9C0Eu8iSSWOHsu/0KHnASuYMo4V855OZ
         o71HsMJgXkJ8qzWySR3P9XwMgVbkCE1dh2tIAfuR/Ot++2wvLhZeb7VIOR5Uut68dD6B
         7+a9yUskrkTs6yJArSKlJF0MSXX70q3TkHQXsWemKoDX16v4kbS9e1dEuMrTQpTbT2rm
         RDClJO/mW1jRA52Nx5raqXSbOvFJhohonCmGWST9FGzXMQpSb1hOKoDVeybrQo4ctChK
         LEI/N/LbXUkXMzQlriAqfBpd3O6zFHLF4uWxsj9jnmWwNefuGmAoWSnNdIF/xlbsxmdk
         m4NQ==
X-Gm-Message-State: APzg51Bs21hCDd1vcZa1wJHEExsi3D3wUnrRrONOB3rEXXpjOs29PThC
        lJtj9xuhSQCmwXJveo8/eyJeGS7ts0ado/EhF1WCJg==
X-Google-Smtp-Source: ANB0VdZImPLt4oFBt0eb/NigtpivHgZeYhGySne90JjNCYDV7j2PYdYZ1L0WU+95/YKiQjVGylecs4qh92M1X0ZA8iw=
X-Received: by 2002:a24:6e96:: with SMTP id w144-v6mr17664090itc.111.1536572749443;
 Mon, 10 Sep 2018 02:45:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 02:45:48
 -0700 (PDT)
In-Reply-To: <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl> <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org> <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon> <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 11:45:48 +0200
Message-ID: <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] nvmem: add support for cell lookups from machine code
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 10:55 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 09:23, Boris Brezillon wrote:
>>
>> Well, if we get rid of nvmem-machine.h, the cell-lookup stuff
>> should go in nvmem-consumer.h not nvmem-provider.h. On the other hand,
>> everything that is related to cell creation should be placed in
>> nvmem-provider.h.
>
> Yes, this is how it should be!
>

Any actual reason for not putting these definitions into a separate
'machine' header? This approach is currently used by gpio, pinctrl,
iio and regulator framework because most systems use either DT or ACPI
and don't need to pull in any stuff aimed at board files.

Bart
