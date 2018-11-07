Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4831FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF9520862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwG7qpjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF9520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeKHDqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:46:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40797 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeKHDqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:46:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so16662691wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2a5ljJAfLHZQDopXMrKiW/T8Irdvzz3YUxgXUgvSTI=;
        b=qwG7qpjdmjaBeDj1qHL4qgMdbT3til4o7ckEzAmBeXs9/SF4GeAWbDKhFb/zKUUfss
         iZi4Wg3dY0JpS8YiIcbXdLwnycKQAXVQp/olbaW782SXRaMSHe2SphqSKBE63vmoym4Q
         KSibSTPDBKMw4p9qfXeE5/hbIvxNQSOivAOy6/28Pg7y3aiMfbT65uS1PuYnX808uBNS
         0S78gb9h4SPDgcCtI/KmmdYfnwtHNT9ABti7kgnrhqMNzLj3b0ObP2mkXME1+p8BKtm/
         YLOa1mH5ai21djCp3i7uDDeg1HbUquGwgLlmm/KhRZSz4aCups4b1O4hSjAgNhOxB8qL
         KuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2a5ljJAfLHZQDopXMrKiW/T8Irdvzz3YUxgXUgvSTI=;
        b=SZEfrf06kC7yOKt9djznAsM4WIpRi4ATBw0unBsS7r0KLry/fg8YkFAZOFgmV6CBHV
         HGEsvbhIaFbm1F4H8rEyCNbI06N+gsqu3qaJ4TZnO61uKvQ7cJughLQwJgE0LLh0BAKO
         nDqu72xJU4p538UP8tN8B/SuU4MKJ20VGb7/k+j7ecV69VVh/F5sGiwCyVWzBRF5qWvY
         Q2nGtyOo8N6fRGQn12tiMrUgj4FBg9/j5i9iInO9HTu6zJ3A5StAy5vm+d2Ej+1FBRWN
         5yGpO8wNP/x/U7DFpKhDYxciUkd1ePtd51Y+KuQTZ84pMaWcyW0iZ06yFj6k9hcxm6f5
         wQKA==
X-Gm-Message-State: AGRZ1gLwuySZIC+9TI0/TrTLd5yS7TG7bm6k6FZqEwOQyIcs/JmBwKWX
        /oM3Qn3QBjBUR4J0d2QmBVzy+iEsCa6i1rV1WlE=
X-Google-Smtp-Source: AJdET5dUi1xVRYjFMiUa0ku9vMsJAXAEfEiHJrl01JsaWYbJjRjfwRYVcLEJ5ffEfznV9aB8hQ2D4fwx9nW0d2NVDeE=
X-Received: by 2002:a1c:ee13:: with SMTP id m19-v6mr1051970wmh.142.1541614471725;
 Wed, 07 Nov 2018 10:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20181106214928.40020-1-nkela@cisco.com> <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
In-Reply-To: <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 7 Nov 2018 19:14:20 +0100
Message-ID: <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
To:     nkela@cisco.com
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, xe-linux-external@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 7:05 PM Nikunj Kela (nkela) <nkela@cisco.com> wrote:
> I had tried to use configs to start with via the following patch however I was advised to have a mount option:
> http://lists.infradead.org/pipermail/linux-mtd/2018-November/085126.html

Just show performance numbers on how your implementation has an impact or not.
So far your implementation is also not much optimized, maybe likely()
or static keys can help...

-- 
Thanks,
//richard
