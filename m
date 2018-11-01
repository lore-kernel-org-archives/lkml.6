Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F0DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5AE20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IemoKm15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5AE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKAMwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:52:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39217 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKAMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:52:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id e3-v6so15543784oiy.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNIuM3EpgnXMH2qXI1qC40M6uwcR60v4H/uQ2Sq6T1w=;
        b=IemoKm15P9Q0KLu+nqPmDuzv2njTXbOkFVKDpy476Ck7Wx4UH/W9fMuwSPPTPV3Kbb
         1SntDmTluDKaaNgu1klPQJCME6XTRWcHgehEs65NfhPfxjFUv0VisGgC9gB69S20lew3
         Ntkf3/POsFPDswP6eFIPULIcUZJz4z/i2+nhiM5qyHOyNGE0G1BKy5Pww7lwN133JyGh
         KDm74hC89OmlY1UExRXgaKmlE55/1roV8QvGxJzXC2Zvzpw1jJD7OodhMvUcqV615aAv
         R/svr11rNnqmqA1Gp+22MXqtvNhvwsC4ICqABqyGcjmGiNjOgxU83A4CzlHSL/EJwGcq
         OknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNIuM3EpgnXMH2qXI1qC40M6uwcR60v4H/uQ2Sq6T1w=;
        b=pD5gFMu58zk3vQjXSr9YyZ7q/kRWvLkxkGMNrA5neg2AEJcE1SjSPNWj1EX5TwHBmx
         jRgHIV/yiFGIf9fNu8YcT6zYgz2hAu3Y5uKtBDAKNNzKXv2ZKRQRfI+sZDxmiyLvHe0L
         0uki4/3o2JELSQ78ftlXsxMOqsaiKlYdPFQlOre98P9ssVz0G+6e7uYlWZZP4K8DTCYI
         WYhx3vX+ohOMrKHJ7+igsVQZEmUQTIMQs002G9ApDcU54cWoU9z8AgRwHni8dgMyHh7b
         aw6HSAS6zPHjl74MMYRcvwOAj8cBrkRot+W7kEsHtQQU5jqu9EyW43uQT6GfqW3JWAtF
         u8nA==
X-Gm-Message-State: AGRZ1gJOU1NgKMhSflK6hLxTXMu7KPQANfPCKbg8ZPSWTOMiWjV4CEHl
        txxkPIi/xxVYdW2XCyktw4Rd9NwgErBJsGXmPARUoQ==
X-Google-Smtp-Source: AJdET5chMWMgfHZqoEomjZDSqtJtc0sreLNA0PZqy4vrKyyaxsQovaEfvWTzmguYsHC+FWHitJRI6dytDxZLh83WeUo=
X-Received: by 2002:aca:c045:: with SMTP id q66-v6mr3509198oif.22.1541044290261;
 Wed, 31 Oct 2018 20:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181010161430.11633-1-laurent@vivier.eu> <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
 <1541041159.4632.6.camel@HansenPartnership.com>
In-Reply-To: <1541041159.4632.6.camel@HansenPartnership.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Nov 2018 04:51:02 +0100
Message-ID: <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, dima@arista.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:59 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2018-10-16 at 11:52 +0200, Laurent Vivier wrote:
> > Hi,
> >
> > Any comment on this last version?
> >
> > Any chance to be merged?
>
> I've got a use case for this:  I went to one of the Graphene talks in
> Edinburgh and it struck me that we seem to keep reinventing the type of
> sandboxing that qemu-user already does.  However if you want to do an
> x86 on x86 sandbox, you can't currently use the binfmt_misc mechanism
> because that has you running *every* binary on the system emulated.
> Doing it per user namespace fixes this problem and allows us to at
> least cut down on all the pointless duplication.

Waaaaaait. What? qemu-user does not do "sandboxing". qemu-user makes
your code slower and *LESS* secure. As far as I know, qemu-user is
only intended for purposes like development and testing.
