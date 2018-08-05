Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D05C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7F2217BF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHO5XDaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7F2217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeHEMa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 08:30:27 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37825 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeHEMa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 08:30:27 -0400
Received: by mail-ua0-f194.google.com with SMTP id y10-v6so9075011uao.4;
        Sun, 05 Aug 2018 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QIsDlcmOui1lnQ3rqfDglrNBfuvBO0AIran9Ii9hwqg=;
        b=BHO5XDaFOmdf8LheqEMaXuZY7JQg/LoT72bx0rK7RBchSNYgcyQmAydFLv1WSXPaBy
         5hzjNQ6ltmoZowLJIQa1eSY+OsrG255xnjc16hBMB6wNH5ZKY/m1w97ECmqtKLgiPHeW
         4Q7HF6LPC4IyM0B8mOo5V1lu4IjbfRffhG2felLiVFHk3j7QZ1cPMvOjW9r0ujMljpaw
         P9Geu3cPN+X7O870UrM/S9eiYEVNHJFi0k0Mi4o7WE8GwlZcpiQd8tf0qhlCDYuaJoU2
         KxCk7dVP43m2bvafIPvd+Uz1g4btLLOb/GeHYl2tE9ATsGXqvbhruIhIUcJb5EDgwOQL
         7uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QIsDlcmOui1lnQ3rqfDglrNBfuvBO0AIran9Ii9hwqg=;
        b=hUWRByyMcU3vgzkgwRyOIqTnbdEPDlk/C2ByWGu2n/4cgXkcmguRjPdcYwBv7n/RSc
         Aqx1r0p4ny7EOy7eYJLCqTubLJnmnUGsppCHO3Xf44i7JDQSZrr3anLTV7RyM3NLPLEO
         +0HZ2OR/dMzkf/6LrjPRT3DfKPpCu3XjWPYnf/TM11tWrMdH0/VjNDofznU5dMpYCv6z
         /tnMVJwqZmtBD1IyiX1QInWazu1BLhvKmzV7scq7ez+JT8CpR0ahfn9+Rq+MZO7fhTxs
         hN2qjMHAno+gU06TmDSV3ZCDQ7trnIwd3jOfCBmV+Hb7WdwI2BcaTyeJRZBEIj1fciF/
         1LhA==
X-Gm-Message-State: AOUpUlGyxYq9XTsH/pdv56fDj+X3Y7C2THtgrWp3RWHH3bwJuJgXKxl0
        WV84GKzsnZURwb8Lfx992sZDGyzL5VYONGEc53OmPfhT
X-Google-Smtp-Source: AAOMgpdXyWHWUojNiwR+2ezac+b/zYSwyH/9kKrAXcGRZw+ffKV3Ja3Z0b9UDGILsyyp+GHNozoa57FdYakTKc4mrPQ=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr6539342vkf.76.1533464781541;
 Sun, 05 Aug 2018 03:26:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 03:26:20 -0700 (PDT)
In-Reply-To: <20180805001839.GA22975@embeddedor.com>
References: <20180805001839.GA22975@embeddedor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Aug 2018 13:26:20 +0300
Message-ID: <CAHp75Vc=HLMVhQ30z9LTM7z+nmYgYPSRJib0PVTVW8H25eYg5g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: use true and false for boolean values
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 3:18 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
>
> This code was detected with the help of Coccinelle.

>  static bool has_cap(u32 cap)
>  {
>         if ((interface->capability & cap) != 0)
> -               return 1;
> +               return true;
>
> -       return 0;
> +       return false;
>  }

this entire function can be oneliner:

return !!(...);


-- 
With Best Regards,
Andy Shevchenko
