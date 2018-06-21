Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BCDC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24783208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24783208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeFUHdt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:33:49 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:46379 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFUHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:33:37 -0400
Received: by mail-ot0-f169.google.com with SMTP id v24-v6so2461659otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ew75zXD0itTdvAC2QSHY7/SL8M4HJs8Vrxdxc3yoyTM=;
        b=M5wXPrxikWUwkltBirr01L9kwYQdpS3gXSYyqslm6rS2HYFLtqWfFiG/EB6rRj7aY3
         ym3zwvzOe9s4BYYc3BS+wUim1tSH2kdYXwxO0gqcHlHSZg7QQ9xZgfuEq9pNu1Ux4ni9
         ycEjxVt7Z7CQJOGWX0DpUyJ4UtNQY0Sb01O627HJmEvGvn6KiXBsmlOOP7jNG5tpa9Pa
         4ciyya7B8z95WavIA2bA9/ZrHh4Ly4PuXxjWBtUB2GCrlWzN9jAUPtZzVuN1HqOKyJsS
         3D4RR98CNJmmYyb+V4iq6bLg5uZ3Pi32z4P/CUJZqnCqS9IkJ9hO8IIeOR548rehmwns
         oOYg==
X-Gm-Message-State: APt69E26/OVonqGpKWBdrL4nevZaswxHVr5LIc+l61FlG5czKmyQTUuY
        CNx2HHw9lbn7tnS+G18U9mIkcwIFBABkNykWZIz1zqYz
X-Google-Smtp-Source: ADUXVKLkw7lHBYR9TI6qZMPJ5KZIO8eR1BopJIgjiqKLEbHJYltrq7gTyWT2SAU1fa75crkrEcVZGbLgT7aL1ExaV/Q=
X-Received: by 2002:a9d:251d:: with SMTP id k29-v6mr2696504otb.149.1529566416884;
 Thu, 21 Jun 2018 00:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180620144227.18bab881@canb.auug.org.au> <8e17ad17-db3b-7588-b04e-3bd8b54060c0@infradead.org>
 <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 Jun 2018 09:33:26 +0200
Message-ID: <CAFqZXNsw8iWB74jDof39Z8KM29EDvnpvQ_AvxPbvdM9hZ1cXAQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 20 (kernel/auditsc.c)
To:     Paul Moore <paul@paul-moore.com>
Cc:     rdunlap@infradead.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 20. 6. 2018 o 22:00 Paul Moore <paul@paul-moore.com> napísal(a):
>
> On Wed, Jun 20, 2018 at 11:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 06/19/2018 09:42 PM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20180619:
> > >
> >
> > on x86_64:
> >
> > kernel/auditsc.o: In function `audit_filter_rules.isra.20':
> > auditsc.c:(.text+0x8c5): undefined reference to `groups_search'
> > auditsc.c:(.text+0x909): undefined reference to `groups_search'
> >
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >
> > Full randconfig file is attached.
>
> Thanks Randy.
>
> I believe the issue is that when CONFIG_MULTIUSER is not enabled
> groups.{c.o} is not included.  Ondrej, please look into this and
> submit a fix as soon as possible, thank you.

I'm working on it, stay tuned... It should be an easy fix, but it will
(likely) need changes outside the audit code. We could work around it
locally, of course, but since this is just in -next, I believe it's
worth to fix it properly.

Cheers,
--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
