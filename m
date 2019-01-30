Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680ADC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEF5218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfA3Kam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:30:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39115 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfA3Kal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:30:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so25607046qtj.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RhT5QQBo9CnhrSqsK9zeY8SpPxw6YQtRAC8uX0MA6c=;
        b=R1lu8Jn4lv4jPYJsSYGFisdAEkfzK6BeyVRrT4HQhfzNLMqg4cVmSF0vCBpCmHEae1
         YsSFB5JJ4Sk3ZxY6HlY57tBpFcR7Oh+rvCJZzrCHdobrb9iOHKq0FKS/rwjodz2Wcuy0
         TXofvb//PYXtHB7+13AW8p9DBNotwRbSvWPhx8m0zBwt+fbM6sUuCu+J+z8+UJx6JLLa
         KcOVBi9AmfoZR9bNJgN3lBczoYTUy0Uvn9jcL5ksG5cfeIG5KKTcYKlIL+oi5fVzFaiy
         92N8NLZRt86rIOcTWVGrR8VfjUQfxxUL8l6mfjFE3mZrBbm4tZ1zAPZMtyog0Hu2nJxA
         FZ6g==
X-Gm-Message-State: AJcUukdLbC9XczGBmxR7Wpy+bXj91b3s85HCAQnWlvZ7QR3Sxrz0jnt9
        IUKjIb9H5lTHyTget+Afwks40khZZLmgPguGZ+M=
X-Google-Smtp-Source: ALg8bN4gk1gkiPZhBES1+GsVzbOJNWK/Z3JzyP3y3m9AARvU7dTUXSP5iRy5qUKoLFZ3OE0QzDyBzfLslnwYdbYfvCU=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr28031686qtm.96.1548844240920;
 Wed, 30 Jan 2019 02:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20190122113525.13705-1-sudeep.holla@arm.com>
In-Reply-To: <20190122113525.13705-1-sudeep.holla@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 11:30:24 +0100
Message-ID: <CAK8P3a09=Z6rfyeqZmSF8rZVuUHwHx0FM0PAA5kaukJFmv_GLQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: provide the mandatory device release callback
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ARM SoC Team <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The device/driver model clearly mandates that bus driver that discover
> and allocate the device must set the release callback. This callback
> will be used to free the device after all references have gone away.
...
> Hi ARM-SoC team,
>
> Can you apply this one patch directly or I can send pull request if you
> prefer ?

I applied it to the arm/fixes branch now, and added a Cc:stable tag
for backporting to 4.19 and 4.20.

Thanks,

      Arnd
