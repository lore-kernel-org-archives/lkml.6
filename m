Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE652082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1sd/7OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE652082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJ3SrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:47:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33717 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeJ3SrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:47:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id o89so6819398qko.0;
        Tue, 30 Oct 2018 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qi5igCbxD3HrmBiL01UGExngrI5GuGC+v35qnbh4sAo=;
        b=K1sd/7OZQ2aA2zBe9Mz57Jv1KhdeWPeVJArAfj9fTjiZS/a/CH17V3q5nlutYQnXDd
         qy245i4gXwWY4dSQEvr6zJJKb98iP3FUUcWsazK31eYpS6cYH8H2WwCdx4s7RZr0ILBJ
         YYQ58vIGAX1Y0bc65RLXJCTOEVx7laAgnDDwV4SfeKv9zXLW/zN2DZx+fL+V+vQf4JHj
         Tvakk8I8xBnZ5jhG2Rsu8zaNMQNoCb2NJagAd/l9V3oK3/pwjMsE/G4Cm83BjHFFgdDx
         BllMu4TlW/qJvGAj/4jhMK7r58/OXhzHdZG2WISYRY1lG10W6Ssn8PotFHwbtn2gTyg1
         ZZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qi5igCbxD3HrmBiL01UGExngrI5GuGC+v35qnbh4sAo=;
        b=a9Hcpg7hhC2cUU+7dFq++uOowd/VEZCigyi0/1qr7J9CqBqrOCE4jr+Ay4NGwLRe4W
         M4OWWOsZn8C5ZfCh3SZUb5VNY9fL51rsh5dA/UT2aLqHabMpXUBVyGTx5E0g378ZqXgt
         BoKHUdbdSXJ+rzSxkpVwZruxKT8yYBogQKSAb+5qg4DDrFoI62NS09QydcyEJSgAQAW3
         DknDDDI4JJALdG/7iXWsOxDY4Kb4eVO7VzViq75+S22T6MnmzORI1G5wAS9rjpsYll0u
         Ae7NrQoQlj2OrVIAZryPz6hdsoEFYcY3Z/0O69UeA7W07YvYIW5RJEQdtS6OVMzXaLWt
         qldg==
X-Gm-Message-State: AGRZ1gKUINCJv6Vlm8JKd7xLVd+sW5MnnsUZUPvKD7z7JdjJL5Asof2F
        p3T3YZePqycHmIw1/DR+NHU8R9HJUTmtryD50Xo=
X-Google-Smtp-Source: AJdET5fyR4I6GXzASuw6bAlnaUCKxEDcZAtwAmo6nDm4MRloCuq8ItP0ImuK9tYoTJ4sr7p8qDqyfc6Uh4uzBQMcawc=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr941942qkl.70.1540893264827;
 Tue, 30 Oct 2018 02:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VcPmnKRdKVs8E+ov=h3roSvD-CKL7m9EZ6cGJWH1dyk1Q@mail.gmail.com>
 <201810301107515541204@zte.com.cn>
In-Reply-To: <201810301107515541204@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 11:54:03 +0200
Message-ID: <CAHp75VfVitVWoXbUs0gQbv9Ny2gwccON-+qU06YaCs19tF9oAw@mail.gmail.com>
Subject: Re: Re: [PATCH V3 3/5] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 5:08 AM <peng.hao2@zte.com.cn> wrote:
> >On Mon, Oct 29, 2018 at 12:54 PM <peng.hao2@zte.com.cn> wrote:

> >I would consider it as a bug if on some architectures iounmap() is not
> >able to take a base got from ioport_map().

> I added TYPE_PVPANIC_MMIO in QEMU to the architecture that does not support IOPORT.
>  If some architectures does not support IOPORT, set TYPE_PVPANIC_MMIO in qemu. This setting is reflected in the kernel pvpanic driver
> and does not invoke ioport_map (calling ioremap).  So I think the situation you described above will not happen.

> But I should  resume one check like this to deal with the failure of ioremap/ioport_map.
>      if (base)
>            iounmap(base)

I'm a bit confused, how come that base == NULL when you about to call
iounmap()? Where you would like to put this check?

> The patch of QEMU is still in review.

-- 
With Best Regards,
Andy Shevchenko
