Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A8C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446B521476
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiWPdXWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446B521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeIXAkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:40:11 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37489 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeIXAkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:40:10 -0400
Received: by mail-lf1-f41.google.com with SMTP id b12-v6so7527810lfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O9XJ4EzlqcIOM8lcUFeUBTkHny71nPN9thjFFE1Btns=;
        b=MiWPdXWWRQi5ahx4vmzhBXbtbGur7dXJ+TN4Q0eUZAWBU9yH9V7IWFFTV8rhOOKSDS
         0bt1VzY0Hp6Kv/8I5X6qK/jV8QpztFxigkMw/pyKcvonwbC+Nz1/sT9H15ROBDESInqH
         rMNq7UooIT32xVyrjLlxvKW98+OidWWusdPMVuSgwAcl9xJAgHurgN1WF/2Eni0Zp6/K
         AfG+XeIOkea2a5uI8GsH3FLghcB8FQOvqY8cHTNcQZNjvopq7+9LA3UWbFX+XrOwKq8W
         h+dQbbhrGUtpOkI6gvNmkFRYtgrKazUMNukLOVBJi313OSarb30vwzjsUXt/rEaAf/Sx
         au3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O9XJ4EzlqcIOM8lcUFeUBTkHny71nPN9thjFFE1Btns=;
        b=rNFdQMbGmGKlyEnujcJm6EGiR0LZRqYb8cH0pdDZcm8xrA9K1pdano2rC8wAyUokYD
         sGuJUYV9v5PGlgITpUttlO2R4HdQtX9ALcKZ+nnXswc9ZPO2xlWXQUPMF76kM9LRwYeF
         BZACHMbHihvyUCazgya6zCrRpKaA1sC+2GOKVPVf21UH1T0UqEZOkrpe9cJpLjnuqL+e
         tGoaaiaL6OLZicLgZ8lvUm+aQttTET0NkjJPSxttSMygPr9ZDDBVlIYOUUKzgEnZBDV6
         8P9UrVycW47zNhmcjoWNN8j01ojxTD+RTLa6IqY+2YLLdDZ/ZQpc/XgX0syPEsHsUTtL
         ftLQ==
X-Gm-Message-State: APzg51BVYFItNUijBaC+oJymGv7dUbniGc0cGLTYUKXh9lxZ1foSK/5W
        IExAtTY8rN9NQAJP8VMBa7q/rhZs8iPqEdS+crg=
X-Google-Smtp-Source: ANB0VdaFraGZjLlsc3kIDufvFDyLLkRTCyCOf3y3aO8ppYI5Th9aVnKdr6WQER04oZ5GgfkUqoR2Xrd+/yrePjcb64s=
X-Received: by 2002:a19:990c:: with SMTP id b12-v6mr3898299lfe.18.1537728104544;
 Sun, 23 Sep 2018 11:41:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 11:41:43
 -0700 (PDT)
In-Reply-To: <a9db544f-db9d-d6c4-67d8-43db2eb591fc@cantab.net>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <20180920041846.GA4418@1wt.eu> <206423b0a199c1f12e61364d6e687e09@redchan.it> <a9db544f-db9d-d6c4-67d8-43db2eb591fc@cantab.net>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Sun, 23 Sep 2018 13:41:43 -0500
Message-ID: <CAMjeLr8WicqyoahumLNsZCHCaEoPdjXT_1vANvzb+s2-EzzbhQ@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Edward Cree <ec429@cantab.net>
Cc:     unconditionedwitness@redchan.it,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Contributors can, at any time, rescind the license grant regarding their
>> property via written notice to those whom they are rescinding the grant
>> from (regarding their property (code)).
>
> I know others have already said it, but:
> This is legally nonsense.  The only way I can revoke someone's rights to
>  my code under the GPL is if they violate the terms of the GPL.  If I
>  were to do so otherwise, then _I_ would be in violation for having
>  distributed derived works of the kernel without a GPL, not to mention
>  the obvious reliance/estoppel problems.

Actually, like Chris Conrad said, this isn't necessarily the case --
even though you are *contractually* right.

The problem is -- that no one *signed* that contract.  These are
gentle/wo/men's agreements.  They are essentially the same as a
click-wrap agreement in terms of enforceability.

That being said, there is still legal recourse, just as there was/is
with click-wrap agreements.  It's just not clear how much.

Mark Janssen, JD
