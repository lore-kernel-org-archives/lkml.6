Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A40C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EC3214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lt/SGW9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeLZU0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:26:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36897 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLZU0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:26:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id y11so11460034lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQVR8xAnz72mawBwUw6fBxhrCEuSz9N0EBAAc/L+6aU=;
        b=Lt/SGW9XD8RsjHozyzZ70dqlDecMu4L8GVuZ+PYb96rOX9QxkiUf+oTp4xSwDJ03Uh
         bdmK7l15TF8i5jliyHmKbAxFoLS1aDgm4xA96L0H5MdFAS6UxUmpYmoDpXOtTpL/4jo4
         wxQlzq0RjDaETOFvZB6f2RgYUmTiO5DmTiUmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQVR8xAnz72mawBwUw6fBxhrCEuSz9N0EBAAc/L+6aU=;
        b=CiM5B3FXNh0P3w2Gn0jC5xkO5hT6MiwHFxpOukY2bBd1EfgQRCjYrG925lKuk6X82z
         UdcoCr+JmnqWT/Cv8+st7v68q7wK9UUKq5iYnY+6T3MwXfPxyEY4sUlH2CDaaC0yjJn8
         vzEwrbEOt5Dx6MqoKcgOajj82kF6VbcruNtIoedY0GbnDqJvf6/q55NbvrA3Yi+32wKf
         YREu5hZgZMPvA2WnbB40zyFZnxvtMg2IlbfsvDGx3/zhrS1dInzIl0G3No3TekGkaeOo
         MLmTdRg/R8sQt3Ap1ovEGbUXKVSV2SmbCosPSZpZb3STLxStXiwk80JXLHqig/yH+3ZT
         aXKw==
X-Gm-Message-State: AA+aEWYru2y7bJ5gstS4GzXFihCSz4MelmXZehp9QBLWsEWZFl5HVG1G
        gxz+aPMnT/O9/1rVzPJHLeywjlR+bck=
X-Google-Smtp-Source: AFSGD/UCz8UmbiaLAykJAUVe8KLrA+D3O0TXotS5c1x2BdUoPCOGdT68xvp+SRG8iWXhvYqDWVbA+w==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr10156465lfk.151.1545855989875;
        Wed, 26 Dec 2018 12:26:29 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a127sm7299956lfe.73.2018.12.26.12.26.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 12:26:28 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id k19-v6so14631096lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:26:28 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr13068815lji.133.1545855988346;
 Wed, 26 Dec 2018 12:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20181223124859.GA26860@zn.tnic>
In-Reply-To: <20181223124859.GA26860@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Dec 2018 12:26:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
Message-ID: <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cache updates for 4.21
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 4:49 AM Borislav Petkov <bp@suse.de> wrote:
>
>  - The generalization of the RDT code to accommodate the addition of AMD's
>    very similar implementation of the cache monitoring feature.

I've pulled this, but I think the new config option name is bad.

I think it should probably have been called "X86_RESCTRL" instead of
just "RESCTRL". That's way too generic a name for something that is
(at least currently) very much an x86 feature.

It not only is x86-specific right now, it's specific to very few
resources. It's not like this is some generic resource control, it's
very much about low-level CPU resources. That should show in the name.

I've left it alone, and maybe it might even be cross-architecture some
day (there's already a hack in the scheduler), but I think it's a bit
misleading to have so a common name for such a specialized thing.

Even if it some day gets to be cross-architecture and isn't limited to
x86, at that point it _still_ wouldn't be "RESCTRL", it would be
"CPU_RESCTRL" or something.

No?

                Linus
