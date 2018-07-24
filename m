Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD280C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712EB205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJXFS6bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712EB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeGXJaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:30:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36475 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbeGXJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:30:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id n21-v6so6056114oig.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CJfZVlBwHzg812l6pz3xse3JdS+NVb3v/rForrGBQfA=;
        b=jJXFS6bEkh3wbFDCX1OgEPwrncosFqzC1Am9kNMhfjg3cD7a8GNh6nv1sQjn9y79Sd
         mzHbfDb6bDYFfOuYfSFyaollM3B0c+/PIiLHMZPrf9X0cl5iSwxc6TC1FT0ftu0ySKF8
         JJ72VH9+PwskS9rdGlJDGYUAkqLWtur1Fc8zg2thli1P4RmTJ7i1npIxtCOnYINPpUgh
         wclysKIBTLCHdhF+t616Ya0cOa6p9o+oImB6WHoxTh0uC3tYLmCLETmWMcOEtELZJSsw
         aGG00UYtHx2/nXFpdsYW9ud6HT4sAvVRgym7sq0gvUMkta7AaInzUhaSaUYWH9oOT/Z0
         98pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CJfZVlBwHzg812l6pz3xse3JdS+NVb3v/rForrGBQfA=;
        b=ToYQMaRM7nSfZf2GoSarrcO05vX6RS9QAjwZOQ5xuutYOiWaZm3C2ZgpznyUGdKMIS
         hvzTFto8HcQt5i2+jzqDdM7Qm33LmDEcaVj0DNYdVBRZM3miDJI2HQeF9WV7dkiOPpm5
         aamI9PILjTcSH/xxJZ4BoZNi1SZRUxRer32aZXgNYCZLgaF4W4M3Re4YF6L79lwfwuMd
         4BMzARLagMhyw6rI5wZifULsuAU9p9hM8Bfa96VyqDCJctHx6BMEkurGDn5e7TU/BVjE
         DGnoIHKfWFwJ3ih0rRFwMrbrWTg8kJweZjytpq+rnXEPXP4U28TmxGlxBrkIzi+cZE2Y
         NvGg==
X-Gm-Message-State: AOUpUlFvA/UGl8rynXwi5KOUI1XyZcuTJMY9nY7Ig5XmRGJPLVsQRaqK
        LGqrFeh0HOgVThuZS5EWQiNpK8p6Q//L2/jXYWY=
X-Google-Smtp-Source: AAOMgpeuEJLAV3yLdFvbt6D++92X5yO3coh1QNipk+pvFfEs2bcxGPaqQr1xitHr95AZk344GzGcEXJv2x0lmEybqXY=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr2333783oih.227.1532420693684;
 Tue, 24 Jul 2018 01:24:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 01:24:53
 -0700 (PDT)
In-Reply-To: <e4ca8572ed913ab65f63be8a351d4439@codeaurora.org>
References: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
 <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com> <e4ca8572ed913ab65f63be8a351d4439@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 10:24:53 +0200
X-Google-Sender-Auth: -7w6NkHsVsyz-M4eIydnqq3ntn8
Message-ID: <CAJZ5v0ixuWo9RC21Z8zVhuHfkr1uV4vdqMh4s+qGMR7R8Wycag@mail.gmail.com>
Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every initcall level
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        Vikram Mulukutla <markivx@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:22 PM,  <rishabhb@codeaurora.org> wrote:
> On 2018-07-23 04:17, Rafael J. Wysocki wrote:
>>
>> On Thu, Jul 19, 2018 at 11:24 PM, Rishabh Bhatnagar
>> <rishabhb@codeaurora.org> wrote:
>>>
>>> Drivers that are registered at an initcall level may have to
>>> wait until late_init before the probe deferral mechanism can
>>> retry their probe functions. It is possible that their
>>> dependencies were resolved much earlier, in some cases even
>>> before the next initcall level. Invoke one probe retry cycle
>>> at every _sync initcall level, allowing these drivers to be
>>> probed earlier.
>>
>>
>> Can you please say something about the actual use case this is
>> expected to address?
>
> We have a display driver that depends 3 other devices to be
> probed so that it can bring-up the display. Because of dependencies
> not being met the deferral mechanism defers the probes for a later time,
> even though the dependencies might be met earlier. With this change
> display can be brought up much earlier.

OK

What runlevel brings up the display after the change?

Thanks,
Rafael
