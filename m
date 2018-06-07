Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5xpgE4CDGVt6GwAAmS7hNA
	; Thu, 07 Jun 2018 19:13:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE3DA608B8; Thu,  7 Jun 2018 19:13:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b6ZhGjYo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lAJrtzHF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7873460590;
	Thu,  7 Jun 2018 19:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7873460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeFGTNw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:13:52 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37894 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeFGTNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:13:51 -0400
Received: by mail-ua0-f193.google.com with SMTP id 59-v6so7263734uas.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qMTtbpS2k5Fyc/Cx+AKDMBTNK2lgaWBCdtq5e/pp2tk=;
        b=b6ZhGjYoRTKib4dOzZf+AZw4Jrt6xwWCf9seYBfv8MLJOY69qSTnFhL6JBIT/Km9GM
         J+gDDSbYVHc0Hx3talgWmguAjk/iN7GSx3FdZzC3eKOyHcrTyLoKtWuwGDdPAYrycy7s
         zCGu0iUVkepwpT+OAjse1ScPFWm1gefh03kL+2zxJY01sWcvjnd571IpoMChYJRVv1Iv
         2A3g+UyJ2Fkv8B6hoeUaNmVjd36XAUmbC2Fv6VHh6XdwFjEW9K3XJRTAEZ7XDYPOKMZo
         EO/b3aclosXNN8TcJJPfLLY9Tc31S/RQtHzTCPJ95cgHAKq9nErFSVmFDOrW9MpGu3NO
         sORQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qMTtbpS2k5Fyc/Cx+AKDMBTNK2lgaWBCdtq5e/pp2tk=;
        b=lAJrtzHFllDpg5CdViBirjTHumRc475XfncHTDMWM89Bgv/ZOkWeVH23js4VyEzbHN
         hRElHfbTRDEyU9HmsXpsrE6igC5mwuMEgxt7NpvIamhAK4Gtf/mmrS5jcXSfsPSfCqfJ
         2GitSE2H++RSg4DkNtGCkJixLwXKVeLzttgbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qMTtbpS2k5Fyc/Cx+AKDMBTNK2lgaWBCdtq5e/pp2tk=;
        b=rXVP2UemvoDXqghUdvAgoHPed6UQuPIAZYPJXMtox/BidnGdQ3qcA5tiDzi0KRjEEG
         iDsRN8hQwBK2LfX9ieUkazDqeJq65QE7RxjzbnQkN9jTJLYQkwQm99xDyxcWF7zlgqfs
         5a+JgdQ5riDZwzB+wzpKpzOPOFzXq9l84mxFqMBYHoY7RqFxAUQT1TJj3Gcucr/iDI80
         9zy4reC0o5rDwnXgh46rMTihsjJR2hj1LLyVPgDpnJH7gTjDzCWr4WZa9QhHIdBUd0cQ
         jxGO6uxD7kCcOUYk2P7w2Q6TYZa5Sdq87z8NMC1C9EZmU62GOxYK6sbm5xC96zGNVArj
         Evcw==
X-Gm-Message-State: APt69E3IhzaU+Lk6cGDJVZn4rydBu4PfcAkHw+l0sSKcsW7B16jeKjWt
        HvVfLpK1Ls4mnvPqs4ZEt6WExi7HqeIwzIkdSc5IxA==
X-Google-Smtp-Source: ADUXVKJrLCfUSN+15vYIrWJZsQTdUMZfREF1lub4/HadA4OUuDUBPsJVnZYh08vhYGsWzte3DEqomcdV3pGgF4nBM5Q=
X-Received: by 2002:ab0:663:: with SMTP id f90-v6mr2099883uaf.167.1528398830081;
 Thu, 07 Jun 2018 12:13:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:a085:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 12:13:49 -0700 (PDT)
In-Reply-To: <20180607093340.1742a5d1@cakuba.netronome.com>
References: <CAGXu5jJq774LZY1xUCKxG3Z4MkJ_JBJP7veB5gUCy4meb_PtSA@mail.gmail.com>
 <20180607093340.1742a5d1@cakuba.netronome.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 7 Jun 2018 12:13:49 -0700
X-Google-Sender-Auth: -sWb8MfGX94iKwqWXmK89G7wKC8
Message-ID: <CAGXu5jJ7bygKKAzq-cP85XjB1OLzGAX6qr2VdCbSJ9_ZD=CZEw@mail.gmail.com>
Subject: Re: nfp: bpf: perf event output helpers support
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 9:33 AM, Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
> On Wed, 6 Jun 2018 22:15:04 -0700, Kees Cook wrote:
>> > +       rcu_read_lock();
>> > +       if (!rhashtable_lookup_fast(&bpf->maps_neutral, &map,
>> > +                                   nfp_bpf_maps_neutral_params)) {
>> > +               rcu_read_unlock();
>> > +               pr_warn("perf event: dest map pointer %px not recognized, dropping event\n",
>> > +                       map);
>>
>> Please don't use %px on kernel pointers unless you absolutely have
>> to[1]. It seems like this value wouldn't be actionable here, so likely
>> it's best to just remove its use entirely.
>
> We're using kernel pointer as an opaque handle when communicating with
> the device.  We need the actual value to correlate things.  Maybe I used
> the %px slightly out of spite there, because I forgot %p is now useless
> and wasted half an hour on debugging an endian issue :S
>
> This message can only really trigger when root loads a specific BPF map
> onto the device and FW is buggy.  Can I fix it in -next?  I'm making
> changes to this part of the code anyway.

That'd be fine by me, thanks!

-Kees

-- 
Kees Cook
Pixel Security
