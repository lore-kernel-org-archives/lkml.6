Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F41CC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92682087A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M/bWbk4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92682087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeHST7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:59:11 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38194 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeHST7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:59:11 -0400
Received: by mail-io0-f195.google.com with SMTP id y3-v6so6329741ioc.5;
        Sun, 19 Aug 2018 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOVc/om/Ad9UFGHwOIWuCn+NicwdGwrNZehC+sCZHl8=;
        b=M/bWbk4YC0qDJ152zGGsHqBmfTgRVQiudiqzbdC6wN0NAfhuV3N1dA+hfDVXuE2ZCV
         FNicR3rxtkCW6QBjhZgFySCTSQAFFXcTDDgMg1uZ65JIaoM06RaezF2qFQxSemK1v2fn
         MWr3h7m2n+1RO8tSEPwj3HlJGG7ExeZw9hJgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOVc/om/Ad9UFGHwOIWuCn+NicwdGwrNZehC+sCZHl8=;
        b=uLsSDeodqZXRf2atOAqKjVteXeRZZymvDWXvXS/c2EevSt41i68jZv3HbcMNsFAhYR
         B/gKzSNzF7gza47nG4NNh9tMDRnqLHF0qmmoq0Bc9KX+rJHw7zsJqSlhX8RWK+JOPS38
         gHrV6+yNCH7jyr6AQZ/9SqAoQi0HevqrNBIVAeWjbjONEM25mGlvhpWcm4wao3vyB+ly
         5cMBWbvkxI6MFnOxGTeinqdQRP7F30lcboucaRm3+Ba/E2POeZyNAJNcFpev+hQbQ92l
         /ICPbTxVnjO21wuUp1N6POsjTHng+BdQiOUYtWZrAbzw7YL6pHnRABhVxwF9Zk7F4epD
         wyjg==
X-Gm-Message-State: AOUpUlGbC//iJA4EOqbhaFiUEqRn+tKrWlf/VY1gGBZvaNeePeuCwdJg
        a/X+kC0JWqI+1VeTzOXTW42keFRg40QZx/Nf5gk=
X-Google-Smtp-Source: AA+uWPw24dP/clRYfOvVMJFDXklA6CjwIjDEgteRqlaqCQLrnhKcezI/DL3dKM6tTxo68IMOkqJf6Nk7hT9jC/CwZuc=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr19834969ioh.259.1534697226842;
 Sun, 19 Aug 2018 09:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
In-Reply-To: <20180819135135.8801-1-sedat.dilek@credativ.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Aug 2018 09:46:55 -0700
Message-ID: <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler warning
To:     sedat.dilek@credativ.de,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 6:51 AM Sedat Dilek <sedat.dilek@credativ.de> wrote:
>
> This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
> ("deprecate the '__deprecated' attribute warnings entirely and for good")
> now in upstream.

Could we please just remove the __deprecated use in i2c entirely?

As fat as I can tell, it's used for one thing, which is the
"attach_adapter" function pointer member in 'struct i2c_driver'.

And I think there is _one_ remaining driver using it, namely the
powermac "therm_windtunnel" driver.

Could somebody who knows the i2c probing just a bit convert that *one*
remaining driver, then remove the "attach_adapter" entirely, and also
remove this thing?

Alternatively, perhaps the driver should be removed? The last actual
powermac change to that driver seems to be from August 2009.
Everything since has been just cleanup unrelated to that driver code
itself (ie spelling fixes, automated coccinelle scripts etc).

Added a few people either because they're still officially maintainers
of that file, or because they touched the code ten years ago.

               Linus
