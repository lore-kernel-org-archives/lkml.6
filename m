Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCCFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0481C2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2XilP7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0481C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeH3NHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:07:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32888 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeH3NHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:07:06 -0400
Received: by mail-it0-f68.google.com with SMTP id j198-v6so1592681ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1D4ilYZA77rojVcK9ZjqdLMmegXI0rnTie5NC2ZBryM=;
        b=O2XilP7VNF3mglDLTfrUJp/05JKS3gzBb0XSYk45XnUKAnq5WTOEI0udzJkXRmrrbi
         TeQ2FYydc/9pGm81ZrxuuyoqDphwGk9sFbDfAkEWFakNVf3uNA3SAWrgJjzHKliSgHWS
         XOW6SPU9i+JF97CBWh9AYI5B++82xxyznJDI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1D4ilYZA77rojVcK9ZjqdLMmegXI0rnTie5NC2ZBryM=;
        b=NTpoCK8dep3bbEpovcho80gOc/NB3ZZUlQEdCZBvpvUBj61rwaD9sj9JZVtiVQOesq
         oWOzW/meA/FkIDNQiVjRzPi28MQjBu7qvvPzsyysMmISILk9tJRhth9YvPHO9aTzNbED
         ECY7PVxkaiQf3563J5KQ+0f9uiFMhbIVkecpehT78nE8MSCxk1AWAIpU1MREDpu8hAzu
         UPO9KU8z0y86OVBm70M/nFp5nCJShJvJ87m/p+VQGOTz5gFb1BsOrGXigArPI/jDXyYL
         rHk8KfqdFbRu4myrb3PyIPgY7x6fINuDeJ4N40+ybcoJg2ugCWk9zty2fh/vBQVR0BS4
         G76g==
X-Gm-Message-State: APzg51BGXeqdnJ1VqEzGj76TUrVmFvePgEc9lBGyP877Pcd3ZjmYHE7U
        U0JzKkw/2YDtXSIbULxCkRneohA/2G0X1M4tAes0Ug==
X-Google-Smtp-Source: ANB0VdZ+c5K8lgWArfTOfH+Lj9PCfnyorkZ9BCPejq3aeVzRd2JEH+Kz2Nyv7mb9KvTnBUZxqn9eZdutxhjcSn0J0gs=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr1298471itk.62.1535619957436;
 Thu, 30 Aug 2018 02:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Aug 2018 11:05:43 +0200
Message-ID: <CACRpkdYu8F6hzw4sHsqBbziYSQQK5Ppb+dwi1AqYZXbzAumw6w@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: brcmstb: allow 0 width GPIO banks
To:     justinpopo6@gmail.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 1:47 AM <justinpopo6@gmail.com> wrote:

> From: Justin Chen <justinpopo6@gmail.com>
>
> Sometimes we have empty banks within the GPIO block. This commit allows
> proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
> incrementing the bank and number of GPIOs, but not initializing them.
> This will mean a call into the non-existent GPIOs will return an error.
>
> Also remove "GPIO registered" dev print. This information is misleading
> since the incremented banks and gpio_base do not reflect the actual GPIOs
> that get initialized. We leave this information out since it is already
> printed with dev_dbg.
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Patch applied with Florian's ACK.

Yours,
Linus Walleij
