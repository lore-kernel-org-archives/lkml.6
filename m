Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46807C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF9C2084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QqY94NTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfATFLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 00:11:35 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42464 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfATFLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 00:11:34 -0500
Received: by mail-lj1-f180.google.com with SMTP id l15-v6so14823764lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 21:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4j2/vVvcJi3rETqZUhpc+ncR58zk37mkzeG2NhCK74=;
        b=QqY94NTo+rm3rhGMAvPfgFk+TDVb7XF5eX2FpPwsP64JmaQ5g/rLWBQBUAElC6kdGI
         AIlWBoj8VZJj3QQ53yVucSnDmBl31EpRtou3IeQ+o6dVbs7QtForxRhooF1OLpKGgRVH
         RoTsFygLKvxJrOqa7TOqLmjzM39x3P6Fi3UCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4j2/vVvcJi3rETqZUhpc+ncR58zk37mkzeG2NhCK74=;
        b=anp+7x840vrQ3e/MhOeVbxR5kodVZMpJGIa/zz0dvf0Jaj3hYgj6tJrw55cCOwKoEl
         UDozm72FguDoHSOMXexYH83b1iEcqLf3+Ice+wA/vx7k/kLxje27FG14S7I4amb8lI64
         GJ5NoBX2wV8OMjrvHIx1h01tQQQtU52E0uaX33uZU1oIWtN3sdKPaNI+WTzP2ennWpJS
         vNWxO4Diifq8BMfTqxZGO4uezXd3f5UShaxjYlmAEOTO0PAjLMQfypzYX/gxE/D5EzKK
         GOJLXI329tc/yK+G2ALEf9JYznMe/2/Pg2FLXLRkuwrj8qVXPbVbJsg08NTHvBirF4BG
         ISnA==
X-Gm-Message-State: AJcUukfdw8elCm7TLk0xFoNiHx0GOaqvsnA+w2OlJSAYDuGculUP3u61
        jYGz5GrRHCahrufIoYpYsZOAoadwSsTGYQ==
X-Google-Smtp-Source: ALg8bN6cWyEO0OkXrFClZi7/Af5F9zHjlpwxIJx9NEu15EmRaapFGj01r3K8pX7Q1XZLxb/jugh94g==
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr15109378ljg.23.1547961092252;
        Sat, 19 Jan 2019 21:11:32 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id u65sm1650982lff.54.2019.01.19.21.11.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 21:11:31 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id t9-v6so14843409ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 21:11:31 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr16448752ljk.80.1547961090973;
 Sat, 19 Jan 2019 21:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
 <20190120000138.GI26876@brain-police> <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
 <CANZrA2YLtnv+PRBYzcLdFUg4uktx82G8dkoZCic8-ANK-3-7fA@mail.gmail.com>
In-Reply-To: <CANZrA2YLtnv+PRBYzcLdFUg4uktx82G8dkoZCic8-ANK-3-7fA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Jan 2019 17:11:14 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjwt4M7wGcMDkVLmSCsFP3xj29pAVgsC6-zbc_XPN1yiw@mail.gmail.com>
Message-ID: <CAHk-=wjwt4M7wGcMDkVLmSCsFP3xj29pAVgsC6-zbc_XPN1yiw@mail.gmail.com>
Subject: Re: fix int_sqrt() for very large numbers
To:     Florian La Roche <florian.laroche@googlemail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 5:03 PM Florian La Roche
<florian.laroche@googlemail.com> wrote:
>
> The real bug is that we compute 1 to 64 for bit 0 to bit 63, whereas
> the algorithm expects 0 to 63 for the value of m.

Florian, you seem to be in denial.

__fls() returns 0-63. Your patch is *wrong* for the __fls() use,
because when you subtract 1, you get -1 to 62, and the -1  now
introduces the very undefined behavior you claim your patch fixes.

So your patch fixes one real case (int_sqrt64(), that has one user
that doesn't care) but it *BREAKS* the other case that is actually
much more widely used (int_sqrt()).

See what Will and I are complainig about?

            Linus
